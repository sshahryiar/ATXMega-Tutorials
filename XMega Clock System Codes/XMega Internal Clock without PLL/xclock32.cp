#line 1 "H:/Current Works/Transfer/Desktop to Laptop/XMega Clocks/XMega Internal Clock without PLL/xclock32.c"
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

 RC32KEN_bit = 1;

 while(!RC32KRDY_bit);

 RC32MEN_bit = 1;

 CPU_CCP = 0xD8;

 CLK_PSCTRL = 0x1C;

 OSC_DFLLCTRL = 0x00;
 DFLLRC32M_CTRL = 0x01;

 while(!RC32MRDY_bit);

 CPU_CCP = 0xD8;

 CLK_CTRL = 0x01;

 PORTCFG_CLKEVOUT = 0x0A;
 PORTD_OUT = 0x00;
 PORTD_DIR = 0x80;
 PORTD_PIN7CTRL = 0x07;
 PORTD_INT0MASK = 0x00;
 PORTD_INT1MASK = 0x00;
 PORTD_INTCTRL = 0x00;

 PORTCFG_VPCTRLA = 0x10;
 PORTCFG_VPCTRLB = 0x32;
}
