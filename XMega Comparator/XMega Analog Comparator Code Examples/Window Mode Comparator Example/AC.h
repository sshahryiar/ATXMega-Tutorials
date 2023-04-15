/*                Definitions for Analog Comparator Module                */


/* ACnCTRL – Analog Comparator n Control Register Definitions */

#define AC_INTMODE_BOTHEDGES_gc                                                      0x00
#define AC_INTMODE_FALLING_gc                                                        0x80
#define AC_INTMODE_RISING_gc                                                         0xC0

#define AC_INTLVL_OFF_gc                                                             0x00
#define AC_INTLVL_LO_gc                                                              0x10
#define AC_INTLVL_MED_gc                                                             0x20
#define AC_INTLVL_HI_gc                                                              0x30
         
#define AC_HSMODE_bp                                                                 0x03

#define AC_HYSMODE_NO_gc                                                             0x00
#define AC_HYSMODE_SMALL_gc                                                          0x02
#define AC_HYSMODE_LARGE_gc                                                          0x04

#define AC_ENABLE_bp                                                                 0x00

                         
/* ACnMUXCTRL – Analog Comparator n Mux Control Register Definitions */ 

#define AC_MUXPOS_PIN0_gc                                                            0x00
#define AC_MUXPOS_PIN1_gc                                                            0x08
#define AC_MUXPOS_PIN2_gc                                                            0x10
#define AC_MUXPOS_PIN3_gc                                                            0x18
#define AC_MUXPOS_PIN4_gc                                                            0x20
#define AC_MUXPOS_PIN5_gc                                                            0x28
#define AC_MUXPOS_PIN6_gc                                                            0x30
#define AC_MUXPOS_DAC_gc                                                             0x38

#define AC_MUXNEG_PIN0_gc                                                            0x00
#define AC_MUXNEG_PIN1_gc                                                            0x01
#define AC_MUXNEG_PIN3_gc                                                            0x02
#define AC_MUXNEG_PIN5_gc                                                            0x03
#define AC_MUXNEG_PIN7_gc                                                            0x04
#define AC_MUXNEG_DAC_gc                                                             0x05
#define AC_MUXNEG_BANDGAP_gc                                                         0x06
#define AC_MUXNEG_SCALER_gc                                                          0x07


/* CTRLA – Control Register A Definitions */   

#define AC_AC1OUT_bp                                                                 0x01
#define AC_AC0OUT_bp                                                                 0x00
          
                    
/* WINCTRL - Window Function Control Register */
              
#define AC_WEN_bp                                                                    0x04

#define AC_WINTMODE_ABOVE_gc                                                         0x00
#define AC_WINTMODE_INSIDE_gc                                                        0x04
#define AC_WINTMODE_BELOW_gc                                                         0x08
#define AC_WINTMODE_OUTSIDE_gc                                                       0x0C

#define AC_WINTLVL_OFF_gc                                                            0x00
#define AC_WINTLVL_LO_gc                                                             0x01
#define AC_WINTLVL_MED_gc                                                            0x02
#define AC_WINTLVL_HI_gc                                                             0x03


/* STATUS – Status Register Definitions */

#define AC_WSTATE_ABOVE_gc                                                           0x00
#define AC_WSTATE_INSIDE_gc                                                          0x40
#define AC_WSTATE_BELOW_gc                                                           0x80
#define AC_WSTATE_OUTSIDE_gc                                                         0xC0

#define AC1STATE_bp                                                                  0x05
#define AC0STATE_bp                                                                  0x04
                                                                             
#define ACWIF_bp                                                                     0x02
#define AC1IF_bp                                                                     0x01
#define AC0IF_bp                                                                     0x00


/* CURRCTRL - Current Source Control Register Register Definitons */
            
#define AC_CURREN_bp                                                                 0x07

#define AC_CURRMODE_bp                                                               0x06

#define AC_AC1CURR_bp                                                                0x01
#define AC_AC0CURR_bp                                                                0x00