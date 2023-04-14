
_main:
	LDI        R27, 255
	OUT        SPL+0, R27
	LDI        R27, 0
	OUT        SPL+1, R27
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 20
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;ADC1.c,26 :: 		void main()
;ADC1.c,28 :: 		signed int adc = 0;
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	PUSH       R6
	PUSH       R7
	PUSH       R8
	PUSH       R9
;ADC1.c,29 :: 		signed int offset = 0;
;ADC1.c,30 :: 		float v = 0;
;ADC1.c,32 :: 		setup();
	CALL       _setup+0
;ADC1.c,33 :: 		offset = adc_avg(100, 0);
	CLR        R3
	LDI        R27, 100
	MOV        R2, R27
	CALL       _adc_avg+0
	STD        Y+10, R16
	STD        Y+11, R17
;ADC1.c,35 :: 		lcd_out(1, 1, "V:");
	LDI        R27, 86
	STD        Y+0, R27
	LDI        R27, 58
	STD        Y+1, R27
	LDI        R27, 0
	STD        Y+2, R27
	MOVW       R16, R28
	MOVW       R4, R16
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;ADC1.c,36 :: 		lcd_out(2, 1, "ADC:");
	LDI        R27, 65
	STD        Y+3, R27
	LDI        R27, 68
	STD        Y+4, R27
	LDI        R27, 67
	STD        Y+5, R27
	LDI        R27, 58
	STD        Y+6, R27
	LDI        R27, 0
	STD        Y+7, R27
	MOVW       R16, R28
	SUBI       R16, 253
	SBCI       R17, 255
	MOVW       R4, R16
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;ADC1.c,38 :: 		while(1)
L_main0:
;ADC1.c,40 :: 		adc = adc_avg(50, 1);
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 50
	MOV        R2, R27
	CALL       _adc_avg+0
	STD        Y+16, R16
	STD        Y+17, R17
	STD        Y+8, R16
	STD        Y+9, R17
;ADC1.c,42 :: 		v = map(adc, offset, 4095.0, 0, 1959.375);
	LDD        R16, Y+10
	LDD        R17, Y+11
	LDI        R18, 0
	SBRC       R17, 7
	LDI        R18, 255
	MOV        R19, R18
	CALL       _float_slong2fp+0
	LDD        R20, Y+16
	LDD        R21, Y+17
	STD        Y+16, R16
	STD        Y+17, R17
	STD        Y+18, R18
	STD        Y+19, R19
	MOVW       R16, R20
	LDI        R18, 0
	SBRC       R21, 7
	LDI        R18, 255
	MOV        R19, R18
	CALL       _float_slong2fp+0
	LDD        R20, Y+16
	LDD        R21, Y+17
	LDD        R22, Y+18
	LDD        R23, Y+19
	MOVW       R6, R20
	MOVW       R8, R22
	MOVW       R2, R16
	MOVW       R4, R18
	LDI        R27, 68
	PUSH       R27
	LDI        R27, 244
	PUSH       R27
	LDI        R27, 236
	PUSH       R27
	LDI        R27, 0
	PUSH       R27
	LDI        R27, 0
	PUSH       R27
	PUSH       R27
	PUSH       R27
	PUSH       R27
	LDI        R27, 69
	PUSH       R27
	LDI        R27, 127
	PUSH       R27
	LDI        R27, 240
	PUSH       R27
	LDI        R27, 0
	PUSH       R27
	CALL       _map+0
	IN         R26, SPL+0
	IN         R27, SPL+1
	ADIW       R26, 12
	OUT        SPL+0, R26
	OUT        SPL+1, R27
;ADC1.c,44 :: 		lcd_print(4, 1, v, 0);
	CALL       _float_fpint+0
	CLR        R6
	MOVW       R4, R16
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 4
	MOV        R2, R27
	CALL       _lcd_print+0
;ADC1.c,45 :: 		lcd_print(5, 2, adc, 1);
	LDI        R27, 1
	MOV        R6, R27
	LDD        R4, Y+8
	LDD        R5, Y+9
	LDI        R27, 2
	MOV        R3, R27
	LDI        R27, 5
	MOV        R2, R27
	CALL       _lcd_print+0
