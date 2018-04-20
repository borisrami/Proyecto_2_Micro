; NOTA: IMPLEMENTADO EN C, COMPILADO Y MODIFICADO PARA FUNCIONAR EN MPLAB
;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.7.1 #10260 (MINGW64)
; Flags: -mpic14 -p16f887 --use-non-free --opt-code-speed --peep-asm --peep-return --allow-unsafe-read
;--------------------------------------------------------
; PIC port for the 14-bit core
;--------------------------------------------------------
	list	p=16f887
	radix dec
	include "p16f887.inc"
;--------------------------------------------------------
; external declarations
;--------------------------------------------------------
	extern	__mulchar
	extern	__gptrput1

	extern PSAVE
	extern SSAVE
	extern WSAVE
;	extern STK12
;   We don't provide STK12 as we use that register to save PCL during the ISR
	extern STK11
	extern STK10
	extern STK09
	extern STK08
	extern STK07
	extern STK06
	extern STK05
	extern STK04
	extern STK03
	extern STK02
	extern STK01
	extern STK00
;--------------------------------------------------------
; global declarations
;--------------------------------------------------------
	global	__putbuf

;--------------------------------------------------------
; global definitions
;--------------------------------------------------------
;--------------------------------------------------------
; absolute symbol definitions
;--------------------------------------------------------
;--------------------------------------------------------
; compiler-defined variables
;--------------------------------------------------------
UDL__putbuf_0	udata
r0x1002	res	1
r0x1003	res	1
r0x1004	res	1
r0x1005	res	1
r0x1008	res	1
r0x1007	res	1
r0x1006	res	1
r0x1009	res	1
__putbuf_idx_1_3	res	1
__putbuf_left_1_3	res	1
;--------------------------------------------------------
; initialized data
;--------------------------------------------------------
;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
;	udata_ovr
;--------------------------------------------------------
; code
;--------------------------------------------------------
code__putbuf	code
;***
;  pBlock Stats: dbName = C
;***
;has an exit
;functions called:
;   __mulchar
;   __gptrput1
;   __mulchar
;   __gptrput1
;15 compiler assigned registers:
;   r0x1002
;   STK00
;   r0x1003
;   STK01
;   r0x1004
;   STK02
;   r0x1005
;   STK03
;   r0x1006
;   STK04
;   r0x1007
;   STK05
;   r0x1008
;   STK06
;   r0x1009
;; Starting pCode block
S__putbuf___putbuf	code
__putbuf:
; 2 exit points
;	.line	20;		char _putbuf(unsigned char curr_char,
	BANKSEL	r0x1002
	MOVWF	r0x1002
	MOVF	STK00,W
	MOVWF	r0x1003
	MOVF	STK01,W
	MOVWF	r0x1004
	MOVF	STK02,W
	MOVWF	r0x1005
	MOVF	STK03,W
	MOVWF	r0x1006
	MOVF	STK04,W
	MOVWF	r0x1007
	MOVF	STK05,W
	MOVWF	r0x1008
	MOVF	STK06,W
	MOVWF	r0x1009
;	.line	28;		if(curr_char==0x05){idx = 0x00;left = args*argn;}
	MOVF	r0x1002,W
	XORLW	0x05
	BTFSS	STATUS,2
	GOTO	_00106_DS_
	BANKSEL	__putbuf_idx_1_3
	CLRF	__putbuf_idx_1_3
	BANKSEL	r0x1004
	MOVF	r0x1004,W
	MOVWF	STK00
	MOVF	r0x1003,W
	PAGESEL	__mulchar
	CALL	__mulchar
	PAGESEL	$
	BANKSEL	__putbuf_left_1_3
	MOVWF	__putbuf_left_1_3
_00106_DS_:
;	.line	29;		if(idx >= size){return 0xFF;}
	BANKSEL	r0x1005
	MOVF	r0x1005,W
	BANKSEL	__putbuf_idx_1_3
	SUBWF	__putbuf_idx_1_3,W
	BTFSS	STATUS,0
	GOTO	_00108_DS_
;;genSkipc:3257: created from rifx:0000000004745770
	MOVLW	0xff
	GOTO	_00109_DS_
_00108_DS_:
;	.line	30;		buff[idx] = val;
	BANKSEL	__putbuf_idx_1_3
	MOVF	__putbuf_idx_1_3,W
	BANKSEL	r0x1008
	ADDWF	r0x1008,F
	MOVF	r0x1007,W
	BTFSC	STATUS,0
	ADDLW	0x01
	MOVWF	r0x1007
	MOVF	r0x1006,W
	BTFSC	STATUS,0
	ADDLW	0x01
	MOVWF	r0x1006
	MOVF	r0x1009,W
	MOVWF	STK02
	MOVF	r0x1008,W
	MOVWF	STK01
	MOVF	r0x1007,W
	MOVWF	STK00
	MOVF	r0x1006,W
	PAGESEL	__gptrput1
	CALL	__gptrput1
	PAGESEL	$
;	.line	31;		left -= 1;
	BANKSEL	__putbuf_left_1_3
	MOVF	__putbuf_left_1_3,W
	BANKSEL	r0x1002
	MOVWF	r0x1002
	DECF	r0x1002,W
	BANKSEL	__putbuf_left_1_3
	MOVWF	__putbuf_left_1_3
;	.line	32;		idx += 1;
	BANKSEL	__putbuf_idx_1_3
	MOVF	__putbuf_idx_1_3,W
	BANKSEL	r0x1002
	MOVWF	r0x1002
	INCF	r0x1002,W
	BANKSEL	__putbuf_idx_1_3
	MOVWF	__putbuf_idx_1_3
;	.line	33;		return left==0?0x01:0x00;
	BANKSEL	__putbuf_left_1_3
	MOVF	__putbuf_left_1_3,W
	BTFSS	STATUS,2
	GOTO	_00111_DS_
	MOVLW	0x01
	BANKSEL	r0x1002
	MOVWF	r0x1002
	CLRF	r0x1003
	GOTO	_00112_DS_
_00111_DS_:
	BANKSEL	r0x1002
	CLRF	r0x1002
	CLRF	r0x1003
_00112_DS_:
	BANKSEL	r0x1002
	MOVF	r0x1002,W
	MOVWF	r0x1004
_00109_DS_:
;	.line	34;		}
	RETURN	
; exit point of __putbuf


;	code size estimation:
;	   69+   22 =    91 instructions (  226 byte)

	end
