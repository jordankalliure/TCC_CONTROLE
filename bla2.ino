static double x1,x2;
volatile double Vc_buck= 0.0000, IL_buck= 0.0000, Ic_buck= 0.0000; //values from buck converter
volatile double Vc_boost = 0.0000, Ic_boost= 0.0000, Ir_boost= 0.0000, Vs_boost= 0.0000;//values from boost converter
volatile double u[20] = {0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00}; //error and control signal
volatile double e[20] = {0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00}; //error and control signal
volatile double vref = 6.00;
volatile double control_dut = 0.00;
volatile int Vy = 0,Iy = 0; //duty cycle variable
volatile int Rcarga = 0, leitura = 0, malha = 0, control = 0, cpl = 0; //Control flags 
volatile int key = 0, deltaT = 0, duty = 0, a0 = 0,a1 = 0,a2 = 0,a3 = 0,a4 = 0,b0 = 0,b1 = 0,b2 = 0,b3 = 0,b4 = 0; //
//static char  space = 32; 

void setup() {

  /*Serial.begin(115200);*/
  uart();
  /*zerar_vetores();*/
//  vref = 6.0; Rcarga = 4.0; /*Initial values*/
  definicao_entrada(); /*set pin to receive analog input*/
  WDT->WDT_MR = WDT_MR_WDDIS;/*disable watchdog!*/
  pwm_start(); /*start pwm signal*/
  startTimer(TC1,0,TC3_IRQn,525); /*function to start the timer counter and to call TC3_Handler to read input register*/
  while(1);
}

void loop(){}

void uart()
{
    PMC->PMC_PCER0 = PMC_PCER0_PID8;  // UART power ON 
    // Reset and disable receiver & transmitter
    UART->UART_CR = UART_CR_RSTRX | UART_CR_RSTTX | UART_CR_RXDIS | UART_CR_TXDIS;
 
    // Set the baudrate to 115200
    UART->UART_BRGR = 45; // 84000000 / 16 * x = BaudRate
 
    // No Parity
    UART->UART_MR = UART_MR_PAR_NO;
 
    // Disable PDC channel requests
    UART->UART_PTCR = UART_PTCR_RXTDIS | UART_PTCR_TXTDIS;
 
    // Disable / Enable interrupts on end of receive
    UART->UART_IDR = 0xFFFFFFFF;
    UART->UART_IER = UART_IER_RXRDY;

    NVIC_EnableIRQ((IRQn_Type) ID_UART); 
    // Enable receiver and transmitter
    UART->UART_CR = UART_CR_RXEN | UART_CR_TXEN;
}

void definicao_entrada()
{
  /*Function to define the analog input
  /*BUCK COVERTER - CH11-A9, CH12-A10, CH13-A11
    BOOST CONVERTER - CH7-A0, CH6-A1, CH5-A2, CH4-A3*/
  REG_PMC_PCER1 |= PMC_PCER1_PID37; //enable adc clock 
  REG_ADC_CR = ADC_CR_SWRST; //reset adc register
  REG_ADC_CR = ADC_CR_START;  // start adc registers
  REG_ADC_MR = ADC_MR_FREERUN_ON; //configure to work in free mode
  REG_ADC_CHER = ADC_CHER_CH4 | ADC_CHER_CH5 | ADC_CHER_CH6 | ADC_CHER_CH7 | ADC_CHER_CH11 | ADC_CHER_CH12 | ADC_CHER_CH13; //enable adc channels
  /*R1 = 30Kohms R2 6.78Kohms */
}

