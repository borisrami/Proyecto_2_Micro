;===-- macros.inc - Proyecto 2: Macros de MPASM ------------*- pic8-asm -*-===//
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

#ifndef CONFIGURED
    error "No se puede proceder sin los símbolos de configuración."
    error "Es posible que quiera importar su configuración antes que macros.inc"
#endif

  ; Es importante que la operación se realice en este orden, por eso, los
  ; paréntesis.
#define     US_TO_TMR1(US)              ((US*CLOCK_KHZ)/4000)
#define	    US_TO_PIR2(US, PRE, POS)    ((US*CLOCK_KHZ)/(4000*PRE*POS)-1)
