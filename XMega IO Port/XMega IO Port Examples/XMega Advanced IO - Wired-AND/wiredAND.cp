#line 1 "C:/Users/Shawon/Desktop/XMega IO Port Examples/Xmega Advanced IO - Wired-AND/wiredAND.c"
#line 1 "c:/users/shawon/desktop/xmega io port examples/xmega advanced io - wired-and/io.h"
#line 1 "c:/users/shawon/desktop/xmega io port examples/xmega advanced io - wired-and/clock.h"
#line 5 "C:/Users/Shawon/Desktop/XMega IO Port Examples/Xmega Advanced IO - Wired-AND/wiredAND.c"
void setup();


void main()
{
 setup();

 while(1)
 {
 PORTA_OUT.B1 = ~PORTA_IN.B0;
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

 PORTA_OUT = 0x02;
 PORTA_DIR = 0x02;
 PORTA_PIN0CTRL = ( 0x00  |  0x01 );
 PORTA_PIN1CTRL = ( 0x38  |  0x00 );
 PORTA_INTCTRL = 0x00;
 PORTA_INT0MASK = 0x00;
 PORTA_INT1MASK = 0x00;
}
