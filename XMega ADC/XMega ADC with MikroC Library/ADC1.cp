#line 1 "G:/Transfer/Laptop to Desktop/Xmega Media/XMega ADC with MikroC Library/ADC1.c"
#line 1 "g:/transfer/laptop to desktop/xmega media/xmega adc with mikroc library/io.h"
#line 1 "g:/transfer/laptop to desktop/xmega media/xmega adc with mikroc library/clock.h"
#line 5 "G:/Transfer/Laptop to Desktop/Xmega Media/XMega ADC with MikroC Library/ADC1.c"
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


void setup();
signed int adc_avg(unsigned char no_of_samples, unsigned char channel);
void lcd_print(unsigned char x_pos, unsigned char y_pos, signed int value, unsigned char cnt_volt);
float map(float v, float x_min, float x_max, float y_min, float y_max);


void main()
{
 signed int adc = 0;
 signed int offset = 0;
 float v = 0;

 setup();
 offset = adc_avg(100, 0);

 lcd_out(1, 1, "V:");
 lcd_out(2, 1, "ADC:");

 while(1)
 {
 adc = adc_avg(50, 1);

 v = map(adc, offset, 4095.0, 0, 1959.375);

 lcd_print(4, 1, v, 0);
 lcd_print(5, 2, adc, 1);
 delay_ms(600);
 };
}


void setup()
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

 PORTD_OUT = 0x00;
 PORTD_DIR = 0x02;
 PORTD_PIN0CTRL = ( 0x08  |  0x00 );
 PORTD_PIN1CTRL = ( 0x00  |  0x00 );

 ADCA_Init_Advanced(_ADC_12bit, _ADC_INTERNAL_REF_VCC);

 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
}


signed int adc_avg(unsigned char no_of_samples, unsigned char channel)
{
 signed long avg = 0;
 unsigned char samples = no_of_samples;

 while(samples > 0)
 {
 avg += ADCA_Get_Sample(channel);
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
