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
#define     TMR1_INTERNAL
  INCLUDE   "libtmr1.inc"
;-------------------------------------------------------------------------------
; global declarations
;-------------------------------------------------------------------------------
  GLOBAL    TMR1_INIT
;-------------------------------------------------------------------------------
; code
;-------------------------------------------------------------------------------
TMR1_INIT   CODE
TMR1_INIT:
  BANKSEL   TMR1L
  CLRF      TMR1L
  CLRF      TMR1H
  BANKSEL   T1CON
  MOVLW	    (1<<T1GINV)|(1<<TMR1GE)|(1<<T1OSCEN)|(1<<T1SYNC)|(1<<TMR1CS)
  ANDWF     T1CON
#if         TMR1_PRESCAL == 1
  MOVLW	    (b'00'<<T1CKPS0)|(1<<TMR1ON)
#else
#if         TMR1_PRESCAL == 2
  MOVLW	    (b'01'<<T1CKPS0)|(1<<TMR1ON)
#else
#if         TMR1_PRESCAL == 4
  MOVLW	    (b'10'<<T1CKPS0)|(1<<TMR1ON)
#else
#if         TMR1_PRESCAL == 8
  MOVLW	    (b'11'<<T1CKPS0)|(1<<TMR1ON)
#else
  error "Invalid prescaler for TIMER1"
#endif
#endif
#endif
#endif
  IORWF     T1CON
#ifdef      TMR2_INTERRUPT
  ; -> Activar interrupción para TIMER1
  BSF	    PIE1,         TMR1IE
#endif
  RETURN
;-------------------------------------------------------------------------------
; WARNING: En código que se ejecuta en el ISR no se deben usar los registros
; STK de la ABI
TMR2_ISR    CODE
TMR2_ISR:
  BANKSEL   PIR1
  BCF       PIR1,       TMR1IF
  RETURN
  END
  