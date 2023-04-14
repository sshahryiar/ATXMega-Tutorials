
_main:
	LDI        R27, 255
	OUT        SPL+0, R27
	LDI        R27, 0
	OUT        SPL+1, R27

;inputs.c,8 :: 		void main()
;inputs.c,10 :: 		setup();
	CALL       _setup+0
;inputs.c,12 :: 		while(1)
L_main0:
;inputs.c,14 :: 		if(PORTC_IN.B0 == 1)
	LDS        R27, PORTC_IN+0
	SBRS       R27, 0
	JMP        L_main2
;inputs.c,16 :: 		PORTD_OUT = 0x01;
	LDI        R27, 1
	STS        PORTD_OUT+0, R27
;inputs.c,17 :: 		}
	JMP        L_main3
L_main2:
;inputs.c,20 :: 		PORTD_OUT = 0x02;
	LDI        R27, 2
	STS        PORTD_OUT+0, R27
;inputs.c,21 :: 		}
L_main3:
;inputs.c,22 :: 		if(PORTC_IN.B1 == 1)
	LDS        R27, PORTC_IN+0
	SBRS       R27, 1
	JMP        L_main4
;inputs.c,24 :: 		PORTD_OUT = 0x04;
	LDI        R27, 4
	STS        PORTD_OUT+0, R27
;inputs.c,25 :: 		}
	JMP        L_main5
L_main4:
;inputs.c,28 :: 		PORTD_OUT = 0x08;
	LDI        R27, 8
	STS        PORTD_OUT+0, R27
;inputs.c,29 :: 		}
L_main5:
;inputs.c,30 :: 		};
	JMP        L_main0
;inputs.c,31 :: 		}
L_end_main:
L__main_end_loop:
	JMP        L__main_end_loop
; end of _main

_setup:

;inputs.c,34 :: 		void setup()
;inputs.c,36 :: 		OSC_CTRL |= OSC_RC32KEN_bm;
	LDS        R27, OSC_CTRL+0
	SBR        R27, 4
	STS        OSC_CTRL+0, R27
;inputs.c,37 :: 		while(!(OSC_STATUS & OSC_RC32KRDY_bm));
L_setup6:
	LDS        R16, OSC_STATUS+0
	SBRC       R16, 2
	JMP        L_setup7
	JMP        L_setup6
L_setup7:
;inputs.c,38 :: 		OSC_CTRL |= OSC_RC32MEN_bm;
	LDS        R16, OSC_CTRL+0
	ORI        R16, 2
	STS        OSC_CTRL+0, R16
;inputs.c,39 :: 		CPU_CCP = CCP_IOREG_gc;
	LDI        R27, 216
	OUT        CPU_CCP+0, R27
;inputs.c,40 :: 		CLK_PSCTRL = ((CLK_PSCTRL & (~(CLK_PSADIV_gm | CLK_PSBCDIV1_bm | CLK_PSBCDIV0_bm)))
	LDS        R16, CLK_PSCTRL+0
	ANDI       R16, 128
;inputs.c,41 :: 		| CLK_PSADIV_1_gc | CLK_PSBCDIV_2_2_gc);
	ORI        R16, 3
	STS        CLK_PSCTRL+0, R16
;inputs.c,42 :: 		OSC_DFLLCTRL = ((OSC_DFLLCTRL & (~(OSC_RC32MCREF_gm | OSC_RC2MCREF_bm))) |
	LDS        R16, OSC_DFLLCTRL+0
	ANDI       R16, 248
;inputs.c,43 :: 		OSC_RC32MCREF_RC32K_gc);
	STS        OSC_DFLLCTRL+0, R16
;inputs.c,44 :: 		DFLLRC32M_CTRL|=DFLL_ENABLE_bm;
	LDS        R16, DFLLRC32M_CTRL+0
	ORI        R16, 1
	STS        DFLLRC32M_CTRL+0, R16
;inputs.c,45 :: 		while (!(OSC_STATUS & OSC_RC32MRDY_bm));
L_setup8:
	LDS        R16, OSC_STATUS+0
	SBRC       R16, 1
	JMP        L_setup9
	JMP        L_setup8
