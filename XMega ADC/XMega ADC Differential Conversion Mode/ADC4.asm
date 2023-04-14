
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

;ADC4.c,33 :: 		void main()
;ADC4.c,35 :: 		signed int adc = 0;
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	PUSH       R6
;ADC4.c,36 :: 		float v = 0;
;ADC4.c,38 :: 		setup();
	CALL       _setup+0
;ADC4.c,40 :: 		lcd_out(1, 1, "V:");
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
;ADC4.c,41 :: 		lcd_out(2, 1, "ADC:");
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
;ADC4.c,43 :: 		while(1)
L_main0:
;ADC4.c,45 :: 		adc = adc_avg(20, ADC_CH_MUXPOS_PIN1_gc, ADC_CH_MUXNEG_PIN2_gc);
	LDI        R27, 2
	MOV        R4, R27
	LDI        R27, 8
	MOV        R3, R27
	LDI        R27, 20
	MOV        R2, R27
	CALL       _adc_avg+0
	STD        Y+8, R16
	STD        Y+9, R17
;ADC4.c,46 :: 		v = ((adc * 2062.5) / 2048);
	LDI        R18, 0
	SBRC       R17, 7
	LDI        R18, 255
	MOV        R19, R18
	CALL       _float_slong2fp+0
	LDI        R20, 0
	LDI        R21, 232
	LDI        R22, 0
	LDI        R23, 69
	CALL       _float_fpmul1+0
	LDI        R20, 0
	LDI        R21, 0
	LDI        R22, 0
	LDI        R23, 69
	CALL       _float_fpdiv1+0
;ADC4.c,48 :: 		lcd_print(6, 1, v, 0);
	CALL       _float_fpint+0
	CLR        R6
	MOVW       R4, R16
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 6
	MOV        R2, R27
	CALL       _lcd_print+0
;ADC4.c,49 :: 		lcd_print(6, 2, adc, 1);
	LDI        R27, 1
	MOV        R6, R27
	LDD        R4, Y+8
	LDD        R5, Y+9
	LDI        R27, 2
	MOV        R3, R27
	LDI        R27, 6
	MOV        R2, R27
	CALL       _lcd_print+0
;ADC4.c,50 :: 		delay_ms(600);
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
;ADC4.c,51 :: 		};
	JMP        L_main0
;ADC4.c,52 :: 		}
L_end_main:
	POP        R6
	POP        R5
	POP        R4
	POP        R3
	POP        R2
L__main_end_loop:
	JMP        L__main_end_loop
; end of _main

_clock_setup:

;ADC4.c,55 :: 		void clock_setup()
;ADC4.c,57 :: 		OSC_CTRL |= OSC_RC32KEN_bm;
	LDS        R27, OSC_CTRL+0
	SBR        R27, 4
	STS        OSC_CTRL+0, R27
;ADC4.c,58 :: 		while(!(OSC_STATUS & OSC_RC32KRDY_bm));
L_clock_setup4:
	LDS        R16, OSC_STATUS+0
	SBRC       R16, 2
	JMP        L_clock_setup5
	JMP        L_clock_setup4
L_clock_setup5:
;ADC4.c,59 :: 		OSC_CTRL |= OSC_RC32MEN_bm;
	LDS        R16, OSC_CTRL+0
	ORI        R16, 2
	STS        OSC_CTRL+0, R16
;ADC4.c,60 :: 		CPU_CCP = CCP_IOREG_gc;
	LDI        R27, 216
	OUT        CPU_CCP+0, R27
;ADC4.c,61 :: 		CLK_PSCTRL = ((CLK_PSCTRL & (~(CLK_PSADIV_gm | CLK_PSBCDIV1_bm | CLK_PSBCDIV0_bm)))
	LDS        R16, CLK_PSCTRL+0
	ANDI       R16, 128
;ADC4.c,62 :: 		| CLK_PSADIV_1_gc | CLK_PSBCDIV_2_2_gc);
	ORI        R16, 3
	STS        CLK_PSCTRL+0, R16
;ADC4.c,63 :: 		OSC_DFLLCTRL = ((OSC_DFLLCTRL & (~(OSC_RC32MCREF_gm | OSC_RC2MCREF_bm))) |
	LDS        R16, OSC_DFLLCTRL+0
	ANDI       R16, 248
;ADC4.c,64 :: 		OSC_RC32MCREF_RC32K_gc);
	STS        OSC_DFLLCTRL+0, R16
;ADC4.c,65 :: 		DFLLRC32M_CTRL |= DFLL_ENABLE_bm;
	LDS        R16, DFLLRC32M_CTRL+0
	ORI        R16, 1
	STS        DFLLRC32M_CTRL+0, R16
