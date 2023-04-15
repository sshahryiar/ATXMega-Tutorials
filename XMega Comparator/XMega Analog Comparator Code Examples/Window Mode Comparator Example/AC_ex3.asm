
_main:
	LDI        R27, 255
	OUT        SPL+0, R27
	LDI        R27, 0
	OUT        SPL+1, R27

;AC_ex3.c,12 :: 		void main()
;AC_ex3.c,14 :: 		unsigned char result = 0;
;AC_ex3.c,16 :: 		setup();
	CALL       _setup+0
;AC_ex3.c,18 :: 		while(1)
L_main0:
;AC_ex3.c,20 :: 		result = (ACA_STATUS & 0xC0);
	LDS        R16, ACA_STATUS+0
	ANDI       R16, 192
; result start address is: 17 (R17)
	MOV        R17, R16
;AC_ex3.c,22 :: 		if(result == AC_WSTATE_ABOVE_gc)
	CPI        R16, 0
	BREQ       L__main11
	JMP        L_main2
L__main11:
;AC_ex3.c,24 :: 		PORTD_OUT = 0x01;
	LDI        R27, 1
	STS        PORTD_OUT+0, R27
;AC_ex3.c,25 :: 		}
L_main2:
;AC_ex3.c,26 :: 		if(result == AC_WSTATE_INSIDE_gc)
	CPI        R17, 64
	BREQ       L__main12
	JMP        L_main3
L__main12:
;AC_ex3.c,28 :: 		PORTD_OUT = 0x02;
	LDI        R27, 2
	STS        PORTD_OUT+0, R27
;AC_ex3.c,29 :: 		}
L_main3:
;AC_ex3.c,30 :: 		if(result == AC_WSTATE_BELOW_gc)
	CPI        R17, 128
	BREQ       L__main13
	JMP        L_main4
L__main13:
;AC_ex3.c,32 :: 		PORTD_OUT = 0x04;
	LDI        R27, 4
	STS        PORTD_OUT+0, R27
;AC_ex3.c,33 :: 		}
L_main4:
;AC_ex3.c,34 :: 		if(result == AC_WSTATE_OUTSIDE_gc)
	CPI        R17, 192
	BREQ       L__main14
	JMP        L_main5
L__main14:
; result end address is: 17 (R17)
;AC_ex3.c,36 :: 		PORTD_OUT = 0x08;
	LDI        R27, 8
	STS        PORTD_OUT+0, R27
;AC_ex3.c,37 :: 		}
L_main5:
;AC_ex3.c,38 :: 		};
	JMP        L_main0
;AC_ex3.c,39 :: 		}
L_end_main:
L__main_end_loop:
	JMP        L__main_end_loop
; end of _main

_setup:

;AC_ex3.c,42 :: 		void setup()
;AC_ex3.c,44 :: 		setup_clock();
	CALL       _setup_clock+0
;AC_ex3.c,45 :: 		setup_GPIO();
	CALL       _setup_GPIO+0
;AC_ex3.c,46 :: 		setup_AC();
	CALL       _setup_AC+0
;AC_ex3.c,47 :: 		}
L_end_setup:
	RET
; end of _setup

_setup_clock:

;AC_ex3.c,50 :: 		void setup_clock()
;AC_ex3.c,52 :: 		asm cli;
	CLI
;AC_ex3.c,53 :: 		OSC_CTRL |= OSC_RC32KEN_bm;
	LDS        R27, OSC_CTRL+0
	SBR        R27, 4
	STS        OSC_CTRL+0, R27
;AC_ex3.c,54 :: 		while(!(OSC_STATUS & OSC_RC32KRDY_bm));
L_setup_clock6:
	LDS        R16, OSC_STATUS+0
	SBRC       R16, 2
	JMP        L_setup_clock7
	JMP        L_setup_clock6
L_setup_clock7:
;AC_ex3.c,55 :: 		OSC_CTRL |= OSC_RC32MEN_bm;
	LDS        R16, OSC_CTRL+0
	ORI        R16, 2
	STS        OSC_CTRL+0, R16
;AC_ex3.c,56 :: 		CPU_CCP = CCP_IOREG_gc;
	LDI        R27, 216
	OUT        CPU_CCP+0, R27
;AC_ex3.c,58 :: 		| CLK_PSBCDIV0_bm))) | CLK_PSADIV_1_gc | CLK_PSBCDIV_2_2_gc);
	LDS        R16, CLK_PSCTRL+0
	ANDI       R16, 128
	ORI        R16, 3
	STS        CLK_PSCTRL+0, R16
;AC_ex3.c,59 :: 		OSC_DFLLCTRL = ((OSC_DFLLCTRL & (~(OSC_RC32MCREF_gm | OSC_RC2MCREF_bm))) |
	LDS        R16, OSC_DFLLCTRL+0
	ANDI       R16, 248
;AC_ex3.c,60 :: 		OSC_RC32MCREF_RC32K_gc);
	STS        OSC_DFLLCTRL+0, R16
;AC_ex3.c,61 :: 		DFLLRC32M_CTRL |= DFLL_ENABLE_bm;
	LDS        R16, DFLLRC32M_CTRL+0
	ORI        R16, 1
	STS        DFLLRC32M_CTRL+0, R16
;AC_ex3.c,62 :: 		while(!(OSC_STATUS & OSC_RC32MRDY_bm));
L_setup_clock8:
	LDS        R16, OSC_STATUS+0
	SBRC       R16, 1
	JMP        L_setup_clock9
	JMP        L_setup_clock8
