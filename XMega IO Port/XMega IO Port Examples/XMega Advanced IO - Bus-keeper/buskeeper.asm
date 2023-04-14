
_main:
	LDI        R27, 255
	OUT        SPL+0, R27
	LDI        R27, 0
	OUT        SPL+1, R27

;buskeeper.c,8 :: 		void main()
;buskeeper.c,10 :: 		setup();
	CALL       _setup+0
;buskeeper.c,12 :: 		while(1)
L_main0:
;buskeeper.c,14 :: 		PORTD_OUT.B1 = PORTD_IN.B0;
	LDS        R27, PORTD_IN+0
	BST        R27, 0
	LDS        R27, PORTD_OUT+0
	BLD        R27, 1
	STS        PORTD_OUT+0, R27
;buskeeper.c,15 :: 		};
	JMP        L_main0
;buskeeper.c,16 :: 		}
L_end_main:
L__main_end_loop:
	JMP        L__main_end_loop
; end of _main

_setup:

;buskeeper.c,19 :: 		void setup()
;buskeeper.c,21 :: 		OSC_CTRL |= OSC_RC32KEN_bm;
	LDS        R27, OSC_CTRL+0
	SBR        R27, 4
	STS        OSC_CTRL+0, R27
;buskeeper.c,22 :: 		while(!(OSC_STATUS & OSC_RC32KRDY_bm));
L_setup2:
	LDS        R16, OSC_STATUS+0
	SBRC       R16, 2
	JMP        L_setup3
	JMP        L_setup2
L_setup3:
;buskeeper.c,23 :: 		OSC_CTRL |= OSC_RC32MEN_bm;
	LDS        R16, OSC_CTRL+0
	ORI        R16, 2
	STS        OSC_CTRL+0, R16
;buskeeper.c,24 :: 		CPU_CCP = CCP_IOREG_gc;
	LDI        R27, 216
	OUT        CPU_CCP+0, R27
;buskeeper.c,25 :: 		CLK_PSCTRL = ((CLK_PSCTRL & (~(CLK_PSADIV_gm | CLK_PSBCDIV1_bm | CLK_PSBCDIV0_bm)))
	LDS        R16, CLK_PSCTRL+0
	ANDI       R16, 128
;buskeeper.c,26 :: 		| CLK_PSADIV_1_gc | CLK_PSBCDIV_2_2_gc);
	ORI        R16, 3
	STS        CLK_PSCTRL+0, R16
;buskeeper.c,27 :: 		OSC_DFLLCTRL = ((OSC_DFLLCTRL & (~(OSC_RC32MCREF_gm | OSC_RC2MCREF_bm))) |
	LDS        R16, OSC_DFLLCTRL+0
	ANDI       R16, 248
;buskeeper.c,28 :: 		OSC_RC32MCREF_RC32K_gc);
	STS        OSC_DFLLCTRL+0, R16
;buskeeper.c,29 :: 		DFLLRC32M_CTRL|=DFLL_ENABLE_bm;
	LDS        R16, DFLLRC32M_CTRL+0
	ORI        R16, 1
	STS        DFLLRC32M_CTRL+0, R16
;buskeeper.c,30 :: 		while (!(OSC_STATUS & OSC_RC32MRDY_bm));
L_setup4:
	LDS        R16, OSC_STATUS+0
	SBRC       R16, 1
	JMP        L_setup5
	JMP        L_setup4
L_setup5:
;buskeeper.c,31 :: 		CPU_CCP = CCP_IOREG_gc;
	LDI        R27, 216
	OUT        CPU_CCP+0, R27
;buskeeper.c,32 :: 		CLK_CTRL = ((CLK_CTRL & (~CLK_SCLKSEL_gm)) | CLK_SCLKSEL_RC32M_gc);
	LDS        R16, CLK_CTRL+0
	ANDI       R16, 248
	ORI        R16, 1
	STS        CLK_CTRL+0, R16
;buskeeper.c,33 :: 		OSC_CTRL &= (~(OSC_RC2MEN_bm | OSC_XOSCEN_bm | OSC_PLLEN_bm));
	LDS        R16, OSC_CTRL+0
	ANDI       R16, 230
	STS        OSC_CTRL+0, R16
;buskeeper.c,34 :: 		PORTCFG_CLKEVOUT = 0x00;
	LDI        R27, 0
	STS        PORTCFG_CLKEVOUT+0, R27
;buskeeper.c,36 :: 		PORTD_OUT = 0x00;
	LDI        R27, 0
	STS        PORTD_OUT+0, R27
;buskeeper.c,37 :: 		PORTD_DIR = 0x02;
	LDI        R27, 2
	STS        PORTD_DIR+0, R27
;buskeeper.c,38 :: 		PORTD_PIN0CTRL = (PORT_OPC_BUSKEEPER_gc | PORT_ISC_BOTHEDGES_gc);
	LDI        R27, 8
	STS        PORTD_PIN0CTRL+0, R27
;buskeeper.c,39 :: 		PORTD_PIN1CTRL = (PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc);
	LDI        R27, 0
	STS        PORTD_PIN1CTRL+0, R27
;buskeeper.c,40 :: 		}
L_end_setup:
	RET
; end of _setup
