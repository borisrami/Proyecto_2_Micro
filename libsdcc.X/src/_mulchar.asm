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
	global	__mulchar

;--------------------------------------------------------
; global definitions
;--------------------------------------------------------
;--------------------------------------------------------
; absolute symbol definitions
;--------------------------------------------------------
;--------------------------------------------------------
; compiler-defined variables
;--------------------------------------------------------
UDL__mulchar_0	udata
r0x1000	res	1
r0x1001	res	1
r0x1002	res	1
r0x1003	res	1
r0x1004	res	1
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
code__mulchar	code
;***
;  pBlock Stats: dbName = C
;***
;has an exit
;6 compiler assigned registers:
;   r0x1000
;   STK00
;   r0x1001
;   r0x1002
;   r0x1003
;   r0x1004
;; Starting pCode block
S__mulchar___mulchar	code
__mulchar:
; 2 exit points
;	.line	33;		_mulchar (char a, char b)
	BANKSEL	r0x1000
	MOVWF	r0x1000
	MOVF	STK00,W
	MOVWF	r0x1001
;	.line	35;		char result = 0;
	CLRF	r0x1002
;	.line	39;		for (i = 0; i < 8u; i++) {
	MOVLW	0x08
	MOVWF	r0x1003
_00119_DS_:
;	.line	41;		if (a & (unsigned char)0x0001u) result += b;
	BANKSEL	r0x1000
	BTFSS	r0x1000,0
	GOTO	_00114_DS_
	MOVF	r0x1001,W
	ADDWF	r0x1002,F
;;shiftRight_Left2ResultLit:5323: shCount=1, size=1, sign=0, same=1, offr=0
_00114_DS_:
;	.line	45;		a = ((unsigned char)a) >> 1u;
	BCF	STATUS,0
	BANKSEL	r0x1000
	RRF	r0x1000,F
;	.line	46;		b <<= 1u;
	BCF	STATUS,0
	RLF	r0x1001,F
	DECF	r0x1003,W
	MOVWF	r0x1004
	MOVWF	r0x1003
;	.line	39;		for (i = 0; i < 8u; i++) {
	MOVF	r0x1004,W
	BTFSS	STATUS,2
	GOTO	_00119_DS_
;	.line	49;		return result;
	MOVF	r0x1002,W
;	.line	50;		}
	RETURN	
; exit point of __mulchar


;	code size estimation:
;	   22+    3 =    25 instructions (   56 byte)

	end
