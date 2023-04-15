
_main:
	LDI        R27, 255
	OUT        SPL+0, R27
	LDI        R27, 0
	OUT        SPL+1, R27

;AC_ex2.c,12 :: 		void main()
;AC_ex2.c,14 :: 		setup();
	CALL       _setup+0
;AC_ex2.c,16 :: 		while(1);
L_main0:
	JMP        L_main0
;AC_ex2.c,17 :: 		}
L_end_main:
L__main_end_loop:
	JMP        L__main_end_loop
; end of _main

_setup:

;AC_ex2.c,20 :: 		void setup()
;AC_ex2.c,22 :: 		setup_clock();
	CALL       _setup_clock+0
;AC_ex2.c,23 :: 		setup_GPIO();
	CALL       _setup_GPIO+0
;AC_ex2.c,24 :: 		setup_AC();
	CALL       _setup_AC+0
;AC_ex2.c,25 :: 		}
L_end_setup:
	RET
; end of _setup

_setup_clock:

;AC_ex2.c,28 :: 		void setup_clock()
;AC_ex2.c,30 :: 		asm cli;
	CLI
;AC_ex2.c,31 :: 		OSC_CTRL |= OSC_RC32KEN_bm;
	LDS        R27, OSC_CTRL+0
	SBR        R27, 4
	STS        OSC_CTRL+0, R27
;AC_ex2.c,32 :: 		while(!(OSC_STATUS & OSC_RC32KRDY_bm));
L_setup_clock2:
	LDS        R16, OSC_STATUS+0
	SBRC       R16, 2
	JMP        L_setup_clock3
	JMP        L_setup_clock2
L_setup_clock3:
;AC_ex2.c,33 :: 		OSC_CTRL |= OSC_RC32MEN_bm;
	LDS        R16, OSC_CTRL+0
	ORI        R16, 2
	STS        OSC_CTRL+0, R16
;AC_ex2.c,34 :: 		CPU_CCP = CCP_IOREG_gc;
	LDI        R27, 216
	OUT        CPU_CCP+0, R27
;AC_ex2.c,36 :: 		| CLK_PSBCDIV0_bm))) | CLK_PSADIV_1_gc | CLK_PSBCDIV_2_2_gc);
	LDS        R16, CLK_PSCTRL+0
	ANDI       R16, 128
	ORI        R16, 3
	STS        CLK_PSCTRL+0, R16
;AC_ex2.c,37 :: 		OSC_DFLLCTRL = ((OSC_DFLLCTRL & (~(OSC_RC32MCREF_gm | OSC_RC2MCREF_bm))) |
	LDS        R16, OSC_DFLLCTRL+0
	ANDI       R16, 248
;AC_ex2.c,38 :: 		OSC_RC32MCREF_RC32K_gc);
	STS        OSC_DFLLCTRL+0, R16
;AC_ex2.c,39 :: 		DFLLRC32M_CTRL |= DFLL_ENABLE_bm;
	LDS        R16, DFLLRC32M_CTRL+0
	ORI        R16, 1
	STS        DFLLRC32M_CTRL+0, R16
;AC_ex2.c,40 :: 		while(!(OSC_STATUS & OSC_RC32MRDY_bm));
L_setup_clock4:
	LDS        R16, OSC_STATUS+0
	SBRC       R16, 1
	JMP        L_setup_clock5
	JMP        L_setup_clock4
L_setup_clock5:
;AC_ex2.c,41 :: 		CPU_CCP = CCP_IOREG_gc;
	LDI        R27, 216
	OUT        CPU_CCP+0, R27
;AC_ex2.c,42 :: 		CLK_CTRL = ((CLK_CTRL & (~CLK_SCLKSEL_gm)) | CLK_SCLKSEL_RC32M_gc);
	LDS        R16, CLK_CTRL+0
	ANDI       R16, 248
	ORI        R16, 1
	STS        CLK_CTRL+0, R16
;AC_ex2.c,43 :: 		OSC_CTRL &= (~(OSC_RC2MEN_bm | OSC_XOSCEN_bm | OSC_PLLEN_bm));
	LDS        R16, OSC_CTRL+0
	ANDI       R16, 230
	STS        OSC_CTRL+0, R16
;AC_ex2.c,44 :: 		PORTCFG_CLKEVOUT = 0x00;
	LDI        R27, 0
	STS        PORTCFG_CLKEVOUT+0, R27
;AC_ex2.c,45 :: 		}
L_end_setup_clock:
	RET
; end of _setup_clock

_setup_GPIO:

;AC_ex2.c,48 :: 		void setup_GPIO()
;AC_ex2.c,50 :: 		PORTA_OUT = 0x00;
	LDI        R27, 0
	STS        PORTA_OUT+0, R27
;AC_ex2.c,51 :: 		PORTA_DIR = 0xC0;
	LDI        R27, 192
	STS        PORTA_DIR+0, R27
;AC_ex2.c,52 :: 		PORTCFG_MPCMASK = 0xFF;
	LDI        R27, 255
	STS        PORTCFG_MPCMASK+0, R27
;AC_ex2.c,53 :: 		PORTA_PIN4CTRL = (PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc);
	LDI        R27, 0
	STS        PORTA_PIN4CTRL+0, R27
;AC_ex2.c,54 :: 		PORTA_INTCTRL = ((PORTA_INTCTRL & (~(PORT_INT1LVL_gm | PORT_INT0LVL_gm))) |
	LDS        R16, PORTA_INTCTRL+0
	ANDI       R16, 240
;AC_ex2.c,55 :: 		PORT_INT1LVL_OFF_gc | PORT_INT0LVL_OFF_gc);
	STS        PORTA_INTCTRL+0, R16
;AC_ex2.c,56 :: 		}
L_end_setup_GPIO:
	RET
; end of _setup_GPIO

_setup_AC:

;AC_ex2.c,59 :: 		void setup_AC()
;AC_ex2.c,61 :: 		unsigned char regval = 0;
;AC_ex2.c,66 :: 		ACA_AC0MUXCTRL = (AC_MUXPOS_PIN0_gc | AC_MUXNEG_SCALER_gc);
	LDI        R27, 7
	STS        ACA_AC0MUXCTRL+0, R27
;AC_ex2.c,67 :: 		ACA_AC0CTRL = regval;
	LDI        R27, 9
	STS        ACA_AC0CTRL+0, R27
;AC_ex2.c,69 :: 		ACA_AC1MUXCTRL = (AC_MUXPOS_PIN1_gc | AC_MUXNEG_BANDGAP_gc);
	LDI        R27, 14
	STS        ACA_AC1MUXCTRL+0, R27
;AC_ex2.c,70 :: 		ACA_AC1CTRL = regval;
	LDI        R27, 9
	STS        ACA_AC1CTRL+0, R27
;AC_ex2.c,72 :: 		ACA_WINCTRL = 0x00;
	LDI        R27, 0
	STS        ACA_WINCTRL+0, R27
;AC_ex2.c,73 :: 		ACA_CTRLA = ((1 << AC_AC1OUT_bp) | (1 << AC_AC0OUT_bp));
	LDI        R27, 3
	STS        ACA_CTRLA+0, R27
;AC_ex2.c,74 :: 		ACA_CTRLB = 0x1F;
	LDI        R27, 31
	STS        ACA_CTRLB+0, R27
;AC_ex2.c,75 :: 		}
L_end_setup_AC:
	RET
; end of _setup_AC