;ADC4.c,66 :: 		while(!(OSC_STATUS & OSC_RC32MRDY_bm));
L_clock_setup6:
	LDS        R16, OSC_STATUS+0
	SBRC       R16, 1
	JMP        L_clock_setup7
	JMP        L_clock_setup6
L_clock_setup7:
;ADC4.c,67 :: 		CPU_CCP = CCP_IOREG_gc;
	LDI        R27, 216
	OUT        CPU_CCP+0, R27
;ADC4.c,68 :: 		CLK_CTRL = ((CLK_CTRL & (~CLK_SCLKSEL_gm)) | CLK_SCLKSEL_RC32M_gc);
	LDS        R16, CLK_CTRL+0
	ANDI       R16, 248
	ORI        R16, 1
	STS        CLK_CTRL+0, R16
;ADC4.c,69 :: 		OSC_CTRL &= (~(OSC_RC2MEN_bm | OSC_XOSCEN_bm | OSC_PLLEN_bm));
	LDS        R16, OSC_CTRL+0
	ANDI       R16, 230
	STS        OSC_CTRL+0, R16
;ADC4.c,70 :: 		PORTCFG_CLKEVOUT = 0x00;
	LDI        R27, 0
	STS        PORTCFG_CLKEVOUT+0, R27
;ADC4.c,71 :: 		}
L_end_clock_setup:
	RET
; end of _clock_setup

_io_setup:

;ADC4.c,74 :: 		void io_setup()
;ADC4.c,76 :: 		PORTA_OUT = 0x00;
	LDI        R27, 0
	STS        PORTA_OUT+0, R27
;ADC4.c,77 :: 		PORTA_DIR = 0x00;
	LDI        R27, 0
	STS        PORTA_DIR+0, R27
;ADC4.c,78 :: 		PORTCFG_MPCMASK = 0xFF;
	LDI        R27, 255
	STS        PORTCFG_MPCMASK+0, R27
;ADC4.c,79 :: 		PORTA_PIN0CTRL = (PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc);
	LDI        R27, 0
	STS        PORTA_PIN0CTRL+0, R27
;ADC4.c,80 :: 		PORTA_INTCTRL = 0x00;
	LDI        R27, 0
	STS        PORTA_INTCTRL+0, R27
;ADC4.c,81 :: 		PORTA_INT0MASK = 0x00;
	LDI        R27, 0
	STS        PORTA_INT0MASK+0, R27
;ADC4.c,82 :: 		PORTA_INT1MASK = 0x00;
	LDI        R27, 0
	STS        PORTA_INT1MASK+0, R27
;ADC4.c,83 :: 		}
L_end_io_setup:
	RET
; end of _io_setup

_adc_setup:

;ADC4.c,86 :: 		void adc_setup()
;ADC4.c,88 :: 		unsigned char samples = 16;
; samples start address is: 20 (R20)
	LDI        R20, 16
;ADC4.c,90 :: 		ADCA_CAL = (0x0FFF & ((PROD_SIGNATURES_ADCACAL1  << 8) | PROD_SIGNATURES_ADCACAL0));
	IN         R16, PROD_SIGNATURES_ADCACAL1+0
	MOV        R19, R16
	CLR        R18
	IN         R16, PROD_SIGNATURES_ADCACAL0+0
	LDI        R17, 0
	OR         R16, R18
	OR         R17, R19
	ANDI       R16, 255
	ANDI       R17, 15
	STS        ADCA_CAL+0, R16
	STS        ADCA_CAL+1, R17
;ADC4.c,91 :: 		ADCA_CTRLB = ((1 << ADC_IMPMODE_bp) | ADC_CURRLIMIT_NO_gc | (1 << ADC_CONMODE_bp) | ADC_RESOLUTION_12BIT_gc);
	LDI        R27, 144
	STS        ADCA_CTRLB+0, R27
;ADC4.c,92 :: 		ADCA_PRESCALER = ADC_PRESCALER_DIV64_gc;
	LDI        R27, 4
	STS        ADCA_PRESCALER+0, R27
;ADC4.c,93 :: 		ADCA_REFCTRL = (ADC_REFSEL_VCC_gc | (0 << ADC_TEMPREF_bp) | (0 << ADC_BANDGAP_bp));
	LDI        R27, 16
	STS        ADCA_REFCTRL+0, R27
;ADC4.c,94 :: 		ADCA_CH0_CTRL = ((0 << ADC_CH_START_bp) | ADC_CH_GAIN_1X_gc | ADC_CH_INPUTMODE_DIFF_gc);
	LDI        R27, 2
	STS        ADCA_CH0_CTRL+0, R27