void pwm_start()
{
  /*Function to configuration the pwm output */
  // PWM Set-up on pins PC7 and PA20 (Arduino Pins 39(PWMH2) and 43(PWML2)): see Datasheet chap. 38.5.1 page 973
  PMC->PMC_PCER1 |= PMC_PCER1_PID36;                   // PWM power ON
  
  PWM->PWM_DIS = PWM_DIS_CHID2;                        // Disable PWM channel 2

  // Select Instance=PWM; Signal=PWMH2 (channel 2); I/O Line=PC7 (P7, Arduino pin 39, see pinout diagram) ; Peripheral type =B
  PIOC->PIO_PDR |= PIO_PDR_P7;                          // Set the pin to the peripheral PWM, not the GPIO

  PIOC->PIO_ABSR |= PIO_PC7B_PWMH2;                     // Set PWM pin perhipheral type B

  // Select Instance=PWM; Signal=PWML2 (channel 2); I/O Line=PA20 (P20, Arduino pin 43, see pinout diagram) ; Peripheral=B
  PIOA->PIO_PDR |= PIO_PDR_P20;                          // Set the pin to the peripheral PWM, not the GPIO

  PIOA->PIO_ABSR |= PIO_PA20B_PWML2;                    // Set PWM pin perhipheral type B

  // Enable the PWM channel 2 (see datasheet page 973)

  PWM->PWM_CLK = PWM_CLK_PREA(0) | PWM_CLK_DIVA(42);    // Set the PWM clock rate to 2MHz (84MHz/42). Adjust DIVA for the resolution you are looking for

  PWM->PWM_CH_NUM[2].PWM_CMR = PWM_CMR_CPRE_CLKA;     // The period is left aligned, clock source as CLKA on channel 2

  PWM->PWM_CH_NUM[2].PWM_CPRD = 100;                             // Channel 2 : Set the PWM frequency 2MHz/(2 * CPRD) = F ;

  PWM->PWM_CH_NUM[2].PWM_CDTY = 50;                             // Channel 2: Set the PWM duty cycle to x%= (CDTY/ CPRD)  * 100 % ;

  PWM->PWM_ENA = PWM_ENA_CHID2;
  
  /*THE PROJECT NEEDED OF TWO PWM IN 10kHz*/
  /*PWM NEED TO START TO CPL IN RAMP INPUT*/
}
void TC3_Handler(){
    /*Function where the input were received and insert in variable*/
    TC_GetStatus(TC1, 0);
    /*startTimer(TC1,0,TC3_IRQn,2625); /*function to start the timer counter and to call TC3_Handler to read input register*/
    while((ADC->ADC_ISR & ADC_CHER_CH11) == 0);
    /*BUCK converter
    receive signal by analog input to buck*/
    Vc_buck = ADC->ADC_CDR[11]*(5.0*3.3/4095.0); 
    
    while((ADC->ADC_ISR & ADC_CHER_CH12) == 0);
    IL_buck = ADC->ADC_CDR[12]*(3.3/4095.0);
    IL_buck = (IL_buck-2.45)/0.185;
    //Vc_buck = ADC->ADC_CDR[13]*(5.0*3.3/4095.0);
        /*BOOST converter
    receive signal by analog input to boost*/
      /*Vc_boost = ADC->ADC_LCDR[7];
      Ic_boost = ADC->ADC_LCDR[6];
*      Ir_boost = ADC->ADC_LCDR[5];
      Vs_boost = ADC->ADC_LCDR[4];*/
   mostrar_sinal();
   //tratar_interrupcao();  

}

void mostrar_sinal()
{
    Vy = Vc_buck*100;
    a0 = Vy/100 + 48;
    a1 = (Vy/10)%10 +48;
    a2 = (Vy/1)%10 +48;

    Iy = IL_buck*100;
    b0 = Iy/100 + 48;
    b1 = (Iy/10)%10 +48;
    b2 = (Iy/1)%10 +48;
    
    while((UART_SR_TXRDY & UART->UART_SR)== 0);
        UART->UART_THR = a0;
    /*while((UART_SR_TXEMPTY & UART->UART_SR) == 0);
        UART->UART_THR = 32;*/    
    while((UART_SR_TXEMPTY & UART->UART_SR) == 0);
        UART->UART_THR = a1;
    /*while((UART_SR_TXEMPTY & UART->UART_SR) == 0);
        UART->UART_THR = 32;*/
    while((UART_SR_TXEMPTY & UART->UART_SR) == 0);
        UART->UART_THR = a2;
    
    while((UART_SR_TXEMPTY & UART->UART_SR) == 0);
       UART->UART_THR = 32;
    while((UART_SR_TXRDY & UART->UART_SR)== 0);
        UART->UART_THR = b0;
    /*while((UART_SR_TXEMPTY & UART->UART_SR) == 0);
        UART->UART_THR = 32; */   
    while((UART_SR_TXEMPTY & UART->UART_SR) == 0);
        UART->UART_THR = b1;
    /*while((UART_SR_TXEMPTY & UART->UART_SR) == 0);
        UART->UART_THR = 32;*/
    while((UART_SR_TXEMPTY & UART->UART_SR) == 0);
        UART->UART_THR = b2;
    while((UART_SR_TXEMPTY & UART->UART_SR) == 0);
        UART->UART_THR = 10;
}

