#include "clock.h"
#include "dac.h"
#include "io.h"


void setup();
void clock_setup();
void io_setup();
void dac_Setup();
void dac_write(unsigned char channel, unsigned int value);


void main() 
{
   signed int temp1 = 0;
   signed int temp2 = 0;
   unsigned int degree = 0;

   setup();
   
   while(1)
   {
       for(degree = 0; degree < 360; degree++)
       {
           temp1 = (2047 * cos(degree * 0.0174532925));
           temp1 = (2048 - temp1);
           temp2 = (2047 * sin(degree * 0.0174532925));
           temp2 = (2048 - temp2);
           dac_write(0, ((unsigned int)temp1));
           dac_write(1, ((unsigned int)temp2));
           delay_us(10);
       }
   };
}


void setup()
{
   clock_setup();
   io_setup();
   dac_Setup();
}


void clock_setup()
{
   OSC_CTRL |= OSC_RC32KEN_bm;
   while(!(OSC_STATUS & OSC_RC32KRDY_bm));
   OSC_CTRL |= OSC_RC32MEN_bm;
   CPU_CCP = CCP_IOREG_gc;
   CLK_PSCTRL = ((CLK_PSCTRL & (~(CLK_PSADIV_gm | CLK_PSBCDIV1_bm 
                | CLK_PSBCDIV0_bm))) | CLK_PSADIV_1_gc | CLK_PSBCDIV_2_2_gc);
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
   PORTB_OUT = 0x00;
   PORTB_DIR = 0x0C;
   PORTB_PIN0CTRL = (PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc);
   PORTB_PIN1CTRL = (PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc);
   PORTB_PIN2CTRL = (PORT_OPC_TOTEM_gc | PORT_ISC_INPUT_DISABLE_gc);
   PORTB_PIN3CTRL = (PORT_OPC_TOTEM_gc | PORT_ISC_INPUT_DISABLE_gc);
   PORTB_INT0MASK = 0x00;
   PORTB_INT1MASK = 0x00;
}


void dac_setup()
{
   DACB_CTRLA = ((DACB_CTRLA & (~(DAC_IDOEN_bm | DAC_CH0EN_bm | DAC_CH1EN_bm
                | DAC_LPMODE_bm))) | DAC_CH0EN_bm | DAC_CH1EN_bm | DAC_ENABLE_bm);
   DACB_CTRLB = ((DACB_CTRLB & (~(DAC_CHSEL_gm | DAC_CH0TRIG_bm 
                | DAC_CH1TRIG_bm))) | DAC_CHSEL_DUAL_gc);
   DACB_CTRLC = ((DACB_CTRLC & (~(DAC_REFSEL_gm | DAC_LEFTADJ_bm)))
                | DAC_REFSEL_AVCC_gc);
}


void dac_write(unsigned char channel, unsigned int value)
{
   switch(channel)
   {
       case 0:
       {
           while(!(DACB_STATUS & DAC_CH0DRE_bm));
           DACB_CH0DATA = value;
           break;
       }
       case 1:
       {
            while(!(DACB_STATUS & DAC_CH1DRE_bm));
            DACB_CH1DATA = value;
            break;
       }
   }
}