;ADC4.c,95 :: 		ADCA_CH0_MUXCTRL = (ADC_CH_MUXPOS_PIN0_gc | ADC_CH_MUXNEG_PIN0_gc);
	LDI        R27, 0
	STS        ADCA_CH0_MUXCTRL+0, R27
;ADC4.c,96 :: 		ADCA_CTRLA |= ADC_ENABLE_bm;
	LDS        R16, ADCA_CTRLA+0
	ORI        R16, 1
	STS        ADCA_CTRLA+0, R16
;ADC4.c,97 :: 		delay_ms(4);
	LDI        R17, 42
	LDI        R16, 142
L_adc_setup8:
	DEC        R16
	BRNE       L_adc_setup8
	DEC        R17
	BRNE       L_adc_setup8
	NOP
; samples end address is: 20 (R20)
;ADC4.c,99 :: 		while(samples > 0)
L_adc_setup10:
; samples start address is: 20 (R20)
	LDI        R16, 0
	CP         R16, R20
	BRLO       L__adc_setup31
	JMP        L_adc_setup11
L__adc_setup31:
;ADC4.c,101 :: 		ADCA_CH0_CTRL |= (1 << ADC_CH_START_bp);
	LDS        R27, ADCA_CH0_CTRL+0
	SBR        R27, 128
	STS        ADCA_CH0_CTRL+0, R27
; samples end address is: 20 (R20)
;ADC4.c,102 :: 		while(!(ADCA_CH0_INTFLAGS & ADC_CH_CHIF_bm));
L_adc_setup12:
; samples start address is: 20 (R20)
	LDS        R16, ADCA_CH0_INTFLAGS+0
	SBRC       R16, 0
	JMP        L_adc_setup13
	JMP        L_adc_setup12
L_adc_setup13:
;ADC4.c,103 :: 		ADCA_CH0_INTFLAGS = ADC_CH_CHIF_bm;
	LDI        R27, 1
	STS        ADCA_CH0_INTFLAGS+0, R27
;ADC4.c,104 :: 		offset += ADCA_CH0RES;
	LDS        R18, _offset+0
	LDS        R19, _offset+1
	LDS        R16, ADCA_CH0RES+0
	LDS        R17, ADCA_CH0RES+1
	ADD        R16, R18
	ADC        R17, R19
	STS        _offset+0, R16
	STS        _offset+1, R17
;ADC4.c,105 :: 		samples--;
	MOV        R16, R20
	SUBI       R16, 1
	MOV        R20, R16
;ADC4.c,106 :: 		}
; samples end address is: 20 (R20)
	JMP        L_adc_setup10
L_adc_setup11:
;ADC4.c,108 :: 		ADCA_CTRLA &= ~ADC_ENABLE_bm;
	LDS        R16, ADCA_CTRLA+0
	ANDI       R16, 254
	STS        ADCA_CTRLA+0, R16
;ADC4.c,109 :: 		offset >>= 4;
	LDS        R16, _offset+0
	LDS        R17, _offset+1
	LDI        R27, 4
L__adc_setup32:
	ASR        R17
	ROR        R16
	DEC        R27
	BRNE       L__adc_setup32
L__adc_setup33:
	STS        _offset+0, R16
	STS        _offset+1, R17
;ADC4.c,110 :: 		ADCA_CH0_CTRL = ((0 << ADC_CH_START_bp) | ADC_CH_GAIN_1X_gc | ADC_CH_INPUTMODE_DIFF_gc);
	LDI        R27, 2
	STS        ADCA_CH0_CTRL+0, R27
;ADC4.c,111 :: 		ADCA_CH0_MUXCTRL = (ADC_CH_MUXPOS_PIN1_gc | ADC_CH_MUXNEG_PIN2_gc);
	LDI        R27, 10
	STS        ADCA_CH0_MUXCTRL+0, R27
;ADC4.c,112 :: 		ADCA_EVCTRL = (ADC_SWEEP_0_gc | ADC_EVACT_NONE_gc);
	LDI        R27, 0
	STS        ADCA_EVCTRL+0, R27
;ADC4.c,113 :: 		ADCA_CH0_INTCTRL = (ADC_CH_INTMODE_COMPLETE_gc | ADC_CH_INTLVL_OFF_gc);
	LDI        R27, 0
	STS        ADCA_CH0_INTCTRL+0, R27
;ADC4.c,114 :: 		ADCA_CH1_INTCTRL = ADC_CH_INTLVL_OFF_gc;
	LDI        R27, 0
	STS        ADCA_CH1_INTCTRL+0, R27
