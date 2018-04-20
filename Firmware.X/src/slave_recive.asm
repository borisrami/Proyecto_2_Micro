;===-- slave_recive.asm - Proyecto 2: Receptor esclavo -----*- pic8-asm -*-===//
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
  INCLUDE   "ABI.inc"
#define ORPM01_INTERNAL
  INCLUDE   "slave_recive.inc"
;-------------------------------------------------------------------------------
; initialized data
;-------------------------------------------------------------------------------
SLVRCI      idata
CURR_CHAR
  DB 0x00
;-------------------------------------------------------------------------------
; extern declarations
;-------------------------------------------------------------------------------
  EXTERN __chksum
  EXTERN __putbuf
;-------------------------------------------------------------------------------
; uninitialized data
;-------------------------------------------------------------------------------
SLVRCIU       udata
CHRBF         RES       1
ORPM01_OPCODE RES       1
ORPM01_ARGS   RES       1
ORPM01_ARGN   RES       1
ORPM01_ARRGS  RES       ARRGS_SIZET ; número máximo de bytes para los argumentos
FLAGS         RES       1
FINALIZADO    EQU       0
MKCHKSUM      EQU       1
ORPM01_FLAGS  RES       1
CHKSM_IDX     RES       1
;-------------------------------------------------------------------------------
; global declarations
;-------------------------------------------------------------------------------
  GLOBAL    RCV_LOOPER
  GLOBAL    ORPM01_FLAGS
  GLOBAL    ORPM01_OPCODE
  GLOBAL    ORPM01_ARGS
  GLOBAL    ORPM01_ARGN
  GLOBAL    ORPM01_ARRGS
;-------------------------------------------------------------------------------
; code
;-------------------------------------------------------------------------------
RCV_LOOPER  CODE
RCV_LOOPER:
  ; Por motivos de que el PIC es muy lento y con pocos recursos, mientras haya
  ; un comando en ejecución (READY==1), no se podra obtener otro desde el
  ; serial.
  BANKSEL   ORPM01_FLAGS
  BTFSC     ORPM01_FLAGS, ORPM01_READY
  GOTO      FLSH_N_RET  ; ORPM01_READY = 1
  BANKSEL   PIR1
  BTFSC     PIR1,       RCIF
  GOTO      GETCHAR ; RCIF = 1
  RETURN  ; RCIF = 0
FLSH_N_RET:
  BANKSEL   PIR1
  BTFSC     PIR1,       RCIF
  CALL      FLUSHCHAR ; RCIF = 1
  RETURN  ; RCIF = 0
GETCHAR:
  CALL      FLUSHCHAR
  BANKSEL   CHRBF
  MOVWF     CHRBF
  ; Switch (CURR_CHAR)
  BANKSEL   CURR_CHAR
  MOVF      CURR_CHAR,  W
  ; Case (0x00)
  XORLW     0x00
  BTFSC     STATUS,     Z
  GOTO      CHAR0 ; Z = 1
  ; Case (0x01)
  MOVF      CURR_CHAR,  W
  XORLW     0x01 ; Z = 0
  BTFSC     STATUS,     Z
  GOTO      CHAR1 ; Z = 1
  ; Case (0x02)
  MOVF      CURR_CHAR,  W
  XORLW     0x02 ; Z = 0
  BTFSC     STATUS,     Z
  GOTO      CHROPCODE ; Z = 1
  ; Case (0x03)
  MOVF      CURR_CHAR,  W
  XORLW     0x03 ; Z = 0
  BTFSC     STATUS,     Z
  GOTO      CHRARGS ; Z = 1
  ; Case (0x04)
  MOVF      CURR_CHAR,  W
  XORLW     0x04 ; Z = 0
  BTFSC     STATUS,     Z
  GOTO      COND_ARGS ; Z = 1
  ; ARGN (o CHKSUM) es el último byte con dirección constante.
  BANKSEL   FLAGS ; Z = 0
  BTFSC     FLAGS,      FINALIZADO
  ; FINALIZADO = 1
  GOTO      FINALIZE_ENTRY
  ; FINALIZADO = 0
  GOTO      CAPTURE_ARGS
  ; Default
  ;RETURN ; Z = 0
