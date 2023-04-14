#include <io.h>
#include <clock.h>


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
     OSC_CTRL |= OSC_RC32KEN_bm;
     while(!(OSC_STATUS & OSC_RC32KRDY_bm));
     OSC_CTRL |= OSC_RC32MEN_bm;
     CPU_CCP = CCP_IOREG_gc;
     CLK_PSCTRL = ((CLK_PSCTRL & (~(CLK_PSADIV_gm | CLK_PSBCDIV1_bm | CLK_PSBCDIV0_bm)))
                  | CLK_PSADIV_1_gc | CLK_PSBCDIV_2_2_gc);
     OSC_DFLLCTRL = ((OSC_DFLLCTRL & (~(OSC_RC32MCREF_gm | OSC_RC2MCREF_bm))) |
                    OSC_RC32MCREF_RC32K_gc);
     
     DFLLRC32M_CTRL |= DFLL_ENABLE_bm;
     while(!(OSC_STATUS & OSC_RC32MRDY_bm));
     CPU_CCP = CCP_IOREG_gc;
     CLK_CTRL = ((CLK_CTRL & (~CLK_SCLKSEL_gm)) | CLK_SCLKSEL_RC32M_gc);
     OSC_CTRL &= (~(OSC_RC2MEN_bm | OSC_XOSCEN_bm | OSC_PLLEN_bm));
     PORTCFG_CLKEVOUT = 0x00;
     
     PORTD_OUT = 0x00;
     PORTD_DIR = 0x02;
     PORTD_PIN0CTRL = (PORT_OPC_BUSKEEPER_gc | PORT_ISC_BOTHEDGES_gc);
     PORTD_PIN1CTRL = (PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc);
     
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