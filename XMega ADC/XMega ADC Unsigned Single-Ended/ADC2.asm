
_main:
	LDI        R27, 255
	OUT        SPL+0, R27
	LDI        R27, 0
	OUT        SPL+1, R27
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 18
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;ADC2.c,34 :: 		void main()
;ADC2.c,36 :: 		signed int adc = 0;
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	PUSH       R6
	PUSH       R7
	PUSH       R8
	PUSH       R9
;ADC2.c,37 :: 		float v = 0;
;ADC2.c,39 :: 		setup();
	CALL       _setup+0
;ADC2.c,41 :: 		lcd_out(1, 1, "V:");
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
;ADC2.c,42 :: 		lcd_out(2, 1, "ADC:");
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
;ADC2.c,44 :: 		while(1)
L_main0:
;ADC2.c,46 :: 		adc = adc_avg(25, ADC_CH_MUXPOS_PIN1_gc);
	LDI        R27, 8
	MOV        R3, R27
	LDI        R27, 25
	MOV        R2, R27
	CALL       _adc_avg+0
	STD        Y+14, R16
	STD        Y+15, R17
	STD        Y+8, R16
	STD        Y+9, R17
;ADC2.c,47 :: 		v = map(adc, offset, 4095.0, 0, 1959.375);
	LDS        R16, _offset+0
	LDS        R17, _offset+1
	LDI        R18, 0
	SBRC       R17, 7
	LDI        R18, 255
	MOV        R19, R18
	CALL       _float_slong2fp+0
	LDD        R20, Y+14
	LDD        R21, Y+15
	STD        Y+14, R16
	STD        Y+15, R17
	STD        Y+16, R18
	STD        Y+17, R19
	MOVW       R16, R20
	LDI        R18, 0
	SBRC       R21, 7
	LDI        R18, 255
	MOV        R19, R18
	CALL       _float_slong2fp+0
	LDD        R20, Y+14
	LDD        R21, Y+15
	LDD        R22, Y+16
	LDD        R23, Y+17
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
;ADC2.c,49 :: 		lcd_print(4, 1, v, 0);
	CALL       _float_fpint+0
	CLR        R6
	MOVW       R4, R16
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 4
	MOV        R2, R27
	CALL       _lcd_print+0
;ADC2.c,50 :: 		lcd_print(5, 2, adc, 1);
	LDI        R27, 1
	MOV        R6, R27
	LDD        R4, Y+8
	LDD        R5, Y+9
	LDI        R27, 2
	MOV        R3, R27
	LDI        R27, 5
	MOV        R2, R27
	CALL       _lcd_print+0
;ADC2.c,51 :: 		delay_ms(600);
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
;ADC2.c,52 :: 		};
	JMP        L_main0
;ADC2.c,53 :: 		}
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

_clock_setup:

;ADC2.c,56 :: 		void clock_setup()
;ADC2.c,58 :: 		OSC_CTRL |= OSC_RC32KEN_bm;
	LDS        R27, OSC_CTRL+0
	SBR        R27, 4
	STS        OSC_CTRL+0, R27
;ADC2.c,59 :: 		while(!(OSC_STATUS & OSC_RC32KRDY_bm));
L_clock_setup4:
	LDS        R16, OSC_STATUS+0
	SBRC       R16, 2
	JMP        L_clock_setup5
	JMP        L_clock_setup4
L_clock_setup5:
;ADC2.c,60 :: 		OSC_CTRL |= OSC_RC32MEN_bm;
	LDS        R16, OSC_CTRL+0
	ORI        R16, 2
	STS        OSC_CTRL+0, R16
;ADC2.c,61 :: 		CPU_CCP = CCP_IOREG_gc;
	LDI        R27, 216
	OUT        CPU_CCP+0, R27
;ADC2.c,62 :: 		CLK_PSCTRL = ((CLK_PSCTRL & (~(CLK_PSADIV_gm | CLK_PSBCDIV1_bm | CLK_PSBCDIV0_bm)))
	LDS        R16, CLK_PSCTRL+0
	ANDI       R16, 128
;ADC2.c,63 :: 		| CLK_PSADIV_1_gc | CLK_PSBCDIV_2_2_gc);
	ORI        R16, 3
	STS        CLK_PSCTRL+0, R16
