
_main:
	LDI        R27, 255
	OUT        SPL+0, R27
	LDI        R27, 0
	OUT        SPL+1, R27

;AC_ex4.c,12 :: 		void main()
;AC_ex4.c,14 :: 		setup();
	CALL       _setup+0
;AC_ex4.c,16 :: 		while(1)
L_main0:
;AC_ex4.c,18 :: 		};
	JMP        L_main0
;AC_ex4.c,19 :: 		}
L_end_main:
L__main_end_loop:
	JMP        L__main_end_loop
; end of _main

_setup:

;AC_ex4.c,22 :: 		void setup()
;AC_ex4.c,24 :: 		setup_clock();
	CALL       _setup_clock+0
;AC_ex4.c,25 :: 		setup_GPIO();
	CALL       _setup_GPIO+0
;AC_ex4.c,26 :: 		setup_AC();
	CALL       _setup_AC+0
;AC_ex4.c,27 :: 		}
L_end_setup:
	RET
; end of _setup

_setup_clock:

;AC_ex4.c,30 :: 		void setup_clock()
;AC_ex4.c,32 :: 		asm cli;
	CLI
;AC_ex4.c,33 :: 		OSC_CTRL |= OSC_RC32KEN_bm;
	LDS        R27, OSC_CTRL+0
	SBR        R27, 4
	STS        OSC_CTRL+0, R27
;AC_ex4.c,34 :: 		while(!(OSC_STATUS & OSC_RC32KRDY_bm));
L_setup_clock2:
	LDS        R16, OSC_STATUS+0
	SBRC       R16, 2
	JMP        L_setup_clock3
	JMP        L_setup_clock2
L_setup_clock3:
;AC_ex4.c,35 :: 		OSC_CTRL |= OSC_RC32MEN_bm;
	LDS        R16, OSC_CTRL+0
	ORI        R16, 2
	STS        OSC_CTRL+0, R16
;AC_ex4.c,36 :: 		CPU_CCP = CCP_IOREG_gc;
	LDI        R27, 216
	OUT        CPU_CCP+0, R27
;AC_ex4.c,38 :: 		| CLK_PSBCDIV0_bm))) | CLK_PSADIV_1_gc | CLK_PSBCDIV_2_2_gc);
	LDS        R16, CLK_PSCTRL+0
	ANDI       R16, 128
	ORI        R16, 3
	STS        CLK_PSCTRL+0, R16
;AC_ex4.c,39 :: 		OSC_DFLLCTRL = ((OSC_DFLLCTRL & (~(OSC_RC32MCREF_gm | OSC_RC2MCREF_bm))) |
	LDS        R16, OSC_DFLLCTRL+0
	ANDI       R16, 248
;AC_ex4.c,40 :: 		OSC_RC32MCREF_RC32K_gc);
	STS        OSC_DFLLCTRL+0, R16
;AC_ex4.c,41 :: 		DFLLRC32M_CTRL |= DFLL_ENABLE_bm;
	LDS        R16, DFLLRC32M_CTRL+0
	ORI        R16, 1
	STS        DFLLRC32M_CTRL+0, R16
;AC_ex4.c,42 :: 		while(!(OSC_STATUS & OSC_RC32MRDY_bm));
L_setup_clock4:
	LDS        R16, OSC_STATUS+0
	SBRC       R16, 1
	JMP        L_setup_clock5
	JMP        L_setup_clock4
L_setup_clock5:
;AC_ex4.c,43 :: 		CPU_CCP = CCP_IOREG_gc;
	LDI        R27, 216
	OUT        CPU_CCP+0, R27
;AC_ex4.c,44 :: 		CLK_CTRL = ((CLK_CTRL & (~CLK_SCLKSEL_gm)) | CLK_SCLKSEL_RC32M_gc);
	LDS        R16, CLK_CTRL+0
	ANDI       R16, 248
	ORI        R16, 1
	STS        CLK_CTRL+0, R16
;AC_ex4.c,45 :: 		OSC_CTRL &= (~(OSC_RC2MEN_bm | OSC_XOSCEN_bm | OSC_PLLEN_bm));
	LDS        R16, OSC_CTRL+0
	ANDI       R16, 230
	STS        OSC_CTRL+0, R16
