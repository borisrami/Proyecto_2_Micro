;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.7.1 #10260 (MINGW64)
; Flags: -mpic14 -p16f887 --use-non-free --opt-code-speed --peep-asm --peep-return --allow-unsafe-read
;-----------------------------------------------------------------------------------------------------------------------
; Esta biblioteca es la biblioteca de dispositivo de SDCC. El prebuilt de cada dispositivo siempre está en el Linker
; Path cuando se generan archivos de SDCC. Este archivo es una compilación directa del archivo pic16f887.c provisto
; por SDCC (adjunto en el proyecto).
;
; Es necesario puesto que los símbolos de MPLINK no son iguales a los requeridos por SDCC, por lo tanto, _gptrget1.S
; genera errores de linker si no se provee este archivo.
;-----------------------------------------------------------------------------------------------------------------------
;--------------------------------------------------------
; PIC port for the 14-bit core
;--------------------------------------------------------
;	.file	"pic16f887.c"
	list	p=16f887
	radix dec
	include "p16f887.inc"
;--------------------------------------------------------
; external declarations
;--------------------------------------------------------
;--------------------------------------------------------
; global declarations
;--------------------------------------------------------
	global	_STATUS
	global	_FSR
	global	_INDF
	global	_PCLATH
	global	_PCL
;--------------------------------------------------------
; global definitions
;--------------------------------------------------------
;--------------------------------------------------------
; absolute symbol definitions
;--------------------------------------------------------
_status_abs	udata_ovr	STATUS
_STATUS
	res	1
_fsr_abs	udata_ovr	FSR
_FSR
	res	1
_indf_abs	udata_ovr	INDF
_INDF
	res	1
_pclath_abs	udata_ovr	PCLATH
_PCLATH
	res	1
_pcl_abs	udata_ovr	PCL
_PCL
	res	1
;--------------------------------------------------------
; compiler-defined variables
;--------------------------------------------------------
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
code_pic16f887	code

;	code size estimation:
;	    0+    0 =     0 instructions (    0 byte)

	end