;ADC1.c,46 :: 		delay_ms(600);
	LDI        R18, 25
	LDI        R17, 90
	LDI        R16, 178
L_main2:
	DEC        R16
	BRNE       L_main2
	DEC        R17
	BRNE       L_main2
	DEC        R18
	BRNE       L_main2
	NOP
	NOP
;ADC1.c,47 :: 		};
	JMP        L_main0
;ADC1.c,48 :: 		}
L_end_main:
	POP        R9
	POP        R8
	POP        R7
	POP        R6
	POP        R5
	POP        R4
	POP        R3
	POP        R2
L__main_end_loop:
	JMP        L__main_end_loop
; end of _main

_setup:

;ADC1.c,51 :: 		void setup()
;ADC1.c,53 :: 		OSC_CTRL |= OSC_RC32KEN_bm;
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	LDS        R27, OSC_CTRL+0
	SBR        R27, 4
	STS        OSC_CTRL+0, R27
;ADC1.c,54 :: 		while(!(OSC_STATUS & OSC_RC32KRDY_bm));
L_setup4:
	LDS        R16, OSC_STATUS+0
	SBRC       R16, 2
	JMP        L_setup5
	JMP        L_setup4
L_setup5:
;ADC1.c,55 :: 		OSC_CTRL |= OSC_RC32MEN_bm;
	LDS        R16, OSC_CTRL+0
	ORI        R16, 2
	STS        OSC_CTRL+0, R16
;ADC1.c,56 :: 		CPU_CCP = CCP_IOREG_gc;
	LDI        R27, 216
	OUT        CPU_CCP+0, R27
;ADC1.c,57 :: 		CLK_PSCTRL = ((CLK_PSCTRL & (~(CLK_PSADIV_gm | CLK_PSBCDIV1_bm | CLK_PSBCDIV0_bm)))
	LDS        R16, CLK_PSCTRL+0
	ANDI       R16, 128
;ADC1.c,58 :: 		| CLK_PSADIV_1_gc | CLK_PSBCDIV_2_2_gc);
	ORI        R16, 3
	STS        CLK_PSCTRL+0, R16
;ADC1.c,59 :: 		OSC_DFLLCTRL = ((OSC_DFLLCTRL & (~(OSC_RC32MCREF_gm | OSC_RC2MCREF_bm))) |
	LDS        R16, OSC_DFLLCTRL+0
	ANDI       R16, 248
;ADC1.c,60 :: 		OSC_RC32MCREF_RC32K_gc);
	STS        OSC_DFLLCTRL+0, R16
;ADC1.c,62 :: 		DFLLRC32M_CTRL |= DFLL_ENABLE_bm;
	LDS        R16, DFLLRC32M_CTRL+0
	ORI        R16, 1
	STS        DFLLRC32M_CTRL+0, R16
;ADC1.c,63 :: 		while(!(OSC_STATUS & OSC_RC32MRDY_bm));
L_setup6:
	LDS        R16, OSC_STATUS+0
	SBRC       R16, 1
	JMP        L_setup7
	JMP        L_setup6
L_setup7:
;ADC1.c,64 :: 		CPU_CCP = CCP_IOREG_gc;
	LDI        R27, 216
	OUT        CPU_CCP+0, R27
;ADC1.c,65 :: 		CLK_CTRL = ((CLK_CTRL & (~CLK_SCLKSEL_gm)) | CLK_SCLKSEL_RC32M_gc);
	LDS        R16, CLK_CTRL+0
	ANDI       R16, 248
	ORI        R16, 1
	STS        CLK_CTRL+0, R16
;ADC1.c,66 :: 		OSC_CTRL &= (~(OSC_RC2MEN_bm | OSC_XOSCEN_bm | OSC_PLLEN_bm));
	LDS        R16, OSC_CTRL+0
	ANDI       R16, 230
	STS        OSC_CTRL+0, R16
;ADC1.c,67 :: 		PORTCFG_CLKEVOUT = 0x00;
	LDI        R27, 0
	STS        PORTCFG_CLKEVOUT+0, R27
;ADC1.c,69 :: 		PORTD_OUT = 0x00;
	LDI        R27, 0
	STS        PORTD_OUT+0, R27