;...............................................................................
FINALIZE_ENTRY:
  BANKSEL   CHKSM_IDX
  MOVF      CHKSM_IDX,  W
  MOVWF     STK01
  INCF      STK01
  MOVF      STK01,      W
  MOVWF     STK00
  MOVF      CURR_CHAR,  W
  XORWF     STK00
  MOVF      STK00,      W
  BTFSC     STATUS,     Z
  GOTO      CHREXIT0 ; Z = 1
  INCF      STK01    ; Z = 0
  MOVF      STK01,      W
  MOVWF     STK00
  MOVF      CURR_CHAR,  W
  XORWF     STK00
  MOVF      STK00,      W
  BTFSC     STATUS,     Z
  GOTO      CHREXIT1 ; Z = 1
CAPTURE_ARGS:
  BANKSEL   FLAGS
  BTFSC     FLAGS,      MKCHKSUM
  GOTO      CHKSUM
  ; STK06: VALOR
  BANKSEL   CHRBF
  MOVF      CHRBF,      W
  MOVWF     STK06
  ; STK05: ARR_L
  MOVLW     LOW(ORPM01_ARRGS)
  MOVWF     STK05
  ; STK04: ARR_H
  MOVLW     HIGH(ORPM01_ARRGS)
  MOVWF     STK04
  ; STK03: No estoy seguro... FSR?
  ;MOVLW     0x00
  CLRF      STK03
  ; STK02: Tamaño del array
  MOVLW     ARRGS_SIZET
  MOVWF     STK02
  ; STK01: ARGN
  BANKSEL   ORPM01_ARGN
  MOVF      ORPM01_ARGN,  W
  MOVWF     STK01
  ; STK00: ARGS
  BANKSEL   ORPM01_ARGS
  MOVF      ORPM01_ARGS,  W
  MOVWF     STK00
  ; WREG: CURR_CHAR
  BANKSEL   CURR_CHAR
  MOVF      CURR_CHAR,    W
  PAGESEL   __putbuf
  CALL      __putbuf
  PAGESEL  $
  ; 0xFF: Overflow
  ; 0x01: Finalizar
  ; 0x00: Continuar
  MOVWF     STK00
  XORLW     0xFF
  BTFSC     STATUS,     Z
  GOTO      CHAR_NVAL
  MOVF      STK00,      W
  XORLW     0x01
  BTFSC     STATUS,     Z
  GOTO      CAPTURE_END
  MOVF      STK00,      W
  BTFSC     STATUS,     Z
  GOTO      CHAR_VAL
  GOTO      CHAR_NVAL
CAPTURE_END:
  BANKSEL   FLAGS
  BSF       FLAGS,      MKCHKSUM
  GOTO      CHAR_VAL
;...............................................................................
CHREXIT0:       ; CHAR = 0xAA
  BANKSEL   CHRBF
  MOVF      CHRBF,      W
  XORLW     0xAA
  BTFSC     STATUS,     Z
  ; Z = 1, el caracter es 0xAA
  GOTO      CHAR_VAL
  ; Z = 0, el caracter no es 0xAA
  GOTO      CHAR_NVAL
CHREXIT1:       ; CHAR = 0x55
  BANKSEL   CHRBF
  MOVF      CHRBF,      W
  XORLW     0x55
  BTFSS     STATUS,     Z
  ; Z = 0, el caracter no es 0x55
  GOTO      CHAR_NVAL
  ; Z = 1, el caracter es 0x55
  ; -> Elevar la bandera READY
  BANKSEL   ORPM01_FLAGS
  BSF       ORPM01_FLAGS,   ORPM01_READY
  ; -> Reiniciar el contador
  BANKSEL   CURR_CHAR
  CLRF      CURR_CHAR
  RETURN
CHAR0:          ; CHAR = 0xBB
  BANKSEL   CHRBF
  MOVF      CHRBF,      W
  XORLW     0xBB
  BTFSC     STATUS,     Z
  ; Z = 1, el caracter es 0xBB
  GOTO      CHAR_VAL
  ; Z = 0, el caracter no es 0xBB
  GOTO      CHAR_NVAL
