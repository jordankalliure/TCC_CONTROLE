static double Ki;
volatile double Vc_buck, Ic_buck, Ir_buck; //values from buck converter
volatile double Vc_boost, Ic_boost, Ir_boost, Vs_boost;//values from boost converter
volatile double u[2], e[2]; //error and control signal
volatile int control_dut; //duty cycle variable
volatile int vref, leitura, malha_fechada, control; //Control flags 
volatile int key = 0; // 

void setup() {

  Serial.begin(9600);
  definicao_entrada(); //set pin to receive analog input
  WDT->WDT_MR = WDT_MR_WDDIS;     // disable watchdog!
  //pinMode(13,OUTPUT);
  //REG_PIOB_OWER = (0x1u << 27); //enable write in output
  tratar_interrupcao();
  pwm_start();
}

  void loop(){}

void definicao_entrada()
{
  /*Function to define the analog input
  /*BUCK COVERTER - CH11-A9, CH12-A10, CH13-A11
    BOOST CONVERTER - CH7-A0, CH6-A1, CH5-A2, CH4-A3*/
  //REG_PIOB_PER = PIO_PB17 |PIO_PB18 | PIO_PB19 | PIO_PB20;
  //REG_PIO_OER = PIO_PB17 |PIO_PB18 | PIO_PB19 | PIO_PB20;
  REG_ADC_MR = ADC_MR_FREERUN_ON;
  REG_ADC_CR = ADC_CR_START;
  REG_ADC_CHER = ADC_CHER_CH4 | ADC_CHER_CH5 | ADC_CHER_CH6 | ADC_CHER_CH7 | ADC_CHER_CH11 | ADC_CHER_CH12 | ADC_CHER_CH13;
}

void pwm_start()
{
  /*Function to configuration the pwm output */
  REG_PMC_PCER1 |= ID_PWM;  //enable pwm
  REG_PIOB_ABSR |= PIO_ABSR_P16;    //set peripherical A to B
  REG_PIOA_PDR |= PIO_PDR_P16;    //set as output
  REG_PWM_CLK |= PWM_CLK_PREA(0) | PWM_CLK_DIVA(32); //(84/32)MHz
  REG_PWM_CMR0 |= PWM_CMR_CPRE_CLKA;
  REG_PWM_CPRD0 |= 2625;
  REG_PWM_CDTY0 |= 0;         //set duty cicle
  REG_PWM_ENA |= PWM_ENA_CHID0;
}
void TC3_Handler(){
    /*Function where the input were received and insert in variable*/
    TC_GetStatus(TC1, 0);
    
    while((ADC->ADC_ISR & ADC_MR_FREERUN_ON)==0)
    /*BUCK converter
    receive signal by analog input to buck*/   
      Vc_buck = ADC->ADC_CDR[11];
      Ic_buck = ADC->ADC_CDR[12];
      Ir_buck = ADC->ADC_CDR[13];
    /*BOOST converter
    receive signal by analog input to boost*/
      Vc_boost = ADC->ADC_CDR[7];
      Ic_boost = ADC->ADC_CDR[6];
      Ir_boost = ADC->ADC_CDR[5];
      Vs_boost = ADC->ADC_CDR[4];  
    //if(REG_PIOB_ODSR & (0x1u << 27))
    //{REG_PIOB_CODR = (0x1u << 27);}
    //else
    //{REG_PIOB_SODR = (0x1u << 27);}
}

void startTimer(Tc *tc, uint32_t channel, IRQn_Type irq, uint32_t frequency){
    /*this function is used to create a interruption using internal clock*/
    
    //Enable or disable write protect of PMC registers.
    pmc_set_writeprotect(false);
    //Enable the specified peripheral clock.
    pmc_enable_periph_clk((uint32_t)irq); 
     
    TC_Configure(tc, channel,TC_CMR_WAVE|TC_CMR_WAVSEL_UPDOWN_RC|TC_CMR_TCCLKS_TIMER_CLOCK3);//|TC_CMR_CPCSTOP);
    uint32_t rc = frequency;//VARIANT_MCK/128/frequency;
     
    TC_SetRA(tc, channel, rc);
    TC_SetRC(tc, channel, rc);
    TC_Start(tc, channel);
     
    tc->TC_CHANNEL[channel].TC_IER = TC_IER_CPCS;
    tc->TC_CHANNEL[channel].TC_IDR = ~TC_IER_CPCS;
    NVIC_EnableIRQ(irq);
}

void tratar_interrupcao()
{
  if (Serial)
  {
    key = Serial.read();
  }
  switch(key)
  {
    case 49:
    /*Receive signals from buck and boost converter*/ 
    leitura = 1;break;
    case 52:
    /*To set EPSAC_SM_CONTROL_BUCK*/
    malha_fechada = 1; control = 1; break; 
    case 53:
    /*To set PI_SM_CONTROL_BUCK*/
    malha_fechada = 1; control = 2; break;
    case 54:
    /*To set SM_CONTROL_BUCK*/
    malha_fechada = 1; control = 3; break;
  }
  if (leitura== 1)
  {
    /*function to start the timer counter and to call TC3_Handler to read input register*/
    startTimer(TC1,0,TC3_IRQn,525);
  }
  if (malha_fechada == 1)
  /*Call the function to execute chosen control strategy*/
  {controle();}
}
 void controle()
 {
  e[0] = vref - Vc_buck;
  if(control == 3)
  {
    /*SLIDING MODE CONTROL*/
    u[0] = (Ir_buck/(Vc_buck*1))*(e[0]) -Ic_buck;
    control_dut = 2625*u[0];
    REG_PWM_CDTY0 = control_dut;
  }
  else if(control == 1)
  {
    /*EXTEDEND PREDICTIVE SELF - ADAPTIVE CONTROL (EPSAC)*/
    u[0] = (Ir_buck/(Vc_buck*1))*(e[0]) -Ic_buck;
    control_dut = 2625*u[0];
    REG_PWM_CDTY0 = control_dut;
  }
  else if(control == 2)
  {
    /*PROPORTIONAL INTEGRAL (PI)*/
    Ki = -150;
    Ic_buck = Ic_buck - Ki*e[0]; 
    u[0] = (Ir_buck/(Vc_buck*1))*(e[0]) - Ic_buck;
    control_dut = 2625*u[0];
    REG_PWM_CDTY0 = control_dut;
  }
  if (u[0]>1)
  {
    u[0] = 1;
    }
  else if (u[0]<0)
  {
    u[0] = 0;
    }
  u[2] = u[1];
  u[1] = u[0];
  e[2] = e[1];
  e[1] = e[0];
 }
