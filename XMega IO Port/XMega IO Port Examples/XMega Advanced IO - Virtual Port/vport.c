#include <io.h>
#include <clock.h>


void setup();


void main()
{
     const unsigned n[10] = {0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F};
     unsigned char s = 0;
     
     setup();

     while(1)
     {
         for(s = 0; s <= 9; s++)
         {
               VPORT3_OUT = n[s];
               delay_ms(400);
         }
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
     DFLLRC32M_CTRL|=DFLL_ENABLE_bm;
     while (!(OSC_STATUS & OSC_RC32MRDY_bm));
     CPU_CCP = CCP_IOREG_gc;
     CLK_CTRL = ((CLK_CTRL & (~CLK_SCLKSEL_gm)) | CLK_SCLKSEL_RC32M_gc);
     OSC_CTRL &= (~(OSC_RC2MEN_bm | OSC_XOSCEN_bm | OSC_PLLEN_bm));
     PORTCFG_CLKEVOUT = 0x00;

     PORTD_OUTCLR = 0xFF;
     PORTD_DIRSET = 0xFF;
     PORTCFG_MPCMASK = 0xFF;
     PORTD_PIN6CTRL = (PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc);
     
     PORTCFG_VPCTRLA = (PORTCFG_VP13MAP_PORTB_gc | PORTCFG_VP02MAP_PORTA_gc);
     PORTCFG_VPCTRLB = (PORTCFG_VP13MAP_PORTD_gc | PORTCFG_VP02MAP_PORTC_gc);
     
     VPORT3_DIR = 0xFF;
     VPORT3_OUT = 0x00;
}