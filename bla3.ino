/*  Trabalho de Conclusão de Curso
  
  Código para os controladores v3.0
    Autor: Jordan Kalliure
    Co-Autor: Isaías Bessa*/


static double x1,x2;
static double Pb = 9; //Potência de base para a CPL
volatile double Vc_buck= 0.0000, IL_buck= 0.0000, Ic_buck= 0.0000; //values from buck converter
volatile double Vc_cpl = 0.0000, IL_cpl= 0.0000; //values from buck cpl
volatile double Vc_boost = 0.0000, Ic_boost= 0.0000, Ir_boost= 0.0000, Vs_boost= 0.0000;//values from boost converter
volatile double u[20] = {0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00}; //error and control signal
volatile double uCpl[20] = {0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00}; //sinal de controle da CPL
volatile double e[20] = {0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00}; //error and control signal
volatile double eCpl[20] = {0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00}; //error da CPL
volatile double r1[20] = {0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00}; //referência para realimentação de estados;
volatile double vref = 6.00;
volatile double Pref = 0.4; //potência de referência  da CPL em p.u.
volatile double reade[8] = {0,0,0,32,0,0,0,10};
volatile double Rcarga = 4.0, control_dut1 = 0.00, control_dut2 = 0.00;
volatile int Vbuck1 = 0,Ibuck1 = 0,Pbuck2 = 0,Ibuck2 = 0; //duty cycle variable
volatile int leitura = 0, malha = 0, control = 0, cpl = 0; //Control flags 
volatile int key = 0, deltaT = 0, duty = 0, a0 = 0,a1 = 0,a2 = 0,a3 = 0,a4 = 0,b0 = 0,b1 = 0,b2 = 0,b3 = 0,b4 = 0,c0 = 0,c1 = 0,c2 = 0,c3 = 0,c4 = 0,d0 = 0,d1 = 0,d2 = 0,d3 = 0,d4 = 0; //
//static char  space = 32; 

void setup() {

  /*Serial.begin(115200);*/
  uart();
  /*zerar_vetores();*/
//  vref = 6.0; Rcarga = 4.0; /*Initial values*/
  definicao_entrada(); /*set pin to receive analog input*/
  WDT->WDT_MR = WDT_MR_WDDIS;/*disable watchdog!*/
  pwm_start(); /*start pwm signal*/
  startTimer(TC1,0,TC3_IRQn,525); /*function to start the timer counter and to call TC3_Handler to read input register*/ /* 84M/32/f_amostragem  5k=525 2k=1312*/
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
  
  PWM->PWM_DIS = PWM_DIS_CHID2 | PWM_DIS_CHID3;                        // Disable PWM channel 2
  
  // Select Instance=PWM; Signal=PWMH2 (channel 2); I/O Line=PC7 (P7, Arduino pin 39, see pinout diagram) ; Peripheral type =B
  PIOC->PIO_PDR |= PIO_PDR_P7;                          // Set the pin to the peripheral PWM, not the GPIO

  PIOC->PIO_ABSR |= PIO_PC7B_PWMH2;                     // 39 Set PWM pin perhipheral type B

  // Select Instance=PWM; Signal=PWMH3 (channel 3); I/O Line=PA20 (P9, Arduino pin 41, see pinout diagram) ; Peripheral=B
  PIOC->PIO_PDR |= PIO_PDR_P9;                          // Set the pin to the peripheral PWM, not the GPIO
  
  PIOC->PIO_ABSR |= PIO_PC9B_PWMH3;                    // 41 Set PWM pin perhipheral type B

  // Enable the PWM channel 2 (see datasheet page 973)

  PWM->PWM_CLK = PWM_CLK_PREA(0) | PWM_CLK_DIVA(42);    // Set the PWM clock rate to 2MHz (84MHz/42). Adjust DIVA for the resolution you are looking for

  PWM->PWM_CH_NUM[2].PWM_CMR = PWM_CMR_CPRE_CLKA;     // The period is left aligned, clock source as CLKA on channel 2

  PWM->PWM_CH_NUM[2].PWM_CPRD = 100;                             // Channel 2 : Set the PWM frequency 2MHz/(2 * CPRD) = F ;

  PWM->PWM_CH_NUM[2].PWM_CDTY = 100;                             // Channel 2: Set the PWM duty cycle to x%= (CDTY/ CPRD)  * 100 % ;

  PWM->PWM_CH_NUM[3].PWM_CMR = PWM_CMR_CPRE_CLKA;     // The period is left aligned, clock source as CLKA on channel 2

  PWM->PWM_CH_NUM[3].PWM_CPRD = 100;                             // Channel 3 : Set the PWM frequency 2MHz/(2 * CPRD) = F ;

  PWM->PWM_CH_NUM[3].PWM_CDTY = 100;                             // Channel 3: Set the PWM duty cycle to x%= (CDTY/ CPRD)  * 100 % ;

  
  PWM->PWM_ENA = PWM_ENA_CHID2 | PWM_ENA_CHID3;
  
  /*THE PROJECT NEEDED OF TWO PWM IN 10kHz*/
  /*PWM NEED TO START TO CPL IN RAMP INPUT*/
}
void TC3_Handler(){

    tratar_interrupcao(); 
    
    /*BUCK converter receive signal by analog input to buck*/
    while((ADC->ADC_ISR & ADC_CHER_CH11) == 0); //A9
    Vc_buck = ADC->ADC_CDR[11]*(5.0*3.3/4095.0); 
    while((ADC->ADC_ISR & ADC_CHER_CH12) == 0); //A10
    IL_buck = ADC->ADC_CDR[12]*(3.3/4095.0);
    IL_buck = (IL_buck-2.45)/0.185;

    /*  */
    while((ADC->ADC_ISR & ADC_CHER_CH13) == 0); //A11
    Vc_cpl = ADC->ADC_CDR[13]*(5.0*3.3/4095.0);
    while((ADC->ADC_ISR & ADC_CHER_CH7) == 0); //A0
    IL_cpl = ADC->ADC_CDR[7]*(3.3/4095.0);
    IL_cpl = (IL_cpl-2.45)/0.185;
    //Vc_buck = ADC->ADC_CDR[13]*(5.0*3.3/4095.0);
        /*BOOST converter
    receive signal by analog input to boost*/
      /*Vc_boost = ADC->ADC_LCDR[7];
      Ic_boost = ADC->ADC_LCDR[6];
*      Ir_boost = ADC->ADC_LCDR[5];
      Vs_boost = ADC->ADC_LCDR[4];*/
   //mostrar_sinal();

       /*Function where the input were received and insert in variable*/
    TC_GetStatus(TC1, 0);
}

