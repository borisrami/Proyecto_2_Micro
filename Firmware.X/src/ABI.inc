;===-- ABI.inc - ABI: Variables y nombres para la ABI ------*- pic8-asm -*-===//
;
;   ABI - Declaraciones para la ABI
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
#ifdef            ABI_BUILDER
;-------------------------------------------------------------------------------
; global declarations
;-------------------------------------------------------------------------------
  GLOBAL  STK00
  GLOBAL  STK01
  GLOBAL  STK02
  GLOBAL  STK03
  GLOBAL  STK04
  GLOBAL  STK05
  GLOBAL  STK06
  GLOBAL  STK07
  GLOBAL  STK08
  GLOBAL  STK10
  GLOBAL  STK11
;-------------------------------------------------------------------------------
; space reservation
;-------------------------------------------------------------------------------
SHAREBANK   UDATA_SHR
STK00       RES     1
STK01       RES     1
STK02       RES     1
STK03       RES     1
STK04       RES     1
STK05       RES     1
STK06       RES     1
STK07       RES     1
STK08       RES     1
STK09       RES     1
STK10       RES     1
STK11       RES     1
#else
;-------------------------------------------------------------------------------
; external declarations
;-------------------------------------------------------------------------------
  EXTERN     STK00
  EXTERN     STK01
  EXTERN     STK02
  EXTERN     STK03
  EXTERN     STK04
  EXTERN     STK05
  EXTERN     STK06
  EXTERN     STK07
  EXTERN     STK08
  EXTERN     STK09
  EXTERN     STK10
  EXTERN     STK11
#endif