;ADC1.c,70 :: 		PORTD_DIR = 0x02;
	LDI        R27, 2
	STS        PORTD_DIR+0, R27
;ADC1.c,71 :: 		PORTD_PIN0CTRL = (PORT_OPC_BUSKEEPER_gc | PORT_ISC_BOTHEDGES_gc);
	LDI        R27, 8
	STS        PORTD_PIN0CTRL+0, R27
;ADC1.c,72 :: 		PORTD_PIN1CTRL = (PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc);
	LDI        R27, 0
	STS        PORTD_PIN1CTRL+0, R27
;ADC1.c,74 :: 		ADCA_Init_Advanced(_ADC_12bit, _ADC_INTERNAL_REF_VCC);
	LDI        R27, 16
	MOV        R4, R27
	LDI        R27, 0
	MOV        R5, R27
	CLR        R2
	CLR        R3
	CALL       _ADCA_Init_Advanced+0
;ADC1.c,76 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;ADC1.c,77 :: 		Lcd_Cmd(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;ADC1.c,78 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	LDI        R27, 12
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;ADC1.c,79 :: 		}
L_end_setup:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _setup

_adc_avg:

;ADC1.c,82 :: 		signed int adc_avg(unsigned char no_of_samples, unsigned char channel)
;ADC1.c,84 :: 		signed long avg = 0;
; avg start address is: 21 (R21)
	LDI        R21, 0
	LDI        R22, 0
	LDI        R23, 0
	LDI        R24, 0
;ADC1.c,85 :: 		unsigned char samples = no_of_samples;
; samples start address is: 20 (R20)
	MOV        R20, R2
; avg end address is: 21 (R21)
; samples end address is: 20 (R20)
;ADC1.c,87 :: 		while(samples > 0)
L_adc_avg8:
; samples start address is: 20 (R20)
; avg start address is: 21 (R21)
	LDI        R16, 0
	CP         R16, R20
	BRLO       L__adc_avg20
	JMP        L_adc_avg9
L__adc_avg20:
;ADC1.c,89 :: 		avg += ADCA_Get_Sample(channel);
	PUSH       R24
	PUSH       R23
	PUSH       R22
	PUSH       R21
	PUSH       R20
	PUSH       R2
	MOV        R2, R3
	CALL       _ADCA_Get_Sample+0
	POP        R2
	POP        R20
	POP        R21
	POP        R22
	POP        R23
	POP        R24
	LDI        R18, 0
	MOV        R19, R18
	ADD        R16, R21
	ADC        R17, R22
	ADC        R18, R23
	ADC        R19, R24
	MOV        R21, R16
	MOV        R22, R17
	MOV        R23, R18
	MOV        R24, R19
;ADC1.c,90 :: 		samples--;
	MOV        R16, R20
	SUBI       R16, 1
	MOV        R20, R16
;ADC1.c,91 :: 		}
; samples end address is: 20 (R20)
	JMP        L_adc_avg8
L_adc_avg9:
;ADC1.c,92 :: 		avg /= no_of_samples;
	PUSH       R3
; avg end address is: 21 (R21)
	PUSH       R2
	MOV        R16, R21
	MOV        R17, R22
	MOV        R18, R23
	MOV        R19, R24
	MOV        R20, R2
	LDI        R21, 0
	MOV        R22, R21
	MOV        R23, R21
	CALL       _Div_32x32_S+0
	MOVW       R16, R18
	MOVW       R18, R20
	POP        R2
	POP        R3
;ADC1.c,94 :: 		return avg;
;ADC1.c,95 :: 		}
L_end_adc_avg:
	RET
; end of _adc_avg

_lcd_print:
	PUSH       R28
	PUSH       R29
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 4
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;ADC1.c,98 :: 		void lcd_print(unsigned char x_pos, unsigned char y_pos, signed int value, unsigned char cnt_volt)
;ADC1.c,100 :: 		unsigned char tmp = 0;
	PUSH       R2
	PUSH       R3
;ADC1.c,102 :: 		if(value > 0)
	LDI        R16, 0
	LDI        R17, 0
	CP         R16, R4
	CPC        R17, R5
	BRLT       L__lcd_print22
	JMP        L_lcd_print10