;ADC2.c,64 :: 		OSC_DFLLCTRL = ((OSC_DFLLCTRL & (~(OSC_RC32MCREF_gm | OSC_RC2MCREF_bm))) |
	LDS        R16, OSC_DFLLCTRL+0
	ANDI       R16, 248
;ADC2.c,65 :: 		OSC_RC32MCREF_RC32K_gc);
	STS        OSC_DFLLCTRL+0, R16
;ADC2.c,66 :: 		DFLLRC32M_CTRL |= DFLL_ENABLE_bm;
	LDS        R16, DFLLRC32M_CTRL+0
	ORI        R16, 1
	STS        DFLLRC32M_CTRL+0, R16
;ADC2.c,67 :: 		while(!(OSC_STATUS & OSC_RC32MRDY_bm));
L_clock_setup6:
	LDS        R16, OSC_STATUS+0
	SBRC       R16, 1
	JMP        L_clock_setup7
	JMP        L_clock_setup6
L_clock_setup7:
;ADC2.c,68 :: 		CPU_CCP = CCP_IOREG_gc;
	LDI        R27, 216
	OUT        CPU_CCP+0, R27
;ADC2.c,69 :: 		CLK_CTRL = ((CLK_CTRL & (~CLK_SCLKSEL_gm)) | CLK_SCLKSEL_RC32M_gc);
	LDS        R16, CLK_CTRL+0
	ANDI       R16, 248
	ORI        R16, 1
	STS        CLK_CTRL+0, R16
;ADC2.c,70 :: 		OSC_CTRL &= (~(OSC_RC2MEN_bm | OSC_XOSCEN_bm | OSC_PLLEN_bm));
	LDS        R16, OSC_CTRL+0
	ANDI       R16, 230
	STS        OSC_CTRL+0, R16
;ADC2.c,71 :: 		PORTCFG_CLKEVOUT = 0x00;
	LDI        R27, 0
	STS        PORTCFG_CLKEVOUT+0, R27
;ADC2.c,72 :: 		}
L_end_clock_setup:
	RET
; end of _clock_setup

_io_setup:

;ADC2.c,75 :: 		void io_setup()
;ADC2.c,77 :: 		PORTA_OUT = 0x00;
	LDI        R27, 0
	STS        PORTA_OUT+0, R27
;ADC2.c,78 :: 		PORTA_DIR = 0x00;
	LDI        R27, 0
	STS        PORTA_DIR+0, R27
;ADC2.c,79 :: 		PORTCFG_MPCMASK = 0xFF;
	LDI        R27, 255
	STS        PORTCFG_MPCMASK+0, R27
;ADC2.c,80 :: 		PORTA_PIN0CTRL = (PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc);
	LDI        R27, 0
	STS        PORTA_PIN0CTRL+0, R27
;ADC2.c,81 :: 		PORTA_INTCTRL = 0x00;
	LDI        R27, 0
	STS        PORTA_INTCTRL+0, R27
;ADC2.c,82 :: 		PORTA_INT0MASK = 0x00;
	LDI        R27, 0
	STS        PORTA_INT0MASK+0, R27
;ADC2.c,83 :: 		PORTA_INT1MASK = 0x00;
	LDI        R27, 0
	STS        PORTA_INT1MASK+0, R27
;ADC2.c,84 :: 		}
L_end_io_setup:
	RET
; end of _io_setup

_adc_setup:

;ADC2.c,87 :: 		void adc_setup()
;ADC2.c,89 :: 		unsigned char samples = 16;
; samples start address is: 20 (R20)
	LDI        R20, 16
;ADC2.c,91 :: 		ADCA_CAL = (0x0FFF & ((PROD_SIGNATURES_ADCACAL1 << 8) | PROD_SIGNATURES_ADCACAL0));
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
;ADC2.c,92 :: 		ADCA_CTRLB = ((1 << ADC_IMPMODE_bp) | ADC_CURRLIMIT_NO_gc | (0 << ADC_CONMODE_bp) | ADC_RESOLUTION_12BIT_gc);
	LDI        R27, 128
	STS        ADCA_CTRLB+0, R27
;ADC2.c,93 :: 		ADCA_PRESCALER = ADC_PRESCALER_DIV64_gc;
	LDI        R27, 4
	STS        ADCA_PRESCALER+0, R27
;ADC2.c,94 :: 		ADCA_REFCTRL = (ADC_REFSEL_VCC_gc | (0 << ADC_TEMPREF_bp) | (0 << ADC_BANDGAP_bp));
	LDI        R27, 16
	STS        ADCA_REFCTRL+0, R27
