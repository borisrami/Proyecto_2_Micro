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

	extern PSAVE
	extern SSAVE
	extern WSAVE
;	extern STK12
; La ABI de SDCC provee __sdcc_saved_fsr, pero no estamos usando la ABI de SDCC
; así que en isr.asm he usado STK12 para almacenar PCL, lo que significa que
; no hay STK12
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
	global	_STATUSbits
	global	_PORTAbits
	global	_PORTBbits
	global	_PORTCbits
	global	_PORTDbits
	global	_PORTEbits
	global	_INTCONbits
	global	_PIR1bits
	global	_PIR2bits
	global	_T1CONbits
	global	_T2CONbits
	global	_SSPCONbits
	global	_CCP1CONbits
	global	_RCSTAbits
	global	_CCP2CONbits
	global	_ADCON0bits
	global	_OPTION_REGbits
	global	_TRISAbits
	global	_TRISBbits
	global	_TRISCbits
	global	_TRISDbits
	global	_TRISEbits
	global	_PIE1bits
	global	_PIE2bits
	global	_PCONbits
	global	_OSCCONbits
	global	_OSCTUNEbits
	global	_SSPCON2bits
	global	_MSKbits
	global	_SSPMSKbits
	global	_SSPSTATbits
	global	_WPUBbits
	global	_IOCBbits
	global	_VRCONbits
	global	_TXSTAbits
	global	_SPBRGbits
	global	_SPBRGHbits
	global	_PWM1CONbits
	global	_ECCPASbits
	global	_PSTRCONbits
	global	_ADCON1bits
	global	_WDTCONbits
	global	_CM1CON0bits
	global	_CM2CON0bits
	global	_CM2CON1bits
	global	_SRCONbits
	global	_BAUDCTLbits
	global	_ANSELbits
	global	_ANSELHbits
	global	_EECON1bits
	global	_INDF
	global	_TMR0
	global	_PCL
	global	_STATUS
	global	_FSR
	global	_PORTA
	global	_PORTB
	global	_PORTC
	global	_PORTD
	global	_PORTE
	global	_PCLATH
	global	_INTCON
	global	_PIR1
	global	_PIR2
	global	_TMR1
	global	_TMR1L
	global	_TMR1H
	global	_T1CON
	global	_TMR2
	global	_T2CON
	global	_SSPBUF
	global	_SSPCON
	global	_CCPR1
	global	_CCPR1L
	global	_CCPR1H
	global	_CCP1CON
	global	_RCSTA
	global	_TXREG
	global	_RCREG
	global	_CCPR2
	global	_CCPR2L
	global	_CCPR2H
	global	_CCP2CON
	global	_ADRESH
	global	_ADCON0
	global	_OPTION_REG
	global	_TRISA
	global	_TRISB
	global	_TRISC
	global	_TRISD
	global	_TRISE
	global	_PIE1
	global	_PIE2
	global	_PCON
	global	_OSCCON
	global	_OSCTUNE
	global	_SSPCON2
	global	_PR2
	global	_MSK
	global	_SSPADD
	global	_SSPMSK
	global	_SSPSTAT
	global	_WPUB
	global	_IOCB
	global	_VRCON
	global	_TXSTA
	global	_SPBRG
	global	_SPBRGH
	global	_PWM1CON
	global	_ECCPAS
	global	_PSTRCON
	global	_ADRESL
	global	_ADCON1
	global	_WDTCON
	global	_CM1CON0
	global	_CM2CON0
	global	_CM2CON1
	global	_EEDAT
	global	_EEDATA
	global	_EEADR
	global	_EEDATH
	global	_EEADRH
	global	_SRCON
	global	_BAUDCTL
	global	_ANSEL
	global	_ANSELH
	global	_EECON1
	global	_EECON2

;--------------------------------------------------------
; global definitions
;--------------------------------------------------------
;--------------------------------------------------------
; absolute symbol definitions
;--------------------------------------------------------
UD_abs_pic16f887_0	udata_ovr	0x0000
_INDF
	res	1
