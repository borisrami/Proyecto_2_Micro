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
;--------------------------------------------------------
; global declarations
;--------------------------------------------------------
	global	_fast_map_255_70

;--------------------------------------------------------
; global definitions
;--------------------------------------------------------
;--------------------------------------------------------
; absolute symbol definitions
;--------------------------------------------------------
;--------------------------------------------------------
; compiler-defined variables
;--------------------------------------------------------
UDL__maputil_0	udata
r0x1000	res	1
r0x1001	res	1
r0x1002	res	1
r0x1003	res	1
r0x1004	res	1
r0x1005	res	1
r0x1006	res	1
r0x1007	res	1
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
code__maputil	code
;***
;  pBlock Stats: dbName = C
;***
;has an exit
;8 compiler assigned registers:
;   r0x1000
;   r0x1001
;   r0x1002
;   r0x1003
;   r0x1004
;   r0x1005
;   r0x1006
;   r0x1007
;; Starting pCode block
S__maputil__fast_map_255_70	code
_fast_map_255_70:
; 2 exit points
	BANKSEL	r0x1003
	MOVWF	r0x1003
;	.line	56;		uint8_t fast_map_255_70(uint8_t x){
	MOVWF	r0x1000
;	.line	60;		uint16_t ex = ((uint16_t)x);
	MOVWF	r0x1001
	CLRF	r0x1002
;;109	MOVF	r0x1000,W
;	.line	61;		ex += x<<1;
	CLRF	r0x1004
	BCF	STATUS,0
	RLF	r0x1003,W
	MOVWF	r0x1006
	MOVWF	r0x1000
	RLF	r0x1004,W
	MOVWF	r0x1007
	MOVWF	r0x1005
;;99	MOVF	r0x1000,W
;;104	MOVF	r0x1005,W
	MOVF	r0x1006,W
	ADDWF	r0x1001,F
	MOVF	r0x1007,W
	BTFSC	STATUS,0
	INCFSZ	r0x1007,W
	ADDWF	r0x1002,F
;	.line	62;		ex += x<<2;
	BCF	STATUS,0
	RLF	r0x1003,W
	MOVWF	r0x1000
	RLF	r0x1004,W
	MOVWF	r0x1005
	BCF	STATUS,0
	RLF	r0x1000,F
	RLF	r0x1005,F
;;106	MOVF	r0x1000,W
;;108	MOVF	r0x1005,W
;;105	MOVF	r0x1006,W
	MOVF	r0x1000,W
	MOVWF	r0x1006
	ADDWF	r0x1001,F
;;107	MOVF	r0x1007,W
	MOVF	r0x1005,W
	MOVWF	r0x1007
	BTFSC	STATUS,0
	INCFSZ	r0x1007,W
	ADDWF	r0x1002,F
;	.line	63;		ex += x<<6;
	SWAPF	r0x1004,W
	ANDLW	0xf0
	MOVWF	r0x1005
	SWAPF	r0x1003,W
	MOVWF	r0x1000
	ANDLW	0x0f
	IORWF	r0x1005,F
	XORWF	r0x1000,F
	BCF	STATUS,0
	RLF	r0x1000,F
	RLF	r0x1005,F
	BCF	STATUS,0
	RLF	r0x1000,F
	RLF	r0x1005,F
;;101	MOVF	r0x1000,W
;;103	MOVF	r0x1005,W
;;100	MOVF	r0x1003,W
	MOVF	r0x1000,W
	MOVWF	r0x1003
	ADDWF	r0x1001,F
;;102	MOVF	r0x1004,W
	MOVF	r0x1005,W
	MOVWF	r0x1004
	BTFSC	STATUS,0
	INCFSZ	r0x1004,W
	ADDWF	r0x1002,F
;	.line	64;		ex = ex>>8;
	MOVF	r0x1002,W
	MOVWF	r0x1001
	CLRF	r0x1002
;	.line	65;		return ex;
	MOVF	r0x1001,W
	MOVWF	r0x1000
;	.line	66;		}
	RETURN	
; exit point of _fast_map_255_70


;	code size estimation:
;	   62+    1 =    63 instructions (  128 byte)

	end
