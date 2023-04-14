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
     //Select external clock frequency range and startup time 
     OSC_XOSCCTRL = 0xCB;
     //Enable the external clock
     XOSCEN_bit = 1;
     //Disable protected IOs to update settings
     CPU_CCP = 0xD8;
     //Configure prescalar 
     CLK_PSCTRL = 0x0F;
     //Wait for the external clock to stabilize
     while(XOSCRDY_bit == 0);
     //Disable protected IOs to update settings
     CPU_CCP = 0xD8;
     //Select system clock source
     CLK_CTRL = 0x03;
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
