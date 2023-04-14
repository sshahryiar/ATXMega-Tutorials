#include <io.h>
#include <adc.h>
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


signed int offset = 0;


void clock_setup();
void io_setup();
void adc_setup();
void setup();
signed int ADCA_read_ext_pins(unsigned char pos_pin, unsigned char neg_pin);
signed int adc_avg(unsigned char no_of_samples, unsigned char pos_pin, unsigned char neg_pin);
void lcd_print(unsigned char x_pos, unsigned char y_pos, signed int value, unsigned char cnt_volt);


void main()
{
     signed int adc = 0;
     float v = 0;

     setup();
     
     lcd_out(1, 1, "V:");
     lcd_out(2, 1, "ADC:");

     while(1)
     {
              adc = adc_avg(20, ADC_CH_MUXPOS_PIN1_gc, ADC_CH_MUXNEG_PIN2_gc);
              v = ((adc * 2062.5) / 2048);

              lcd_print(6, 1, v, 0);
              lcd_print(6, 2, adc, 1);
              delay_ms(600);
     };
}


void clock_setup()
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
}


void io_setup()
{
     PORTA_OUT = 0x00;
     PORTA_DIR = 0x00;
     PORTCFG_MPCMASK = 0xFF;
     PORTA_PIN0CTRL = (PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc);
     PORTA_INTCTRL = 0x00;
     PORTA_INT0MASK = 0x00;
     PORTA_INT1MASK = 0x00;
}


void adc_setup()
{
     unsigned char samples = 16;

     ADCA_CAL = (0x0FFF & ((PROD_SIGNATURES_ADCACAL1  << 8) | PROD_SIGNATURES_ADCACAL0));
     ADCA_CTRLB = ((1 << ADC_IMPMODE_bp) | ADC_CURRLIMIT_NO_gc | (1 << ADC_CONMODE_bp) | ADC_RESOLUTION_12BIT_gc);
     ADCA_PRESCALER = ADC_PRESCALER_DIV64_gc;
     ADCA_REFCTRL = (ADC_REFSEL_VCC_gc | (0 << ADC_TEMPREF_bp) | (0 << ADC_BANDGAP_bp));
     ADCA_CH0_CTRL = ((0 << ADC_CH_START_bp) | ADC_CH_GAIN_1X_gc | ADC_CH_INPUTMODE_DIFF_gc);
     ADCA_CH0_MUXCTRL = (ADC_CH_MUXPOS_PIN0_gc | ADC_CH_MUXNEG_PIN0_gc);
     ADCA_CTRLA |= ADC_ENABLE_bm;
     delay_ms(4);

     while(samples > 0)
     {
        ADCA_CH0_CTRL |= (1 << ADC_CH_START_bp);
        while(!(ADCA_CH0_INTFLAGS & ADC_CH_CHIF_bm));
        ADCA_CH0_INTFLAGS = ADC_CH_CHIF_bm;
        offset += ADCA_CH0RES;
        samples--;
     }

     ADCA_CTRLA &= ~ADC_ENABLE_bm;
     offset >>= 4;
     ADCA_CH0_CTRL = ((0 << ADC_CH_START_bp) | ADC_CH_GAIN_1X_gc | ADC_CH_INPUTMODE_DIFF_gc);
     ADCA_CH0_MUXCTRL = (ADC_CH_MUXPOS_PIN1_gc | ADC_CH_MUXNEG_PIN2_gc);
     ADCA_EVCTRL = (ADC_SWEEP_0_gc | ADC_EVACT_NONE_gc);
     ADCA_CH0_INTCTRL = (ADC_CH_INTMODE_COMPLETE_gc | ADC_CH_INTLVL_OFF_gc);
     ADCA_CH1_INTCTRL = ADC_CH_INTLVL_OFF_gc;
     ADCA_CH2_INTCTRL = ADC_CH_INTLVL_OFF_gc;
     ADCA_CH3_INTCTRL = ADC_CH_INTLVL_OFF_gc;
     ADCA_CTRLB |= ADC_FREERUN_bm;
     ADCA_CTRLA |= ADC_ENABLE_bm;
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


signed int ADCA_read_ext_pins(unsigned char pos_pin, unsigned char neg_pin)
{
    signed int val = 0;

    ADCA_CH0_MUXCTRL = (pos_pin | neg_pin);
    while (!(ADCA_CH0_INTFLAGS & ADC_CH_CHIF_bm));
    ADCA_CH0_INTFLAGS = ADC_CH_CHIF_bm;
    val = ADCA_CH0_RES;
    val -= offset;
    
    return val;
}


signed int adc_avg(unsigned char no_of_samples, unsigned char pos_pin, unsigned char neg_pin)
{
      signed long avg = 0;
      unsigned char samples = no_of_samples;

      while(samples > 0)
      {
          avg += ADCA_read_ext_pins(pos_pin, neg_pin);
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