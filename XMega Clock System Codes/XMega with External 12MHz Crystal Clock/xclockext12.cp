#line 1 "H:/Current Works/Transfer/Desktop to Laptop/XMega Clocks/XMega with External 12MHz Crystal Clock/xclockext12.c"
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

 OSC_CTRL = 0x00;

 OSC_XOSCCTRL = 0xCB;

 XOSCEN_bit = 1;

 CPU_CCP = 0xD8;

 CLK_PSCTRL = 0x0F;

 while(XOSCRDY_bit == 0);

 CPU_CCP = 0xD8;

 CLK_CTRL = 0x03;

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
