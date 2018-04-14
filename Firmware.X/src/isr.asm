;===-- isr.asm - Proyecto 2: Interrupt Service Rutine ------*- pic8-asm -*-===//
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
;-----------------------------------------------------------------------------------------------------------------------
; external declarations
;-----------------------------------------------------------------------------------------------------------------------
  EXTERN     FSRSAVE
  EXTERN     PSAVE
  EXTERN     SSAVE
  EXTERN     WSAVE
  EXTERN     STK00
;-----------------------------------------------------------------------------------------------------------------------
; global variables
;-----------------------------------------------------------------------------------------------------------------------
;-----------------------------------------------------------------------------------------------------------------------
; scope variables
;-----------------------------------------------------------------------------------------------------------------------
ISR_UDATAS      UDATA
TEMP0_08BIT     RES     1
ANALOG_CHNL     RES     1
TEMP1_08BIT     RES     1
TEMP2_08BIT     RES     1
TEMP3_08BIT     RES     1
;-----------------------------------------------------------------------------------------------------------------------
; global declarations
;-----------------------------------------------------------------------------------------------------------------------
  GLOBAL    ISR
;-----------------------------------------------------------------------------------------------------------------------
; code
;-----------------------------------------------------------------------------------------------------------------------
ISR         CODE            0x0004
ISR:
  ; Guardar W
  MOVWF     WSAVE
  ; Guardar STATUS
  SWAPF     STATUS,     W
  CLRF      STATUS
  MOVWF     SSAVE
  ; Guardar PCLATH
  MOVF      PCLATH,     W
  CLRF      PCLATH
  MOVWF     PSAVE
  ; Guardar FSR
  MOVF      FSR,        W
  BANKSEL   FSRSAVE
  MOVWF     FSRSAVE
;--------------------------------------------------------
  BANKSEL   PIR1
  BTFSC     PIR1,       TMR2IF
  GOTO      SERVICE_TIMER2
  ;BTFSC     PIR1,       ADIF
  ;GOTO      SERVICE_ADC
  BANKSEL   INTCON
  BTFSC     INTCON,     RBIF
  GOTO      SERVICE_RBCHG
  GOTO      INVALID_INTERRUPT
SERVICE_TIMER2:
  ; Limpiar la interrupcion
  BANKSEL   PIR1
  BCF       PIR1,       TMR2IF
  GOTO      EXIT_ISR
SERVICE_RBCHG:
  BANKSEL   INTCON
  ; Realizar una operacion READ del puerto B para quitar la condicion de
  ;     de cambio. Lo movemos a W para evitar el clasico problema RMW
  MOVF      PORTB,      W
  BCF       INTCON,     RBIF
  GOTO      EXIT_ISR
;SERVICE_ADC:
  ; Limpiar la interrupcion
  ;BANKSEL   PIR1
  ;BCF       PIR1,       ADIF
  ;GOTO      EXIT_ISR
INVALID_INTERRUPT:
  ; Esta interrupcion no esta soportada, pero ha ocurrido. En este caso, si no
  ; se borra, entonces el programa se bloquea en la rutina ISR.
  ; --> Borra todas las interrupciones incondicionalmente
  BANKSEL   INTCON
  MOVLW     b'11111000'
  ANDWF     INTCON
  BANKSEL   PIR1
  MOVLW     0x00
  MOVWF     PIR1
  BANKSEL   PIR2
  MOVWF     PIR2
  GOTO      EXIT_ISR
;--------------------------------------------------------
EXIT_ISR:
  ; Restaurar FSR
  BANKSEL   FSR
  MOVF      FSRSAVE,    W
  MOVWF     FSR
  ; Restaurar PCLATH
  MOVF      PSAVE,      W
  MOVWF     PCLATH
  ; Restaurar STATUS
  CLRF      STATUS
  SWAPF     SSAVE,      W
  MOVWF     STATUS
  ; Restaurar W
  ; Se hace con dos SWAPF porque SWAPF no modifica las banderas
  SWAPF     WSAVE,      F
  SWAPF     WSAVE,      W
  RETFIE
  END