L__lcd_print22:
;ADC1.c,104 :: 		lcd_out(y_pos, x_pos, " ");
	LDI        R27, 32
	STD        Y+0, R27
	LDI        R27, 0
	STD        Y+1, R27
	MOVW       R16, R28
	PUSH       R6
	PUSH       R5
	PUSH       R4
	PUSH       R3
	MOVW       R4, R16
	MOV        R3, R2
	POP        R2
	CALL       _Lcd_Out+0
	POP        R4
	POP        R5
	POP        R6
;ADC1.c,105 :: 		}
	JMP        L_lcd_print11
L_lcd_print10:
;ADC1.c,108 :: 		lcd_out(y_pos, x_pos, "-");
	LDI        R27, 45
	STD        Y+2, R27
	LDI        R27, 0
	STD        Y+3, R27
	MOVW       R16, R28
	SUBI       R16, 254
	SBCI       R17, 255
	PUSH       R6
	PUSH       R5
	PUSH       R4
	PUSH       R3
	MOVW       R4, R16
	MOV        R3, R2
	POP        R2
	CALL       _Lcd_Out+0
	POP        R4
	POP        R5
	POP        R6
;ADC1.c,109 :: 		value *= -1;
	MOVW       R16, R4
	LDI        R20, 255
	LDI        R21, 255
	CALL       _HWMul_16x16+0
	MOVW       R4, R16
;ADC1.c,110 :: 		}
L_lcd_print11:
;ADC1.c,112 :: 		tmp = (value / 1000);
	PUSH       R6
	PUSH       R5
	PUSH       R4
	LDI        R20, 232
	LDI        R21, 3
	MOVW       R16, R4
	CALL       _Div_16x16_S+0
	MOVW       R16, R22
;ADC1.c,113 :: 		lcd_chr_cp(tmp + 48);
	SUBI       R16, 208
	MOV        R2, R16
	CALL       _Lcd_Chr_CP+0
	POP        R4
	POP        R5
	POP        R6
;ADC1.c,115 :: 		switch(cnt_volt)
	JMP        L_lcd_print12
;ADC1.c,117 :: 		case 1:
L_lcd_print14:
;ADC1.c,119 :: 		break;
	JMP        L_lcd_print13
;ADC1.c,121 :: 		default:
L_lcd_print15:
;ADC1.c,123 :: 		lcd_chr_cp(46);
	PUSH       R5
	PUSH       R4
	LDI        R27, 46
	MOV        R2, R27
	CALL       _Lcd_Chr_CP+0
	POP        R4
	POP        R5
;ADC1.c,124 :: 		break;
	JMP        L_lcd_print13
;ADC1.c,126 :: 		}
L_lcd_print12:
	LDI        R27, 1
	CP         R6, R27
	BRNE       L__lcd_print23
	JMP        L_lcd_print14
L__lcd_print23:
	JMP        L_lcd_print15
L_lcd_print13:
;ADC1.c,128 :: 		tmp = ((value / 100) % 10);
	PUSH       R5
	PUSH       R4
	LDI        R20, 100
	LDI        R21, 0
	MOVW       R16, R4
	CALL       _Div_16x16_S+0
	MOVW       R16, R22
	LDI        R20, 10
	LDI        R21, 0
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
;ADC1.c,129 :: 		lcd_chr_cp((tmp + 48));
	SUBI       R16, 208
	MOV        R2, R16
	CALL       _Lcd_Chr_CP+0
	POP        R4
	POP        R5
;ADC1.c,130 :: 		tmp = ((value / 10) % 10);
	PUSH       R5
	PUSH       R4
	LDI        R20, 10
	LDI        R21, 0
	MOVW       R16, R4
	CALL       _Div_16x16_S+0
	MOVW       R16, R22
	LDI        R20, 10
	LDI        R21, 0
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
;ADC1.c,131 :: 		lcd_chr_cp((tmp + 48));
	SUBI       R16, 208
	MOV        R2, R16
	CALL       _Lcd_Chr_CP+0
	POP        R4
	POP        R5
