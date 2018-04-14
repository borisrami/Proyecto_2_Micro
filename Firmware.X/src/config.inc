;===-- config.inc - Proyecto 2: Configuración --------------*- pic8-asm -*-===//
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
#define     CLOCK_KHZ                 18432
#define     BAUD_RATE                 115200
#define     TMR2_US                   1000
#define     TMR2_PRE                  4
#define     TMR2_POS                  6
#define     TMR2_INT
    
    ; Obliga a macros.inc a ser importado después de este archivo.
#define	    CONFIGURED
