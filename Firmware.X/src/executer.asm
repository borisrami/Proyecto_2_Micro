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
  RETURN
  MOVF        ORPM01_OPCODE,  W
  XORLW       EXECUTER_ABSMOVE
  BTFSC       STATUS,   Z
  GOTO        ABSMOVE
  MOVF        ORPM01_OPCODE,  W
  XORLW       EXECUTER_RELMOVE
  BTFSC       STATUS,   Z
  GOTO        RELMOVE
  BCF         ORPM01_FLAGS, ORPM01_READY
  RETURN
RELMOVE:
  RETURN
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
  RETURN      ; El ángulo está fuera de rango
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
  RETURN      ; El ángulo está fuera de rango
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
  ; ARG = 0x00
  GOTO        MOVPOS1
  MOVF        STK00,    W
  XORLW       0x01
  BTFSC       STATUS,   Z
  ; ARG = 0x01
  GOTO        MOVPOS2
  RETURN      ; Solo puede ser 0 o 1.
MOVPOS1:
  MOVLW       SERVO_RANGE_DEGS
  MOVWF       SRV3_ANGLE
  GOTO        EXIT0
MOVPOS2:
  MOVLW       SERVO_RANGE_DEGS/2
  MOVWF       SRV3_ANGLE
  GOTO        EXIT0
EXIT0:
  BCF         ORPM01_FLAGS, ORPM01_READY
  RETURN
  END
  