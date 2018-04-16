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
;-------------------------------------------------------------------------------
; initialized data
;-------------------------------------------------------------------------------
SLVRCI      idata
CURR_CHAR
  DB 0x00
;-------------------------------------------------------------------------------
; uninitialized data
;-------------------------------------------------------------------------------
SLVRCIU      udata
CHRBF        RES      1
CMDBUF       RES      1+3   ; 1 para opcode, 3 para los argumentos máximo
;-------------------------------------------------------------------------------
; global declarations
;-------------------------------------------------------------------------------
  GLOBAL    RCV_LOOPER
;-------------------------------------------------------------------------------
; code
;-------------------------------------------------------------------------------
RCV_LOOPER  CODE
RCV_LOOPER:
  PAGESEL   $
  BANKSEL   PIR1
  BTFSC     PIR1,       RCIF
  GOTO      GETCHAR ; RCIF = 1
  RETURN  ; RCIF = 0
GETCHAR:
  CALL      FLUSHCHAR
  PAGESEL   $
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
  XORLW     0x01 ; Z = 0
  BTFSC     STATUS,     Z
  GOTO      CHAR1 ; Z = 1
  ; Case (0x02)
  XORLW     0x02 ; Z = 0
CHAR0:      ; CHAR0 = 0x44
  BANKSEL   CHRBF
  MOVF      CHRBF,  W
  XORLW     0xBB
  BTFSC     STATUS,     Z
  ; Z = 1, el caracter es 0xBB
  GOTO      CHAR_VAL
  ; Z = 0, el caracter no es 0xBB
  GOTO      CHAR_NVAL
CHAR1:
  BANKSEL   CHRBF
  MOVF      CHRBF,  W
  XORLW     0x44
  BTFSC     STATUS,     Z
  ; Z = 1, el caracter es 0x44
  GOTO      CHAR_VAL
  ; Z = 0, el caracter no es 0x44
  GOTO      CHAR_NVAL
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
  PAGESEL   $
  BANKSEL   RCREG
  MOVF      RCREG,      W
  RETURN
  END
  