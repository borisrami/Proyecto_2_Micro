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
  MOVLW       LOW(ORPM01_ARRGS)
  MOVWF       STK01
  MOVLW       HIGH(ORPM01_ARRGS)
  MOVWF       STK00
  MOVLW       0x00
  PAGESEL     __gptrget1
  CALL        __gptrget1
  MOVWF       STK00
  SUBLW       SERVO_RANGE_DEGS
  BTFSS       STATUS,   C
  RETURN      ; El ángulo está fuera de rango
  MOVF        STK00,    W
  MOVWF       SRV1_ANGLE
  BCF         ORPM01_FLAGS, ORPM01_READY
  RETURN
  END
  