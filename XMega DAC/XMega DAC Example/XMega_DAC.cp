#line 1 "C:/Users/Shawon/Desktop/XMega Media/XMega DAC Example/XMega_DAC.c"
#line 1 "c:/users/shawon/desktop/xmega media/xmega dac example/clock.h"
#line 1 "c:/users/shawon/desktop/xmega media/xmega dac example/dac.h"
#line 1 "c:/users/shawon/desktop/xmega media/xmega dac example/io.h"
#line 6 "C:/Users/Shawon/Desktop/XMega Media/XMega DAC Example/XMega_DAC.c"
void setup();
void clock_setup();
void io_setup();
void dac_Setup();
void dac_write(unsigned char channel, unsigned int value);


void main()
{
 signed int temp1 = 0;
 signed int temp2 = 0;
 unsigned int degree = 0;

 setup();

 while(1)
 {
 for(degree = 0; degree < 360; degree++)
 {
 temp1 = (2047 * cos(degree * 0.0174532925));
 temp1 = (2048 - temp1);
 temp2 = (2047 * sin(degree * 0.0174532925));
 temp2 = (2048 - temp2);
 dac_write(0, ((unsigned int)temp1));
 dac_write(1, ((unsigned int)temp2));
 delay_us(10);
 }
 };
}


void setup()
{
 clock_setup();
 io_setup();
 dac_Setup();
}


void clock_setup()
{
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


void io_setup()
{
 PORTB_OUT = 0x00;
 PORTB_DIR = 0x0C;
 PORTB_PIN0CTRL = ( 0x00  |  0x00 );
 PORTB_PIN1CTRL = ( 0x00  |  0x00 );
 PORTB_PIN2CTRL = ( 0x00  |  0x07 );
 PORTB_PIN3CTRL = ( 0x00  |  0x07 );
 PORTB_INT0MASK = 0x00;
 PORTB_INT1MASK = 0x00;
}


void dac_setup()
{
 DACB_CTRLA = ((DACB_CTRLA & (~( 0x10  |  0x04  |  0x08 
 |  0x02 ))) |  0x04  |  0x08  |  0x01 );
 DACB_CTRLB = ((DACB_CTRLB & (~( 0x60  |  0x01 
 |  0x02 ))) |  0x40 );
 DACB_CTRLC = ((DACB_CTRLC & (~( 0x14  |  0x01 )))
 |  0x08 );
}


void dac_write(unsigned char channel, unsigned int value)
{
 switch(channel)
 {
 case 0:
 {
 while(!(DACB_STATUS &  0x01 ));
 DACB_CH0DATA = value;
 break;
 }
 case 1:
 {
 while(!(DACB_STATUS &  0x02 ));
 DACB_CH1DATA = value;
 break;
 }
 }
}