CHAR1:          ; CHAR = 0x44
  BANKSEL   CHRBF
  MOVF      CHRBF,      W
  XORLW     0x44
  BTFSC     STATUS,     Z
  ; Z = 1, el caracter es 0x44
  GOTO      CHAR_VAL
  ; Z = 0, el caracter no es 0x44
  GOTO      CHAR_NVAL
CHROPCODE:      ; CHAR = OPCODE
  ; Cualquier valor para OPCODE es considerado válido
  BANKSEL   CHRBF
  MOVF      CHRBF,      W
  BANKSEL   ORPM01_OPCODE
  MOVWF     ORPM01_OPCODE
  GOTO      CHAR_VAL
CHRARGS:        ; CHAR = ARGS
  ; Cualquier valor para ARGS es considerado válido
  BANKSEL   CHRBF
  MOVF      CHRBF,      W
  BANKSEL   ORPM01_ARGS
  MOVWF     ORPM01_ARGS
  GOTO      CHAR_VAL
COND_ARGS:
  ; -> CONDITIONAL ARGS: ARGN no está presente si ARGS es 0
  ; -> ARGN nunca debe ser 0
  BANKSEL   ORPM01_ARGS
  MOVF      ORPM01_ARGS,       W
  XORLW     0x00
  BTFSC     STATUS,     Z
  ; Z = 1, ARGS es 0, saltar a CHKSUM
  GOTO      CHKSUM
  ; Z = 0, ARGS no es 0, guardar ARGN
  BANKSEL   CHRBF
  MOVF      CHRBF,      W
  XORLW     0x00
  BTFSC     STATUS,     Z
  ; Z = 1, ARGN es 0, error
  GOTO      CHAR_NVAL
  ; Z = 0, ARGN no es 0, guardar ARGN
  BANKSEL   ORPM01_ARGN
  MOVWF     ORPM01_ARGN
  GOTO      CHAR_VAL
CHKSUM:
  BANKSEL   FLAGS
  BCF       FLAGS,      MKCHKSUM
  ; __chksum es una rutina implementada en C, el el proyecto adjunto "libsdcc.X"
  MOVLW     ORPM01_ARRGS
  MOVWF     STK04
  MOVLW     HIGH(ORPM01_ARRGS)
  MOVWF     STK03
  MOVLW     0x00
  MOVWF     STK02
  BANKSEL   ORPM01_ARGN
  MOVF      ORPM01_ARGN,W
  MOVWF     STK01
  BANKSEL   ORPM01_ARGS
  MOVF      ORPM01_ARGS,W
  MOVWF     STK00
  BANKSEL   ORPM01_OPCODE
  MOVF      ORPM01_OPCODE,  W
  ;MOVWF    WREG
  PAGESEL   __chksum
  CALL      __chksum
  PAGESEL   $
  MOVWF     STK00
  MOVF      CHRBF,      W
  XORWF     STK00
  MOVF      STK00,      W   ; Afecta Z
  BTFSC     STATUS,     Z
  ; Z = 1, La checksum es válida
  GOTO      CHKSUM_VAL
  ; Z = 0, La checksum es inválida
  GOTO      CHAR_NVAL
CHKSUM_VAL:
  BANKSEL   FLAGS
  BSF       FLAGS,      FINALIZADO
  BANKSEL   CURR_CHAR
  MOVF      CURR_CHAR,   W
  BANKSEL   CHKSM_IDX
  MOVWF     CHKSM_IDX
  GOTO      CHAR_VAL
CHAR_NVAL:
  BANKSEL   CURR_CHAR
  CLRF      CURR_CHAR ; Reinicia el curr_char, ¿el efecto?, ignorar el búfer
  RETURN
CHAR_VAL:
  BANKSEL   CURR_CHAR
  INCF      CURR_CHAR
  RETURN
  
;-------------------------------------------------------------------------------
FLUSHCHAR   CODE
FLUSHCHAR:
  BANKSEL   RCREG
  MOVF      RCREG,      W
  RETURN
  END
  