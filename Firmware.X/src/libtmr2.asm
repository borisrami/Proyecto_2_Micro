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
;-------------------------------------------------------------------------------
; global declarations
;-------------------------------------------------------------------------------
  GLOBAL    TMR2_INIT
  GLOBAL    TMR2_ISR
;-------------------------------------------------------------------------------
; code
;-------------------------------------------------------------------------------
TMR2_INIT   CODE
TMR2_INIT:
  PAGESEL   $
  ; Configura TIMER2
  BANKSEL   T2CON
#if         TMR2_PRE == 1
  MOVLW	    ((TMR2_POS-1)<<TOUTPS0)|(b'1'<<TMR2ON)|(b'00'<<T2CKPS0)
#else
#if         TMR2_PRE == 4
  MOVLW	    ((TMR2_POS-1)<<TOUTPS0)|(b'1'<<TMR2ON)|(b'01'<<T2CKPS0)
#else
#if         TMR2_PRE == 16
  MOVLW	    ((TMR2_POS-1)<<TOUTPS0)|(b'1'<<TMR2ON)|(b'10'<<T2CKPS0)
#else
  error "Invalid prescaler for TIMER2"
#endif
#endif
#endif
  MOVWF	    T2CON
  BANKSEL   PR2
  MOVLW	    PIR2_VAL
  MOVWF	    PR2
#ifdef      TMR2_INT
  ; -> Activar interrupción para TIMER2
  BSF	    PIE1,         TMR2IE
#endif
  RETURN
;-------------------------------------------------------------------------------
TMR2_ISR    CODE
TMR2_ISR:
  BANKSEL   PIR1
  BCF       PIR1,       TMR2IF
  RETURN
;-------------------------------------------------------------------------------
  END