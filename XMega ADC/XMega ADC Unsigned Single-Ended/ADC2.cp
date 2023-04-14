#line 1 "C:/Users/Shawon/Desktop/Xmega Media/XMega ADC Unsigned Single-Ended/ADC2.c"
#line 1 "c:/users/shawon/desktop/xmega media/xmega adc unsigned single-ended/io.h"
#line 1 "c:/users/shawon/desktop/xmega media/xmega adc unsigned single-ended/adc.h"
#line 1 "c:/users/shawon/desktop/xmega media/xmega adc unsigned single-ended/clock.h"
#line 6 "C:/Users/Shawon/Desktop/Xmega Media/XMega ADC Unsigned Single-Ended/ADC2.c"
sbit LCD_RS at PORTC_OUT.B2;
sbit LCD_EN at PORTC_OUT.B3;
sbit LCD_D4 at PORTC_OUT.B4;
sbit LCD_D5 at PORTC_OUT.B5;
sbit LCD_D6 at PORTC_OUT.B6;
sbit LCD_D7 at PORTC_OUT.B7;

sbit LCD_RS_Direction at PORTC_DIR.B2;
sbit LCD_EN_Direction at PORTC_DIR.B3;
sbit LCD_D4_Direction at PORTC_DIR.B4;
sbit LCD_D5_Direction at PORTC_DIR.B5;
sbit LCD_D6_Direction at PORTC_DIR.B6;
sbit LCD_D7_Direction at PORTC_DIR.B7;


signed int offset = 0;


void clock_setup();
void io_setup();
void adc_setup();
void setup();
signed int ADCA_read_ext_pins(unsigned char pin);
signed int adc_avg(unsigned char no_of_samples, unsigned char pin);
void lcd_print(unsigned char x_pos, unsigned char y_pos, signed int value, unsigned char cnt_volt);
float map(float v, float x_min, float x_max, float y_min, float y_max);


void main()
{
 signed int adc = 0;
 float v = 0;

 setup();

 lcd_out(1, 1, "V:");
 lcd_out(2, 1, "ADC:");

 while(1)
 {
 adc = adc_avg(25,  0x08 );
 v = map(adc, offset, 4095.0, 0, 1959.375);

 lcd_print(4, 1, v, 0);
 lcd_print(5, 2, adc, 1);
 delay_ms(600);
 };
}


void clock_setup()
{
 OSC_CTRL |=  0x04 ;
 while(!(OSC_STATUS &  0x04 ));
 OSC_CTRL |=  0x02 ;
 CPU_CCP =  0xD8 ;
 CLK_PSCTRL = ((CLK_PSCTRL & (~( 0x7C  |  0x02  |  0x01 )))
 |  0x00  |  0x03 );
 OSC_DFLLCTRL = ((OSC_DFLLCTRL & (~( 0x06  |  0x01 ))) |
  0x00 );
 DFLLRC32M_CTRL |=  0x01 ;
 while(!(OSC_STATUS &  0x02 ));
 CPU_CCP =  0xD8 ;
 CLK_CTRL = ((CLK_CTRL & (~ 0x07 )) |  0x01 );
 OSC_CTRL &= (~( 0x01  |  0x08  |  0x10 ));
 PORTCFG_CLKEVOUT = 0x00;
}


void io_setup()
{
 PORTA_OUT = 0x00;
 PORTA_DIR = 0x00;
 PORTCFG_MPCMASK = 0xFF;
 PORTA_PIN0CTRL = ( 0x00  |  0x00 );
 PORTA_INTCTRL = 0x00;
 PORTA_INT0MASK = 0x00;
 PORTA_INT1MASK = 0x00;
}


void adc_setup()
{
 unsigned char samples = 16;

 ADCA_CAL = (0x0FFF & ((PROD_SIGNATURES_ADCACAL1 << 8) | PROD_SIGNATURES_ADCACAL0));
 ADCA_CTRLB = ((1 <<  0x07 ) |  0x00  | (0 <<  0x04 ) |  0x00 );
 ADCA_PRESCALER =  0x04 ;
 ADCA_REFCTRL = ( 0x10  | (0 <<  0x00 ) | (0 <<  0x01 ));
 ADCA_CH0_CTRL = ((0 <<  0x07 ) |  0x01 );
 ADCA_CH0_MUXCTRL =  0x00 ;
 ADCA_CTRLA |=  0x01 ;
 delay_ms(4);

 while(samples > 0)
 {
 ADCA_CH0_CTRL |= (1 <<  0x07 );
 while(!(ADCA_CH0_INTFLAGS &  0x01 ));
 ADCA_CH0_INTFLAGS =  0x01 ;
 offset += ADCA_CH0RES;
 samples--;
 }

 ADCA_CTRLA &= ~ 0x01 ;
 offset >>= 4;
 ADCA_CMP = 0x0000;
 ADCA_CH0_CTRL = ((0 <<  0x07 ) |  0x00  |  0x01 );
 ADCA_CH0_MUXCTRL =  0x08 ;
 ADCA_EVCTRL = ( 0x00  |  0x00 );
 ADCA_CH0_INTCTRL = ( 0x00  |  0x00 );
 ADCA_CH1_INTCTRL =  0x00 ;
 ADCA_CH2_INTCTRL =  0x00 ;
 ADCA_CH3_INTCTRL =  0x00 ;
 ADCA_CTRLB |=  0x08 ;
 ADCA_CTRLA |=  0x01 ;
 delay_ms(9);
}


void setup()
{
 clock_setup();
 io_setup();
 adc_setup();
 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
}


signed int ADCA_read_ext_pins(unsigned char pin)
{
 signed int val = 0;

 ADCA_CH0_MUXCTRL = pin;
 while(!(ADCA_CH0_INTFLAGS &  0x01 ));
 ADCA_CH0_INTFLAGS =  0x01 ;
 val = ADCA_CH0_RES;

 return val;
}


signed int adc_avg(unsigned char no_of_samples, unsigned char pin)
{
 signed long avg = 0;
 unsigned char samples = no_of_samples;

 while(samples > 0)
 {
 avg += ADCA_read_ext_pins(pin);
 samples--;
 }
 avg /= no_of_samples;

 return avg;
}


void lcd_print(unsigned char x_pos, unsigned char y_pos, signed int value, unsigned char cnt_volt)
{
 unsigned char tmp = 0;

 if(value > 0)
 {
 lcd_out(y_pos, x_pos, " ");
 }
 else
 {
 lcd_out(y_pos, x_pos, "-");
 value *= -1;
 }

 tmp = (value / 1000);
 lcd_chr_cp(tmp + 48);

 switch(cnt_volt)
 {
 case 1:
 {
 break;
 }
 default:
 {
 lcd_chr_cp(46);
 break;
 }
 }

 tmp = ((value / 100) % 10);
 lcd_chr_cp((tmp + 48));
 tmp = ((value / 10) % 10);
 lcd_chr_cp((tmp + 48));
 tmp = (value % 10);
 lcd_chr_cp((tmp + 48));
}


float map(float v, float x_min, float x_max, float y_min, float y_max)
{
 float m = 0.0;
 m = ((y_max - y_min)/(x_max - x_min));
 return (y_min + (m * (v - x_min)));
}