;ADC4.c,115 :: 		ADCA_CH2_INTCTRL = ADC_CH_INTLVL_OFF_gc;
	LDI        R27, 0
	STS        ADCA_CH2_INTCTRL+0, R27
;ADC4.c,116 :: 		ADCA_CH3_INTCTRL = ADC_CH_INTLVL_OFF_gc;
	LDI        R27, 0
	STS        ADCA_CH3_INTCTRL+0, R27
;ADC4.c,117 :: 		ADCA_CTRLB |= ADC_FREERUN_bm;
	LDS        R16, ADCA_CTRLB+0
	ORI        R16, 8
	STS        ADCA_CTRLB+0, R16
;ADC4.c,118 :: 		ADCA_CTRLA |= ADC_ENABLE_bm;
	LDS        R16, ADCA_CTRLA+0
	ORI        R16, 1
	STS        ADCA_CTRLA+0, R16
;ADC4.c,119 :: 		delay_ms(9);
	LDI        R17, 94
	LDI        R16, 129
L_adc_setup14:
	DEC        R16
	BRNE       L_adc_setup14
	DEC        R17
	BRNE       L_adc_setup14
;ADC4.c,120 :: 		}
L_end_adc_setup:
	RET
; end of _adc_setup

_setup:

;ADC4.c,123 :: 		void setup()
;ADC4.c,125 :: 		clock_setup();
	PUSH       R2
	CALL       _clock_setup+0
;ADC4.c,126 :: 		io_setup();
	CALL       _io_setup+0
;ADC4.c,127 :: 		adc_setup();
	CALL       _adc_setup+0
;ADC4.c,128 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;ADC4.c,129 :: 		Lcd_Cmd(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;ADC4.c,130 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	LDI        R27, 12
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;ADC4.c,131 :: 		}
L_end_setup:
	POP        R2
	RET
; end of _setup

_ADCA_read_ext_pins:

;ADC4.c,134 :: 		signed int ADCA_read_ext_pins(unsigned char pos_pin, unsigned char neg_pin)
;ADC4.c,136 :: 		signed int val = 0;
;ADC4.c,138 :: 		ADCA_CH0_MUXCTRL = (pos_pin | neg_pin);
	MOV        R16, R2
	OR         R16, R3
	STS        ADCA_CH0_MUXCTRL+0, R16
;ADC4.c,139 :: 		while (!(ADCA_CH0_INTFLAGS & ADC_CH_CHIF_bm));
L_ADCA_read_ext_pins16:
	LDS        R16, ADCA_CH0_INTFLAGS+0
	SBRC       R16, 0
	JMP        L_ADCA_read_ext_pins17
	JMP        L_ADCA_read_ext_pins16
L_ADCA_read_ext_pins17:
;ADC4.c,140 :: 		ADCA_CH0_INTFLAGS = ADC_CH_CHIF_bm;
	LDI        R27, 1
	STS        ADCA_CH0_INTFLAGS+0, R27
;ADC4.c,141 :: 		val = ADCA_CH0_RES;
; val start address is: 18 (R18)
	LDS        R18, ADCA_CH0_RES+0
	LDS        R19, ADCA_CH0_RES+1
;ADC4.c,142 :: 		val -= offset;
	LDS        R0, _offset+0
	LDS        R1, _offset+1
	MOVW       R16, R18
	SUB        R16, R0
	SBC        R17, R1
; val end address is: 18 (R18)
;ADC4.c,144 :: 		return val;
;ADC4.c,145 :: 		}
L_end_ADCA_read_ext_pins:
	RET
; end of _ADCA_read_ext_pins

_adc_avg:

;ADC4.c,148 :: 		signed int adc_avg(unsigned char no_of_samples, unsigned char pos_pin, unsigned char neg_pin)
;ADC4.c,150 :: 		signed long avg = 0;
; avg start address is: 21 (R21)
	LDI        R21, 0
	LDI        R22, 0
	LDI        R23, 0
	LDI        R24, 0
;ADC4.c,151 :: 		unsigned char samples = no_of_samples;
; samples start address is: 20 (R20)
	MOV        R20, R2
; avg end address is: 21 (R21)
; samples end address is: 20 (R20)
;ADC4.c,153 :: 		while(samples > 0)
L_adc_avg18:
; samples start address is: 20 (R20)
; avg start address is: 21 (R21)
	LDI        R16, 0
	CP         R16, R20
	BRLO       L__adc_avg37
	JMP        L_adc_avg19
