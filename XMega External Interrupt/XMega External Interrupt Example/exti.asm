
_set_global_interrupt:

;interrupt.h,8 :: 		void set_global_interrupt()
;interrupt.h,10 :: 		asm sei;
	SEI
;interrupt.h,11 :: 		}
L_end_set_global_interrupt:
	RET
; end of _set_global_interrupt

_clear_global_interrupt:

;interrupt.h,14 :: 		void clear_global_interrupt()
;interrupt.h,16 :: 		asm cli;
	CLI
;interrupt.h,17 :: 		}
L_end_clear_global_interrupt:
	RET
; end of _clear_global_interrupt

_PORTA_INT0_ISR:
	PUSH       R30
	PUSH       R31
	PUSH       R27
	IN         R27, SREG+0
	PUSH       R27
	PUSH       R28
	PUSH       R29
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 14
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;exti.c,28 :: 		org IVT_ADDR_PORTA_INT0
;exti.c,30 :: 		unsigned char s = 16;
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	LDI        R27, 16
	STD        Y+13, R27
;exti.c,32 :: 		while(s > 0)
L_PORTA_INT0_ISR0:
	LDD        R17, Y+13
	LDI        R16, 0
	CP         R16, R17
	BRLO       L__PORTA_INT0_ISR19
	JMP        L_PORTA_INT0_ISR1
L__PORTA_INT0_ISR19:
;exti.c,34 :: 		Lcd_Cmd(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;exti.c,35 :: 		Lcd_Out(1, 1, "LOW Lvl");
	LDI        R30, #lo_addr(?ICS?lstr1_exti+0)
	LDI        R31, hi_addr(?ICS?lstr1_exti+0)
	MOVW       R26, R28
	LDI        R24, 8
	LDI        R25, 0
	CALL       ___CC2DW+0
	MOVW       R16, R28
	MOVW       R4, R16
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;exti.c,36 :: 		Lcd_Out(2, 3, "ISR.");
	LDI        R27, 73
	STD        Y+8, R27
	LDI        R27, 83
	STD        Y+9, R27
	LDI        R27, 82
	STD        Y+10, R27
	LDI        R27, 46
	STD        Y+11, R27
	LDI        R27, 0
	STD        Y+12, R27
	MOVW       R16, R28
	SUBI       R16, 248
	SBCI       R17, 255
	MOVW       R4, R16
	LDI        R27, 3
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;exti.c,37 :: 		PORTD_OUT.B1 ^= 1;
	LDS        R0, PORTD_OUT+0
	LDI        R27, 2
	EOR        R0, R27
	STS        PORTD_OUT+0, R0
;exti.c,38 :: 		delay_ms(200);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_PORTA_INT0_ISR2:
	DEC        R16
	BRNE       L_PORTA_INT0_ISR2
	DEC        R17
	BRNE       L_PORTA_INT0_ISR2
	DEC        R18
	BRNE       L_PORTA_INT0_ISR2
	NOP
;exti.c,39 :: 		s--;
	LDD        R16, Y+13
	SUBI       R16, 1
	STD        Y+13, R16
;exti.c,40 :: 		}
	JMP        L_PORTA_INT0_ISR0
L_PORTA_INT0_ISR1:
;exti.c,41 :: 		}
L_end_PORTA_INT0_ISR:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	ADIW       R28, 13
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	POP        R29
	POP        R28
	POP        R27
	OUT        SREG+0, R27
	POP        R27
	POP        R31
	POP        R30
	RETI
; end of _PORTA_INT0_ISR

_PORTA_INT1_ISR:
	PUSH       R30
	PUSH       R31
	PUSH       R27
	IN         R27, SREG+0
	PUSH       R27
	PUSH       R28
	PUSH       R29
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 15
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;exti.c,45 :: 		org IVT_ADDR_PORTA_INT1
;exti.c,47 :: 		unsigned char s = 16;
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	LDI        R27, 16
	STD        Y+14, R27
;exti.c,49 :: 		while(s > 0)
L_PORTA_INT1_ISR4:
	LDD        R17, Y+14
	LDI        R16, 0
	CP         R16, R17
	BRLO       L__PORTA_INT1_ISR23
	JMP        L_PORTA_INT1_ISR5
