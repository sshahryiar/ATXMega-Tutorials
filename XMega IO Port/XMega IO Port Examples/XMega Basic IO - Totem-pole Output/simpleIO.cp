#line 1 "C:/Users/Shawon/Desktop/XMega IO Port Codes/XMega Basic IO - Simple IO Control/simpleIO.c"
#line 1 "c:/users/shawon/desktop/xmega io port codes/xmega basic io - simple io control/io.h"
#line 1 "c:/users/shawon/desktop/xmega io port codes/xmega basic io - simple io control/clock.h"
#line 5 "C:/Users/Shawon/Desktop/XMega IO Port Codes/XMega Basic IO - Simple IO Control/simpleIO.c"
void setup();


void main()
{
 setup();

 while(1)
 {
 PORTD_OUT = 0x55;
 delay_ms(200);
 PORTD_OUT = 0xAA;
 delay_ms(200);
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

 PORTD_OUTCLR = 0xFF;
 PORTD_DIRSET = 0xFF;
 PORTCFG_MPCMASK = 0xFF;
 PORTD_PIN6CTRL = ( 0x00  |  0x00 );
}
