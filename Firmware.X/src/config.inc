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
#define     BAUD_RATE                 57600
#define     TMR2_TICK_US              500
#define     TMR2_PRESCAL              4
#define     TMR2_POSTSCAL             6
#define     TMR2_INTERRUPT
#define     TMR2_SERVO
#define     TMR2_SERVO_MINDUTY_US     500
#define     SERVO_ACUAL_MINDUTY_US    1000
#define     TMR2_SERVO_CYCLCE_US      20000
#define     SERVO_RANGE_US            1000
#define     SERVO_RANGE_DEGS          60
#define     SERVO_OVERSHT_COMPS       2
#define     TMR2_SERVO_BITMASK        b'00000111'
#define     SERVO0_BIT                0x00
#define     SERVO1_BIT                0x01
#define     SERVO2_BIT                0x02
#define     TMR2_SERVO_PORT           PORTD
#define     TMR2_SERVO_TRIS           TRISD
#define     TMR1_CLK_KHZ              (CLOCK_KHZ/4)
#define     TMR1_PRESCAL              1
#define     TMR1_COUT_RATE_US         5
#define     EXECUTER_ABSMOVE          0x11
#define     EXECUTER_RELMOVE          0x22
#define     REPORTER_ENOCMD           0xA0
#define     REPORTER_ERANGE           0xA1
#define     REPORTER_UPDATE           0xA2
;#define     TMR1_INTERRUPT   
    
    ; Obliga a macros.inc a ser importado después de este archivo.
#define	    CONFIGURED
