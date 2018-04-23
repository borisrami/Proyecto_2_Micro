;===-- executer.asm - Proyecto 2: Ejecutor -----------------*- pic8-asm -*-===//
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
  INCLUDE   "slave_recive.inc"
  INCLUDE   "ABI.inc"
;-------------------------------------------------------------------------------
; global declarations
;-------------------------------------------------------------------------------
  GLOBAL COMMAND_EXEC
;-------------------------------------------------------------------------------
; scope variables
;-------------------------------------------------------------------------------
ISR_UDATAS      UDATA
MARCANDO        RES     1
;-------------------------------------------------------------------------------
; extern declarations
;-------------------------------------------------------------------------------
  EXTERN    SRV_TICKS
  EXTERN    __gptrget1
  EXTERN    SRV1_ANGLE
  EXTERN    SRV2_ANGLE
  EXTERN    SRV3_ANGLE
;-------------------------------------------------------------------------------
; code
;-------------------------------------------------------------------------------
COMMAND_EXEC            CODE
COMMAND_EXEC:
  BANKSEL     ORPM01_FLAGS
  BTFSS       ORPM01_FLAGS, ORPM01_READY
  RETLW       0x00
  MOVF        ORPM01_OPCODE,  W
  XORLW       EXECUTER_ABSMOVE
  BTFSC       STATUS,   Z
  GOTO        ABSMOVE
  MOVF        ORPM01_OPCODE,  W
  XORLW       EXECUTER_RELMOVE
  BTFSC       STATUS,   Z
  GOTO        RELMOVE
  BCF         ORPM01_FLAGS, ORPM01_READY
  RETLW       REPORTER_ENOCMD
RELMOVE:
  ; Primer Argumento
  MOVLW       LOW(ORPM01_ARRGS)
  MOVWF       STK01
  MOVLW       HIGH(ORPM01_ARRGS)
  MOVWF       STK00
  MOVLW       0x00
  PAGESEL     __gptrget1
  CALL        __gptrget1
  PAGESEL     $
  MOVWF       STK00
  BANKSEL     SRV1_ANGLE
  ADDWF       SRV1_ANGLE
  MOVF        SRV1_ANGLE, W
  SUBLW       SERVO_RANGE_DEGS
  BTFSS       STATUS,   C
  GOTO        R0  ; Fuera de rango
  GOTO        R1  ; En rango
R0:
  BTFSC       STK00,    7
  GOTO        R0R ; Si bit7 es 1, entonces es una resta
  GOTO        R0S ; Si bit7 es 0, entonces es una suma
R0R:
  MOVLW       0
  MOVWF       SRV1_ANGLE
  GOTO        R1
R0S:
  MOVLW       SERVO_RANGE_DEGS
  MOVWF       SRV1_ANGLE
  GOTO        R1
R1:
  ; Segundo Argumento
  MOVLW       LOW(ORPM01_ARRGS+1)
  MOVWF       STK01
  MOVLW       HIGH(ORPM01_ARRGS+1)
  MOVWF       STK00
  MOVLW       0x00
  PAGESEL     __gptrget1
  CALL        __gptrget1
  PAGESEL     $
  MOVWF       STK00
  BANKSEL     SRV2_ANGLE
  ADDWF       SRV2_ANGLE
  MOVF        SRV2_ANGLE, W
  SUBLW       SERVO_RANGE_DEGS
  BTFSS       STATUS,   C
  GOTO        R2  ; Fuera de rango
  GOTO        R3  ; En rango
R2:
  BTFSC       STK00,    7
  GOTO        R2R ; Si bit7 es 1, entonces es una resta
  GOTO        R2S ; Si bit7 es 0, entonces es una suma
R2R:
  MOVLW       0
  MOVWF       SRV2_ANGLE
  GOTO        R3
R2S:
  MOVLW       SERVO_RANGE_DEGS
  MOVWF       SRV2_ANGLE
  GOTO        R3
R3:
  ; Tercer Argumento
  MOVLW       LOW(ORPM01_ARRGS+2)
  MOVWF       STK01
  MOVLW       HIGH(ORPM01_ARRGS+2)
  MOVWF       STK00
  MOVLW       0x00
  PAGESEL     __gptrget1
  CALL        __gptrget1
  PAGESEL     $
  BANKSEL     MARCANDO
  XORWF       MARCANDO
  BTFSC       MARCANDO, 0
  GOTO        MOVPOS2 ; MARCANDO es 0x01
  GOTO        MOVPOS1 ; MARCANDO es 0x00
ABSMOVE:
  ; Primer Argumento
  MOVLW       LOW(ORPM01_ARRGS)
  MOVWF       STK01
  MOVLW       HIGH(ORPM01_ARRGS)
  MOVWF       STK00
  MOVLW       0x00
  PAGESEL     __gptrget1
  CALL        __gptrget1
  PAGESEL     $
  BANKSEL     SRV1_ANGLE
  MOVWF       STK00
  SUBLW       SERVO_RANGE_DEGS
  BTFSS       STATUS,   C
  RETLW       REPORTER_ERANGE ; El ángulo está fuera de rango
  MOVF        STK00,    W
  MOVWF       SRV1_ANGLE
  ; Segundo Argumento
  MOVLW       LOW(ORPM01_ARRGS+1)
  MOVWF       STK01
  MOVLW       HIGH(ORPM01_ARRGS+1)
  MOVWF       STK00
  MOVLW       0x00
  PAGESEL     __gptrget1
  CALL        __gptrget1
  PAGESEL     $
  BANKSEL     SRV2_ANGLE
  MOVWF       STK00
  SUBLW       SERVO_RANGE_DEGS
  BTFSS       STATUS,   C
  RETLW       REPORTER_ERANGE ; El ángulo está fuera de rango
  MOVF        STK00,    W
  MOVWF       SRV2_ANGLE
  ; Tercer Argumento
  MOVLW       LOW(ORPM01_ARRGS+2)
  MOVWF       STK01
  MOVLW       HIGH(ORPM01_ARRGS+2)
  MOVWF       STK00
  MOVLW       0x00
  PAGESEL     __gptrget1
  CALL        __gptrget1
  PAGESEL     $
  BANKSEL     SRV3_ANGLE
  MOVWF       STK00
  XORLW       0x00
  BTFSC       STATUS,   Z
  GOTO        MOVPOS1 ; ARG = 0x00
  MOVF        STK00,    W
  XORLW       0x01
  BTFSC       STATUS,   Z
  GOTO        MOVPOS2 ; ARG = 0x01
  RETURN      REPORTER_ERANGE ; Solo puede ser 0 o 1.
MOVPOS1:
  MOVLW       SERVO_RANGE_DEGS
  MOVWF       SRV3_ANGLE
  BANKSEL     MARCANDO
  MOVLW       0x00
  MOVWF       MARCANDO
  GOTO        EXIT0
MOVPOS2:
  MOVLW       SERVO_RANGE_DEGS/2
  MOVWF       SRV3_ANGLE
  BANKSEL     MARCANDO
  MOVLW       0x01
  MOVWF       MARCANDO
  GOTO        EXIT0
EXIT0:
  BCF         ORPM01_FLAGS, ORPM01_READY
  RETLW       REPORTER_UPDATE
  END
  