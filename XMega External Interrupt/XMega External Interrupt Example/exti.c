#include "io.h"
#include "clock.h"
#include "interrupt.h"


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
    OSC_CTRL |= OSC_RC32KEN_bm;
    while(!(OSC_STATUS & OSC_RC32KRDY_bm));
    DFLLRC32M_CTRL = 0;
    OSC_CTRL |= OSC_RC32MEN_bm;
    while(!(OSC_STATUS & OSC_RC32MRDY_bm));
    OSC_DFLLCTRL = OSC_RC32MCREF_RC32K_gc;
    DFLLRC32M_CTRL = DFLL_ENABLE_bm;
    CPU_CCP = CCP_IOREG_gc;
    CLK_PSCTRL = (CLK_PSADIV_4_gc | CLK_PSBCDIV_1_1_gc);
    CPU_CCP = CCP_IOREG_gc;
    CLK_CTRL = CLK_SCLKSEL_RC32M_gc;
    OSC_CTRL &= ~(OSC_RC2MEN_bm | OSC_XOSCEN_bm | OSC_PLLEN_bm);
    PORTCFG_CLKEVOUT = 0x00;
}


void setup_io()
{
    PORTA_OUT = 0x00;
    PORTA_DIR = 0x00;
    PORTA_PIN0CTRL = (PORT_OPC_TOTEM_gc | PORT_ISC_RISING_gc);
    PORTA_PIN1CTRL = (PORT_OPC_TOTEM_gc | PORT_ISC_RISING_gc);
    PORTA_PIN2CTRL = (PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc);
    PORTA_PIN3CTRL = (PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc);
    PORTA_PIN4CTRL = (PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc);
    PORTA_PIN5CTRL = (PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc);
    PORTA_PIN6CTRL = (PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc);
    PORTA_PIN7CTRL = (PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc);
    PORTA_INTCTRL = (PORT_INT1LVL_HI_gc | PORT_INT0LVL_LO_gc);
    PORTA_INT0MASK = 0x01;
    PORTA_INT1MASK = 0x02;
    
    PORTD_OUT = 0x00;
    PORTD_DIR = 0x07;
    PORTD_PIN0CTRL = (PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc);
    PORTD_PIN1CTRL = (PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc);
    PORTD_PIN2CTRL = (PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc);
    PORTD_PIN3CTRL = (PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc);
    PORTD_PIN4CTRL = (PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc);
    PORTD_PIN5CTRL = (PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc);
    PORTD_PIN6CTRL = (PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc);
    PORTD_PIN7CTRL = (PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc);
    PORTD_INTCTRL = (PORT_INT1LVL_OFF_gc | PORT_INT0LVL_OFF_gc);
    PORTD_INT0MASK = 0x00;
    PORTD_INT1MASK = 0x00;
    
    set_global_interrupt();
}


void setup_interrupts()
{
    clear_global_interrupt();
    CPU_CCP = CCP_IOREG_gc;
    PMIC_CTRL = (PMIC_LOLVLEN_bm | PMIC_HILVLEN_bm);
    PMIC_INTPRI = 0x00;
}


void setup_lcd()
{
    Lcd_Init();
    Lcd_Cmd(_LCD_CLEAR);
    Lcd_Cmd(_LCD_CURSOR_OFF);
}