#include "CLOCK.h"
#include "IO.h"
#include "AC.h"


void setup();
void setup_clock();
void setup_GPIO();
void setup_AC();


void main()
{
     setup();

     while(1)
     {
     };
}


void setup()
{
     setup_clock();
     setup_GPIO();
     setup_AC();
}


void setup_clock()
{
    asm cli;
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


void setup_GPIO()
{
    PORTA_OUT = 0x00;
    PORTA_DIR = 0xC0;
    PORTCFG_MPCMASK = 0xFF;
    PORTA_PIN4CTRL = (PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc);
    PORTA_INTCTRL = ((PORTA_INTCTRL & (~(PORT_INT1LVL_gm | PORT_INT0LVL_gm))) |
                      PORT_INT1LVL_OFF_gc | PORT_INT0LVL_OFF_gc);

    PORTD_OUT = 0x00;
    PORTD_DIR = 0x0F;
    PORTCFG_MPCMASK = 0xFF;
    PORTD_PIN6CTRL = (PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc);
    PORTD_INTCTRL = ((PORTD_INTCTRL & (~(PORT_INT1LVL_gm | PORT_INT0LVL_gm))) |
                      PORT_INT1LVL_OFF_gc | PORT_INT0LVL_OFF_gc);
}


void setup_AC()
{
    unsigned char reg_val;
    
    reg_val = (AC_MUXPOS_PIN1_gc | AC_MUXNEG_SCALER_gc);
    
    ACA_AC0MUXCTRL = reg_val;
    ACA_AC0CTRL = (AC_INTMODE_BOTHEDGES_gc | AC_INTLVL_OFF_gc | (1 << AC_HSMODE_bp)
                   | AC_HYSMODE_LARGE_gc | (1 << AC_ENABLE_bp));

    ACA_AC1MUXCTRL = reg_val;
    ACA_AC1CTRL = (AC_INTMODE_BOTHEDGES_gc | AC_INTLVL_OFF_gc | (1 << AC_HSMODE_bp)
                   | AC_HYSMODE_SMALL_gc | (1 << AC_ENABLE_bp));

    ACA_CTRLA = (1 << AC_AC1OUT_bp) | (1 << AC_AC0OUT_bp);
    ACA_CTRLB = 0x1F;
    
    ACA_WINCTRL = 0x00;
}