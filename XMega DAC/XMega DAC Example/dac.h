/*
        Definitions of registers related to DAC
*/


//Control Register A Definitions

#define DAC_IDOEN_bm                0x10
#define DAC_CH1EN_bm                0x08
#define DAC_CH0EN_bm                0x04
#define DAC_LPMODE_bm               0x02
#define DAC_ENABLE_bm               0x01


//Control Register B Definitions

#define DAC_CHSEL_gm                0x60

#define DAC_CH1TRIG_bm              0x02
#define DAC_CH0TRIG_bm              0x01

#define DAC_CHSEL_SINGLE0_gc        0x00
#define DAC_CHSEL_SINGLE1_gc        0x20
#define DAC_CHSEL_DUAL_gc           0x40
#define DAC_CHSEL_SINGLE_gc         DAC_CHSEL_SINGLE0_gc


//Control Register C Definitions

#define DAC_REFSEL_gm               0x14

#define DAC_LEFTADJ_bm              0x01

#define DAC_REFSEL_INT1V_gc         0x00
#define DAC_REFSEL_AVCC_gc          0x08
#define DAC_REFSEL_AREFA_gc         0x10
#define DAC_REFSEL_AREFB_gc         0x18


//Control Register C Definitions

#define DAC_EVSEL_gm                0x0F

#define DAC_EVSEL_0_gc              0x00
#define DAC_EVSEL_1_gc              0x01
#define DAC_EVSEL_2_gc              0x02
#define DAC_EVSEL_3_gc              0x03
#define DAC_EVSEL_4_gc              0x04
#define DAC_EVSEL_5_gc              0x05
#define DAC_EVSEL_6_gc              0x06
#define DAC_EVSEL_7_gc              0x07


//Status Register Definitions

#define DAC_CH0DRE_bm               0x01
#define DAC_CH1DRE_bm               0x02