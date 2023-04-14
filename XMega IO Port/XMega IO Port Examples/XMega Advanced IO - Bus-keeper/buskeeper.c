#include <io.h>
#include <clock.h>


void setup();


void main()
{
     setup();

     while(1)
     {
         PORTD_OUT.B1 = PORTD_IN.B0;
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

     PORTD_OUT = 0x00;
     PORTD_DIR = 0x02;
     PORTD_PIN0CTRL = (PORT_OPC_BUSKEEPER_gc | PORT_ISC_BOTHEDGES_gc);
     PORTD_PIN1CTRL = (PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc);
}