;ADC2.c,95 :: 		ADCA_CH0_CTRL = ((0 << ADC_CH_START_bp) | ADC_CH_INPUTMODE_SINGLEENDED_gc);
	LDI        R27, 1
	STS        ADCA_CH0_CTRL+0, R27
;ADC2.c,96 :: 		ADCA_CH0_MUXCTRL = ADC_CH_MUXPOS_PIN0_gc;
	LDI        R27, 0
	STS        ADCA_CH0_MUXCTRL+0, R27
;ADC2.c,97 :: 		ADCA_CTRLA |= ADC_ENABLE_bm;
	LDS        R16, ADCA_CTRLA+0
	ORI        R16, 1
	STS        ADCA_CTRLA+0, R16
;ADC2.c,98 :: 		delay_ms(4);
	LDI        R17, 42
	LDI        R16, 142
L_adc_setup8:
	DEC        R16
	BRNE       L_adc_setup8
	DEC        R17
	BRNE       L_adc_setup8
	NOP
; samples end address is: 20 (R20)
;ADC2.c,100 :: 		while(samples > 0)
L_adc_setup10:
; samples start address is: 20 (R20)
	LDI        R16, 0
	CP         R16, R20
	BRLO       L__adc_setup31
	JMP        L_adc_setup11
L__adc_setup31:
;ADC2.c,102 :: 		ADCA_CH0_CTRL |= (1 << ADC_CH_START_bp);
	LDS        R27, ADCA_CH0_CTRL+0
	SBR        R27, 128
	STS        ADCA_CH0_CTRL+0, R27
; samples end address is: 20 (R20)
;ADC2.c,103 :: 		while(!(ADCA_CH0_INTFLAGS & ADC_CH_CHIF_bm));
L_adc_setup12:
; samples start address is: 20 (R20)
	LDS        R16, ADCA_CH0_INTFLAGS+0
	SBRC       R16, 0
	JMP        L_adc_setup13
	JMP        L_adc_setup12
L_adc_setup13:
;ADC2.c,104 :: 		ADCA_CH0_INTFLAGS = ADC_CH_CHIF_bm;
	LDI        R27, 1
	STS        ADCA_CH0_INTFLAGS+0, R27
;ADC2.c,105 :: 		offset += ADCA_CH0RES;
	LDS        R18, _offset+0
	LDS        R19, _offset+1
	LDS        R16, ADCA_CH0RES+0
	LDS        R17, ADCA_CH0RES+1
	ADD        R16, R18
	ADC        R17, R19
	STS        _offset+0, R16
	STS        _offset+1, R17
;ADC2.c,106 :: 		samples--;
	MOV        R16, R20
	SUBI       R16, 1
	MOV        R20, R16
;ADC2.c,107 :: 		}
; samples end address is: 20 (R20)
	JMP        L_adc_setup10
L_adc_setup11:
;ADC2.c,109 :: 		ADCA_CTRLA &= ~ADC_ENABLE_bm;
	LDS        R16, ADCA_CTRLA+0
	ANDI       R16, 254
	STS        ADCA_CTRLA+0, R16
;ADC2.c,110 :: 		offset >>= 4;
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
;ADC2.c,111 :: 		ADCA_CMP = 0x0000;
	LDI        R27, 0
	STS        ADCA_CMP+0, R27
	STS        ADCA_CMP+1, R27
;ADC2.c,112 :: 		ADCA_CH0_CTRL = ((0 << ADC_CH_START_bp) | ADC_CH_GAIN_1X_gc | ADC_CH_INPUTMODE_SINGLEENDED_gc);
	LDI        R27, 1
	STS        ADCA_CH0_CTRL+0, R27
;ADC2.c,113 :: 		ADCA_CH0_MUXCTRL = ADC_CH_MUXPOS_PIN1_gc;
	LDI        R27, 8
	STS        ADCA_CH0_MUXCTRL+0, R27
;ADC2.c,114 :: 		ADCA_EVCTRL = (ADC_SWEEP_0_gc | ADC_EVACT_NONE_gc);
	LDI        R27, 0
	STS        ADCA_EVCTRL+0, R27
;ADC2.c,115 :: 		ADCA_CH0_INTCTRL = (ADC_CH_INTMODE_COMPLETE_gc | ADC_CH_INTLVL_OFF_gc);
	LDI        R27, 0
	STS        ADCA_CH0_INTCTRL+0, R27
;ADC2.c,116 :: 		ADCA_CH1_INTCTRL = ADC_CH_INTLVL_OFF_gc;
	LDI        R27, 0
	STS        ADCA_CH1_INTCTRL+0, R27
