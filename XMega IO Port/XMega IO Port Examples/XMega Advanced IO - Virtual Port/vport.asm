
_main:
	LDI        R27, 255
	OUT        SPL+0, R27
	LDI        R27, 0
	OUT        SPL+1, R27

;vport.c,8 :: 		void main()
;vport.c,11 :: 		unsigned char s = 0;
;vport.c,13 :: 		setup();
	CALL       _setup+0
;vport.c,15 :: 		while(1)
L_main0:
;vport.c,17 :: 		for(s = 0; s <= 9; s++)
; s start address is: 20 (R20)
	LDI        R20, 0
; s end address is: 20 (R20)
L_main2:
; s start address is: 20 (R20)
	LDI        R16, 9
	CP         R16, R20
	BRSH       L__main12
	JMP        L_main3
L__main12:
;vport.c,19 :: 		VPORT3_OUT = n[s];
	MOV        R18, R20
	LDI        R19, 0
	LSL        R18
	ROL        R19
	LDI        R16, #lo_addr(main_n_L0+0)
	LDI        R17, hi_addr(main_n_L0+0)
	MOVW       R30, R18
	ADD        R30, R16
	ADC        R31, R17
	LPM        R16, Z
	OUT        VPORT3_OUT+0, R16
;vport.c,20 :: 		delay_ms(400);
	LDI        R18, 17
	LDI        R17, 60
	LDI        R16, 204
L_main5:
	DEC        R16
	BRNE       L_main5
	DEC        R17
	BRNE       L_main5
	DEC        R18
	BRNE       L_main5
;vport.c,17 :: 		for(s = 0; s <= 9; s++)
	MOV        R16, R20
	SUBI       R16, 255
	MOV        R20, R16
;vport.c,21 :: 		}
; s end address is: 20 (R20)
	JMP        L_main2
L_main3:
;vport.c,22 :: 		};
	JMP        L_main0
;vport.c,23 :: 		}
L_end_main:
L__main_end_loop:
	JMP        L__main_end_loop
; end of _main

_setup:

;vport.c,26 :: 		void setup()
;vport.c,28 :: 		OSC_CTRL |= OSC_RC32KEN_bm;
	LDS        R27, OSC_CTRL+0
	SBR        R27, 4
	STS        OSC_CTRL+0, R27
;vport.c,29 :: 		while(!(OSC_STATUS & OSC_RC32KRDY_bm));
L_setup7:
	LDS        R16, OSC_STATUS+0
	SBRC       R16, 2
	JMP        L_setup8
	JMP        L_setup7
L_setup8:
;vport.c,30 :: 		OSC_CTRL |= OSC_RC32MEN_bm;
	LDS        R16, OSC_CTRL+0
	ORI        R16, 2
	STS        OSC_CTRL+0, R16
;vport.c,31 :: 		CPU_CCP = CCP_IOREG_gc;
	LDI        R27, 216
	OUT        CPU_CCP+0, R27
;vport.c,32 :: 		CLK_PSCTRL = ((CLK_PSCTRL & (~(CLK_PSADIV_gm | CLK_PSBCDIV1_bm | CLK_PSBCDIV0_bm)))
	LDS        R16, CLK_PSCTRL+0
	ANDI       R16, 128
;vport.c,33 :: 		| CLK_PSADIV_1_gc | CLK_PSBCDIV_2_2_gc);
	ORI        R16, 3
	STS        CLK_PSCTRL+0, R16
;vport.c,34 :: 		OSC_DFLLCTRL = ((OSC_DFLLCTRL & (~(OSC_RC32MCREF_gm | OSC_RC2MCREF_bm))) |
	LDS        R16, OSC_DFLLCTRL+0
	ANDI       R16, 248
;vport.c,35 :: 		OSC_RC32MCREF_RC32K_gc);
	STS        OSC_DFLLCTRL+0, R16
;vport.c,36 :: 		DFLLRC32M_CTRL|=DFLL_ENABLE_bm;
	LDS        R16, DFLLRC32M_CTRL+0
	ORI        R16, 1
	STS        DFLLRC32M_CTRL+0, R16
;vport.c,37 :: 		while (!(OSC_STATUS & OSC_RC32MRDY_bm));
L_setup9:
	LDS        R16, OSC_STATUS+0
	SBRC       R16, 1
	JMP        L_setup10
	JMP        L_setup9
L_setup10:
;vport.c,38 :: 		CPU_CCP = CCP_IOREG_gc;
	LDI        R27, 216
	OUT        CPU_CCP+0, R27
;vport.c,39 :: 		CLK_CTRL = ((CLK_CTRL & (~CLK_SCLKSEL_gm)) | CLK_SCLKSEL_RC32M_gc);
	LDS        R16, CLK_CTRL+0
	ANDI       R16, 248
	ORI        R16, 1
	STS        CLK_CTRL+0, R16
;vport.c,40 :: 		OSC_CTRL &= (~(OSC_RC2MEN_bm | OSC_XOSCEN_bm | OSC_PLLEN_bm));
	LDS        R16, OSC_CTRL+0
	ANDI       R16, 230
	STS        OSC_CTRL+0, R16
;vport.c,41 :: 		PORTCFG_CLKEVOUT = 0x00;
	LDI        R27, 0
	STS        PORTCFG_CLKEVOUT+0, R27
;vport.c,43 :: 		PORTD_OUTCLR = 0xFF;
	LDI        R27, 255
	STS        PORTD_OUTCLR+0, R27
;vport.c,44 :: 		PORTD_DIRSET = 0xFF;
	LDI        R27, 255
	STS        PORTD_DIRSET+0, R27
;vport.c,45 :: 		PORTCFG_MPCMASK = 0xFF;
	LDI        R27, 255
	STS        PORTCFG_MPCMASK+0, R27
;vport.c,46 :: 		PORTD_PIN6CTRL = (PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc);
	LDI        R27, 0
	STS        PORTD_PIN6CTRL+0, R27
;vport.c,48 :: 		PORTCFG_VPCTRLA = (PORTCFG_VP13MAP_PORTB_gc | PORTCFG_VP02MAP_PORTA_gc);
	LDI        R27, 16
	STS        PORTCFG_VPCTRLA+0, R27
;vport.c,49 :: 		PORTCFG_VPCTRLB = (PORTCFG_VP13MAP_PORTD_gc | PORTCFG_VP02MAP_PORTC_gc);
	LDI        R27, 50
	STS        PORTCFG_VPCTRLB+0, R27
;vport.c,51 :: 		VPORT3_DIR = 0xFF;
	LDI        R27, 255
	OUT        VPORT3_DIR+0, R27
;vport.c,52 :: 		VPORT3_OUT = 0x00;
	LDI        R27, 0
	OUT        VPORT3_OUT+0, R27
;vport.c,53 :: 		}
L_end_setup:
	RET
; end of _setup