L__PORTA_INT1_ISR23:
;exti.c,51 :: 		Lcd_Cmd(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;exti.c,52 :: 		Lcd_Out(1, 1, "HIGH Lvl");
	LDI        R30, #lo_addr(?ICS?lstr3_exti+0)
	LDI        R31, hi_addr(?ICS?lstr3_exti+0)
	MOVW       R26, R28
	LDI        R24, 9
	LDI        R25, 0
	CALL       ___CC2DW+0
	MOVW       R16, R28
	MOVW       R4, R16
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;exti.c,53 :: 		Lcd_Out(2, 3, "ISR.");
	LDI        R27, 73
	STD        Y+9, R27
	LDI        R27, 83
	STD        Y+10, R27
	LDI        R27, 82
	STD        Y+11, R27
	LDI        R27, 46
	STD        Y+12, R27
	LDI        R27, 0
	STD        Y+13, R27
	MOVW       R16, R28
	SUBI       R16, 247
	SBCI       R17, 255
	MOVW       R4, R16
	LDI        R27, 3
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;exti.c,54 :: 		PORTD_OUT.B2 ^= 1;
	LDS        R0, PORTD_OUT+0
	LDI        R27, 4
	EOR        R0, R27
	STS        PORTD_OUT+0, R0
;exti.c,55 :: 		delay_ms(200);
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_PORTA_INT1_ISR6:
	DEC        R16
	BRNE       L_PORTA_INT1_ISR6
	DEC        R17
	BRNE       L_PORTA_INT1_ISR6
	DEC        R18
	BRNE       L_PORTA_INT1_ISR6
	NOP
;exti.c,56 :: 		s--;
	LDD        R16, Y+14
	SUBI       R16, 1
	STD        Y+14, R16
;exti.c,57 :: 		}
	JMP        L_PORTA_INT1_ISR4
L_PORTA_INT1_ISR5:
;exti.c,58 :: 		}
L_end_PORTA_INT1_ISR:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	ADIW       R28, 14
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	POP        R29
	POP        R28
	POP        R27
	OUT        SREG+0, R27
	POP        R27
	POP        R31
	POP        R30
	RETI
; end of _PORTA_INT1_ISR

_main:
	LDI        R27, 255
	OUT        SPL+0, R27
	LDI        R27, 0
	OUT        SPL+1, R27
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 10
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;exti.c,61 :: 		void main()
;exti.c,63 :: 		setup_interrupts();
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	CALL       _setup_interrupts+0
;exti.c,64 :: 		setup_clock();
	CALL       _setup_clock+0
;exti.c,65 :: 		setup_io();
	CALL       _setup_io+0
;exti.c,66 :: 		setup_lcd();
	CALL       _setup_lcd+0
;exti.c,68 :: 		while(1)
L_main8:
;exti.c,70 :: 		Lcd_Cmd(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;exti.c,71 :: 		Lcd_Out(1, 3, "Main");
	LDI        R27, 77
	STD        Y+0, R27
	LDI        R27, 97
	STD        Y+1, R27
	LDI        R27, 105
	STD        Y+2, R27
	LDI        R27, 110
	STD        Y+3, R27
	LDI        R27, 0
	STD        Y+4, R27
	MOVW       R16, R28
	MOVW       R4, R16
	LDI        R27, 3
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;exti.c,72 :: 		Lcd_Out(2, 3, "Loop");
	LDI        R27, 76
	STD        Y+5, R27
	LDI        R27, 111
	STD        Y+6, R27
	LDI        R27, 111
	STD        Y+7, R27
	LDI        R27, 112
	STD        Y+8, R27
	LDI        R27, 0
	STD        Y+9, R27
	MOVW       R16, R28
	SUBI       R16, 251
	SBCI       R17, 255
	MOVW       R4, R16
	LDI        R27, 3
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;exti.c,73 :: 		PORTD_OUT.B0 ^= 1;
	LDS        R0, PORTD_OUT+0
	LDI        R27, 1
	EOR        R0, R27
	STS        PORTD_OUT+0, R0
;exti.c,74 :: 		delay_ms(900);
	LDI        R18, 37
	LDI        R17, 135
	LDI        R16, 140
L_main10:
	DEC        R16
	BRNE       L_main10
	DEC        R17
	BRNE       L_main10
	DEC        R18
	BRNE       L_main10
	NOP
	NOP
;exti.c,75 :: 		}
	JMP        L_main8
;exti.c,76 :: 		}
L_end_main:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
L__main_end_loop:
	JMP        L__main_end_loop
; end of _main

_setup_clock:

;exti.c,79 :: 		void setup_clock()
;exti.c,81 :: 		clear_global_interrupt();
	CALL       _clear_global_interrupt+0
