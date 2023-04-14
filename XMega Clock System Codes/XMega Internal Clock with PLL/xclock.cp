#line 1 "H:/Current Works/Transfer/Desktop to Laptop/XMega Clocks/XMega Internal Clock with PLL/xclock.c"
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

 OSC_CTRL |= 0x04;

 while(!RC32KRDY_bit);

 OSC_CTRL |= 0x01;

 DFLLRC32M_CTRL = 0x00;
 DFLLRC2M_CTRL = 0x01;

 while(!RC2MRDY_bit);

 OSC_PLLCTRL = 0x1F;
 OSC_CTRL |= 0x10;

 CPU_CCP = 0xD8;

 CLK_PSCTRL = 0x44;

 while(!PLLRDY_bit);

 CPU_CCP = 0xD8;

 CLK_CTRL = 0x04;

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
