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
	global	__cmuli

;--------------------------------------------------------
; global definitions
;--------------------------------------------------------
;--------------------------------------------------------
; absolute symbol definitions
;--------------------------------------------------------
;--------------------------------------------------------
; compiler-defined variables
;--------------------------------------------------------
UDL__cmuli_0	udata
r0x1000	res	1
r0x1001	res	1
r0x1002	res	1
r0x1003	res	1
r0x1004	res	1
r0x1005	res	1
r0x1006	res	1
r0x1007	res	1
r0x1008	res	1
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
code__cmuli	code
;***
;  pBlock Stats: dbName = C
;***
;has an exit
;10 compiler assigned registers:
;   r0x1000
;   STK00
;   r0x1001
;   r0x1002
;   r0x1003
;   r0x1004
;   r0x1005
;   r0x1006
;   r0x1007
;   r0x1008
;; Starting pCode block
S__cmuli___cmuli	code
__cmuli:
; 2 exit points
;	.line	34;		uint16_t _cmuli(uint8_t a, uint8_t b) {
	BANKSEL	r0x1000
	MOVWF	r0x1000
	MOVF	STK00,W
	MOVWF	r0x1001
;	.line	35;		uint16_t result = 0;
	CLRF	r0x1002
	CLRF	r0x1003
;	.line	38;		for (uint8_t i = 0; i < 8u; i++) {
	CLRF	r0x1004
;;unsigned compare: left < lit(0x8=8), size=1
_00118_DS_:
	MOVLW	0x08
	BANKSEL	r0x1004
	SUBWF	r0x1004,W
	BTFSC	STATUS,0
	GOTO	_00116_DS_
;;genSkipc:3257: created from rifx:0000000004745770
;	.line	40;		if (a & 0x0001u) result += b;
	MOVF	r0x1000,W
	MOVWF	r0x1005
	CLRF	r0x1006
	BTFSS	r0x1005,0
	GOTO	_00114_DS_
;;101	MOVF	r0x1001,W
	MOVWF	r0x1005
	CLRF	r0x1006
;;99	MOVF	r0x1005,W
	MOVLW	0x00
	MOVWF	r0x1008
;;100	MOVF	r0x1007,W
	MOVF	r0x1001,W
	MOVWF	r0x1007
	ADDWF	r0x1002,F
	MOVF	r0x1008,W
	BTFSC	STATUS,0
	INCFSZ	r0x1008,W
	ADDWF	r0x1003,F
_00114_DS_:
;	.line	44;		a = ((uint16_t)a) >> 1u;
	BANKSEL	r0x1000
	MOVF	r0x1000,W
	MOVWF	r0x1005
	CLRF	r0x1006
;;shiftRight_Left2ResultLit:5323: shCount=1, size=2, sign=0, same=0, offr=0
	BCF	STATUS,0
	RRF	r0x1006,W
	MOVWF	r0x1008
	RRF	r0x1005,W
	MOVWF	r0x1007
	MOVWF	r0x1000
;	.line	45;		b <<= 1u;
	BCF	STATUS,0
	RLF	r0x1001,F
;	.line	38;		for (uint8_t i = 0; i < 8u; i++) {
	INCF	r0x1004,F
	GOTO	_00118_DS_
_00116_DS_:
;	.line	47;		return result;
	BANKSEL	r0x1002
	MOVF	r0x1002,W
	MOVWF	STK00
	MOVF	r0x1003,W
;	.line	48;		}
	RETURN	
; exit point of __cmuli


;	code size estimation:
;	   43+    4 =    47 instructions (  102 byte)

	end