;exti.c,82 :: 		OSC_CTRL |= OSC_RC32KEN_bm;
	LDS        R27, OSC_CTRL+0
	SBR        R27, 4
	STS        OSC_CTRL+0, R27
;exti.c,83 :: 		while(!(OSC_STATUS & OSC_RC32KRDY_bm));
L_setup_clock12:
	LDS        R16, OSC_STATUS+0
	SBRC       R16, 2
	JMP        L_setup_clock13
	JMP        L_setup_clock12
L_setup_clock13:
;exti.c,84 :: 		DFLLRC32M_CTRL = 0;
	LDI        R27, 0
	STS        DFLLRC32M_CTRL+0, R27
;exti.c,85 :: 		OSC_CTRL |= OSC_RC32MEN_bm;
	LDS        R16, OSC_CTRL+0
	ORI        R16, 2
	STS        OSC_CTRL+0, R16
;exti.c,86 :: 		while(!(OSC_STATUS & OSC_RC32MRDY_bm));
L_setup_clock14:
	LDS        R16, OSC_STATUS+0
	SBRC       R16, 1
	JMP        L_setup_clock15
	JMP        L_setup_clock14
L_setup_clock15:
;exti.c,87 :: 		OSC_DFLLCTRL = OSC_RC32MCREF_RC32K_gc;
	LDI        R27, 0
	STS        OSC_DFLLCTRL+0, R27
;exti.c,88 :: 		DFLLRC32M_CTRL = DFLL_ENABLE_bm;
	LDI        R27, 1
	STS        DFLLRC32M_CTRL+0, R27
;exti.c,89 :: 		CPU_CCP = CCP_IOREG_gc;
	LDI        R27, 216
	OUT        CPU_CCP+0, R27
;exti.c,90 :: 		CLK_PSCTRL = (CLK_PSADIV_4_gc | CLK_PSBCDIV_1_1_gc);
	LDI        R27, 12
	STS        CLK_PSCTRL+0, R27
;exti.c,91 :: 		CPU_CCP = CCP_IOREG_gc;
	LDI        R27, 216
	OUT        CPU_CCP+0, R27
;exti.c,92 :: 		CLK_CTRL = CLK_SCLKSEL_RC32M_gc;
	LDI        R27, 1
	STS        CLK_CTRL+0, R27
;exti.c,93 :: 		OSC_CTRL &= ~(OSC_RC2MEN_bm | OSC_XOSCEN_bm | OSC_PLLEN_bm);
	LDS        R16, OSC_CTRL+0
	ANDI       R16, 230
	STS        OSC_CTRL+0, R16
;exti.c,94 :: 		PORTCFG_CLKEVOUT = 0x00;
	LDI        R27, 0
	STS        PORTCFG_CLKEVOUT+0, R27
;exti.c,95 :: 		}
L_end_setup_clock:
	RET
; end of _setup_clock

_setup_io:

;exti.c,98 :: 		void setup_io()
;exti.c,100 :: 		PORTA_OUT = 0x00;
	LDI        R27, 0
	STS        PORTA_OUT+0, R27
;exti.c,101 :: 		PORTA_DIR = 0x00;
	LDI        R27, 0
	STS        PORTA_DIR+0, R27
;exti.c,102 :: 		PORTA_PIN0CTRL = (PORT_OPC_TOTEM_gc | PORT_ISC_RISING_gc);
	LDI        R27, 1
	STS        PORTA_PIN0CTRL+0, R27
;exti.c,103 :: 		PORTA_PIN1CTRL = (PORT_OPC_TOTEM_gc | PORT_ISC_RISING_gc);
	LDI        R27, 1
	STS        PORTA_PIN1CTRL+0, R27
;exti.c,104 :: 		PORTA_PIN2CTRL = (PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc);
	LDI        R27, 0
	STS        PORTA_PIN2CTRL+0, R27
;exti.c,105 :: 		PORTA_PIN3CTRL = (PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc);
	LDI        R27, 0
	STS        PORTA_PIN3CTRL+0, R27
;exti.c,106 :: 		PORTA_PIN4CTRL = (PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc);
	LDI        R27, 0
	STS        PORTA_PIN4CTRL+0, R27
;exti.c,107 :: 		PORTA_PIN5CTRL = (PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc);
	LDI        R27, 0
	STS        PORTA_PIN5CTRL+0, R27
