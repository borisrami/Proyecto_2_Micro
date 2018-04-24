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
  INCLUDE   "slave_recive.inc"
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
 EXTERN     COMMAND_EXEC
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
  ; 20MHz con la anterior config: 19,200 bps
  MOVLW	    64
  MOVWF	    SPBRG
  ; -> Activa el receptor asíncrono
  BANKSEL   RCSTA
  BSF	    RCSTA,        CREN
  ; -> Garantiza el estado de I/O para los pines del puerto serial
  BANKSEL   TRISC
  BSF	    TRISC,        RC7   ; RX
  BCF	    TRISC,        RC6   ; TX
  BCF       TRISD,        RD3
  BSF       ADC1_TRIS,    ADC1_PORT_BIT
  BSF       ADC2_TRIS,    ADC2_PORT_BIT
  BANKSEL   ANSEL
  BSF       ADC1_ANSL,    ADC1_ABIT
  BSF       ADC2_ANSL,    ADC2_ABIT
  BANKSEL   ADCON0
  ; ADCS0: 10 FOSC/32; CHS0: ADC1_ACHNL; NOT_DONE: 0 NO CONV; ADON: 1 ON
  MOVLW     (b'00'<<ADCS0)|(ADC1_ACHNL<<CHS0)|(b'0'<<NOT_DONE)|(b'1'<<ADON)
  MOVWF     ADCON0
  BANKSEL   ADCON1
  ; ADFM: 0 LEFT; VCFG1: 0 VSS; VCFG0: 0 VDD
  MOVLW     (b'0'<<ADFM)|(b'0'<<VCFG1)|(b'0'<<VCFG0)
  MOVWF     ADCON1
  ; Iniciar la conversión
  BLOCK_MS  1
  BANKSEL   ADCON0
  BSF       ADCON0,   NOT_DONE
EXTERN      AUTO_EXEC
  MOVLW     0xFF
  MOVWF     AUTO_EXEC
  ; Eliminar cualquier posible overrun
  BANKSEL   RCSTA
  BCF	    RCSTA,        CREN
  BLOCK_MS  1
  BANKSEL   RCSTA
  BSF	    RCSTA,        CREN
  GOTO      BUSY_WAIT
L1: ; Esta etiqueta es una trampa :3
  GOTO	    L1
;-------------------------------------------------------------------------------
; El PWM se genera por software. Utilizando el Timer2 como apoyo para generar
; los 500uS de tiempo de espera mínimo. El ISR suele ocupar gran parte del
; tiempo de CPU mientras se simula el PWM.
;
; Atender otras interrupciones puede alterar el ciclo del PWM. Todas las macros
; calculan los valores para CCP y Timer1 media vez los valores en config.inc
; sean sanos.
;
; Con baudrates elevados, es posible que el RC entre en overflow. El programa
; no intenta recuperarse de los overflow. Se debe tomar en cuenta el tiempo
; en el ISR durante el PWM antes de elegir un baudrate.
;
; Los valores en config.inc fueron calibrados, y deben ser calibrados de acuerdo
; a los servos. No se pueden calibrar los servos individuales.
;-------------------------------------------------------------------------------
BUSY_WAIT   CODE
BUSY_WAIT:
  ; BUSY WAIT descarga el trabajo del ISR en una rutina cíclica que polea los
  ; resultados
  CALL      RCV_LOOPER
  CALL      COMMAND_EXEC
  GOTO      BUSY_WAIT
  END