;ADC2.c,117 :: 		ADCA_CH2_INTCTRL = ADC_CH_INTLVL_OFF_gc;
	LDI        R27, 0
	STS        ADCA_CH2_INTCTRL+0, R27
;ADC2.c,118 :: 		ADCA_CH3_INTCTRL = ADC_CH_INTLVL_OFF_gc;
	LDI        R27, 0
	STS        ADCA_CH3_INTCTRL+0, R27
;ADC2.c,119 :: 		ADCA_CTRLB |= ADC_FREERUN_bm;
	LDS        R16, ADCA_CTRLB+0
	ORI        R16, 8
	STS        ADCA_CTRLB+0, R16
;ADC2.c,120 :: 		ADCA_CTRLA |= ADC_ENABLE_bm;
	LDS        R16, ADCA_CTRLA+0
	ORI        R16, 1
	STS        ADCA_CTRLA+0, R16
;ADC2.c,121 :: 		delay_ms(9);
	LDI        R17, 94
	LDI        R16, 129
L_adc_setup14:
	DEC        R16
	BRNE       L_adc_setup14
	DEC        R17
	BRNE       L_adc_setup14
;ADC2.c,122 :: 		}
L_end_adc_setup:
	RET
; end of _adc_setup

_setup:

;ADC2.c,125 :: 		void setup()
;ADC2.c,127 :: 		clock_setup();
	PUSH       R2
	CALL       _clock_setup+0
;ADC2.c,128 :: 		io_setup();
	CALL       _io_setup+0
;ADC2.c,129 :: 		adc_setup();
	CALL       _adc_setup+0
;ADC2.c,130 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;ADC2.c,131 :: 		Lcd_Cmd(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;ADC2.c,132 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	LDI        R27, 12
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;ADC2.c,133 :: 		}
L_end_setup:
	POP        R2
	RET
; end of _setup

_ADCA_read_ext_pins:

;ADC2.c,136 :: 		signed int ADCA_read_ext_pins(unsigned char pin)
;ADC2.c,138 :: 		signed int val = 0;
;ADC2.c,140 :: 		ADCA_CH0_MUXCTRL = pin;
	STS        ADCA_CH0_MUXCTRL+0, R2
;ADC2.c,141 :: 		while(!(ADCA_CH0_INTFLAGS & ADC_CH_CHIF_bm));
L_ADCA_read_ext_pins16:
	LDS        R16, ADCA_CH0_INTFLAGS+0
	SBRC       R16, 0
	JMP        L_ADCA_read_ext_pins17
	JMP        L_ADCA_read_ext_pins16
L_ADCA_read_ext_pins17:
;ADC2.c,142 :: 		ADCA_CH0_INTFLAGS = ADC_CH_CHIF_bm;
	LDI        R27, 1
	STS        ADCA_CH0_INTFLAGS+0, R27
;ADC2.c,143 :: 		val = ADCA_CH0_RES;
; val start address is: 18 (R18)
	LDS        R18, ADCA_CH0_RES+0
	LDS        R19, ADCA_CH0_RES+1
;ADC2.c,145 :: 		return val;
	MOVW       R16, R18
; val end address is: 18 (R18)
;ADC2.c,146 :: 		}
L_end_ADCA_read_ext_pins:
	RET
; end of _ADCA_read_ext_pins

_adc_avg:

;ADC2.c,149 :: 		signed int adc_avg(unsigned char no_of_samples, unsigned char pin)
;ADC2.c,151 :: 		signed long avg = 0;
; avg start address is: 21 (R21)
	LDI        R21, 0
	LDI        R22, 0
	LDI        R23, 0
	LDI        R24, 0
;ADC2.c,152 :: 		unsigned char samples = no_of_samples;
; samples start address is: 20 (R20)
	MOV        R20, R2
; avg end address is: 21 (R21)
; samples end address is: 20 (R20)
;ADC2.c,154 :: 		while(samples > 0)
L_adc_avg18:
; samples start address is: 20 (R20)
; avg start address is: 21 (R21)
	LDI        R16, 0
	CP         R16, R20
	BRLO       L__adc_avg37
	JMP        L_adc_avg19
L__adc_avg37:
;ADC2.c,156 :: 		avg += ADCA_read_ext_pins(pin);
	PUSH       R2
	MOV        R2, R3
	CALL       _ADCA_read_ext_pins+0
	POP        R2
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
;ADC2.c,157 :: 		samples--;
	MOV        R16, R20
	SUBI       R16, 1
	MOV        R20, R16
