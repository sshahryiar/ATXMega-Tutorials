
_main:
	LDI        R27, 255
	OUT        SPL+0, R27
	LDI        R27, 0
	OUT        SPL+1, R27
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 6
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;XMega_DAC.c,13 :: 		void main()
;XMega_DAC.c,15 :: 		signed int temp1 = 0;
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
;XMega_DAC.c,16 :: 		signed int temp2 = 0;
;XMega_DAC.c,17 :: 		unsigned int degree = 0;
;XMega_DAC.c,19 :: 		setup();
	CALL       _setup+0
;XMega_DAC.c,21 :: 		while(1)
L_main0:
;XMega_DAC.c,23 :: 		for(degree = 0; degree < 360; degree++)
	LDI        R27, 0
	STD        Y+4, R27
	STD        Y+5, R27
L_main2:
	LDD        R16, Y+4
	LDD        R17, Y+5
	CPI        R17, 1
	BRNE       L__main20
	CPI        R16, 104
L__main20:
	BRLO       L__main21
	JMP        L_main3
L__main21:
;XMega_DAC.c,25 :: 		temp1 = (2047 * cos(degree * 0.0174532925));
	LDD        R16, Y+4
	LDD        R17, Y+5
	LDI        R18, 0
	MOV        R19, R18
	CALL       _float_ulong2fp+0
	LDI        R20, 53
	LDI        R21, 250
	LDI        R22, 142
	LDI        R23, 60
	CALL       _float_fpmul1+0
	MOVW       R2, R16
	MOVW       R4, R18
	CALL       _cos+0
	LDI        R20, 0
	LDI        R21, 224
	LDI        R22, 255
	LDI        R23, 68
	CALL       _float_fpmul1+0
	CALL       _float_fpint+0
;XMega_DAC.c,26 :: 		temp1 = (2048 - temp1);
	MOVW       R0, R16
	LDI        R16, 0
	LDI        R17, 8
	SUB        R16, R0
	SBC        R17, R1
	STD        Y+0, R16
	STD        Y+1, R17
;XMega_DAC.c,27 :: 		temp2 = (2047 * sin(degree * 0.0174532925));
	LDD        R16, Y+4
	LDD        R17, Y+5
	LDI        R18, 0
	MOV        R19, R18
	CALL       _float_ulong2fp+0
	LDI        R20, 53
	LDI        R21, 250
	LDI        R22, 142
	LDI        R23, 60
	CALL       _float_fpmul1+0
	MOVW       R2, R16
	MOVW       R4, R18
	CALL       _sin+0
	LDI        R20, 0
	LDI        R21, 224
	LDI        R22, 255
	LDI        R23, 68
	CALL       _float_fpmul1+0
	CALL       _float_fpint+0
;XMega_DAC.c,28 :: 		temp2 = (2048 - temp2);
	MOVW       R0, R16
	LDI        R16, 0
	LDI        R17, 8
	SUB        R16, R0
	SBC        R17, R1
	STD        Y+2, R16
	STD        Y+3, R17
;XMega_DAC.c,29 :: 		dac_write(0, ((unsigned int)temp1));
	LDD        R3, Y+0
	LDD        R4, Y+1
	CLR        R2
	CALL       _dac_write+0
;XMega_DAC.c,30 :: 		dac_write(1, ((unsigned int)temp2));
	LDD        R3, Y+2
	LDD        R4, Y+3
	LDI        R27, 1
	MOV        R2, R27
	CALL       _dac_write+0
;XMega_DAC.c,31 :: 		delay_us(10);
	LDI        R16, 26
L_main5:
	DEC        R16
	BRNE       L_main5
	NOP
	NOP
;XMega_DAC.c,23 :: 		for(degree = 0; degree < 360; degree++)
	LDD        R16, Y+4
	LDD        R17, Y+5
	SUBI       R16, 255
	SBCI       R17, 255
	STD        Y+4, R16
	STD        Y+5, R17
;XMega_DAC.c,32 :: 		}
	JMP        L_main2
L_main3:
;XMega_DAC.c,33 :: 		};
	JMP        L_main0
;XMega_DAC.c,34 :: 		}
L_end_main:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
L__main_end_loop:
	JMP        L__main_end_loop
; end of _main

_setup:

;XMega_DAC.c,37 :: 		void setup()
;XMega_DAC.c,39 :: 		clock_setup();
	CALL       _clock_setup+0
