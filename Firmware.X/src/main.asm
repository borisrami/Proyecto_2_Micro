;===-- main.asm - Proyecto 2: Programa principal -----------*- pic8-asm -*-===//
;
;   Proyecto 2 - Microcontroladores aplicados a la industria
;
;   Copyright (c) 2018 Oever González
;   Distribución libre solamente para usos exclusivamente académicos.
;
; EL SOFTWARE SE PROPORCIONA "TAL CUAL", SIN GARANTÍA DE NINGÚN TIPO, EXPRESA O
;    IMPLÍCITA, INCLUYENDO PERO NO LIMITADO A GARANTÍAS DE COMERCIALIZACIÓN,
;  IDONEIDAD PARA UN PROPÓSITO PARTICULAR Y NO INFRACCIÓN. EN NINGÚN CASO LOS
; AUTORES O TITULARES DEL COPYRIGHT SERÁN RESPONSABLES DE NINGUNA RECLAMACIÓN,
; DAÑOS U OTRAS RESPONSABILIDADES, YA SEA EN UNA ACCIÓN DE CONTRATO, AGRAVIO O
; CUALQUIER OTRO MOTIVO, QUE SURJA DE O EN CONEXIÓN CON EL SOFTWARE O EL USO U
;                   OTRO TIPO DE ACCIONES EN EL SOFTWARE.
;
;===-----------------------------------------------------------------------===//
  LIST      p=16f887
  RADIX     DEC
  INCLUDE   "p16f887.inc"
  INCLUDE   "config.inc"
  INCLUDE   "libtmr2.inc"
  INCLUDE   "libtmr1.inc"
#define     ABI_BUILDER
  INCLUDE   "ABI.inc"
;-------------------------------------------------------------------------------
; config word(s)
;-------------------------------------------------------------------------------
 __CONFIG _CONFIG1, _FOSC_HS & _WDTE_OFF & _PWRTE_OFF & _MCLRE_ON & _CP_OFF & _CPD_OFF & _BOREN_OFF & _IESO_OFF & _FCMEN_OFF & _LVP_OFF
 __CONFIG _CONFIG2, _BOR4V_BOR40V & _WRT_OFF
;-------------------------------------------------------------------------------
; external declarations
;-------------------------------------------------------------------------------
 EXTERN     RCV_LOOPER
;-------------------------------------------------------------------------------
; global variables
;-------------------------------------------------------------------------------
;-------------------------------------------------------------------------------
; global declarations
;-------------------------------------------------------------------------------
  GLOBAL    BOOT
  GLOBAL    SETUP
;-------------------------------------------------------------------------------
; reset vector
;-------------------------------------------------------------------------------
RES_VECT    CODE    0x0000
    GOTO    BOOT
;-------------------------------------------------------------------------------
; code
;-------------------------------------------------------------------------------
BOOT        CODE
BOOT:
  ; Borrar ANSEL y ANSELH, así solamente se usan los puertos digitales
  BANKSEL   ANSEL
  CLRF      ANSEL
  CLRF      ANSELH
  
  ; Pone como entradas digitales a todos los puertos.
  BANKSEL   TRISA
  MOVLW     0xFF
  MOVWF     TRISA
  MOVWF     TRISB
  MOVWF     TRISC
  MOVWF     TRISD
  MOVWF     TRISE
  ; Pone el valor de todos los puertos en 0x00
  BANKSEL   PORTA
  MOVLW     0x00
  MOVWF     PORTA
  MOVWF     PORTB
  MOVWF     PORTC
  MOVWF     PORTD
  MOVWF     PORTE
  ; Salta a SETUP
  GOTO      SETUP
L0: ; Esta etiqueta es una trampa :3
  GOTO      L0
;-------------------------------------------------------------------------------
SETUP       CODE
SETUP:
  ; La verdadera configuración ocurre aquí
  BANKSEL   OSCCON
  ; OSCCON para reloj externo
  ; IRCF7, OSTS1, HTS1, LTS1, SCS0
  MOVLW     (b'111'<<IRCF0)|(b'1'<<OSTS)|(b'1'<<HTS)|(b'1'<<LTS)|(b'0'<<SCS)
  MOVWF     OSCCON
  ; Después de retraso del despertar del reloj externo...
