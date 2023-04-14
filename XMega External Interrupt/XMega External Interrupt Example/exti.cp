#line 1 "C:/Users/Shawon/Desktop/XMega Media/XMega External Interrupt Example/exti.c"
#line 1 "c:/users/shawon/desktop/xmega media/xmega external interrupt example/io.h"
#line 1 "c:/users/shawon/desktop/xmega media/xmega external interrupt example/clock.h"
#line 1 "c:/users/shawon/desktop/xmega media/xmega external interrupt example/interrupt.h"
#line 8 "c:/users/shawon/desktop/xmega media/xmega external interrupt example/interrupt.h"
void set_global_interrupt()
{
 asm sei;
}


void clear_global_interrupt()
{
 asm cli;
}
#line 6 "C:/Users/Shawon/Desktop/XMega Media/XMega External Interrupt Example/exti.c"
sbit LCD_RS at PORTC_OUT.B2;
sbit LCD_EN at PORTC_OUT.B3;
sbit LCD_D4 at PORTC_OUT.B4;
sbit LCD_D5 at PORTC_OUT.B5;
sbit LCD_D6 at PORTC_OUT.B6;
sbit LCD_D7 at PORTC_OUT.B7;

sbit LCD_RS_Direction at PORTC_DIR.B2;
sbit LCD_EN_Direction at PORTC_DIR.B3;
sbit LCD_D4_Direction at PORTC_DIR.B4;
sbit LCD_D5_Direction at PORTC_DIR.B5;
sbit LCD_D6_Direction at PORTC_DIR.B6;
sbit LCD_D7_Direction at PORTC_DIR.B7;


void setup_clock();
void setup_io();
void setup_interrupts();
void setup_lcd();


void PORTA_INT0_ISR()
org IVT_ADDR_PORTA_INT0
{
 unsigned char s = 16;

 while(s > 0)
 {
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 1, "LOW Lvl");
 Lcd_Out(2, 3, "ISR.");
 PORTD_OUT.B1 ^= 1;
 delay_ms(200);
 s--;
 }
}


void PORTA_INT1_ISR()
org IVT_ADDR_PORTA_INT1
{
 unsigned char s = 16;

 while(s > 0)
 {
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 1, "HIGH Lvl");
 Lcd_Out(2, 3, "ISR.");
 PORTD_OUT.B2 ^= 1;
 delay_ms(200);
 s--;
 }
}


void main()
{
 setup_interrupts();
 setup_clock();
 setup_io();
 setup_lcd();

 while(1)
 {
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 3, "Main");
 Lcd_Out(2, 3, "Loop");
 PORTD_OUT.B0 ^= 1;
 delay_ms(900);
 }
}


void setup_clock()
{
 clear_global_interrupt();
 OSC_CTRL |=  0x04 ;
 while(!(OSC_STATUS &  0x04 ));
 DFLLRC32M_CTRL = 0;
 OSC_CTRL |=  0x02 ;
 while(!(OSC_STATUS &  0x02 ));
 OSC_DFLLCTRL =  0x00 ;
 DFLLRC32M_CTRL =  0x01 ;
 CPU_CCP =  0xD8 ;
 CLK_PSCTRL = ( 0x0C  |  0x00 );
 CPU_CCP =  0xD8 ;
 CLK_CTRL =  0x01 ;
 OSC_CTRL &= ~( 0x01  |  0x08  |  0x10 );
 PORTCFG_CLKEVOUT = 0x00;
}


void setup_io()
{
 PORTA_OUT = 0x00;
 PORTA_DIR = 0x00;
 PORTA_PIN0CTRL = ( 0x00  |  0x01 );
 PORTA_PIN1CTRL = ( 0x00  |  0x01 );
 PORTA_PIN2CTRL = ( 0x00  |  0x00 );
 PORTA_PIN3CTRL = ( 0x00  |  0x00 );
 PORTA_PIN4CTRL = ( 0x00  |  0x00 );
 PORTA_PIN5CTRL = ( 0x00  |  0x00 );
 PORTA_PIN6CTRL = ( 0x00  |  0x00 );
 PORTA_PIN7CTRL = ( 0x00  |  0x00 );
 PORTA_INTCTRL = ( 0x0C  |  0x01 );
 PORTA_INT0MASK = 0x01;
 PORTA_INT1MASK = 0x02;

 PORTD_OUT = 0x00;
 PORTD_DIR = 0x07;
 PORTD_PIN0CTRL = ( 0x00  |  0x00 );
 PORTD_PIN1CTRL = ( 0x00  |  0x00 );
 PORTD_PIN2CTRL = ( 0x00  |  0x00 );
 PORTD_PIN3CTRL = ( 0x00  |  0x00 );
 PORTD_PIN4CTRL = ( 0x00  |  0x00 );
 PORTD_PIN5CTRL = ( 0x00  |  0x00 );
 PORTD_PIN6CTRL = ( 0x00  |  0x00 );
 PORTD_PIN7CTRL = ( 0x00  |  0x00 );
 PORTD_INTCTRL = ( 0x00  |  0x00 );
 PORTD_INT0MASK = 0x00;
 PORTD_INT1MASK = 0x00;

 set_global_interrupt();
}


void setup_interrupts()
{
 clear_global_interrupt();
 CPU_CCP =  0xD8 ;
 PMIC_CTRL = ( 0x01  |  0x04 );
 PMIC_INTPRI = 0x00;
}


void setup_lcd()
{
 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
}