L__adc_avg37:
;ADC4.c,155 :: 		avg += ADCA_read_ext_pins(pos_pin, neg_pin);
	PUSH       R3
	PUSH       R2
	MOV        R2, R3
	MOV        R3, R4
	CALL       _ADCA_read_ext_pins+0
	POP        R2
	POP        R3
	LDI        R18, 0
	SBRC       R17, 7
	LDI        R18, 255
	MOV        R19, R18
	ADD        R16, R21
	ADC        R17, R22
	ADC        R18, R23
	ADC        R19, R24
	MOV        R21, R16
	MOV        R22, R17
	MOV        R23, R18
	MOV        R24, R19
;ADC4.c,156 :: 		samples--;
	MOV        R16, R20
	SUBI       R16, 1
	MOV        R20, R16
;ADC4.c,157 :: 		}
; samples end address is: 20 (R20)
	JMP        L_adc_avg18
L_adc_avg19:
;ADC4.c,158 :: 		avg /= no_of_samples;
	PUSH       R4
; avg end address is: 21 (R21)
	PUSH       R3
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
	POP        R4
;ADC4.c,160 :: 		return avg;
;ADC4.c,161 :: 		}
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

;ADC4.c,164 :: 		void lcd_print(unsigned char x_pos, unsigned char y_pos, signed int value, unsigned char cnt_volt)
;ADC4.c,166 :: 		unsigned char tmp = 0;
	PUSH       R2
	PUSH       R3
;ADC4.c,168 :: 		if(value > 0)
	LDI        R16, 0
	LDI        R17, 0
	CP         R16, R4
	CPC        R17, R5
	BRLT       L__lcd_print39
	JMP        L_lcd_print20
L__lcd_print39:
;ADC4.c,170 :: 		lcd_out(y_pos, x_pos, " ");
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
;ADC4.c,171 :: 		}
	JMP        L_lcd_print21
L_lcd_print20:
;ADC4.c,174 :: 		lcd_out(y_pos, x_pos, "-");
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
;ADC4.c,175 :: 		value *= -1;
	MOVW       R16, R4
	LDI        R20, 255
	LDI        R21, 255
	CALL       _HWMul_16x16+0
	MOVW       R4, R16
;ADC4.c,176 :: 		}
L_lcd_print21:
;ADC4.c,178 :: 		tmp = (value / 1000);
	PUSH       R6
	PUSH       R5
	PUSH       R4
	LDI        R20, 232
	LDI        R21, 3
	MOVW       R16, R4
	CALL       _Div_16x16_S+0
	MOVW       R16, R22
;ADC4.c,179 :: 		lcd_chr_cp(tmp + 48);
	SUBI       R16, 208
	MOV        R2, R16
	CALL       _Lcd_Chr_CP+0
	POP        R4
	POP        R5
	POP        R6
;ADC4.c,181 :: 		switch(cnt_volt)
	JMP        L_lcd_print22
;ADC4.c,183 :: 		case 1:
L_lcd_print24:
;ADC4.c,185 :: 		break;
	JMP        L_lcd_print23
;ADC4.c,187 :: 		default:
L_lcd_print25:
;ADC4.c,189 :: 		lcd_chr_cp(46);
	PUSH       R5
	PUSH       R4
	LDI        R27, 46
	MOV        R2, R27
	CALL       _Lcd_Chr_CP+0
	POP        R4
	POP        R5
;ADC4.c,190 :: 		break;
	JMP        L_lcd_print23
;ADC4.c,192 :: 		}
L_lcd_print22:
	LDI        R27, 1
	CP         R6, R27
	BRNE       L__lcd_print40
	JMP        L_lcd_print24
L__lcd_print40:
	JMP        L_lcd_print25
L_lcd_print23:
;ADC4.c,194 :: 		tmp = ((value / 100) % 10);
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
;ADC4.c,195 :: 		lcd_chr_cp((tmp + 48));
	SUBI       R16, 208
	MOV        R2, R16
	CALL       _Lcd_Chr_CP+0
	POP        R4
	POP        R5
;ADC4.c,196 :: 		tmp = ((value / 10) % 10);
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
;ADC4.c,197 :: 		lcd_chr_cp((tmp + 48));
	SUBI       R16, 208
	MOV        R2, R16
	CALL       _Lcd_Chr_CP+0
	POP        R4
	POP        R5
;ADC4.c,198 :: 		tmp = (value % 10);
	LDI        R20, 10
	LDI        R21, 0
	MOVW       R16, R4
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
;ADC4.c,199 :: 		lcd_chr_cp((tmp + 48));
	SUBI       R16, 208
	MOV        R2, R16
	CALL       _Lcd_Chr_CP+0
;ADC4.c,200 :: 		}
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