;AC_ex4.c,46 :: 		PORTCFG_CLKEVOUT = 0x00;
	LDI        R27, 0
	STS        PORTCFG_CLKEVOUT+0, R27
;AC_ex4.c,47 :: 		}
L_end_setup_clock:
	RET
; end of _setup_clock

_setup_GPIO:

;AC_ex4.c,50 :: 		void setup_GPIO()
;AC_ex4.c,52 :: 		PORTA_OUT = 0x00;
	LDI        R27, 0
	STS        PORTA_OUT+0, R27
;AC_ex4.c,53 :: 		PORTA_DIR = 0xC0;
	LDI        R27, 192
	STS        PORTA_DIR+0, R27
;AC_ex4.c,54 :: 		PORTCFG_MPCMASK = 0xFF;
	LDI        R27, 255
	STS        PORTCFG_MPCMASK+0, R27
;AC_ex4.c,55 :: 		PORTA_PIN4CTRL = (PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc);
	LDI        R27, 0
	STS        PORTA_PIN4CTRL+0, R27
;AC_ex4.c,56 :: 		PORTA_INTCTRL = ((PORTA_INTCTRL & (~(PORT_INT1LVL_gm | PORT_INT0LVL_gm))) |
	LDS        R16, PORTA_INTCTRL+0
	ANDI       R16, 240
;AC_ex4.c,57 :: 		PORT_INT1LVL_OFF_gc | PORT_INT0LVL_OFF_gc);
	STS        PORTA_INTCTRL+0, R16
;AC_ex4.c,59 :: 		PORTD_OUT = 0x00;
	LDI        R27, 0
	STS        PORTD_OUT+0, R27
;AC_ex4.c,60 :: 		PORTD_DIR = 0x0F;
	LDI        R27, 15
	STS        PORTD_DIR+0, R27
;AC_ex4.c,61 :: 		PORTCFG_MPCMASK = 0xFF;
	LDI        R27, 255
	STS        PORTCFG_MPCMASK+0, R27
;AC_ex4.c,62 :: 		PORTD_PIN6CTRL = (PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc);
	LDI        R27, 0
	STS        PORTD_PIN6CTRL+0, R27
;AC_ex4.c,63 :: 		PORTD_INTCTRL = ((PORTD_INTCTRL & (~(PORT_INT1LVL_gm | PORT_INT0LVL_gm))) |
	LDS        R16, PORTD_INTCTRL+0
	ANDI       R16, 240
;AC_ex4.c,64 :: 		PORT_INT1LVL_OFF_gc | PORT_INT0LVL_OFF_gc);
	STS        PORTD_INTCTRL+0, R16
;AC_ex4.c,65 :: 		}
L_end_setup_GPIO:
	RET
; end of _setup_GPIO

_setup_AC:

;AC_ex4.c,68 :: 		void setup_AC()
;AC_ex4.c,74 :: 		ACA_AC0MUXCTRL = reg_val;
	LDI        R27, 15
	STS        ACA_AC0MUXCTRL+0, R27
;AC_ex4.c,76 :: 		| AC_HYSMODE_LARGE_gc | (1 << AC_ENABLE_bp));
	LDI        R27, 13
	STS        ACA_AC0CTRL+0, R27
;AC_ex4.c,78 :: 		ACA_AC1MUXCTRL = reg_val;
	LDI        R27, 15
	STS        ACA_AC1MUXCTRL+0, R27
;AC_ex4.c,80 :: 		| AC_HYSMODE_SMALL_gc | (1 << AC_ENABLE_bp));
	LDI        R27, 11
	STS        ACA_AC1CTRL+0, R27
;AC_ex4.c,82 :: 		ACA_CTRLA = (1 << AC_AC1OUT_bp) | (1 << AC_AC0OUT_bp);
	LDI        R27, 3
	STS        ACA_CTRLA+0, R27
;AC_ex4.c,83 :: 		ACA_CTRLB = 0x1F;
	LDI        R27, 31
	STS        ACA_CTRLB+0, R27
;AC_ex4.c,85 :: 		ACA_WINCTRL = 0x00;
	LDI        R27, 0
	STS        ACA_WINCTRL+0, R27
;AC_ex4.c,86 :: 		}
L_end_setup_AC:
	RET
; end of _setup_AC
