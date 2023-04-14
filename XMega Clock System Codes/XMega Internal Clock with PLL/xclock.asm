
_main:
	LDI        R27, 255
	OUT        SPL+0, R27
	LDI        R27, 0
	OUT        SPL+1, R27

;xclock.c,4 :: 		void main()
;xclock.c,6 :: 		setup();
	CALL       _setup+0
;xclock.c,7 :: 		while(1)
L_main0:
;xclock.c,9 :: 		};
	JMP        L_main0
;xclock.c,10 :: 		}
L_end_main:
L__main_end_loop:
	JMP        L__main_end_loop
; end of _main

_setup:

;xclock.c,13 :: 		void setup()
;xclock.c,16 :: 		OSC_CTRL = 0x00;
	LDI        R27, 0
	STS        OSC_CTRL+0, R27
;xclock.c,18 :: 		OSC_CTRL |= 0x04;
	LDS        R27, OSC_CTRL+0
	SBR        R27, 4
	STS        OSC_CTRL+0, R27
;xclock.c,20 :: 		while(!RC32KRDY_bit);
L_setup2:
	LDS        R27, RC32KRDY_bit+0
	SBRC       R27, BitPos(RC32KRDY_bit+0)
	JMP        L_setup3
	JMP        L_setup2
L_setup3:
;xclock.c,22 :: 		OSC_CTRL |= 0x01;
	LDS        R16, OSC_CTRL+0
	ORI        R16, 1
	STS        OSC_CTRL+0, R16
;xclock.c,24 :: 		DFLLRC32M_CTRL = 0x00;
	LDI        R27, 0
	STS        DFLLRC32M_CTRL+0, R27
;xclock.c,25 :: 		DFLLRC2M_CTRL = 0x01;
	LDI        R27, 1
	STS        DFLLRC2M_CTRL+0, R27
;xclock.c,27 :: 		while(!RC2MRDY_bit);
L_setup4:
	LDS        R27, RC2MRDY_bit+0
	SBRC       R27, BitPos(RC2MRDY_bit+0)
	JMP        L_setup5
	JMP        L_setup4
L_setup5:
;xclock.c,29 :: 		OSC_PLLCTRL = 0x1F;
	LDI        R27, 31
	STS        OSC_PLLCTRL+0, R27
;xclock.c,30 :: 		OSC_CTRL |= 0x10;
	LDS        R16, OSC_CTRL+0
	ORI        R16, 16
	STS        OSC_CTRL+0, R16
;xclock.c,32 :: 		CPU_CCP = 0xD8;
	LDI        R27, 216
	OUT        CPU_CCP+0, R27
;xclock.c,34 :: 		CLK_PSCTRL = 0x44;
	LDI        R27, 68
	STS        CLK_PSCTRL+0, R27
;xclock.c,36 :: 		while(!PLLRDY_bit);
L_setup6:
	LDS        R27, PLLRDY_bit+0
	SBRC       R27, BitPos(PLLRDY_bit+0)
	JMP        L_setup7
	JMP        L_setup6
L_setup7:
;xclock.c,38 :: 		CPU_CCP = 0xD8;
	LDI        R27, 216
	OUT        CPU_CCP+0, R27
;xclock.c,40 :: 		CLK_CTRL = 0x04;
	LDI        R27, 4
	STS        CLK_CTRL+0, R27
;xclock.c,42 :: 		PORTCFG_CLKEVOUT = 0x01;
	LDI        R27, 1
	STS        PORTCFG_CLKEVOUT+0, R27
;xclock.c,43 :: 		PORTC_OUT = 0x00;
	LDI        R27, 0
	STS        PORTC_OUT+0, R27
;xclock.c,44 :: 		PORTC_DIR = 0x80;
	LDI        R27, 128
	STS        PORTC_DIR+0, R27
;xclock.c,45 :: 		PORTC_PIN7CTRL = 0x07;
	LDI        R27, 7
	STS        PORTC_PIN7CTRL+0, R27
;xclock.c,46 :: 		PORTC_INT0MASK = 0x00;
	LDI        R27, 0
	STS        PORTC_INT0MASK+0, R27
;xclock.c,47 :: 		PORTC_INT1MASK = 0x00;
	LDI        R27, 0
	STS        PORTC_INT1MASK+0, R27
;xclock.c,48 :: 		PORTC_INTCTRL = 0x00;
	LDI        R27, 0
	STS        PORTC_INTCTRL+0, R27
;xclock.c,49 :: 		PORTCFG_VPCTRLA = 0x10;
	LDI        R27, 16
	STS        PORTCFG_VPCTRLA+0, R27
;xclock.c,50 :: 		PORTCFG_VPCTRLB = 0x32;
	LDI        R27, 50
	STS        PORTCFG_VPCTRLB+0, R27
;xclock.c,51 :: 		}
L_end_setup:
	RET
; end of _setup