UD_abs_pic16f887_1	udata_ovr	0x0001
_TMR0
	res	1
UD_abs_pic16f887_2	udata_ovr	0x0002
_PCL
	res	1
UD_abs_pic16f887_3	udata_ovr	0x0003
_STATUSbits
_STATUS
	res	1
UD_abs_pic16f887_4	udata_ovr	0x0004
_FSR
	res	1
UD_abs_pic16f887_5	udata_ovr	0x0005
_PORTAbits
_PORTA
	res	1
UD_abs_pic16f887_6	udata_ovr	0x0006
_PORTBbits
_PORTB
	res	1
UD_abs_pic16f887_7	udata_ovr	0x0007
_PORTCbits
_PORTC
	res	1
UD_abs_pic16f887_8	udata_ovr	0x0008
_PORTDbits
_PORTD
	res	1
UD_abs_pic16f887_9	udata_ovr	0x0009
_PORTEbits
_PORTE
	res	1
UD_abs_pic16f887_a	udata_ovr	0x000a
_PCLATH
	res	1
UD_abs_pic16f887_b	udata_ovr	0x000b
_INTCONbits
_INTCON
	res	1
UD_abs_pic16f887_c	udata_ovr	0x000c
_PIR1bits
_PIR1
	res	1
UD_abs_pic16f887_d	udata_ovr	0x000d
_PIR2bits
_PIR2
	res	1
UD_abs_pic16f887_e	udata_ovr	0x000e
_TMR1
_TMR1L
	res	1
UD_abs_pic16f887_f	udata_ovr	0x000f
_TMR1H
	res	1
UD_abs_pic16f887_10	udata_ovr	0x0010
_T1CONbits
_T1CON
	res	1
UD_abs_pic16f887_11	udata_ovr	0x0011
_TMR2
	res	1
UD_abs_pic16f887_12	udata_ovr	0x0012
_T2CONbits
_T2CON
	res	1
UD_abs_pic16f887_13	udata_ovr	0x0013
_SSPBUF
	res	1
UD_abs_pic16f887_14	udata_ovr	0x0014
_SSPCONbits
_SSPCON
	res	1
UD_abs_pic16f887_15	udata_ovr	0x0015
_CCPR1
_CCPR1L
	res	1
UD_abs_pic16f887_16	udata_ovr	0x0016
_CCPR1H
	res	1
UD_abs_pic16f887_17	udata_ovr	0x0017
_CCP1CONbits
_CCP1CON
	res	1
UD_abs_pic16f887_18	udata_ovr	0x0018
_RCSTAbits
_RCSTA
	res	1
UD_abs_pic16f887_19	udata_ovr	0x0019
_TXREG
	res	1
UD_abs_pic16f887_1a	udata_ovr	0x001a
_RCREG
	res	1
UD_abs_pic16f887_1b	udata_ovr	0x001b
_CCPR2
_CCPR2L
	res	1
UD_abs_pic16f887_1c	udata_ovr	0x001c
_CCPR2H
	res	1
UD_abs_pic16f887_1d	udata_ovr	0x001d
_CCP2CONbits
_CCP2CON
	res	1
UD_abs_pic16f887_1e	udata_ovr	0x001e
_ADRESH
	res	1
UD_abs_pic16f887_1f	udata_ovr	0x001f
_ADCON0bits
_ADCON0
	res	1
UD_abs_pic16f887_81	udata_ovr	0x0081
_OPTION_REGbits
_OPTION_REG
	res	1
UD_abs_pic16f887_85	udata_ovr	0x0085
_TRISAbits
_TRISA
	res	1
UD_abs_pic16f887_86	udata_ovr	0x0086
_TRISBbits
_TRISB
	res	1
UD_abs_pic16f887_87	udata_ovr	0x0087
_TRISCbits
_TRISC
	res	1
UD_abs_pic16f887_88	udata_ovr	0x0088
_TRISDbits
_TRISD
	res	1
UD_abs_pic16f887_89	udata_ovr	0x0089
_TRISEbits
_TRISE
	res	1