;XMega_DAC.c,40 :: 		io_setup();
	CALL       _io_setup+0
;XMega_DAC.c,41 :: 		dac_Setup();
	CALL       _dac_Setup+0
;XMega_DAC.c,42 :: 		}
L_end_setup:
	RET
; end of _setup

_clock_setup:

;XMega_DAC.c,45 :: 		void clock_setup()
;XMega_DAC.c,47 :: 		OSC_CTRL |= OSC_RC32KEN_bm;
	LDS        R27, OSC_CTRL+0
	SBR        R27, 4
	STS        OSC_CTRL+0, R27
;XMega_DAC.c,48 :: 		while(!(OSC_STATUS & OSC_RC32KRDY_bm));
L_clock_setup7:
	LDS        R16, OSC_STATUS+0
	SBRC       R16, 2
	JMP        L_clock_setup8
	JMP        L_clock_setup7
L_clock_setup8:
;XMega_DAC.c,49 :: 		OSC_CTRL |= OSC_RC32MEN_bm;
	LDS        R16, OSC_CTRL+0
	ORI        R16, 2
	STS        OSC_CTRL+0, R16
;XMega_DAC.c,50 :: 		CPU_CCP = CCP_IOREG_gc;
	LDI        R27, 216
	OUT        CPU_CCP+0, R27
;XMega_DAC.c,52 :: 		| CLK_PSBCDIV0_bm))) | CLK_PSADIV_1_gc | CLK_PSBCDIV_2_2_gc);
	LDS        R16, CLK_PSCTRL+0
	ANDI       R16, 128
	ORI        R16, 3
	STS        CLK_PSCTRL+0, R16
;XMega_DAC.c,53 :: 		OSC_DFLLCTRL = ((OSC_DFLLCTRL & (~(OSC_RC32MCREF_gm | OSC_RC2MCREF_bm))) |
	LDS        R16, OSC_DFLLCTRL+0
	ANDI       R16, 248
;XMega_DAC.c,54 :: 		OSC_RC32MCREF_RC32K_gc);
	STS        OSC_DFLLCTRL+0, R16
;XMega_DAC.c,55 :: 		DFLLRC32M_CTRL |= DFLL_ENABLE_bm;
	LDS        R16, DFLLRC32M_CTRL+0
	ORI        R16, 1
	STS        DFLLRC32M_CTRL+0, R16
;XMega_DAC.c,56 :: 		while(!(OSC_STATUS & OSC_RC32MRDY_bm));
L_clock_setup9:
	LDS        R16, OSC_STATUS+0
	SBRC       R16, 1
	JMP        L_clock_setup10
	JMP        L_clock_setup9
L_clock_setup10:
;XMega_DAC.c,57 :: 		CPU_CCP = CCP_IOREG_gc;
	LDI        R27, 216
	OUT        CPU_CCP+0, R27
;XMega_DAC.c,58 :: 		CLK_CTRL = ((CLK_CTRL & (~CLK_SCLKSEL_gm)) | CLK_SCLKSEL_RC32M_gc);
	LDS        R16, CLK_CTRL+0
	ANDI       R16, 248
	ORI        R16, 1
	STS        CLK_CTRL+0, R16
;XMega_DAC.c,59 :: 		OSC_CTRL &= (~(OSC_RC2MEN_bm | OSC_XOSCEN_bm | OSC_PLLEN_bm));
	LDS        R16, OSC_CTRL+0
	ANDI       R16, 230
	STS        OSC_CTRL+0, R16
;XMega_DAC.c,60 :: 		PORTCFG_CLKEVOUT = 0x00;
	LDI        R27, 0
	STS        PORTCFG_CLKEVOUT+0, R27
;XMega_DAC.c,61 :: 		}
L_end_clock_setup:
	RET
; end of _clock_setup

_io_setup:

;XMega_DAC.c,64 :: 		void io_setup()
;XMega_DAC.c,66 :: 		PORTB_OUT = 0x00;
	LDI        R27, 0
	STS        PORTB_OUT+0, R27
;XMega_DAC.c,67 :: 		PORTB_DIR = 0x0C;
	LDI        R27, 12
	STS        PORTB_DIR+0, R27
;XMega_DAC.c,68 :: 		PORTB_PIN0CTRL = (PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc);
	LDI        R27, 0
	STS        PORTB_PIN0CTRL+0, R27
