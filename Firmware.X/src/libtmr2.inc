;===-- libtmr2.inc - In-Source Libary: Timer2 API ----------*- pic8-asm -*-===//
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
                                              
#ifndef   CONFIGURED
    error "Not configured!"
#else
#ifndef   TMR2_INTERNAL
;-------------------------------------------------------------------------------
; external declarations
;-------------------------------------------------------------------------------
  EXTERN     TMR2_INIT
  EXTERN     TMR2_ISR
  EXTERN     BLOCK_TICKS16
;-------------------------------------------------------------------------------
#endif

#define   PIR2_VAL  ((TMR2_US*CLOCK_KHZ)/(4000*TMR2_PRE*TMR2_POS)-1)
BLOCK_MS  macro   mS
  local ticks, ticksL, ticksH
ticks set (mS*1000)/TMR2_US
ticksL set (ticks & 0xFF)
ticksH set ((ticks>>8) & 0xFF)
  MOVLW ticksH
  MOVWF STK00
  MOVLW ticksL
  CALL BLOCK_TICKS16
  endm
#endif
    
