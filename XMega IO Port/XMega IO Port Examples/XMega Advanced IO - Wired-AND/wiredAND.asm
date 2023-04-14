
_main:
	LDI        R27, 255
	OUT        SPL+0, R27
	LDI        R27, 0
	OUT        SPL+1, R27

;wiredAND.c,8 :: 		void main()
;wiredAND.c,10 :: 		setup();
	CALL       _setup+0
;wiredAND.c,12 :: 		while(1)
L_main0:
;wiredAND.c,14 :: 		PORTA_OUT.B1 = ~PORTA_IN.B0;
	LDS        R27, PORTA_IN+0
	LDS        R0, PORTA_OUT+0
	CLT
	SBRS       R27, 0
	SET
	BLD        R0, 1
	STS        PORTA_OUT+0, R0
;wiredAND.c,15 :: 		};
	JMP        L_main0
;wiredAND.c,16 :: 		}
L_end_main:
L__main_end_loop:
	JMP        L__main_end_loop
; end of _main

_setup:

;wiredAND.c,19 :: 		void setup()
;wiredAND.c,21 :: 		OSC_CTRL |= OSC_RC32KEN_bm;
	LDS        R27, OSC_CTRL+0
	SBR        R27, 4
	STS        OSC_CTRL+0, R27
;wiredAND.c,22 :: 		while(!(OSC_STATUS & OSC_RC32KRDY_bm));
L_setup2:
	LDS        R16, OSC_STATUS+0
	SBRC       R16, 2
	JMP        L_setup3
	JMP        L_setup2
L_setup3:
;wiredAND.c,23 :: 		OSC_CTRL |= OSC_RC32MEN_bm;
	LDS        R16, OSC_CTRL+0
	ORI        R16, 2
	STS        OSC_CTRL+0, R16
;wiredAND.c,24 :: 		CPU_CCP = CCP_IOREG_gc;
	LDI        R27, 216
	OUT        CPU_CCP+0, R27
;wiredAND.c,25 :: 		CLK_PSCTRL = ((CLK_PSCTRL & (~(CLK_PSADIV_gm | CLK_PSBCDIV1_bm | CLK_PSBCDIV0_bm)))
	LDS        R16, CLK_PSCTRL+0
	ANDI       R16, 128
;wiredAND.c,26 :: 		| CLK_PSADIV_1_gc | CLK_PSBCDIV_2_2_gc);
	ORI        R16, 3
	STS        CLK_PSCTRL+0, R16
;wiredAND.c,27 :: 		OSC_DFLLCTRL = ((OSC_DFLLCTRL & (~(OSC_RC32MCREF_gm | OSC_RC2MCREF_bm))) |
	LDS        R16, OSC_DFLLCTRL+0
	ANDI       R16, 248
;wiredAND.c,28 :: 		OSC_RC32MCREF_RC32K_gc);
	STS        OSC_DFLLCTRL+0, R16
;wiredAND.c,29 :: 		DFLLRC32M_CTRL|=DFLL_ENABLE_bm;
	LDS        R16, DFLLRC32M_CTRL+0
	ORI        R16, 1
	STS        DFLLRC32M_CTRL+0, R16
;wiredAND.c,30 :: 		while (!(OSC_STATUS & OSC_RC32MRDY_bm));
L_setup4:
	LDS        R16, OSC_STATUS+0
	SBRC       R16, 1
	JMP        L_setup5
	JMP        L_setup4
L_setup5:
;wiredAND.c,31 :: 		CPU_CCP = CCP_IOREG_gc;
	LDI        R27, 216
	OUT        CPU_CCP+0, R27
;wiredAND.c,32 :: 		CLK_CTRL = ((CLK_CTRL & (~CLK_SCLKSEL_gm)) | CLK_SCLKSEL_RC32M_gc);
	LDS        R16, CLK_CTRL+0
	ANDI       R16, 248
	ORI        R16, 1
	STS        CLK_CTRL+0, R16
;wiredAND.c,33 :: 		OSC_CTRL &= (~(OSC_RC2MEN_bm | OSC_XOSCEN_bm | OSC_PLLEN_bm));
	LDS        R16, OSC_CTRL+0
	ANDI       R16, 230
	STS        OSC_CTRL+0, R16
;wiredAND.c,34 :: 		PORTCFG_CLKEVOUT = 0x00;
	LDI        R27, 0
	STS        PORTCFG_CLKEVOUT+0, R27
;wiredAND.c,36 :: 		PORTA_OUT = 0x02;
	LDI        R27, 2
	STS        PORTA_OUT+0, R27
;wiredAND.c,37 :: 		PORTA_DIR = 0x02;
	LDI        R27, 2
	STS        PORTA_DIR+0, R27
;wiredAND.c,38 :: 		PORTA_PIN0CTRL = (PORT_OPC_TOTEM_gc | PORT_ISC_RISING_gc);
	LDI        R27, 1
	STS        PORTA_PIN0CTRL+0, R27
;wiredAND.c,39 :: 		PORTA_PIN1CTRL = (PORT_OPC_WIREDANDPULL_gc | PORT_ISC_BOTHEDGES_gc);
	LDI        R27, 56
	STS        PORTA_PIN1CTRL+0, R27
;wiredAND.c,40 :: 		PORTA_INTCTRL = 0x00;
	LDI        R27, 0
	STS        PORTA_INTCTRL+0, R27
;wiredAND.c,41 :: 		PORTA_INT0MASK = 0x00;
	LDI        R27, 0
	STS        PORTA_INT0MASK+0, R27
;wiredAND.c,42 :: 		PORTA_INT1MASK = 0x00;
	LDI        R27, 0
	STS        PORTA_INT1MASK+0, R27
;wiredAND.c,43 :: 		}
L_end_setup:
	RET
; end of _setup
