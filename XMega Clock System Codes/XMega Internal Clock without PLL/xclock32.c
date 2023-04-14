void setup();


void main() 
{
     setup();
     
     while(1)
     {
     };
}


void setup()
{
     //Disable all clock sources
     OSC_CTRL = 0x00;
     //Enable the internal 32.768 kHz RC oscillator 
     RC32KEN_bit = 1;
     //Wait for the internal 32.768 kHz RC oscillator to stabilize
     while(!RC32KRDY_bit);
     //Enable the internal 32 MHz RC oscillator 
     RC32MEN_bit = 1;
     //Disable protected IOs to update settings
     CPU_CCP = 0xD8;
     //Configure prescalar 
     CLK_PSCTRL = 0x1C;
     //Configure DFLL for calibration
     OSC_DFLLCTRL = 0x00;
     DFLLRC32M_CTRL = 0x01;
     //Wait for the internal 32 MHz RC oscillator to stabilize
     while(!RC32MRDY_bit);
     //Disable protected IOs to update settings
     CPU_CCP = 0xD8;
     //Select system clock source
     CLK_CTRL = 0x01;
     //Configure port pin for clock output
     PORTCFG_CLKEVOUT = 0x0A;
     PORTD_OUT = 0x00;
     PORTD_DIR = 0x80;
     PORTD_PIN7CTRL = 0x07;
     PORTD_INT0MASK = 0x00;
     PORTD_INT1MASK = 0x00;
     PORTD_INTCTRL = 0x00;

     PORTCFG_VPCTRLA = 0x10;
     PORTCFG_VPCTRLB = 0x32;
}
