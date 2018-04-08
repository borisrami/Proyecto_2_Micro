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
  LIST      p=16f887dd
  RADIX     DEC
  INCLUDE   "p16f887.inc"
;-----------------------------------------------------------------------------------------------------------------------
; config word(s)
;-----------------------------------------------------------------------------------------------------------------------
 __CONFIG _CONFIG1, _FOSC_HS & _WDTE_OFF & _PWRTE_OFF & _MCLRE_ON & _CP_OFF & _CPD_OFF & _BOREN_OFF & _IESO_OFF & _FCMEN_OFF & _LVP_OFF
 __CONFIG _CONFIG2, _BOR4V_BOR40V & _WRT_OFF
;-----------------------------------------------------------------------------------------------------------------------
; global declarations for the ABI
;-----------------------------------------------------------------------------------------------------------------------
  GLOBAL FSRSAVE
  GLOBAL PSAVE
  GLOBAL SSAVE
  GLOBAL WSAVE
  GLOBAL STK00
; Este es un SHAREBANK con UDATA_SHR, esto significa que no hay que hacer BANKSEL para acceder a estos registros
SHAREBANK   UDATA_SHR
FSRSAVE     RES     1
PSAVE       RES     1
SSAVE       RES     1
WSAVE       RES     1
STK00       RES     1
;-----------------------------------------------------------------------------------------------------------------------
; external declarations
;-----------------------------------------------------------------------------------------------------------------------
;-----------------------------------------------------------------------------------------------------------------------
; global variables
;-----------------------------------------------------------------------------------------------------------------------
;-----------------------------------------------------------------------------------------------------------------------
; global declarations
;-----------------------------------------------------------------------------------------------------------------------
  GLOBAL    BOOT
  GLOBAL    SETUP
;-----------------------------------------------------------------------------------------------------------------------
; reset vector
;-----------------------------------------------------------------------------------------------------------------------
RES_VECT    CODE    0x0000
    GOTO    BOOT
;-----------------------------------------------------------------------------------------------------------------------
; code
;-----------------------------------------------------------------------------------------------------------------------
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
;-----------------------------------------------------------------------------------------------------------------------
SETUP       CODE
SETUP:
  ; La verdadera configuración ocurre aquí
  BANKSEL   OSCCON
  ; OSCCON para 18.432 MHz desde el reloj externo
  ; IRCF7, OSTS1, HTS1, LTS1, SCS0
  MOVLW     (b'111'<<IRCF0)|(b'1'<<OSTS)|(b'1'<<HTS)|(b'1'<<LTS)|(b'0'<<SCS)
  MOVWF     OSCCON
  ; No se pueden obtener 20.000 mS exactos con esta configuración. El 
L1: ; Esta etiqueta es una trampa :3
  GOTO      L1
  END