/*
        Registers related to ADC
*/


//ADC CTRLA - Control Register A Register Definitions

#define ADC_ENABLE_bm                                0x01

#define ADC_FLUSH_bm                                 0x02

#define ADC_DMASEL_OFF_gm                            0x00
#define ADC_DMASEL_CH01_gm                           0x40
#define ADC_DMASEL_CH012_gm                          0x80
#define ADC_DMASEL_CH0123_gm                         0xC0


//ADC CTRLB - Control Register B Register Definitions

#define ADC_IMPMODE_bp                               0x07

#define ADC_CONMODE_bp                               0x04

#define ADC_CURRLIMIT_NO_gc                          0x00
#define ADC_CURRLIMIT_SMALL_gc                       0x20
#define ADC_CURRLIMIT_MEDIUM_gc                      0x40
#define ADC_CURRLIMIT_LARGE_gc                       0x60

#define ADC_RESOLUTION_12BIT_gc                      0x00
#define ADC_RESOLUTION_8BIT_gc                       0x40
#define ADC_RESOLUTION_LEFT12BIT_gc                  0x06

#define ADC_FREERUN_bm                               0x08


//ADC REFCTRL - Reference Control Register Definitions

#define ADC_TEMPREF_bp                                0x00

#define ADC_BANDGAP_bp                                0x01

#define ADC_REFSEL_INT1V_gc                           0x00
#define ADC_REFSEL_VCC_gc                             0x10
#define ADC_REFSEL_AREFA_gc                           0x20
#define ADC_REFSEL_AREFB_gc                           0x30
#define ADC_REFSEL_VCCDIV2_gc                         0x40


//ADC EVCTRL – Event Control Register Definitions

#define ADC_SWEEP_0_gc                                0x00
#define ADC_SWEEP_01_gc                               0x40
#define ADC_SWEEP_012_gc                              0x80
#define ADC_SWEEP_0123_gc                             0xC0

#define ADC_EVSEL_0123_gc                             0x00
#define ADC_EVSEL_1234_gc                             0x08
#define ADC_EVSEL_2345_gc                             0x10
#define ADC_EVSEL_3456_gc                             0x18
#define ADC_EVSEL_4567_gc                             0x20
#define ADC_EVSEL_567_gc                              0x28
#define ADC_EVSEL_67_gc                               0x30
#define ADC_EVSEL_7_gc                                0x38

#define ADC_EVACT_NONE_gc                             0x00
#define ADC_EVACT_CH0_gc                              0x01
#define ADC_EVACT_CH01_gc                             0x02
#define ADC_EVACT_CH012_gc                            0x03
#define ADC_EVACT_CH0123_gc                           0x04
#define ADC_EVACT_SWEEP_gc                            0x05
#define ADC_EVACT_SYNCHSWEEP_gc                       0x06


//ADC PRESCALER – Clock Prescaler Register Definitions

#define ADC_PRESCALER_DIV4_gc                         0x00
#define ADC_PRESCALER_DIV8_gc                         0x01
#define ADC_PRESCALER_DIV16_gc                        0x02
#define ADC_PRESCALER_DIV32_gc                        0x03
#define ADC_PRESCALER_DIV64_gc                        0x04
#define ADC_PRESCALER_DIV128_gc                       0x05
#define ADC_PRESCALER_DIV256_gc                       0x06
#define ADC_PRESCALER_DIV512_gc                       0x07


//ADC CTRL – Channel Control Register Definitions

#define ADC_CH_START_bp                               0x07

#define ADC_CH_GAIN_1X_gc                             0x00
#define ADC_CH_GAIN_2X_gc                             0x04
#define ADC_CH_GAIN_4X_gc                             0x08
#define ADC_CH_GAIN_8X_gc                             0x0C
#define ADC_CH_GAIN_16X_gc                            0x10
#define ADC_CH_GAIN_32X_gc                            0x14
#define ADC_CH_GAIN_64X_gc                            0x18
#define ADC_CH_GAIN_DIV2_gc                           0x1C

#define ADC_CH_INPUTMODE_INTERNAL_gc                  0x00
#define ADC_CH_INPUTMODE_SINGLEENDED_gc               0x01
#define ADC_CH_INPUTMODE_DIFF_gc                      0x02
#define ADC_CH_INPUTMODE_DIFFWGAIN_gc                 0x03


//ADC MUXCTRL – ADC Channel MUX Control Register Definitions

#define ADC_CH_MUXINT_TEMP_gc                        0x00
#define ADC_CH_MUXINT_BANDGAP_gc                     0x08
#define ADC_CH_MUXINT_SCALEDVCC_gc                   0x10
#define ADC_CH_MUXINT_DAC_gc                         0x18

#define ADC_CH_MUXPOS_PIN0_gc                        0x00   
#define ADC_CH_MUXPOS_PIN1_gc                        0x08  
#define ADC_CH_MUXPOS_PIN2_gc                        0x10   
#define ADC_CH_MUXPOS_PIN3_gc                        0x18  
#define ADC_CH_MUXPOS_PIN4_gc                        0x20   
#define ADC_CH_MUXPOS_PIN5_gc                        0x28  
#define ADC_CH_MUXPOS_PIN6_gc                        0x30
#define ADC_CH_MUXPOS_PIN7_gc                        0x38  
#define ADC_CH_MUXPOS_PIN8_gc                        0x40   
#define ADC_CH_MUXPOS_PIN9_gc                        0x48 
#define ADC_CH_MUXPOS_PIN10_gc                       0x50
#define ADC_CH_MUXPOS_PIN11_gc                       0x58
#define ADC_CH_MUXPOS_PIN12_gc                       0x60
#define ADC_CH_MUXPOS_PIN13_gc                       0x68
#define ADC_CH_MUXPOS_PIN14_gc                       0x70
#define ADC_CH_MUXPOS_PIN15_gc                       0x78

#define ADC_CH_MUXNEG_PIN0_gc                        0x00
#define ADC_CH_MUXNEG_PIN1_gc                        0x01  
#define ADC_CH_MUXNEG_PIN2_gc                        0x02
#define ADC_CH_MUXNEG_PIN3_gc                        0x03
#define ADC_CH_MUXNEG_PIN4_gc                        0x00
#define ADC_CH_MUXNEG_PIN5_gc                        0x01  
#define ADC_CH_MUXNEG_PIN6_gc                        0x02
#define ADC_CH_MUXNEG_PIN7_gc                        0x03   
#define ADC_CH_MUXNEGL_GND_gc                        0x05  
#define ADC_CH_MUXNEGH_GND_gc                        0x07
#define ADC_CH_MUXNEGL_INTGND_gc                     0x07
#define ADC_CH_MUXNEGH_INTGND_gc                     0x04


//ADC INTCTRL – Channel Interrupt Control Register Definitions

#define ADC_CH_INTMODE_COMPLETE_gc                  0x00
#define ADC_CH_INTMODE_BELOW_gc                     0x04
#define ADC_CH_INTMODE_ABOVE_gc                     0x0C

#define ADC_CH_INTLVL_OFF_gc                        0x00
#define ADC_CH_INTLVL_LO_gc                         0x01
#define ADC_CH_INTLVL_MED_gc                        0x02
#define ADC_CH_INTLVL_HI_gc                         0x03


//ADC INTFLAGS – ADC Channel Interrupt Flag Register Definitions
                     
#define ADC_CH_CHIF_bm                              0x01