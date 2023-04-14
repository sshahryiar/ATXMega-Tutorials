
_main:
	LDI        R27, 255
	OUT        SPL+0, R27
	LDI        R27, 0
	OUT        SPL+1, R27

;xclock32.c,4 :: 		void main()
;xclock32.c,6 :: 		setup();
	CALL       _setup+0
;xclock32.c,8 :: 		while(1)
L_main0:
;xclock32.c,10 :: 		};
	JMP        L_main0
;xclock32.c,11 :: 		}
L_end_main:
L__main_end_loop:
	JMP        L__main_end_loop
; end of _main

_setup:

;xclock32.c,14 :: 		void setup()
;xclock32.c,17 :: 		OSC_CTRL = 0x00;
	LDI        R27, 0
	STS        OSC_CTRL+0, R27
;xclock32.c,19 :: 		RC32KEN_bit = 1;
	LDS        R27, RC32KEN_bit+0
	SBR        R27, BitMask(RC32KEN_bit+0)
	STS        RC32KEN_bit+0, R27
;xclock32.c,21 :: 		while(!RC32KRDY_bit);
L_setup2:
	LDS        R27, RC32KRDY_bit+0
	SBRC       R27, BitPos(RC32KRDY_bit+0)
	JMP        L_setup3
	JMP        L_setup2
L_setup3:
;xclock32.c,23 :: 		RC32MEN_bit = 1;
	LDS        R27, RC32MEN_bit+0
	SBR        R27, BitMask(RC32MEN_bit+0)
	STS        RC32MEN_bit+0, R27
;xclock32.c,25 :: 		CPU_CCP = 0xD8;
	LDI        R27, 216
	OUT        CPU_CCP+0, R27
;xclock32.c,27 :: 		CLK_PSCTRL = 0x1C;
	LDI        R27, 28
	STS        CLK_PSCTRL+0, R27
;xclock32.c,29 :: 		OSC_DFLLCTRL = 0x00;
	LDI        R27, 0
	STS        OSC_DFLLCTRL+0, R27
;xclock32.c,30 :: 		DFLLRC32M_CTRL = 0x01;
	LDI        R27, 1
	STS        DFLLRC32M_CTRL+0, R27
;xclock32.c,32 :: 		while(!RC32MRDY_bit);
L_setup4:
	LDS        R27, RC32MRDY_bit+0
	SBRC       R27, BitPos(RC32MRDY_bit+0)
	JMP        L_setup5
	JMP        L_setup4
L_setup5:
;xclock32.c,34 :: 		CPU_CCP = 0xD8;
	LDI        R27, 216
	OUT        CPU_CCP+0, R27
;xclock32.c,36 :: 		CLK_CTRL = 0x01;
	LDI        R27, 1
	STS        CLK_CTRL+0, R27
;xclock32.c,38 :: 		PORTCFG_CLKEVOUT = 0x0A;
	LDI        R27, 10
	STS        PORTCFG_CLKEVOUT+0, R27
;xclock32.c,39 :: 		PORTD_OUT = 0x00;
	LDI        R27, 0
	STS        PORTD_OUT+0, R27
;xclock32.c,40 :: 		PORTD_DIR = 0x80;
	LDI        R27, 128
	STS        PORTD_DIR+0, R27
;xclock32.c,41 :: 		PORTD_PIN7CTRL = 0x07;
	LDI        R27, 7
	STS        PORTD_PIN7CTRL+0, R27
;xclock32.c,42 :: 		PORTD_INT0MASK = 0x00;
	LDI        R27, 0
	STS        PORTD_INT0MASK+0, R27
;xclock32.c,43 :: 		PORTD_INT1MASK = 0x00;
	LDI        R27, 0
	STS        PORTD_INT1MASK+0, R27
;xclock32.c,44 :: 		PORTD_INTCTRL = 0x00;
	LDI        R27, 0
	STS        PORTD_INTCTRL+0, R27
;xclock32.c,46 :: 		PORTCFG_VPCTRLA = 0x10;
	LDI        R27, 16
	STS        PORTCFG_VPCTRLA+0, R27
;xclock32.c,47 :: 		PORTCFG_VPCTRLB = 0x32;
	LDI        R27, 50
	STS        PORTCFG_VPCTRLB+0, R27
;xclock32.c,48 :: 		}
L_end_setup:
	RET
; end of _setup