void mostrar_sinal()
{ //voltar
    Vbuck1 = Vc_buck*100;
    a0 = Vbuck1/100 + 48;
    a1 = (Vbuck1/10)%10 +48;
    a2 = (Vbuck1/1)%10 +48;

    Ibuck1 = IL_buck*100;
    b0 = Ibuck1/100 + 48;
    b1 = (Ibuck1/10)%10 +48;
    b2 = (Ibuck1/1)%10 +48;

    Pbuck2 = ((Vc_cpl*Vc_cpl)/(Pb*4))*100;
    c0 = Pbuck2/100 + 48;
    c1 = (Pbuck2/10)%10 +48;
    c2 = (Pbuck2/1)%10 +48;

    Ibuck2 = IL_cpl*100;
    d0 = Ibuck2/100 + 48;
    d1 = (Ibuck2/10)%10 +48;
    d2 = (Ibuck2/1)%10 +48;
    
    volatile double reade[16] = {a0,a1,a2,32,b0,b1,b2,32,c0,c1,c2,32,d0,d1,d2,10};
    for (int i =0; i<16; i++)
    {
      while((UART_SR_TXRDY & UART->UART_SR)== 0);
        UART->UART_THR = reade[i];
    }  
        
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
  while ((UART_SR_RXBUFF && !UART_SR_RXRDY) == 1); /*wait for conversion by uart register*/
  key = UART->UART_RHR; /*receive serial message*/
  switch(key)
  {
    case 49: //1
    /*Receive signals from buck and boost converter*/ 
    leitura = 1; break;
    
    case 50: //2
    malha = 1; break; /*Call the function to work in open mash*/
    
    case 51: //3
    //while(duty <= 50) /*CPL acionada em MA*/
    cpl = 1;
    break; 
    
    case 52: //4
    malha = 2; control = 1;break; /*Call the function to execute chosen control strategy State feedback*/ 
         
    case 53: //5
    malha = 2; control = 4; break;

    case 54: //6
    malha = 2; control = 5; break;

    case 55: //7
    malha = 2; control = 6; break;

    case 56: //8
    malha = 2; control = 7; break;

    case 57: //9
    malha = 2; cpl = 1; break;
    
    case 115:  //s stop /*zero for all control flags*/
    leitura = 0; malha = 0; control = 0; cpl = 0;PWM->PWM_CH_NUM[2].PWM_CDTY = 100;PWM->PWM_CH_NUM[3].PWM_CDTY = 100;
    volatile double u[20] = {0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00};
    volatile double e[20] = {0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00};
    volatile double uCpl[20] = {0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00};
    volatile double eCpl[20] = {0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00};
    volatile double r1[20] = {0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00};    
    break;
  }

  if (leitura == 1)
  { mostrar_sinal();}    
    
  if (malha == 1) /*Call the function to work in open mash*/
  {open_loop();
   mostrar_sinal();}
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
  eCpl[0] = Pref - (Vc_buck*Vc_buck)/(4.0*Pb);
  
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
  else if (control == 4)
  {
    diophantine_control_m();
  }
  else if (control == 5)
  {
    lgr_control_m();
  }
  else if (control == 6)
  {
    lqr_control();
  }
  else if (control == 7)
  {
    lya_control();
  }
  else if (control == 8)
  {
    cplBuck_control_m();
  }
  else if (cpl == 1)
  {
    /*CPL control law*/
    cplBuck_control_m();
  }

  control_dut1 = 100.0 - u[0]*100.0;
  PWM->PWM_CH_NUM[2].PWM_CDTY = control_dut1;

  control_dut2 = 100.0 - uCpl[0]*100.0;
  PWM->PWM_CH_NUM[3].PWM_CDTY = control_dut2;
}

