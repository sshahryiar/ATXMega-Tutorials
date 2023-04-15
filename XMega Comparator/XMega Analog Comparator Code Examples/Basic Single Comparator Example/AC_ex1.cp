#line 1 "C:/Users/Shawon/Desktop/XMega Media/Basic Single Comparator Example/AC_ex1.c"
#line 1 "c:/users/shawon/desktop/xmega media/basic single comparator example/clock.h"
#line 1 "c:/users/shawon/desktop/xmega media/basic single comparator example/io.h"
#line 1 "c:/users/shawon/desktop/xmega media/basic single comparator example/ac.h"
#line 6 "C:/Users/Shawon/Desktop/XMega Media/Basic Single Comparator Example/AC_ex1.c"
void setup();
void setup_clock();
void setup_GPIO();
void setup_AC();


void main()
{
 setup();

 while(1)
 {
 };
}


void setup()
{
 setup_clock();
 setup_GPIO();
 setup_AC();
}


void setup_clock()
{
 asm cli;
 OSC_CTRL |=  0x04 ;
 while(!(OSC_STATUS &  0x04 ));
 OSC_CTRL |=  0x02 ;
 CPU_CCP =  0xD8 ;
 CLK_PSCTRL = ((CLK_PSCTRL & (~( 0x7C  |  0x02 
 |  0x01 ))) |  0x00  |  0x03 );
 OSC_DFLLCTRL = ((OSC_DFLLCTRL & (~( 0x06  |  0x01 ))) |
  0x00 );
 DFLLRC32M_CTRL |=  0x01 ;
 while(!(OSC_STATUS &  0x02 ));
 CPU_CCP =  0xD8 ;
 CLK_CTRL = ((CLK_CTRL & (~ 0x07 )) |  0x01 );
 OSC_CTRL &= (~( 0x01  |  0x08  |  0x10 ));
 PORTCFG_CLKEVOUT = 0x00;
}


void setup_GPIO()
{
 PORTA_OUT = 0x00;
 PORTA_DIR = 0x80;
 PORTCFG_MPCMASK = 0xFF;
 PORTA_PIN4CTRL = ( 0x00  |  0x00 );
 PORTA_INTCTRL = ((PORTA_INTCTRL & (~( 0x0C  |  0x03 ))) |
  0x00  |  0x00 );
}


void setup_AC()
{
 ACA_WINCTRL = 0x00;
 ACA_AC0MUXCTRL = ( 0x00  |  0x01 );
 ACA_AC0CTRL = ( 0x00  |  0x00  | (0 <<  0x03 )
 |  0x00  | (1 <<  0x00 ));
 ACA_AC1MUXCTRL = 0x00;
 ACA_AC1CTRL = 0x00;
 ACA_CTRLA = ((0 <<  0x01 ) | (1 <<  0x00 ));
}
