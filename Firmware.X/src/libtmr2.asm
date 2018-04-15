;===-- libtmr2.asm - In-Source Libary: Timer2 --------------*- pic8-asm -*-===//
;
;   In-Source Library - Biblioteca no binaria para Timer2
;
;   Copyright (c) 2018 Oever González
;   Disponible bajo la licencia MIT
;
; Por la presente se autoriza, de forma gratuita, a cualquier persona que haya
; obtenido una copia de este software y archivos de documentación asociados (el
; "Software"), a utilizar el Software sin restricción, incluyendo sin limitación
;   los derechos de usar, copiar, modificar, fusionar, publicar, distribuir,
;  sublicenciar, y/o vender copias de este Software, y permitir lo mismo a las
;     personas a las que se les proporcione el Software, de acuerdo con las
;                           siguientes condiciones:
;
;    El aviso de copyright anterior y este aviso de permiso tendrán que ser
;       incluidos en todas las copias o partes sustanciales del Software.
;
; EL SOFTWARE SE ENTREGA "TAL CUAL", SIN GARANTÍA DE NINGÚN TIPO, YA SEA EXPRESA
;      O IMPLÍCITA, INCLUYENDO, A MODO ENUNCIATIVO, CUALQUIER GARANTÍA DE
; COMERCIABILIDAD, IDONEIDAD PARA UN FIN PARTICULAR Y NO INFRACCIÓN. EN NINGÚN
;   CASO LOS AUTORES O TITULARES DEL COPYRIGHT INCLUIDOS EN ESTE AVISO SERÁN
; RESPONSABLES DE NINGUNA RECLAMACIÓN, DAÑOS U OTRAS RESPONSABILIDADES, YA SEA
;  EN UN LITIGIO, AGRAVIO O DE OTRO MODO, RESULTANTES DE O EN CONEXIÓN CON EL
;           SOFTWARE, SU USO U OTRO TIPO DE ACCIONES EN EL SOFTWARE.
;===-----------------------------------------------------------------------===//
  LIST      p=16f887
  RADIX     DEC
  INCLUDE   "p16f887.inc"
  INCLUDE   "config.inc"
#define     TMR2_INTERNAL
  INCLUDE   "libtmr2.inc"
  INCLUDE   "ABI.inc"
;-------------------------------------------------------------------------------
; initialized data
;-------------------------------------------------------------------------------
LIBTMR2I         idata
TICKS_FROM_BOOT
  DB 0x00, 0x00
;-------------------------------------------------------------------------------
; uninitialized data
;-------------------------------------------------------------------------------
LIBTMR2U        udata
FUTURE          res     2
;-------------------------------------------------------------------------------
; global declarations
;-------------------------------------------------------------------------------
  GLOBAL    TMR2_INIT
  GLOBAL    TMR2_ISR
  GLOBAL    BLOCK_TICKS16
;-------------------------------------------------------------------------------
; code
;-------------------------------------------------------------------------------
TMR2_INIT   CODE
TMR2_INIT:
  PAGESEL   $
  ; Configura TIMER2
  BANKSEL   T2CON
#if         TMR2_PRESCAL == 1
  MOVLW	    ((TMR2_POSTSCAL-1)<<TOUTPS0)|(b'1'<<TMR2ON)|(b'00'<<T2CKPS0)
#else
#if         TMR2_PRESCAL == 4
  MOVLW	    ((TMR2_POSTSCAL-1)<<TOUTPS0)|(b'1'<<TMR2ON)|(b'01'<<T2CKPS0)
#else
#if         TMR2_PRESCAL == 16
  MOVLW	    ((TMR2_POSTSCAL-1)<<TOUTPS0)|(b'1'<<TMR2ON)|(b'10'<<T2CKPS0)
#else
  error "Invalid prescaler for TIMER2"
#endif
#endif
#endif
  MOVWF	    T2CON
  BANKSEL   PR2
  MOVLW	    PIR2_VAL
  MOVWF	    PR2
#ifdef      TMR2_INTERRUPT
  ; -> Activar interrupción para TIMER2
  BSF	    PIE1,         TMR2IE
#endif
  RETURN
;-------------------------------------------------------------------------------
; WARNING: En código que se ejecuta en el ISR no se deben usar los registros
; STK de la ABI
TMR2_ISR    CODE
TMR2_ISR:
  BANKSEL   PIR1
  BCF       PIR1,       TMR2IF
  BANKSEL   TICKS_FROM_BOOT
  INCF      TICKS_FROM_BOOT
  BTFSC     STATUS,     Z
  INCF      (TICKS_FROM_BOOT+1),  F
  RETURN
;-------------------------------------------------------------------------------
BLOCK_TICKS16  CODE
; void block_ticks16( unsigned int x );
; Bloquea el hilo de ejecución durante x (16 bit) ticks
BLOCK_TICKS16:
  PAGESEL     $
  ; La variable FUTURE es de 16 bits y contiene el valor de TICKS_FROM_BOOT + x
  BANKSEL     FUTURE
  MOVWF       FUTURE                          ; FUTUREL = xL
  MOVF        STK00,      W                   ; W = xH
  MOVWF       (FUTURE+1)                      ; FUTUREH = xH
  MOVF        FUTURE,     W                   ; W = FUTUREL
  ; Suma de 16 bits
  BANKSEL     TICKS_FROM_BOOT
  ADDWF       TICKS_FROM_BOOT,  W             ; W = TICKS_FROM_BOOTL + FUTUREL
  BANKSEL     FUTURE                      
  MOVWF       FUTURE                          ; FUTUREL = W
  BANKSEL     TICKS_FROM_BOOT
  MOVF        (TICKS_FROM_BOOT+1),  W
  BTFSC       STATUS,   C
  INCF        (TICKS_FROM_BOOT+1),  W
  BTFSC       STATUS,   Z
  GOTO        L1
  BANKSEL     FUTURE
  ADDWF       (FUTURE+1)
  ; Loop bloqueado
L1:
  BANKSEL     FUTURE
  MOVF        (FUTURE+1),   W
  BANKSEL     TICKS_FROM_BOOT
  SUBWF       (TICKS_FROM_BOOT+1),  W
  BTFSS       STATUS,   Z
  GOTO        L2
  BANKSEL     FUTURE
  MOVF        FUTURE,   W
  BANKSEL     TICKS_FROM_BOOT
  SUBWF       TICKS_FROM_BOOT,  W
  ; Salta la comprobación del segundo byte
L2:
  BTFSS       STATUS,   C
  GOTO        L1
  RETURN
  END