L_setup_clock9:
;AC_ex3.c,63 :: 		CPU_CCP = CCP_IOREG_gc;
	LDI        R27, 216
	OUT        CPU_CCP+0, R27
;AC_ex3.c,64 :: 		CLK_CTRL = ((CLK_CTRL & (~CLK_SCLKSEL_gm)) | CLK_SCLKSEL_RC32M_gc);
	LDS        R16, CLK_CTRL+0
	ANDI       R16, 248
	ORI        R16, 1
	STS        CLK_CTRL+0, R16
;AC_ex3.c,65 :: 		OSC_CTRL &= (~(OSC_RC2MEN_bm | OSC_XOSCEN_bm | OSC_PLLEN_bm));
	LDS        R16, OSC_CTRL+0
	ANDI       R16, 230
	STS        OSC_CTRL+0, R16
;AC_ex3.c,66 :: 		PORTCFG_CLKEVOUT = 0x00;
	LDI        R27, 0
	STS        PORTCFG_CLKEVOUT+0, R27
;AC_ex3.c,67 :: 		}
L_end_setup_clock:
	RET
; end of _setup_clock

_setup_GPIO:

;AC_ex3.c,70 :: 		void setup_GPIO()
;AC_ex3.c,72 :: 		PORTA_OUT = 0x00;
	LDI        R27, 0
	STS        PORTA_OUT+0, R27
;AC_ex3.c,73 :: 		PORTA_DIR = 0xC0;
	LDI        R27, 192
	STS        PORTA_DIR+0, R27
;AC_ex3.c,74 :: 		PORTCFG_MPCMASK = 0xFF;
	LDI        R27, 255
	STS        PORTCFG_MPCMASK+0, R27
;AC_ex3.c,75 :: 		PORTA_PIN4CTRL = (PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc);
	LDI        R27, 0
	STS        PORTA_PIN4CTRL+0, R27
;AC_ex3.c,76 :: 		PORTA_INTCTRL = ((PORTA_INTCTRL & (~(PORT_INT1LVL_gm | PORT_INT0LVL_gm))) |
	LDS        R16, PORTA_INTCTRL+0
	ANDI       R16, 240
;AC_ex3.c,77 :: 		PORT_INT1LVL_OFF_gc | PORT_INT0LVL_OFF_gc);
	STS        PORTA_INTCTRL+0, R16
;AC_ex3.c,79 :: 		PORTD_OUT = 0x00;
	LDI        R27, 0
	STS        PORTD_OUT+0, R27
;AC_ex3.c,80 :: 		PORTD_DIR = 0x0F;
	LDI        R27, 15
	STS        PORTD_DIR+0, R27
;AC_ex3.c,81 :: 		PORTCFG_MPCMASK = 0xFF;
	LDI        R27, 255
	STS        PORTCFG_MPCMASK+0, R27
;AC_ex3.c,82 :: 		PORTD_PIN6CTRL = (PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc);
	LDI        R27, 0
	STS        PORTD_PIN6CTRL+0, R27
;AC_ex3.c,83 :: 		PORTD_INTCTRL = ((PORTD_INTCTRL & (~(PORT_INT1LVL_gm | PORT_INT0LVL_gm))) |
	LDS        R16, PORTD_INTCTRL+0
	ANDI       R16, 240
;AC_ex3.c,84 :: 		PORT_INT1LVL_OFF_gc | PORT_INT0LVL_OFF_gc);
	STS        PORTD_INTCTRL+0, R16
;AC_ex3.c,85 :: 		}
L_end_setup_GPIO:
	RET
; end of _setup_GPIO

_setup_AC:

;AC_ex3.c,88 :: 		void setup_AC()
;AC_ex3.c,90 :: 		unsigned char reg_val = 0;
;AC_ex3.c,95 :: 		ACA_AC0MUXCTRL = (AC_MUXPOS_PIN0_gc | AC_MUXNEG_SCALER_gc);
	LDI        R27, 7
	STS        ACA_AC0MUXCTRL+0, R27
;AC_ex3.c,96 :: 		ACA_AC0CTRL = reg_val;
	LDI        R27, 5
	STS        ACA_AC0CTRL+0, R27
;AC_ex3.c,98 :: 		ACA_AC1MUXCTRL = (AC_MUXPOS_PIN0_gc | AC_MUXNEG_BANDGAP_gc);
	LDI        R27, 6
	STS        ACA_AC1MUXCTRL+0, R27
;AC_ex3.c,99 :: 		ACA_AC1CTRL = reg_val;
	LDI        R27, 5
	STS        ACA_AC1CTRL+0, R27
;AC_ex3.c,101 :: 		ACA_WINCTRL = ((1 << AC_WEN_bp) | AC_WINTMODE_OUTSIDE_gc | AC_WINTLVL_OFF_gc);
	LDI        R27, 28
	STS        ACA_WINCTRL+0, R27
;AC_ex3.c,103 :: 		ACA_CTRLA = (1 << AC_AC1OUT_bp) | (1 << AC_AC0OUT_bp);
	LDI        R27, 3
	STS        ACA_CTRLA+0, R27
;AC_ex3.c,104 :: 		ACA_CTRLB = 0x33;
	LDI        R27, 51
	STS        ACA_CTRLB+0, R27
;AC_ex3.c,105 :: 		}
L_end_setup_AC:
	RET
; end of _setup_AC