L_setup9:
;inputs.c,46 :: 		CPU_CCP = CCP_IOREG_gc;
	LDI        R27, 216
	OUT        CPU_CCP+0, R27
;inputs.c,47 :: 		CLK_CTRL = ((CLK_CTRL & (~CLK_SCLKSEL_gm)) | CLK_SCLKSEL_RC32M_gc);
	LDS        R16, CLK_CTRL+0
	ANDI       R16, 248
	ORI        R16, 1
	STS        CLK_CTRL+0, R16
;inputs.c,48 :: 		OSC_CTRL &= (~(OSC_RC2MEN_bm | OSC_XOSCEN_bm | OSC_PLLEN_bm));
	LDS        R16, OSC_CTRL+0
	ANDI       R16, 230
	STS        OSC_CTRL+0, R16
;inputs.c,49 :: 		PORTCFG_CLKEVOUT = 0x00;
	LDI        R27, 0
	STS        PORTCFG_CLKEVOUT+0, R27
;inputs.c,51 :: 		PORTC_OUT=0x00;
	LDI        R27, 0
	STS        PORTC_OUT+0, R27
;inputs.c,52 :: 		PORTC_DIR = 0x00;
	LDI        R27, 0
	STS        PORTC_DIR+0, R27
;inputs.c,53 :: 		PORTC_PIN0CTRL = (PORT_OPC_PULLUP_gc | PORT_ISC_FALLING_gc);
	LDI        R27, 26
	STS        PORTC_PIN0CTRL+0, R27
;inputs.c,54 :: 		PORTC_PIN1CTRL = (PORT_OPC_PULLDOWN_gc | PORT_ISC_RISING_gc);
	LDI        R27, 17
	STS        PORTC_PIN1CTRL+0, R27
;inputs.c,55 :: 		PORTCFG_MPCMASK = 0xFC;
	LDI        R27, 252
	STS        PORTCFG_MPCMASK+0, R27
;inputs.c,56 :: 		PORTC_PIN2CTRL = (PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc);
	LDI        R27, 0
	STS        PORTC_PIN2CTRL+0, R27
;inputs.c,57 :: 		PORTC_REMAP = 0x00;
	LDI        R27, 0
	STS        PORTC_REMAP+0, R27
;inputs.c,58 :: 		PORTC_INTCTRL = 0x00;
	LDI        R27, 0
	STS        PORTC_INTCTRL+0, R27
;inputs.c,59 :: 		PORTC_INT0MASK = 0x00;
	LDI        R27, 0
	STS        PORTC_INT0MASK+0, R27
;inputs.c,60 :: 		PORTC_INT1MASK = 0x00;
	LDI        R27, 0
	STS        PORTC_INT1MASK+0, R27
;inputs.c,62 :: 		PORTD_OUT = 0x00;
	LDI        R27, 0
	STS        PORTD_OUT+0, R27
;inputs.c,63 :: 		PORTD_DIR = 0x0F;
	LDI        R27, 15
	STS        PORTD_DIR+0, R27
;inputs.c,64 :: 		PORTCFG_MPCMASK = 0x0F;
	LDI        R27, 15
	STS        PORTCFG_MPCMASK+0, R27
;inputs.c,65 :: 		PORTD_PIN0CTRL = (PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc);
	LDI        R27, 0
	STS        PORTD_PIN0CTRL+0, R27
;inputs.c,66 :: 		PORTD_INTCTRL = 0x00;
	LDI        R27, 0
	STS        PORTD_INTCTRL+0, R27
;inputs.c,67 :: 		PORTD_INT0MASK = 0x00;
	LDI        R27, 0
	STS        PORTD_INT0MASK+0, R27
;inputs.c,68 :: 		PORTD_INT1MASK = 0x00;
	LDI        R27, 0
	STS        PORTD_INT1MASK+0, R27
;inputs.c,69 :: 		}
L_end_setup:
	RET
; end of _setup