void startTimer(Tc *tc, uint32_t channel, IRQn_Type irq, uint32_t frequency){
    /*this function is used to create a interruption using internal clock*/
    
    //Enable or disable write protect of PMC registers.
    pmc_set_writeprotect(false);
    //Enable the specified peripheral clock.
    pmc_enable_periph_clk((uint32_t)irq); 
     
    TC_Configure(tc, channel,TC_CMR_WAVE|TC_CMR_WAVSEL_UPDOWN_RC|TC_CMR_TCCLKS_TIMER_CLOCK3);
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
  while ((UART->UART_SR & UART_SR_RXRDY) == 0); /*wait for conversion by uart register*/
  key = UART->UART_RHR; /*receive serial message*/
  switch(key)
  {
    case 49:
    /*Receive signals from buck and boost converter*/ 
    leitura = 1; break;
    
    case 50:
    malha = 1; break; /*Call the function to work in open mash*/
    
    case 51:
    while(duty <= 50) /*generate ramp to point of operation in cpl*/
    {
     delay(100);
     duty = duty + 10;
     PWM->PWM_CH_NUM[2].PWM_CDTY = duty;
    }
    cpl = 1;
    break; 
    
    case 52:
    malha = 2; control = 1;break; /*Call the function to execute chosen control strategy State feedback*/ 
    
    case 53:
    malha = 2; control = 2; break; /*Call the function to execute chosen control strategy State feedback Classic control law*/
    
    case 54:
    malha = 2; control = 3; break; /*Call the function to execute chosen control strategy State feedback Classic control law sliding mode control*/
    
    case 55:  /*zero for all control flags*/
    leitura = 0; malha = 0; control = 0; cpl = 0;PWM->PWM_CH_NUM[2].PWM_CDTY = 0;
    volatile double u[20] = {0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00};
    volatile double e[20] = {0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00};
    break;
  }

  if (leitura == 1)
  {}

  if (malha == 1) /*Call the function to work in open mash*/
  {open_loop();}
  if (malha == 2) /*Call the function to execute chosen control strategy*/
  {closed_loop();
  mostrar_sinal();}
        
}

void open_loop() /*open mash */
{
  PWM->PWM_CH_NUM[2].PWM_CDTY = 50;                             // Channel 2: Set the PWM duty cycle to x%= (CDTY/ CPRD)  * 100 % ;
}
  /*control_dut = u[0]*200;
  PWM->PWM_CH_NUM[2].PWM_CDTY = control_dut;
  delay(10);*/

 void closed_loop() /*closed mash*/
 {
  e[0] = vref - Vc_buck;
  
  if(control == 3)
  {
   deltaT = 1;
   /*sliding mode control*/
   sm_control(); 
  }
  else if(control == 1)
  {
    /*Classic control law*/
    pi_control();
  }
  else if(control == 2)
  {
    /*State feedback*/
    
  }
  else if (cpl == 1)
  {
    /*CPL control law*/
  }

  control_dut = u[0]*200.0;
  PWM->PWM_CH_NUM[2].PWM_CDTY = control_dut;

}

void sm_control()
{
  Ic_buck = IL_buck - Vc_buck/Rcarga; 
  u[0] = ((Vc_buck/Rcarga)/(Vc_buck*1))*(e[0]) - Ic_buck;
}

void pi_control()
{
  // Metodo do LGR
static double x1 = 0.0340;
static double x2 = -0.0300;
// Alocacao de Polos Classica
// x1 = 0.0030;
// x2 = -0.0003;
// Alocacao de Polos Robusta
// x1 = 0.0158;
// x2 = -0.0114;
u[0] = u[1]+x1*e[0]+x2*e[1];

  if (u[0]>1.0)
  {
    u[0] = 1.0;
    }
  else if (u[0]<0.0)
  {
    u[0] = 0.0;
  }

    u[1] = u[0];
    e[1] = e[0];
    
}