;XMega_DAC.c,69 :: 		PORTB_PIN1CTRL = (PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc);
	LDI        R27, 0
	STS        PORTB_PIN1CTRL+0, R27
;XMega_DAC.c,70 :: 		PORTB_PIN2CTRL = (PORT_OPC_TOTEM_gc | PORT_ISC_INPUT_DISABLE_gc);
	LDI        R27, 7
	STS        PORTB_PIN2CTRL+0, R27
;XMega_DAC.c,71 :: 		PORTB_PIN3CTRL = (PORT_OPC_TOTEM_gc | PORT_ISC_INPUT_DISABLE_gc);
	LDI        R27, 7
	STS        PORTB_PIN3CTRL+0, R27
;XMega_DAC.c,72 :: 		PORTB_INT0MASK = 0x00;
	LDI        R27, 0
	STS        PORTB_INT0MASK+0, R27
;XMega_DAC.c,73 :: 		PORTB_INT1MASK = 0x00;
	LDI        R27, 0
	STS        PORTB_INT1MASK+0, R27
;XMega_DAC.c,74 :: 		}
L_end_io_setup:
	RET
; end of _io_setup

_dac_setup:

;XMega_DAC.c,77 :: 		void dac_setup()
;XMega_DAC.c,80 :: 		| DAC_LPMODE_bm))) | DAC_CH0EN_bm | DAC_CH1EN_bm | DAC_ENABLE_bm);
	LDS        R16, DACB_CTRLA+0
	ANDI       R16, 225
	ORI        R16, 4
	ORI        R16, 8
	ORI        R16, 1
	STS        DACB_CTRLA+0, R16
;XMega_DAC.c,82 :: 		| DAC_CH1TRIG_bm))) | DAC_CHSEL_DUAL_gc);
	LDS        R16, DACB_CTRLB+0
	ANDI       R16, 156
	ORI        R16, 64
	STS        DACB_CTRLB+0, R16
;XMega_DAC.c,83 :: 		DACB_CTRLC = ((DACB_CTRLC & (~(DAC_REFSEL_gm | DAC_LEFTADJ_bm)))
	LDS        R16, DACB_CTRLC+0
	ANDI       R16, 234
;XMega_DAC.c,84 :: 		| DAC_REFSEL_AVCC_gc);
	ORI        R16, 8
	STS        DACB_CTRLC+0, R16
;XMega_DAC.c,85 :: 		}
L_end_dac_setup:
	RET
; end of _dac_setup

_dac_write:

;XMega_DAC.c,88 :: 		void dac_write(unsigned char channel, unsigned int value)
;XMega_DAC.c,90 :: 		switch(channel)
	JMP        L_dac_write11
;XMega_DAC.c,92 :: 		case 0:
L_dac_write13:
;XMega_DAC.c,94 :: 		while(!(DACB_STATUS & DAC_CH0DRE_bm));
L_dac_write14:
	LDS        R16, DACB_STATUS+0
	SBRC       R16, 0
	JMP        L_dac_write15
	JMP        L_dac_write14
L_dac_write15:
;XMega_DAC.c,95 :: 		DACB_CH0DATA = value;
	STS        DACB_CH0DATA+0, R3
	STS        DACB_CH0DATA+1, R4
;XMega_DAC.c,96 :: 		break;
	JMP        L_dac_write12
;XMega_DAC.c,98 :: 		case 1:
L_dac_write16:
;XMega_DAC.c,100 :: 		while(!(DACB_STATUS & DAC_CH1DRE_bm));
L_dac_write17:
	LDS        R16, DACB_STATUS+0
	SBRC       R16, 1
	JMP        L_dac_write18
	JMP        L_dac_write17
L_dac_write18:
;XMega_DAC.c,101 :: 		DACB_CH1DATA = value;
	STS        DACB_CH1DATA+0, R3
	STS        DACB_CH1DATA+1, R4
;XMega_DAC.c,102 :: 		break;
	JMP        L_dac_write12
;XMega_DAC.c,104 :: 		}
L_dac_write11:
	LDI        R27, 0
	CP         R2, R27
	BRNE       L__dac_write28
	JMP        L_dac_write13
L__dac_write28:
	LDI        R27, 1
	CP         R2, R27
	BRNE       L__dac_write29
	JMP        L_dac_write16
L__dac_write29:
L_dac_write12:
;XMega_DAC.c,105 :: 		}
L_end_dac_write:
	RET
; end of _dac_write
