; NOTA: IMPLEMENTADO EN C, COMPILADO Y MODIFICADO PARA FUNCIONAR EN MPLAB
;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.7.1 #10260 (MINGW64)
; Flags: -mpic14 -p16f887 --use-non-free --opt-code-speed --peep-asm --peep-return --allow-unsafe-read
;--------------------------------------------------------
; PIC port for the 14-bit core
;--------------------------------------------------------
;	.file	"C:/Users/NoTengoBattery/Documents/Proyecto 2 micro/PIC/Firmware.X/lib/_putbuf.c"
	list	p=16f887
	radix dec
	include "p16f887.inc"
;--------------------------------------------------------
; external declarations
;--------------------------------------------------------
	extern	__gptrget1
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
r0x1001	res	1
r0x1000	res	1
r0x1003	res	1
r0x1006	res	1
r0x1005	res	1
r0x1004	res	1
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
code__putbuf	code
;***
;  pBlock Stats: dbName = C
;***
;has an exit
;functions called:
;   __gptrget1
;   __gptrput1
;   __gptrput1
;   __gptrget1
;   __gptrput1
;   __gptrput1
;16 compiler assigned registers:
;   r0x1000
;   STK00
;   r0x1001
;   STK01
;   r0x1002
;   STK02
;   r0x1003
;   STK03
;   r0x1004
;   STK04
;   r0x1005
;   STK05
;   r0x1006
;   STK06
;   r0x1007
;   r0x1008
;; Starting pCode block
S__putbuf___putbuf	code
__putbuf:
; 2 exit points
;	.line	18; "C:/Users/NoTengoBattery/Documents/Proyecto 2 micro/PIC/Firmware.X/lib/_putbuf.c"	void _putbuf(unsigned char buff[], unsigned char size, unsigned char *idx, unsigned char val){
	BANKSEL	r0x1000
	MOVWF	r0x1000
	MOVF	STK00,W
	MOVWF	r0x1001
	MOVF	STK01,W
	MOVWF	r0x1002
	MOVF	STK02,W
	MOVWF	r0x1003
	MOVF	STK03,W
	MOVWF	r0x1004
	MOVF	STK04,W
	MOVWF	r0x1005
	MOVF	STK05,W
	MOVWF	r0x1006
	MOVF	STK06,W
	MOVWF	r0x1007
;	.line	19; "C:/Users/NoTengoBattery/Documents/Proyecto 2 micro/PIC/Firmware.X/lib/_putbuf.c"	unsigned char vidx = *idx;
	MOVF	r0x1006,W
	MOVWF	STK01
	MOVF	r0x1005,W
	MOVWF	STK00
	MOVF	r0x1004,W
	PAGESEL	__gptrget1
	CALL	__gptrget1
	PAGESEL	$
	BANKSEL	r0x1008
	MOVWF	r0x1008
;	.line	20; "C:/Users/NoTengoBattery/Documents/Proyecto 2 micro/PIC/Firmware.X/lib/_putbuf.c"	if(vidx >= size){return;}
	MOVF	r0x1003,W
;	.line	21; "C:/Users/NoTengoBattery/Documents/Proyecto 2 micro/PIC/Firmware.X/lib/_putbuf.c"	buff[vidx] = val;
	SUBWF	r0x1008,W
	BTFSC	STATUS,0
	GOTO	_00107_DS_
	MOVF	r0x1008,W
	ADDWF	r0x1002,F
	MOVF	r0x1001,W
	BTFSC	STATUS,0
	ADDLW	0x01
	MOVWF	r0x1001
	MOVF	r0x1000,W
	BTFSC	STATUS,0
	ADDLW	0x01
	MOVWF	r0x1000
	MOVF	r0x1007,W
	MOVWF	STK02
	MOVF	r0x1002,W
	MOVWF	STK01
	MOVF	r0x1001,W
	MOVWF	STK00
	MOVF	r0x1000,W
	PAGESEL	__gptrput1
	CALL	__gptrput1
	PAGESEL	$
;	.line	22; "C:/Users/NoTengoBattery/Documents/Proyecto 2 micro/PIC/Firmware.X/lib/_putbuf.c"	*idx = vidx + 1;
	BANKSEL	r0x1008
	MOVF	r0x1008,W
	MOVWF	r0x1002
	INCF	r0x1002,W
	MOVWF	r0x1008
	MOVWF	STK02
	MOVF	r0x1006,W
	MOVWF	STK01
	MOVF	r0x1005,W
	MOVWF	STK00
	MOVF	r0x1004,W
	PAGESEL	__gptrput1
	CALL	__gptrput1
	PAGESEL	$
_00107_DS_:
;	.line	23; "C:/Users/NoTengoBattery/Documents/Proyecto 2 micro/PIC/Firmware.X/lib/_putbuf.c"	}
	RETURN	
; exit point of __putbuf


;	code size estimation:
;	   56+    9 =    65 instructions (  148 byte)

	end
