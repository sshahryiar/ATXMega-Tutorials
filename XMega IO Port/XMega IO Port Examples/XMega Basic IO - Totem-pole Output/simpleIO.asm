
_main:
	LDI        R27, 255
	OUT        SPL+0, R27
	LDI        R27, 0
	OUT        SPL+1, R27

;simpleIO.c,8 :: 		void main()
;simpleIO.c,10 :: 		setup();
	CALL       _setup+0
;simpleIO.c,12 :: 		while(1)
L_main0:
;simpleIO.c,14 :: 		PORTD_OUT = 0x55;
	LDI        R27, 85
	STS        PORTD_OUT+0, R27
;simpleIO.c,15 :: 		delay_ms(200);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_main2:
	DEC        R16
	BRNE       L_main2
	DEC        R17
	BRNE       L_main2
	DEC        R18
	BRNE       L_main2
	NOP
;simpleIO.c,16 :: 		PORTD_OUT = 0xAA;
	LDI        R27, 170
	STS        PORTD_OUT+0, R27
;simpleIO.c,17 :: 		delay_ms(200);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_main4:
	DEC        R16
	BRNE       L_main4
	DEC        R17
	BRNE       L_main4
	DEC        R18
	BRNE       L_main4
	NOP
;simpleIO.c,18 :: 		};
	JMP        L_main0
;simpleIO.c,19 :: 		}
L_end_main:
L__main_end_loop:
	JMP        L__main_end_loop
; end of _main

_setup:

;simpleIO.c,22 :: 		void setup()
;simpleIO.c,24 :: 		OSC_CTRL |= OSC_RC32KEN_bm;
	LDS        R27, OSC_CTRL+0
	SBR        R27, 4
	STS        OSC_CTRL+0, R27
;simpleIO.c,25 :: 		while(!(OSC_STATUS & OSC_RC32KRDY_bm));
L_setup6:
	LDS        R16, OSC_STATUS+0
	SBRC       R16, 2
	JMP        L_setup7
	JMP        L_setup6
L_setup7:
;simpleIO.c,26 :: 		OSC_CTRL |= OSC_RC32MEN_bm;
	LDS        R16, OSC_CTRL+0
	ORI        R16, 2
	STS        OSC_CTRL+0, R16
;simpleIO.c,27 :: 		CPU_CCP = CCP_IOREG_gc;
	LDI        R27, 216
	OUT        CPU_CCP+0, R27
;simpleIO.c,28 :: 		CLK_PSCTRL = ((CLK_PSCTRL & (~(CLK_PSADIV_gm | CLK_PSBCDIV1_bm | CLK_PSBCDIV0_bm)))
	LDS        R16, CLK_PSCTRL+0
	ANDI       R16, 128
;simpleIO.c,29 :: 		| CLK_PSADIV_1_gc | CLK_PSBCDIV_2_2_gc);
	ORI        R16, 3
	STS        CLK_PSCTRL+0, R16
;simpleIO.c,30 :: 		OSC_DFLLCTRL = ((OSC_DFLLCTRL & (~(OSC_RC32MCREF_gm | OSC_RC2MCREF_bm))) |
	LDS        R16, OSC_DFLLCTRL+0
	ANDI       R16, 248
;simpleIO.c,31 :: 		OSC_RC32MCREF_RC32K_gc);
	STS        OSC_DFLLCTRL+0, R16
;simpleIO.c,32 :: 		DFLLRC32M_CTRL|=DFLL_ENABLE_bm;
	LDS        R16, DFLLRC32M_CTRL+0
	ORI        R16, 1
	STS        DFLLRC32M_CTRL+0, R16
;simpleIO.c,33 :: 		while (!(OSC_STATUS & OSC_RC32MRDY_bm));
L_setup8:
	LDS        R16, OSC_STATUS+0
	SBRC       R16, 1
	JMP        L_setup9
	JMP        L_setup8
L_setup9:
;simpleIO.c,34 :: 		CPU_CCP = CCP_IOREG_gc;
	LDI        R27, 216
	OUT        CPU_CCP+0, R27
;simpleIO.c,35 :: 		CLK_CTRL = ((CLK_CTRL & (~CLK_SCLKSEL_gm)) | CLK_SCLKSEL_RC32M_gc);
	LDS        R16, CLK_CTRL+0
	ANDI       R16, 248
	ORI        R16, 1
	STS        CLK_CTRL+0, R16
;simpleIO.c,36 :: 		OSC_CTRL &= (~(OSC_RC2MEN_bm | OSC_XOSCEN_bm | OSC_PLLEN_bm));
	LDS        R16, OSC_CTRL+0
	ANDI       R16, 230
	STS        OSC_CTRL+0, R16
;simpleIO.c,37 :: 		PORTCFG_CLKEVOUT = 0x00;
	LDI        R27, 0
	STS        PORTCFG_CLKEVOUT+0, R27
;simpleIO.c,39 :: 		PORTD_OUTCLR = 0xFF;
	LDI        R27, 255
	STS        PORTD_OUTCLR+0, R27
;simpleIO.c,40 :: 		PORTD_DIRSET = 0xFF;
	LDI        R27, 255
	STS        PORTD_DIRSET+0, R27
;simpleIO.c,41 :: 		PORTCFG_MPCMASK = 0xFF;
	LDI        R27, 255
	STS        PORTCFG_MPCMASK+0, R27
;simpleIO.c,42 :: 		PORTD_PIN6CTRL = (PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc);
	LDI        R27, 0
	STS        PORTD_PIN6CTRL+0, R27
;simpleIO.c,43 :: 		}
L_end_setup:
	RET
; end of _setup
