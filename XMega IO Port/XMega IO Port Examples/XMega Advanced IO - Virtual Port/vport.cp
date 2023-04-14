#line 1 "C:/Users/Shawon/Desktop/XMega IO Port Examples/XMega Advanced IO - Virtual Port/vport.c"
#line 1 "c:/users/shawon/desktop/xmega io port examples/xmega advanced io - virtual port/io.h"
#line 1 "c:/users/shawon/desktop/xmega io port examples/xmega advanced io - virtual port/clock.h"
#line 5 "C:/Users/Shawon/Desktop/XMega IO Port Examples/XMega Advanced IO - Virtual Port/vport.c"
void setup();


void main()
{
 const unsigned n[10] = {0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F};
 unsigned char s = 0;

 setup();

 while(1)
 {
 for(s = 0; s <= 9; s++)
 {
 VPORT3_OUT = n[s];
 delay_ms(400);
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

 PORTD_OUTCLR = 0xFF;
 PORTD_DIRSET = 0xFF;
 PORTCFG_MPCMASK = 0xFF;
 PORTD_PIN6CTRL = ( 0x00  |  0x00 );

 PORTCFG_VPCTRLA = ( 0x10  |  0x00 );
 PORTCFG_VPCTRLB = ( 0x30  |  0x02 );

 VPORT3_DIR = 0xFF;
 VPORT3_OUT = 0x00;
}