void sm_control()
{
  Ic_buck = IL_buck - Vc_buck/Rcarga; 
  u[0] = ((Vc_buck/Rcarga)/(Vc_buck*1))*(e[0]) - Ic_buck;
  if (u[0]>0.2)
  {
    u[0] = 1.0;
    }
  else if (u[0]<-0.2)
  {
    u[0] = 0.0;
  }
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

void diophantine_control_t() //Controle por equação diofantina utilizando aproximação tustin p/ o feeder
{
static double a = 0.7686;
static double b = -1.512;
static double c = 0.7629;

u[0] = u[4] + a*e[0] + b*e[2] + c*e[4];

 if (u[0]>1.0)
 {
   u[0] = 1.0;
 }
 else if (u[0]<0.0)
 {
   u[0] = 0.0;
 }
 
u[4]=u[2];
u[2]=u[0];  
e[4]=e[2];
e[2]=e[0];
}

void lgr_control_t() //Controle por LGR utilizando aproximação tustin p/ o feeder
{
static double a = 0.8205;
static double b = -1.589;
static double c = 0.7821;

u[0] = u[4] + a*e[0] + b*e[2] + c*e[4];

 if (u[0]>1.0)
 {
   u[0] = 1.0;
 }
 else if (u[0]<0.0)
 {
   u[0] = 0.0;
 }
 
u[4]=u[2];
u[2]=u[0];  
e[4]=e[2];
e[2]=e[0];
}

void diophantine_control_m() //Controle por equação diofantina utilizando aproximação matched p/ o feeder
{
static double a = 0.4774;//0.3825;
static double b = -0.9443;//-0.7526;
static double c = 0.4746;//0.3797;

u[0] = u[2] + (2.0*a+b)*e[0] + (-a+c)*e[2];

 if (u[0]>1.0)
 {
   u[0] = 1.0;
 }
 else if (u[0]<0.0)
 {
   u[0] = 0.0;
 }
 
u[2]=u[0];  
e[2]=e[0];
}

void lgr_control_m() //Controle por LGR utilizando aproximação matched p/ o feeder
{
static double a = 0.5086;//0.409;
static double b = -0.9927;//-0.7922;
static double c = 0.4894;//0.3898;

u[0] = u[2] + (2.0*a+b)*e[0] + (-a+c)*e[2];

 if (u[0]>1.0)
 {
   u[0] = 1.0;
 }
 else if (u[0]<0.0)
 {
   u[0] = 0.0;
 }
 
u[2]=u[0];  
e[2]=e[0];
}

void lqr_control() //Controle por LQR utilizando realimentação de estados;
{

static double k1 = 0.2161;//0.1735;//0.2522;
static double k2 = 0.065;//0.034;//0.7317;
static double c = 0.012;//0.025;//0.12;

 r1[0] = r1[2] + c*e[2];
 u[0] = r1[0] - k1*IL_buck - k2*Vc_buck;
 
 if (u[0]>1.0)
 {
   u[0] = 1.0;
 }
 else if (u[0]<0.0)
 {
   u[0] = 0.0;
 }
r1[2]=r1[0];  
e[2]=e[0];
}

void lya_control() //Controle por Lyapunov utilizando realimentação de estados;
{

static double k1 = 0.0455; //0.0427;
static double k2 = 0.0592;//0.0602;
static double c = 0.012;//0.015;

 r1[0] = r1[2] + c*e[2];
 u[0] = r1[0] - k1*IL_buck - k2*Vc_buck;
 
 if (u[0]>1.0)
 {
   u[0] = 1.0;
 }
 else if (u[0]<0.0)
 {
   u[0] = 0.0;
 }
r1[2]=r1[0];  
e[2]=e[0];
}


void cplBuck_control_t() //Controle por equação diofantina utilizando aproximação tustin p/ a CPL
{
static double a = 25.45;
static double b = -50.68;
static double c = 25.32;

uCpl[0] = uCpl[2] + a*eCpl[0] + b*eCpl[1] + c*eCpl[2];

 if (uCpl[0]>1.0)
 {
   uCpl[0] = 1.0;
 }
 else if (u[0]<0.0)
 {
   uCpl[0] = 0.0;
 }
 
uCpl[2]=u[1];
uCpl[1]=u[0];  
eCpl[2]=eCpl[1];
eCpl[1]=eCpl[0];
}

void cplBuck_control_m() //Controle por equação diofantina utilizando aproximação matched p/ a CPL
{
static double a = 12.71;
static double b = -25.32;
static double c = 12.64;

uCpl[0] = uCpl[1] + (2.0*a+b)*eCpl[0] + (-a+c)*eCpl[1];

 if (uCpl[0]>1.0)
 {
   uCpl[0] = 1.0;
 }
 else if (uCpl[0]<0.0)
 {
   uCpl[0] = 0.0;
 }
 
uCpl[1]=uCpl[0];  
eCpl[1]=eCpl[0];
}