;...............................................................................
  ; Activar interrupción
  BANKSEL   INTCON
  BSF	    INTCON,       GIE
  BSF	    INTCON,       PEIE
  ; Configurar TIMER2
  CALL      TMR2_INIT
  ; Esperar 1 segundo (para estabilidad)
  BLOCK_MS  1000
  ; -> Configurar TIMER1 como temporizador para el módulo CCP. No se puede usar
  ;    PWM con la frecuencia de diseño (18.432 MHz). El Timer1 no será el
  ;    responsable de la interrupción, se configura solamente para el módulo CCP
  BANKSEL   T1CON
  BCF       T1CON,        TMR1GE ; Cuenta siempre
  BCF       T1CON,        TMR1CS ; FOSC/4
  CALL      TMR1_INIT
  ; Configurar CCP
  BANKSEL   CCP1CON
  ; Compare Mode con Interrupt y reset del Timer 1
  MOVLW     (0<<P1M0)|(0<<DC1B0)|(b'1011'<<CCP1M0)
  MOVWF     CCP1CON
  BANKSEL   CCPR1H
  MOVLW     HIGH((SERVO_RANGE_US*CLOCK_KHZ)/(4000*SERVO_RANGE_DEGS))
  MOVWF     CCPR1H
  MOVLW     LOW((SERVO_RANGE_US*CLOCK_KHZ)/(4000*SERVO_RANGE_DEGS))
  MOVWF     CCPR1L
  BANKSEL   PIE1
  BSF       PIE1,       CCP1IE
  ; Configurar el puerto serial
  ; -> Activa el transmisor asíncrono
  BANKSEL   TXSTA
  BSF	    TXSTA,        TXEN
  BCF	    TXSTA,        SYNC
  BANKSEL   RCSTA
  BSF	    RCSTA,        SPEN
  ; -> De acuerdo a 12.1.1.6 de la hoja de datos
  ;   -> Inicializar SPBRGH, SPBRG, BRGH, BRG16
  ;      SYNC=0, BRGH=0, BRG16=1
  BANKSEL   BAUDCTL
  BSF	    BAUDCTL,      BRG16
  BANKSEL   TXSTA
  BCF	    TXSTA,        BRGH
  BANKSEL   SPBRGH
  CLRF	    SPBRGH
  MOVLW	    0x09
  MOVWF	    SPBRG
  ; -> Activa el receptor asíncrono
  BANKSEL   RCSTA
  BSF	    RCSTA,        CREN
  ; -> Garantiza el estado de I/O para los pines del puerto serial
  BANKSEL   TRISC
  BSF	    TRISC,        RC7   ; RX
  BCF	    TRISC,        RC6   ; TX
  GOTO      BUSY_WAIT
L1: ; Esta etiqueta es una trampa :3
  GOTO	    L1
;-------------------------------------------------------------------------------
; Problema: Con 18.432MHz no se puede generar un PWM descente. Es imposible usar
; el módulo PWM a esa frecuencia para mover un servo, sin contar que el PIC
; cuenta con solo dos PWM: uno de ellos debe ser por software.
;
; La solución propuesta e implementada es utilizar el TIMER1 y el módulo CCP
; para generar los 3 "duty cycle" por software en el ISR. En conjunto con el
; TIMER2, generar el PWM a 50.000 Hz.
;
; TIMER1 puede contar de 1 en 1 cada 217.01 nanosegundos como mínimo. El tiempo
; del duty cycle de un servo es una escala lineal que representa ángulos de 0 a
; 180 en un rango de 1.00 mS a 2.00 mS
;
; Cada paso discreto del servo se puede representar como 1.00 mS / 180 o
; 5.556 uS por grado. Para alcanzar 5.556 uS, los registros del CCP se deben
; configurar en 25.6 (o 26). El resultado es un intervalo de 1.0156 mS con
; 180 divisiones de 5.642 uS
;
; Durante 5.642 uS, que es el tiempo en el que se espera la siguiente
; interrupción del CCP, el PIC puede ejecutar solamente 26 instrucciones. Esto
; significa que durante 1.0156 mS el PIC no podrá responder a ninguna
; interrupción o ejecutar código.
;
; En los otros 19 mS, el Timer2 puede apoyar al módulo CCP, al elevar los pines
; del puerto cada 20.000 mS, esperar 1.000 mS e inmediatamente encender el
; módulo CCP.
;
; Luego de diversas pruebas, el ISR no puede ejecutarse en menos de 26 ciclos de
; pulsos del reloj. Existen unas macros en TMR2 e ISR que ayudan a calcular
; automáticamente todos los valores dadas las especificaciones en config.inc
;
; Para esta configuración, 75 divisiones en el intervalo de 1000 uS del servo
; funcionan bien, mientras que 180 simplemente no funciona. Esto es por culpa
; del ISR. Mientras más tiempo se tarde el ISR, menos resolución tendrá.
;
; Con 75 instrucciones para el ISR, las divisiones máximas disminuyen a 60, lo
; cual resulta razonable y seguro.
;-------------------------------------------------------------------------------
BUSY_WAIT   CODE
BUSY_WAIT:
  ; BUSY WAIT descarga el trabajo del ISR en una rutina cíclica que polea los
  ; resultados
  CALL      RCV_LOOPER
  GOTO      BUSY_WAIT
  END
