; NOTA: IMPLEMENTADO EN C, COMPILADO Y MODIFICADO PARA FUNCIONAR EN MPLAB
;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.7.1 #10260 (MINGW64)
; Flags: -mpic14 -p16f887 --use-non-free --opt-code-speed --peep-asm --peep-return --allow-unsafe-read
;--------------------------------------------------------
; PIC port for the 14-bit core
;--------------------------------------------------------
;	.file	"C:/Users/NoTengoBattery/Documents/Proyecto 2 micro/PIC/Firmware.X/lib/_chksm.c"
	list	p=16f887
	radix dec
	include "p16f887.inc"
;--------------------------------------------------------
; external declarations
;--------------------------------------------------------
	extern	__cmuli
	extern	__gptrget1

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
	global	__chksum

;--------------------------------------------------------
; global definitions
;--------------------------------------------------------
;--------------------------------------------------------
; absolute symbol definitions
;--------------------------------------------------------
;--------------------------------------------------------
; compiler-defined variables
;--------------------------------------------------------
UDL__chksm_0	udata
r0x1000	res	1
r0x1001	res	1
r0x1002	res	1
r0x1005	res	1
r0x1004	res	1
r0x1003	res	1
r0x1007	res	1
r0x1006	res	1
r0x1008	res	1
r0x1009	res	1
r0x100A	res	1
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
code__chksm	code
;***
;  pBlock Stats: dbName = C
;***
;has an exit
;functions called:
;   __cmuli
;   __gptrget1
;   __cmuli
;   __gptrget1
;17 compiler assigned registers:
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
;   r0x1006
;   r0x1007
;   r0x1008
;   r0x1009
;   r0x100A
;   r0x100B
;; Starting pCode block
S__chksm___chksum	code
__chksum:
; 2 exit points
;	.line	20;		uint8_t _chksum(uint8_t opcode, uint8_t args, uint8_t argn, uint8_t arrgs[]){
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
;	.line	21;		if (args == 0){
	MOVF	r0x1001,W
	BTFSS	STATUS,2
	GOTO	_00107_DS_
;	.line	22;		return opcode;
	MOVF	r0x1000,W
	GOTO	_00112_DS_
_00107_DS_:
;	.line	24;		uint16_t size_arrgs = _cmuli(args, argn);
	BANKSEL	r0x1002
	MOVF	r0x1002,W
	MOVWF	STK00
	MOVF	r0x1001,W
	PAGESEL	__cmuli
	CALL	__cmuli
	PAGESEL	$
	BANKSEL	r0x1006
	MOVWF	r0x1006
	MOVF	STK00,W
	MOVWF	r0x1007
;	.line	26;		chksm += args;
	MOVF	r0x1001,W
	ADDWF	r0x1000,F
;	.line	27;		chksm += argn;
	MOVF	r0x1002,W
	ADDWF	r0x1000,F
;	.line	28;		for (uint16_t i = 0; i < size_arrgs; i++){
	CLRF	r0x1001
	CLRF	r0x1002
_00110_DS_:
	BANKSEL	r0x1006
	MOVF	r0x1006,W
	SUBWF	r0x1002,W
	BTFSS	STATUS,2
	GOTO	_00124_DS_
	MOVF	r0x1007,W
	SUBWF	r0x1001,W
_00124_DS_:
	BTFSC	STATUS,0
	GOTO	_00105_DS_
;;genSkipc:3257: created from rifx:0000000004745770
;	.line	29;		chksm += arrgs[i];
	BANKSEL	r0x1001
	MOVF	r0x1001,W
	ADDWF	r0x1005,W
	MOVWF	r0x1008
	MOVF	r0x1004,W
	MOVWF	r0x1009
	MOVF	r0x1002,W
	BTFSC	STATUS,0
	INCFSZ	r0x1002,W
	ADDWF	r0x1009,F
	MOVF	r0x1003,W
	BTFSC	STATUS,0
	ADDLW	0x01
	MOVWF	r0x100A
	MOVF	r0x1008,W
	MOVWF	STK01
	MOVF	r0x1009,W
	MOVWF	STK00
	MOVF	r0x100A,W
	PAGESEL	__gptrget1
	CALL	__gptrget1
	PAGESEL	$
;;1	MOVWF	r0x100B
	BANKSEL	r0x1000
	ADDWF	r0x1000,F
;	.line	28;		for (uint16_t i = 0; i < size_arrgs; i++){
	INCF	r0x1001,F
	BTFSC	STATUS,2
	INCF	r0x1002,F
	GOTO	_00110_DS_
_00105_DS_:
;	.line	31;		return chksm;
	BANKSEL	r0x1000
	MOVF	r0x1000,W
_00112_DS_:
;	.line	33;		}
	RETURN	
; exit point of __chksum


;	code size estimation:
;	   63+   11 =    74 instructions (  170 byte)

	end