;ADC1.c,132 :: 		tmp = (value % 10);
	LDI        R20, 10
	LDI        R21, 0
	MOVW       R16, R4
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
;ADC1.c,133 :: 		lcd_chr_cp((tmp + 48));
	SUBI       R16, 208
	MOV        R2, R16
	CALL       _Lcd_Chr_CP+0
;ADC1.c,134 :: 		}
L_end_lcd_print:
	POP        R3
	POP        R2
	ADIW       R28, 3
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	POP        R29
	POP        R28
	RET
; end of _lcd_print

_map:
	PUSH       R28
	PUSH       R29
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 16
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;ADC1.c,137 :: 		float map(float v, float x_min, float x_max, float y_min, float y_max)
	LDD        R16, Y+20
	LDD        R17, Y+21
	LDD        R18, Y+22
	LDD        R19, Y+23
	STD        Y+20, R16
	STD        Y+21, R17
	STD        Y+22, R18
	STD        Y+23, R19
	LDD        R16, Y+24
	LDD        R17, Y+25
	LDD        R18, Y+26
	LDD        R19, Y+27
	STD        Y+24, R16
	STD        Y+25, R17
	STD        Y+26, R18
	STD        Y+27, R19
	LDD        R16, Y+28
	LDD        R17, Y+29
	LDD        R18, Y+30
	LDD        R19, Y+31
	STD        Y+28, R16
	STD        Y+29, R17
	STD        Y+30, R18
	STD        Y+31, R19
;ADC1.c,139 :: 		float m = 0.0;
;ADC1.c,140 :: 		m = ((y_max - y_min)/(x_max - x_min));
	PUSH       R9
	PUSH       R8
	PUSH       R7
	PUSH       R6
	PUSH       R5
	PUSH       R4
	PUSH       R3
	PUSH       R2
	LDD        R20, Y+24
	LDD        R21, Y+25
	LDD        R22, Y+26
	LDD        R23, Y+27
	LDD        R16, Y+28
	LDD        R17, Y+29
	LDD        R18, Y+30
	LDD        R19, Y+31
	CALL       _float_fpsub1+0
	POP        R2
	POP        R3
	POP        R4
	POP        R5
	POP        R6
	POP        R7
	POP        R8
	POP        R9
	STD        Y+12, R16
	STD        Y+13, R17
	STD        Y+14, R18
	STD        Y+15, R19
	PUSH       R9
	PUSH       R8
	PUSH       R7
	PUSH       R6
	PUSH       R5
	PUSH       R4
	PUSH       R3
	PUSH       R2
	MOVW       R20, R6
	MOVW       R22, R8
	LDD        R16, Y+20
	LDD        R17, Y+21
	LDD        R18, Y+22
	LDD        R19, Y+23
	CALL       _float_fpsub1+0
	STD        Y+0, R16
	STD        Y+1, R17
	STD        Y+2, R18
	STD        Y+3, R19
	LDD        R16, Y+12
	LDD        R17, Y+13
	LDD        R18, Y+14
	LDD        R19, Y+15
	LDD        R20, Y+0
	LDD        R21, Y+1
	LDD        R22, Y+2
	LDD        R23, Y+3
	CALL       _float_fpdiv1+0
	POP        R2
	POP        R3
	POP        R4
	POP        R5
	POP        R6
	POP        R7
	POP        R8
	POP        R9
	STD        Y+12, R16
	STD        Y+13, R17
	STD        Y+14, R18
	STD        Y+15, R19
;ADC1.c,141 :: 		return (y_min + (m * (v - x_min)));
	MOVW       R20, R6
	MOVW       R22, R8
	MOVW       R16, R2
	MOVW       R18, R4
	CALL       _float_fpsub1+0
	LDD        R20, Y+12
	LDD        R21, Y+13
	LDD        R22, Y+14
	LDD        R23, Y+15
	CALL       _float_fpmul1+0
	LDD        R20, Y+24
	LDD        R21, Y+25
	LDD        R22, Y+26
	LDD        R23, Y+27
	CALL       _float_fpadd1+0
;ADC1.c,142 :: 		}
L_end_map:
	ADIW       R28, 15
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	POP        R29
	POP        R28
	RET
; end of _map
