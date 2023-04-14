#line 1 "C:/Users/Shawon/Desktop/XMega IO Port Codes/XMega Basic IO - Inputs with Pull Resistors/inputs.c"
#line 1 "c:/users/shawon/desktop/xmega io port codes/xmega basic io - inputs with pull resistors/io.h"
#line 1 "c:/users/shawon/desktop/xmega io port codes/xmega basic io - inputs with pull resistors/clock.h"
#line 5 "C:/Users/Shawon/Desktop/XMega IO Port Codes/XMega Basic IO - Inputs with Pull Resistors/inputs.c"
void setup();


void main()
{
 setup();

 while(1)
 {
 if(PORTC_IN.B0 == 1)
 {
 PORTD_OUT = 0x01;
 }
 else
 {
 PORTD_OUT = 0x02;
 }
 if(PORTC_IN.B1 == 1)
 {
 PORTD_OUT = 0x04;
 }
 else
 {
 PORTD_OUT = 0x08;
 }
 };
}


void setup()
{
 OSC_CTRL |=  0x04 ;
 while(!(OSC_STATUS &  0x04 ));
 OSC_CTRL |=  0x02 ;
 CPU_CCP =  0xD8 ;
 CLK_PSCTRL = ((CLK_PSCTRL & (~( 0x7C  |  0x02  |  0x01 )))
 |  0x00  |  0x03 );
 OSC_DFLLCTRL = ((OSC_DFLLCTRL & (~( 0x06  |  0x01 ))) |
  0x00 );
 DFLLRC32M_CTRL|= 0x01 ;
 while (!(OSC_STATUS &  0x02 ));
 CPU_CCP =  0xD8 ;
 CLK_CTRL = ((CLK_CTRL & (~ 0x07 )) |  0x01 );
 OSC_CTRL &= (~( 0x01  |  0x08  |  0x10 ));
 PORTCFG_CLKEVOUT = 0x00;

 PORTC_OUT=0x00;
 PORTC_DIR = 0x00;
 PORTC_PIN0CTRL = ( 0x18  |  0x02 );
 PORTC_PIN1CTRL = ( 0x10  |  0x01 );
 PORTCFG_MPCMASK = 0xFC;
 PORTC_PIN2CTRL = ( 0x00  |  0x00 );
 PORTC_REMAP = 0x00;
 PORTC_INTCTRL = 0x00;
 PORTC_INT0MASK = 0x00;
 PORTC_INT1MASK = 0x00;

 PORTD_OUT = 0x00;
 PORTD_DIR = 0x0F;
 PORTCFG_MPCMASK = 0x0F;
 PORTD_PIN0CTRL = ( 0x00  |  0x00 );
 PORTD_INTCTRL = 0x00;
 PORTD_INT0MASK = 0x00;
 PORTD_INT1MASK = 0x00;
}
