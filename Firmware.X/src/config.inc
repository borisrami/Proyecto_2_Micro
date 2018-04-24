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
#define     CLOCK_KHZ                 20000
#define     BAUD_RATE                 19200
#define     TMR2_TICK_US              500
#define     TMR2_PRESCAL              4
#define     TMR2_POSTSCAL             5
#define     TMR2_INTERRUPT
#define     TMR2_SERVO
#define     TMR2_SERVO_MINDUTY_US     500
#define     SERVO_ACUAL_MINDUTY_US    550
#define     TMR2_SERVO_CYCLCE_US      20000
#define     SERVO_RANGE_US            1840
#define     SERVO_RANGE_DEGS          70
#define     SERVO_OVERSHT_COMPS       1
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
#define     EXECUTER_AUTO             0x10
#define     EXECUTER_MANUAL           0x12
#define     REPORTER_ENOCMD           0xA0
#define     REPORTER_ERANGE           0xA1
#define     REPORTER_UPDATE           0xA2
#define     ADC1_PORT_BIT             0x00
#define     ADC2_PORT_BIT             0x00
#define     ADC1_TRIS                 TRISA
#define     ADC2_TRIS                 TRISB
#define     ADC1_ANSL                 ANSEL
#define     ADC2_ANSL                 ANSELH
#define     ADC1_ABIT                 0x00
#define     ADC2_ABIT                 0x04
#define     ADC1_ACHNL                0x00
#define     ADC2_ACHNL                0x0C
;#define     TMR1_INTERRUPT   
    
    ; Obliga a macros.inc a ser importado después de este archivo.
#define	    CONFIGURED