UD_abs_pic16f887_8c	udata_ovr	0x008c
_PIE1bits
_PIE1
	res	1
UD_abs_pic16f887_8d	udata_ovr	0x008d
_PIE2bits
_PIE2
	res	1
UD_abs_pic16f887_8e	udata_ovr	0x008e
_PCONbits
_PCON
	res	1
UD_abs_pic16f887_8f	udata_ovr	0x008f
_OSCCONbits
_OSCCON
	res	1
UD_abs_pic16f887_90	udata_ovr	0x0090
_OSCTUNEbits
_OSCTUNE
	res	1
UD_abs_pic16f887_91	udata_ovr	0x0091
_SSPCON2bits
_SSPCON2
	res	1
UD_abs_pic16f887_92	udata_ovr	0x0092
_PR2
	res	1
UD_abs_pic16f887_93	udata_ovr	0x0093
_MSKbits
_SSPMSKbits
_MSK
_SSPADD
_SSPMSK
	res	1
UD_abs_pic16f887_94	udata_ovr	0x0094
_SSPSTATbits
_SSPSTAT
	res	1
UD_abs_pic16f887_95	udata_ovr	0x0095
_WPUBbits
_WPUB
	res	1
UD_abs_pic16f887_96	udata_ovr	0x0096
_IOCBbits
_IOCB
	res	1
UD_abs_pic16f887_97	udata_ovr	0x0097
_VRCONbits
_VRCON
	res	1
UD_abs_pic16f887_98	udata_ovr	0x0098
_TXSTAbits
_TXSTA
	res	1
UD_abs_pic16f887_99	udata_ovr	0x0099
_SPBRGbits
_SPBRG
	res	1
UD_abs_pic16f887_9a	udata_ovr	0x009a
_SPBRGHbits
_SPBRGH
	res	1
UD_abs_pic16f887_9b	udata_ovr	0x009b
_PWM1CONbits
_PWM1CON
	res	1
UD_abs_pic16f887_9c	udata_ovr	0x009c
_ECCPASbits
_ECCPAS
	res	1
UD_abs_pic16f887_9d	udata_ovr	0x009d
_PSTRCONbits
_PSTRCON
	res	1
UD_abs_pic16f887_9e	udata_ovr	0x009e
_ADRESL
	res	1
UD_abs_pic16f887_9f	udata_ovr	0x009f
_ADCON1bits
_ADCON1
	res	1
UD_abs_pic16f887_105	udata_ovr	0x0105
_WDTCONbits
_WDTCON
	res	1
UD_abs_pic16f887_107	udata_ovr	0x0107
_CM1CON0bits
_CM1CON0
	res	1
UD_abs_pic16f887_108	udata_ovr	0x0108
_CM2CON0bits
_CM2CON0
	res	1
UD_abs_pic16f887_109	udata_ovr	0x0109
_CM2CON1bits
_CM2CON1
	res	1
UD_abs_pic16f887_10c	udata_ovr	0x010c
_EEDAT
_EEDATA
	res	1
UD_abs_pic16f887_10d	udata_ovr	0x010d
_EEADR
	res	1
UD_abs_pic16f887_10e	udata_ovr	0x010e
_EEDATH
	res	1
UD_abs_pic16f887_10f	udata_ovr	0x010f
_EEADRH
	res	1
UD_abs_pic16f887_185	udata_ovr	0x0185
_SRCONbits
_SRCON
	res	1
UD_abs_pic16f887_187	udata_ovr	0x0187
_BAUDCTLbits
_BAUDCTL
	res	1
UD_abs_pic16f887_188	udata_ovr	0x0188
_ANSELbits
_ANSEL
	res	1
UD_abs_pic16f887_189	udata_ovr	0x0189
_ANSELHbits
_ANSELH
	res	1
UD_abs_pic16f887_18c	udata_ovr	0x018c
_EECON1bits
_EECON1
	res	1
UD_abs_pic16f887_18d	udata_ovr	0x018d
_EECON2
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
