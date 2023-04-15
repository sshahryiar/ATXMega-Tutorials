#line 1 "C:/Users/Shawon & Nipa/Desktop/XMega Media/Window Mode Comparator Example/AC_ex3.c"
#line 1 "c:/users/shawon & nipa/desktop/xmega media/window mode comparator example/clock.h"
#line 1 "c:/users/shawon & nipa/desktop/xmega media/window mode comparator example/io.h"
#line 1 "c:/users/shawon & nipa/desktop/xmega media/window mode comparator example/ac.h"
#line 6 "C:/Users/Shawon & Nipa/Desktop/XMega Media/Window Mode Comparator Example/AC_ex3.c"
void setup();
void setup_clock();
void setup_GPIO();
void setup_AC();


void main()
{
 unsigned char result = 0;

 setup();

 while(1)
 {
 result = (ACA_STATUS & 0xC0);

 if(result ==  0x00 )
 {
 PORTD_OUT = 0x01;
 }
 if(result ==  0x40 )
 {
 PORTD_OUT = 0x02;
 }
 if(result ==  0x80 )
 {
 PORTD_OUT = 0x04;
 }
 if(result ==  0xC0 )
 {
 PORTD_OUT = 0x08;
 }
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
 PORTA_DIR = 0xC0;
 PORTCFG_MPCMASK = 0xFF;
 PORTA_PIN4CTRL = ( 0x00  |  0x00 );
 PORTA_INTCTRL = ((PORTA_INTCTRL & (~( 0x0C  |  0x03 ))) |
  0x00  |  0x00 );

 PORTD_OUT = 0x00;
 PORTD_DIR = 0x0F;
 PORTCFG_MPCMASK = 0xFF;
 PORTD_PIN6CTRL = ( 0x00  |  0x00 );
 PORTD_INTCTRL = ((PORTD_INTCTRL & (~( 0x0C  |  0x03 ))) |
  0x00  |  0x00 );
}


void setup_AC()
{
 unsigned char reg_val = 0;

 reg_val = ( 0x00  |  0x00  | (0 <<  0x03 )
 |  0x04  | (1 <<  0x00 ));

 ACA_AC0MUXCTRL = ( 0x00  |  0x07 );
 ACA_AC0CTRL = reg_val;

 ACA_AC1MUXCTRL = ( 0x00  |  0x06 );
 ACA_AC1CTRL = reg_val;

 ACA_WINCTRL = ((1 <<  0x04 ) |  0x0C  |  0x00 );

 ACA_CTRLA = (1 <<  0x01 ) | (1 <<  0x00 );
 ACA_CTRLB = 0x33;
}
