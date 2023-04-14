/*
        Registers related to Interrupt System
*/                                           


//Miscellaneous Functions

void set_global_interrupt()
{
    asm sei;
} 


void clear_global_interrupt()
{       
    asm cli;
}       
  
   
//PMIC Control Register Definitions 

#define PMIC_RREN_bm                                0x80 
#define PMIC_IVSEL_bm                               0x40
#define PMIC_HILVLEN_bm                             0x04
#define PMIC_MEDLVLEN_bm                            0x02
#define PMIC_LOLVLEN_bm                             0x01
                  

//PMIC Status Register Definitions 

#define PMIC_NMIEX_bm                               0x80
#define PMIC_HILVLEX_bm                             0x04
#define PMIC_MEDLVLEX_bm                            0x02
#define PMIC_LOLVLEX_bm                             0x01