;ADC2.c,158 :: 		}
; samples end address is: 20 (R20)
	JMP        L_adc_avg18
L_adc_avg19:
;ADC2.c,159 :: 		avg /= no_of_samples;
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
;ADC2.c,161 :: 		return avg;
;ADC2.c,162 :: 		}
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

;ADC2.c,165 :: 		void lcd_print(unsigned char x_pos, unsigned char y_pos, signed int value, unsigned char cnt_volt)
;ADC2.c,167 :: 		unsigned char tmp = 0;
	PUSH       R2
	PUSH       R3
;ADC2.c,169 :: 		if(value > 0)
	LDI        R16, 0
	LDI        R17, 0
	CP         R16, R4
	CPC        R17, R5
	BRLT       L__lcd_print39
	JMP        L_lcd_print20
L__lcd_print39:
;ADC2.c,171 :: 		lcd_out(y_pos, x_pos, " ");
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
;ADC2.c,172 :: 		}
	JMP        L_lcd_print21
L_lcd_print20:
;ADC2.c,175 :: 		lcd_out(y_pos, x_pos, "-");
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
;ADC2.c,176 :: 		value *= -1;
	MOVW       R16, R4
	LDI        R20, 255
	LDI        R21, 255
	CALL       _HWMul_16x16+0
	MOVW       R4, R16
;ADC2.c,177 :: 		}
L_lcd_print21:
;ADC2.c,179 :: 		tmp = (value / 1000);
	PUSH       R6
	PUSH       R5
	PUSH       R4
	LDI        R20, 232
	LDI        R21, 3
	MOVW       R16, R4
	CALL       _Div_16x16_S+0
	MOVW       R16, R22
;ADC2.c,180 :: 		lcd_chr_cp(tmp + 48);
	SUBI       R16, 208
	MOV        R2, R16
	CALL       _Lcd_Chr_CP+0
	POP        R4
	POP        R5
	POP        R6
;ADC2.c,182 :: 		switch(cnt_volt)
	JMP        L_lcd_print22
;ADC2.c,184 :: 		case 1:
L_lcd_print24:
;ADC2.c,186 :: 		break;
	JMP        L_lcd_print23
;ADC2.c,188 :: 		default:
L_lcd_print25:
;ADC2.c,190 :: 		lcd_chr_cp(46);
	PUSH       R5
	PUSH       R4
	LDI        R27, 46
	MOV        R2, R27
	CALL       _Lcd_Chr_CP+0
	POP        R4
	POP        R5
;ADC2.c,191 :: 		break;
	JMP        L_lcd_print23
;ADC2.c,193 :: 		}
L_lcd_print22:
	LDI        R27, 1
	CP         R6, R27
	BRNE       L__lcd_print40
	JMP        L_lcd_print24
L__lcd_print40:
	JMP        L_lcd_print25
L_lcd_print23:
;ADC2.c,195 :: 		tmp = ((value / 100) % 10);
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
;ADC2.c,196 :: 		lcd_chr_cp((tmp + 48));
	SUBI       R16, 208
	MOV        R2, R16
	CALL       _Lcd_Chr_CP+0
	POP        R4
	POP        R5
;ADC2.c,197 :: 		tmp = ((value / 10) % 10);
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
;ADC2.c,198 :: 		lcd_chr_cp((tmp + 48));
	SUBI       R16, 208
	MOV        R2, R16
	CALL       _Lcd_Chr_CP+0
	POP        R4
	POP        R5
;ADC2.c,199 :: 		tmp = (value % 10);
	LDI        R20, 10
	LDI        R21, 0
	MOVW       R16, R4
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
;ADC2.c,200 :: 		lcd_chr_cp((tmp + 48));
	SUBI       R16, 208
	MOV        R2, R16
	CALL       _Lcd_Chr_CP+0
;ADC2.c,201 :: 		}
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

;ADC2.c,204 :: 		float map(float v, float x_min, float x_max, float y_min, float y_max)
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
;ADC2.c,206 :: 		float m = 0.0;
;ADC2.c,207 :: 		m = ((y_max - y_min)/(x_max - x_min));
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
;ADC2.c,208 :: 		return (y_min + (m * (v - x_min)));
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
;ADC2.c,209 :: 		}
L_end_map:
	ADIW       R28, 15
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	POP        R29
	POP        R28
	RET
; end of _map
