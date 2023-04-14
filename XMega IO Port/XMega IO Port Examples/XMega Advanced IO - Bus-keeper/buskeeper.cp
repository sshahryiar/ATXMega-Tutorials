#line 1 "C:/Users/Shawon/Desktop/XMega IO Port Codes/Xmega Advanced IO - Bus-keeper/buskeeper.c"
#line 1 "c:/users/shawon/desktop/xmega io port codes/xmega advanced io - bus-keeper/io.h"
#line 1 "c:/users/shawon/desktop/xmega io port codes/xmega advanced io - bus-keeper/clock.h"
#line 5 "C:/Users/Shawon/Desktop/XMega IO Port Codes/Xmega Advanced IO - Bus-keeper/buskeeper.c"
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

 PORTD_OUT = 0x00;
 PORTD_DIR = 0x02;
 PORTD_PIN0CTRL = ( 0x08  |  0x00 );
 PORTD_PIN1CTRL = ( 0x00  |  0x00 );
}