;exti.c,108 :: 		PORTA_PIN6CTRL = (PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc);
	LDI        R27, 0
	STS        PORTA_PIN6CTRL+0, R27
;exti.c,109 :: 		PORTA_PIN7CTRL = (PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc);
	LDI        R27, 0
	STS        PORTA_PIN7CTRL+0, R27
;exti.c,110 :: 		PORTA_INTCTRL = (PORT_INT1LVL_HI_gc | PORT_INT0LVL_LO_gc);
	LDI        R27, 13
	STS        PORTA_INTCTRL+0, R27
;exti.c,111 :: 		PORTA_INT0MASK = 0x01;
	LDI        R27, 1
	STS        PORTA_INT0MASK+0, R27
;exti.c,112 :: 		PORTA_INT1MASK = 0x02;
	LDI        R27, 2
	STS        PORTA_INT1MASK+0, R27
;exti.c,114 :: 		PORTD_OUT = 0x00;
	LDI        R27, 0
	STS        PORTD_OUT+0, R27
;exti.c,115 :: 		PORTD_DIR = 0x07;
	LDI        R27, 7
	STS        PORTD_DIR+0, R27
;exti.c,116 :: 		PORTD_PIN0CTRL = (PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc);
	LDI        R27, 0
	STS        PORTD_PIN0CTRL+0, R27
;exti.c,117 :: 		PORTD_PIN1CTRL = (PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc);
	LDI        R27, 0
	STS        PORTD_PIN1CTRL+0, R27
;exti.c,118 :: 		PORTD_PIN2CTRL = (PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc);
	LDI        R27, 0
	STS        PORTD_PIN2CTRL+0, R27
;exti.c,119 :: 		PORTD_PIN3CTRL = (PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc);
	LDI        R27, 0
	STS        PORTD_PIN3CTRL+0, R27
;exti.c,120 :: 		PORTD_PIN4CTRL = (PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc);
	LDI        R27, 0
	STS        PORTD_PIN4CTRL+0, R27
;exti.c,121 :: 		PORTD_PIN5CTRL = (PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc);
	LDI        R27, 0
	STS        PORTD_PIN5CTRL+0, R27
;exti.c,122 :: 		PORTD_PIN6CTRL = (PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc);
	LDI        R27, 0
	STS        PORTD_PIN6CTRL+0, R27
;exti.c,123 :: 		PORTD_PIN7CTRL = (PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc);
	LDI        R27, 0
	STS        PORTD_PIN7CTRL+0, R27
;exti.c,124 :: 		PORTD_INTCTRL = (PORT_INT1LVL_OFF_gc | PORT_INT0LVL_OFF_gc);
	LDI        R27, 0
	STS        PORTD_INTCTRL+0, R27
;exti.c,125 :: 		PORTD_INT0MASK = 0x00;
	LDI        R27, 0
	STS        PORTD_INT0MASK+0, R27
;exti.c,126 :: 		PORTD_INT1MASK = 0x00;
	LDI        R27, 0
	STS        PORTD_INT1MASK+0, R27
;exti.c,128 :: 		set_global_interrupt();
	CALL       _set_global_interrupt+0
;exti.c,129 :: 		}
L_end_setup_io:
	RET
; end of _setup_io

_setup_interrupts:

;exti.c,132 :: 		void setup_interrupts()
;exti.c,134 :: 		clear_global_interrupt();
	CALL       _clear_global_interrupt+0
;exti.c,135 :: 		CPU_CCP = CCP_IOREG_gc;
	LDI        R27, 216
	OUT        CPU_CCP+0, R27
;exti.c,136 :: 		PMIC_CTRL = (PMIC_LOLVLEN_bm | PMIC_HILVLEN_bm);
	LDI        R27, 5
	STS        PMIC_CTRL+0, R27
;exti.c,137 :: 		PMIC_INTPRI = 0x00;
	LDI        R27, 0
	STS        PMIC_INTPRI+0, R27
;exti.c,138 :: 		}
L_end_setup_interrupts:
	RET
; end of _setup_interrupts

_setup_lcd:

;exti.c,141 :: 		void setup_lcd()
;exti.c,143 :: 		Lcd_Init();
	PUSH       R2
	CALL       _Lcd_Init+0
;exti.c,144 :: 		Lcd_Cmd(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;exti.c,145 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	LDI        R27, 12
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;exti.c,146 :: 		}
L_end_setup_lcd:
	POP        R2
	RET
; end of _setup_lcd
