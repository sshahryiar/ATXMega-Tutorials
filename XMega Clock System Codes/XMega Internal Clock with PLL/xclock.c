void setup();


void main()
{
     setup();
     while(1)
     {
     };
}


void setup()
{
    //Disable all clock sources
    OSC_CTRL = 0x00;
    //Enable the internal 32.768 kHz RC oscillator 
    OSC_CTRL |= 0x04;
    //Wait for the internal 32.768 kHz RC oscillator to stabilize
    while(!RC32KRDY_bit);
    //Enable the internal 2 MHz RC oscillator 
    OSC_CTRL |= 0x01;
    //Configure DFLL for calibration
    DFLLRC32M_CTRL = 0x00;
    DFLLRC2M_CTRL = 0x01;
    //Wait for the internal 2 MHz RC oscillator to stabilize
    while(!RC2MRDY_bit);
    //Configure PLL
    OSC_PLLCTRL = 0x1F;
    OSC_CTRL |= 0x10;
    //Disable protected IOs to update settings
    CPU_CCP = 0xD8; 
    //Configure prescalar 
    CLK_PSCTRL = 0x44;
    //Wait for the PLL to stabilize  
    while(!PLLRDY_bit);
    //Disable protected IOs to update settings
    CPU_CCP = 0xD8;
    //Select system clock source
    CLK_CTRL = 0x04;
    //Configure port pin for clock output
    PORTCFG_CLKEVOUT = 0x01;
    PORTC_OUT = 0x00;
    PORTC_DIR = 0x80;
    PORTC_PIN7CTRL = 0x07;
    PORTC_INT0MASK = 0x00;
    PORTC_INT1MASK = 0x00;
    PORTC_INTCTRL = 0x00;
    PORTCFG_VPCTRLA = 0x10;
    PORTCFG_VPCTRLB = 0x32;   
}