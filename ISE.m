clear all; clc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Simulation of system
%sim('EPSAC_SM_BOOST');
%sim('PI_sm_current_controller_boost');
sim('pi_sm_buck_variacao_carga');
sim('epsac_sm_buck_variacao_carga');
sim('sm_control_feedback_buck_variacao_carga');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Transitions in analisys                                   
%      i = 1:499
     i = 500:999
     j = 1e3:1499
     k = 2e3:2499
     l = 2.5e3:2999
     
var = [-2 -1 1 2];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     
% %% Values of errors to EPSAC+SMC boost 
%         er1_EPS_BO = Vref(i) - Vc(i);
%         er2_EPS_BO = Vref(j) - Vc(j);
%         er3_EPS_BO = Vref(k) - Vc(k);
%         er4_EPS_BO = Vref(l) - Vc(l);
% %         er5_EPS_BO = Vref(m) - Vc(m);
%         %er6_EPS_BO = Vref(n) - Vc(n);
% 
% %plot(er1_EPS_BO); hold on;        
% %plot(er2_EPS_BO);
% %plot(er3_EPS_BO);
% %plot(er4_EPS_BO);
% %plot(er5_EPS_BO);
% %plot(er6_EPS_BO);
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%Calculus to IAE,ITAE,ISE,ITSE to boost system %%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%         IAE1_EPS_BO = sum(abs(er1_EPS_BO));
%         ISEE1_EPS_BO = sum((er1_EPS_BO).^2);
%         ITSEE1_EPS_BO = sum(i*(er1_EPS_BO).^2);
%         ITAE1_EPS_BO = sum(i*abs(er1_EPS_BO));
%        
%     
%     IAE2_EPS_BO = sum(abs(er2_EPS_BO));
%         ISEE2_EPS_BO = sum((er2_EPS_BO).^2);
%         ITSEE2_EPS_BO = sum(j*(er2_EPS_BO).^2);
%         ITAE2_EPS_BO = sum(j*abs(er2_EPS_BO));
%     
%      
%         IAE3_EPS_BO = sum(abs(er3_EPS_BO));
%         ISEE3_EPS_BO = sum((er3_EPS_BO).^2);
%         ITSEE3_EPS_BO = sum(k*(er3_EPS_BO).^2);
%         ITAE3_EPS_BO = sum(k*abs(er3_EPS_BO));
%     
%    
%         IAE4_EPS_BO = sum(abs(er4_EPS_BO));
%         ISEE4_EPS_BO = sum((er4_EPS_BO).^2);
%         ITSEE4_EPS_BO = sum(l*(er4_EPS_BO).^2);
%         ITAE4_EPS_BO = sum(l*abs(er4_EPS_BO));
%     
% %      
% %         IAE5_EPS_BO = sum(abs(er5_EPS_BO));
% %         ISEE5_EPS_BO = sum((er5_EPS_BO).^2);
% %         ITSEE5_EPS_BO = sum(m*(er5_EPS_BO).^2);
% %         ITAE5_EPS_BO = sum(m*abs(er5_EPS_BO));
% %     
% %      
% %         IAE6_EPS_BO = sum(abs(er6_EPS_BO));
% %         ISEE6_EPS_BO = sum((er6_EPS_BO).^2);
% %         ITSEE6_EPS_BO = sum(n*(er6_EPS_BO).^2);
% %         ITAE6_EPS_BO = sum(n*abs(er6_EPS_BO));
% %     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     %% Vectors created to plot
%          IAE_EPS_BO = [IAE1_EPS_BO IAE2_EPS_BO IAE3_EPS_BO IAE4_EPS_BO];% IAE5_EPS_BO IAE6_EPS_BO]   
%          ISEE_EPS_BO = [ISEE1_EPS_BO ISEE2_EPS_BO ISEE3_EPS_BO ISEE4_EPS_BO];% ISEE5_EPS_BO ISEE6_EPS_BO]
%          ITSEE_EPS_BO = [ITSEE1_EPS_BO ITSEE2_EPS_BO ITSEE3_EPS_BO ITSEE4_EPS_BO];% ITSEE5_EPS_BO ITSEE6_EPS_BO];
%          ITAE_EPS_BO = [ITAE1_EPS_BO ITAE2_EPS_BO ITAE3_EPS_BO ITAE4_EPS_BO];% ITAE5_EPS_BO ITAE6_EPS_BO]; 
%          
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     
% %% Values of errors to PI+SMC boost 
%         er1_PI_BO = Vref1(i) - Vc1(i);
%         er2_PI_BO = Vref1(j) - Vc1(j);
%         er3_PI_BO = Vref1(k) - Vc1(k);
%         er4_PI_BO = Vref1(l) - Vc1(l);
% %         er5_PI_BO = Vref1(m) - Vc1(m);
% %         er6_PI_BO = Vref1(n) - Vc1(n);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%Calculus to IAE,ITAE,ISE,ITSE to BOOST system %%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%         IAE1_PI_BO = sum(abs(er1_PI_BO));
%         ISEE1_PI_BO = sum((er1_PI_BO).^2);
%         ITSEE1_PI_BO = sum(i*(er1_PI_BO).^2);
%         ITAE1_PI_BO = sum(i*abs(er1_PI_BO));
%        
%     
%         IAE2_PI_BO = sum(abs(er2_PI_BO));
%         ISEE2_PI_BO = sum((er2_PI_BO).^2);
%         ITSEE2_PI_BO = sum(j*(er2_PI_BO).^2);
%         ITAE2_PI_BO = sum(j*abs(er2_PI_BO));
%     
%      
%         IAE3_PI_BO = sum(abs(er3_PI_BO));
%         ISEE3_PI_BO = sum((er3_PI_BO).^2);
%         ITSEE3_PI_BO = sum(k*(er3_PI_BO).^2);
%         ITAE3_PI_BO = sum(k*abs(er3_PI_BO));
%     
%    
%         IAE4_PI_BO = sum(abs(er4_PI_BO));
%         ISEE4_PI_BO = sum((er4_PI_BO).^2);
%         ITSEE4_PI_BO = sum(l*(er4_PI_BO).^2);
%         ITAE4_PI_BO = sum(l*abs(er4_PI_BO));
%     
%      
% %         IAE5_PI_BO = sum(abs(er5_PI_BO));
% %         ISEE5_PI_BO = sum((er5_PI_BO).^2);
% %         ITSEE5_PI_BO = sum(m*(er5_PI_BO).^2);
% %         ITAE5_PI_BO = sum(m*abs(er5_PI_BO));
% %     
% %      
% %         IAE6_PI_BO = sum(abs(er6_PI_BO));
% %         ISEE6_PI_BO = sum((er6_PI_BO).^2);
% %         ITSEE6_PI_BO = sum(n*(er6_PI_BO).^2);
% %         ITAE6_PI_BO = sum(n*abs(er6_PI_BO));
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     %% Vectors created to plot
%          IAE_PI_BO = [IAE1_PI_BO IAE2_PI_BO IAE3_PI_BO IAE4_PI_BO];% IAE5_PI_BO IAE6_PI_BO]   
%          ISEE_PI_BO = [ISEE1_PI_BO ISEE2_PI_BO ISEE3_PI_BO ISEE4_PI_BO];% ISEE5_PI_BO ISEE6_PI_BO]
%          ITSEE_PI_BO = [ITSEE1_PI_BO ITSEE2_PI_BO ITSEE3_PI_BO ITSEE4_PI_BO];% ITSEE5_PI_BO ITSEE6_PI_BO];
%          ITAE_PI_BO = [ITAE1_PI_BO ITAE2_PI_BO ITAE3_PI_BO ITAE4_PI_BO];% ITAE5_PI_BO ITAE6_PI_BO];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     

%% Values of errors to PI+SMC buck output variation
        er1_PI_BU = Vref2(i) - Vc2(i);
        er2_PI_BU = Vref2(j) - Vc2(j);
        er3_PI_BU = Vref2(k) - Vc2(k);
        er4_PI_BU = Vref2(l) - Vc2(l);
%         er5_PI_BU = Vref2(m) - Vc2(m);
%         er6_PI_BU = Vref2(n) - Vc2(n);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Calculus to IAE,ITAE,ISE,ITSE to BUCK system %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
        IAE1_PI_BU = sum(abs(er1_PI_BU));
        ISEE1_PI_BU = sum((er1_PI_BU).^2);
        ITSEE1_PI_BU = sum(i*(er1_PI_BU).^2);
        ITAE1_PI_BU = sum(i*abs(er1_PI_BU));
       
    
        IAE2_PI_BU = sum(abs(er2_PI_BU));
        ISEE2_PI_BU = sum((er2_PI_BU).^2);
        ITSEE2_PI_BU = sum(j*(er2_PI_BU).^2);
        ITAE2_PI_BU = sum(j*abs(er2_PI_BU));
    
     
        IAE3_PI_BU = sum(abs(er3_PI_BU));
        ISEE3_PI_BU = sum((er3_PI_BU).^2);
        ITSEE3_PI_BU = sum(k*(er3_PI_BU).^2);
        ITAE3_PI_BU = sum(k*abs(er3_PI_BU));
    
   
        IAE4_PI_BU = sum(abs(er4_PI_BU));
        ISEE4_PI_BU = sum((er4_PI_BU).^2);
        ITSEE4_PI_BU = sum(l*(er4_PI_BU).^2);
        ITAE4_PI_BU = sum(l*abs(er4_PI_BU));
    
     
%         IAE5_PI_BU = sum(abs(er5_PI_BU));
%         ISEE5_PI_BU = sum((er5_PI_BU).^2);
%         ITSEE5_PI_BU = sum(m*(er5_PI_BU).^2);
%         ITAE5_PI_BU = sum(m*abs(er5_PI_BU));
%     
%      
%         IAE6_PI_BU = sum(abs(er6_PI_BU));
%         ISEE6_PI_BU = sum((er6_PI_BU).^2);
%         ITSEE6_PI_BU = sum(n*(er6_PI_BU).^2);
%         ITAE6_PI_BU = sum(n*abs(er6_PI_BU));
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Vectors created to plot
         IAE_PI_BU = [IAE1_PI_BU IAE2_PI_BU IAE3_PI_BU IAE4_PI_BU];% IAE5_PI_BU IAE6_PI_BU]   
         ISEE_PI_BU = [ISEE1_PI_BU ISEE2_PI_BU ISEE3_PI_BU ISEE4_PI_BU];% ISEE5_PI_BU ISEE6_PI_BU]
         ITSEE_PI_BU = [ITSEE1_PI_BU ITSEE2_PI_BU ITSEE3_PI_BU ITSEE4_PI_BU];% ITSEE5_PI_BU ITSEE6_PI_BU];
         ITAE_PI_BU = [ITAE1_PI_BU ITAE2_PI_BU ITAE3_PI_BU ITAE4_PI_BU];% ITAE6_PI_BU];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Values of errors to EPSAC+SMC buck voltage variation
        er1_EPS_Bu = Vref3(i) - Vc3(i);
        er2_EPS_Bu = Vref3(j) - Vc3(j);
        er3_EPS_Bu = Vref3(k) - Vc3(k);
        er4_EPS_Bu = Vref3(l) - Vc3(l);
%         er5_EPS_Bu = Vref3(m) - Vc3(m);
%         er6_EPS_Bu = Vref3(n) - Vc3(n);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Calculus to IAE,ITAE,ISE,ITSE to buck system %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
        IAE1_EPS_Bu = sum(abs(er1_EPS_Bu));
        ISEE1_EPS_Bu = sum((er1_EPS_Bu).^2);
        ITSEE1_EPS_Bu = sum(i*(er1_EPS_Bu).^2);
        ITAE1_EPS_Bu = sum(i*abs(er1_EPS_Bu));
       
    
        IAE2_EPS_Bu = sum(abs(er2_EPS_Bu));
        ISEE2_EPS_Bu = sum((er2_EPS_Bu).^2);
        ITSEE2_EPS_Bu = sum(j*(er2_EPS_Bu).^2);
        ITAE2_EPS_Bu = sum(j*abs(er2_EPS_Bu));
    
     
        IAE3_EPS_Bu = sum(abs(er3_EPS_Bu));
        ISEE3_EPS_Bu = sum((er3_EPS_Bu).^2);
        ITSEE3_EPS_Bu = sum(k*(er3_EPS_Bu).^2);
        ITAE3_EPS_Bu = sum(k*abs(er3_EPS_Bu));
    
   
        IAE4_EPS_Bu = sum(abs(er4_EPS_Bu));
        ISEE4_EPS_Bu = sum((er4_EPS_Bu).^2);
        ITSEE4_EPS_Bu = sum(l*(er4_EPS_Bu).^2);
        ITAE4_EPS_Bu = sum(l*abs(er4_EPS_Bu));
    
     
%         IAE5_EPS_Bu = sum(abs(er5_EPS_Bu));
%         ISEE5_EPS_Bu = sum((er5_EPS_Bu).^2);
%         ITSEE5_EPS_Bu = sum(m*(er5_EPS_Bu).^2);
%         ITAE5_EPS_Bu = sum(m*abs(er5_EPS_Bu));
%     
%      
%         IAE6_EPS_Bu = sum(abs(er6_EPS_Bu));
%         ISEE6_EPS_Bu = sum((er6_EPS_Bu).^2);
%         ITSEE6_EPS_Bu = sum(n*(er6_EPS_Bu).^2);
%         ITAE6_EPS_Bu = sum(n*abs(er6_EPS_Bu));
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Vectors created to plot
         IAE_EPS_Bu = [IAE1_EPS_Bu IAE2_EPS_Bu IAE3_EPS_Bu IAE4_EPS_Bu];% IAE5_EPS_Bu IAE6_EPS_Bu];
         ISEE_EPS_Bu = [ISEE1_EPS_Bu ISEE2_EPS_Bu ISEE3_EPS_Bu ISEE4_EPS_Bu];% ISEE5_EPS_Bu ISEE6_EPS_Bu];
         ITSEE_EPS_Bu = [ITSEE1_EPS_Bu ITSEE2_EPS_Bu ITSEE3_EPS_Bu ITSEE4_EPS_Bu];% ITSEE5_EPS_Bu ITSEE6_EPS_Bu];
         ITAE_EPS_Bu = [ITAE1_EPS_Bu ITAE2_EPS_Bu ITAE3_EPS_Bu ITAE4_EPS_Bu];% ITAE5_EPS_Bu ITAE6_EPS_Bu];
         
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Values of errors to SMC buck voltage variation
        er1_SMC_Bu = Vref6(i) - Vc6(i);
        er2_SMC_Bu = Vref6(j) - Vc6(j);
        er3_SMC_Bu = Vref6(k) - Vc6(k);
        er4_SMC_Bu = Vref6(l) - Vc6(l);
%         er5_EPS_Bu = Vref3(m) - Vc3(m);
%         er6_EPS_Bu = Vref3(n) - Vc3(n);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Calculus to IAE,ITAE,ISE,ITSE to buck system %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
        IAE1_SMC_Bu = sum(abs(er1_SMC_Bu));
        ISEE1_SMC_Bu = sum((er1_SMC_Bu).^2);
        ITSEE1_SMC_Bu = sum(i*(er1_SMC_Bu).^2);
        ITAE1_SMC_Bu = sum(i*abs(er1_SMC_Bu));
       
    
        IAE2_SMC_Bu = sum(abs(er2_SMC_Bu));
        ISEE2_SMC_Bu = sum((er2_SMC_Bu).^2);
        ITSEE2_SMC_Bu = sum(j*(er2_SMC_Bu).^2);
        ITAE2_SMC_Bu = sum(j*abs(er2_SMC_Bu));
    
     
        IAE3_SMC_Bu = sum(abs(er3_SMC_Bu));
        ISEE3_SMC_Bu = sum((er3_SMC_Bu).^2);
        ITSEE3_SMC_Bu = sum(k*(er3_SMC_Bu).^2);
        ITAE3_SMC_Bu = sum(k*abs(er3_SMC_Bu));
    
   
        IAE4_SMC_Bu = sum(abs(er4_SMC_Bu));
        ISEE4_SMC_Bu = sum((er4_SMC_Bu).^2);
        ITSEE4_SMC_Bu = sum(l*(er4_SMC_Bu).^2);
        ITAE4_SMC_Bu = sum(l*abs(er4_SMC_Bu));
    
     
%         IAE5_EPS_Bu = sum(abs(er5_EPS_Bu));
%         ISEE5_EPS_Bu = sum((er5_EPS_Bu).^2);
%         ITSEE5_EPS_Bu = sum(m*(er5_EPS_Bu).^2);
%         ITAE5_EPS_Bu = sum(m*abs(er5_EPS_Bu));
%     
%      
%         IAE6_EPS_Bu = sum(abs(er6_EPS_Bu));
%         ISEE6_EPS_Bu = sum((er6_EPS_Bu).^2);
%         ITSEE6_EPS_Bu = sum(n*(er6_EPS_Bu).^2);
%         ITAE6_EPS_Bu = sum(n*abs(er6_EPS_Bu));
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Vectors created to plot
         IAE_SMC_Bu = [IAE1_SMC_Bu IAE2_SMC_Bu IAE3_SMC_Bu IAE4_SMC_Bu];% IAE5_EPS_Bu IAE6_EPS_Bu];
         ISEE_SMC_Bu = [ISEE1_SMC_Bu ISEE2_SMC_Bu ISEE3_SMC_Bu ISEE4_SMC_Bu];% ISEE5_EPS_Bu ISEE6_EPS_Bu];
         ITSEE_SMC_Bu = [ITSEE1_SMC_Bu ITSEE2_SMC_Bu ITSEE3_SMC_Bu ITSEE4_SMC_Bu];% ITSEE5_EPS_Bu ITSEE6_EPS_Bu];
         ITAE_SMC_Bu = [ITAE1_SMC_Bu ITAE2_SMC_Bu ITAE3_SMC_Bu ITAE4_SMC_Bu];% ITAE5_EPS_Bu ITAE6_EPS_Bu]; 
         
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%lOAD VARIATION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Values of errors to PI+SMC buck load variation
        er1_PIC_BU = Vref5(i) - Vc5(i);
        er2_PIC_BU = Vref5(j) - Vc5(j);
        er3_PIC_BU = Vref5(k) - Vc5(k);
        er4_PIC_BU = Vref5(l) - Vc5(l);
%         er5_PI_BU = Vref2(m) - Vc2(m);
%         er6_PI_BU = Vref2(n) - Vc2(n);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Calculus to IAE,ITAE,ISE,ITSE to BUCK system %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
        IAE1_PIC_BU = sum(abs(er1_PIC_BU));
        ISEE1_PIC_BU = sum((er1_PIC_BU).^2);
        ITSEE1_PIC_BU = sum(i*(er1_PIC_BU).^2);
        ITAE1_PIC_BU = sum(i*abs(er1_PIC_BU));
       
    
        IAE2_PIC_BU = sum(abs(er2_PIC_BU));
        ISEE2_PIC_BU = sum((er2_PIC_BU).^2);
        ITSEE2_PIC_BU = sum(j*(er2_PIC_BU).^2);
        ITAE2_PIC_BU = sum(j*abs(er2_PIC_BU));
    
     
        IAE3_PIC_BU = sum(abs(er3_PIC_BU));
        ISEE3_PIC_BU = sum((er3_PIC_BU).^2);
        ITSEE3_PIC_BU = sum(k*(er3_PIC_BU).^2);
        ITAE3_PIC_BU = sum(k*abs(er3_PIC_BU));
    
   
        IAE4_PIC_BU = sum(abs(er4_PIC_BU));
        ISEE4_PIC_BU = sum((er4_PIC_BU).^2);
        ITSEE4_PIC_BU = sum(l*(er4_PIC_BU).^2);
        ITAE4_PIC_BU = sum(l*abs(er4_PIC_BU));
    
     
%         IAE5_PI_BU = sum(abs(er5_PI_BU));
%         ISEE5_PI_BU = sum((er5_PI_BU).^2);
%         ITSEE5_PI_BU = sum(m*(er5_PI_BU).^2);
%         ITAE5_PI_BU = sum(m*abs(er5_PI_BU));
%     
%      
%         IAE6_PI_BU = sum(abs(er6_PI_BU));
%         ISEE6_PI_BU = sum((er6_PI_BU).^2);
%         ITSEE6_PI_BU = sum(n*(er6_PI_BU).^2);
%         ITAE6_PI_BU = sum(n*abs(er6_PI_BU));
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Vectors created to plot
         IAE_PIC_BU = [IAE1_PIC_BU IAE2_PIC_BU IAE3_PIC_BU IAE4_PIC_BU];% IAE5_PI_BU IAE6_PI_BU]   
         ISEE_PIC_BU = [ISEE1_PIC_BU ISEE2_PIC_BU ISEE3_PIC_BU ISEE4_PIC_BU];% ISEE5_PI_BU ISEE6_PI_BU]
         ITSEE_PIC_BU = [ITSEE1_PIC_BU ITSEE2_PIC_BU ITSEE3_PIC_BU ITSEE4_PIC_BU];% ITSEE5_PI_BU ITSEE6_PI_BU];
         ITAE_PIC_BU = [ITAE1_PIC_BU ITAE2_PIC_BU ITAE3_PIC_BU ITAE4_PIC_BU];% ITAE6_PI_BU];
         
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     

%% Values of errors to EPSAC+SMC buck load variation
        er1_EPSC_Bu = Vref4(i) - Vc4(i);
        er2_EPSC_Bu = Vref4(j) - Vc4(j);
        er3_EPSC_Bu = Vref4(k) - Vc4(k);
        er4_EPSC_Bu = Vref4(l) - Vc4(l);
%         er5_EPS_Bu = Vref3(m) - Vc3(m);
%         er6_EPS_Bu = Vref3(n) - Vc3(n);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Calculus to IAE,ITAE,ISE,ITSE to boost system %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
        IAE1_EPSC_Bu = sum(abs(er1_EPSC_Bu));
        ISEE1_EPSC_Bu = sum((er1_EPSC_Bu).^2);
        ITSEE1_EPSC_Bu = sum(i*(er1_EPSC_Bu).^2);
        ITAE1_EPSC_Bu = sum(i*abs(er1_EPSC_Bu));
       
    
        IAE2_EPSC_Bu = sum(abs(er2_EPSC_Bu));
        ISEE2_EPSC_Bu = sum((er2_EPSC_Bu).^2);
        ITSEE2_EPSC_Bu = sum(j*(er2_EPSC_Bu).^2);
        ITAE2_EPSC_Bu = sum(j*abs(er2_EPSC_Bu));
    
     
        IAE3_EPSC_Bu = sum(abs(er3_EPSC_Bu));
        ISEE3_EPSC_Bu = sum((er3_EPSC_Bu).^2);
        ITSEE3_EPSC_Bu = sum(k*(er3_EPSC_Bu).^2);
        ITAE3_EPSC_Bu = sum(k*abs(er3_EPSC_Bu));
    
   
        IAE4_EPSC_Bu = sum(abs(er4_EPSC_Bu));
        ISEE4_EPSC_Bu = sum((er4_EPSC_Bu).^2);
        ITSEE4_EPSC_Bu = sum(l*(er4_EPSC_Bu).^2);
        ITAE4_EPSC_Bu = sum(l*abs(er4_EPSC_Bu));
    
     
%         IAE5_EPS_Bu = sum(abs(er5_EPS_Bu));
%         ISEE5_EPS_Bu = sum((er5_EPS_Bu).^2);
%         ITSEE5_EPS_Bu = sum(m*(er5_EPS_Bu).^2);
%         ITAE5_EPS_Bu = sum(m*abs(er5_EPS_Bu));
%     
%      
%         IAE6_EPS_Bu = sum(abs(er6_EPS_Bu));
%         ISEE6_EPS_Bu = sum((er6_EPS_Bu).^2);
%         ITSEE6_EPS_Bu = sum(n*(er6_EPS_Bu).^2);
%         ITAE6_EPS_Bu = sum(n*abs(er6_EPS_Bu));
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Vectors created to plot
         IAE_EPSC_Bu = [IAE1_EPSC_Bu IAE2_EPSC_Bu IAE3_EPSC_Bu IAE4_EPSC_Bu];% IAE5_EPS_Bu IAE6_EPS_Bu];
         ISEE_EPSC_Bu = [ISEE1_EPSC_Bu ISEE2_EPSC_Bu ISEE3_EPSC_Bu ISEE4_EPSC_Bu];% ISEE5_EPS_Bu ISEE6_EPS_Bu];
         ITSEE_EPSC_Bu = [ITSEE1_EPSC_Bu ITSEE2_EPSC_Bu ITSEE3_EPSC_Bu ITSEE4_EPSC_Bu];% ITSEE5_EPS_Bu ITSEE6_EPS_Bu];
         ITAE_EPSC_Bu = [ITAE1_EPSC_Bu ITAE2_EPSC_Bu ITAE3_EPSC_Bu ITAE4_EPSC_Bu];% ITAE5_EPS_Bu ITAE6_EPS_Bu]; 
         
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Values of errors to SMC buck load variation
        er1_SMCC_Bu = Vref7(i) - Vc7(i);
        er2_SMCC_Bu = Vref7(j) - Vc7(j);
        er3_SMCC_Bu = Vref7(k) - Vc7(k);
        er4_SMCC_Bu = Vref7(l) - Vc7(l);
%         er5_EPS_Bu = Vref3(m) - Vc3(m);
%         er6_EPS_Bu = Vref3(n) - Vc3(n);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Calculus to IAE,ITAE,ISE,ITSE to boost system %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
        IAE1_SMCC_Bu = sum(abs(er1_SMCC_Bu));
        ISEE1_SMCC_Bu = sum((er1_SMCC_Bu).^2);
        ITSEE1_SMCC_Bu = sum(i*(er1_SMCC_Bu).^2);
        ITAE1_SMCC_Bu = sum(i*abs(er1_SMCC_Bu));
       
    
        IAE2_SMCC_Bu = sum(abs(er2_SMCC_Bu));
        ISEE2_SMCC_Bu = sum((er2_SMCC_Bu).^2);
        ITSEE2_SMCC_Bu = sum(j*(er2_SMCC_Bu).^2);
        ITAE2_SMCC_Bu = sum(j*abs(er2_SMCC_Bu));
    
     
        IAE3_SMCC_Bu = sum(abs(er3_SMCC_Bu));
        ISEE3_SMCC_Bu = sum((er3_SMCC_Bu).^2);
        ITSEE3_SMCC_Bu = sum(k*(er3_SMCC_Bu).^2);
        ITAE3_SMCC_Bu = sum(k*abs(er3_SMCC_Bu));
    
   
        IAE4_SMCC_Bu = sum(abs(er4_SMCC_Bu));
        ISEE4_SMCC_Bu = sum((er4_SMCC_Bu).^2);
        ITSEE4_SMCC_Bu = sum(l*(er4_SMCC_Bu).^2);
        ITAE4_SMCC_Bu = sum(l*abs(er4_SMCC_Bu));
    
     
%         IAE5_EPS_Bu = sum(abs(er5_EPS_Bu));
%         ISEE5_EPS_Bu = sum((er5_EPS_Bu).^2);
%         ITSEE5_EPS_Bu = sum(m*(er5_EPS_Bu).^2);
%         ITAE5_EPS_Bu = sum(m*abs(er5_EPS_Bu));
%     
%      
%         IAE6_EPS_Bu = sum(abs(er6_EPS_Bu));
%         ISEE6_EPS_Bu = sum((er6_EPS_Bu).^2);
%         ITSEE6_EPS_Bu = sum(n*(er6_EPS_Bu).^2);
%         ITAE6_EPS_Bu = sum(n*abs(er6_EPS_Bu));
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Vectors created to plot
         IAE_SMCC_Bu = [IAE1_SMCC_Bu IAE2_SMCC_Bu IAE3_SMCC_Bu IAE4_SMCC_Bu];% IAE5_EPS_Bu IAE6_EPS_Bu];
         ISEE_SMCC_Bu = [ISEE1_SMCC_Bu ISEE2_SMCC_Bu ISEE3_SMCC_Bu ISEE4_SMCC_Bu];% ISEE5_EPS_Bu ISEE6_EPS_Bu];
         ITSEE_SMCC_Bu = [ITSEE1_SMCC_Bu ITSEE2_SMCC_Bu ITSEE3_SMCC_Bu ITSEE4_SMCC_Bu];% ITSEE5_EPS_Bu ITSEE6_EPS_Bu];
         ITAE_SMCC_Bu = [ITAE1_SMCC_Bu ITAE2_SMCC_Bu ITAE3_SMCC_Bu ITAE4_SMCC_Bu];% ITAE5_EPS_Bu ITAE6_EPS_Bu]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%SOURCE VARIATION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Values of errors to EPSAC+SMC buck source variation
        er1_EPS_Bu_source = Vref8(i) - Vc8(i);
        er2_EPS_Bu_source = Vref8(j) - Vc8(j);
        er3_EPS_Bu_source = Vref8(k) - Vc8(k);
        er4_EPS_Bu_source = Vref8(l) - Vc8(l);
% %         er5_EPS_Bu = Vref3(m) - Vc3(m); er6_EPS_Bu = Vref3(n) - Vc3(n);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%Calculus to IAE,ITAE,ISE,ITSE to buck system %%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%         IAE1_EPS_Bu_source = sum(abs(er1_EPS_Bu_source));
%         ISEE1_EPS_Bu_source = sum((er1_EPS_Bu_source).^2);
%         ITSEE1_EPS_Bu_source = sum(i*(er1_EPS_Bu_source).^2);
%         ITAE1_EPS_Bu_source = sum(i*abs(er1_EPS_Bu_source));
%        
%     
%         IAE2_EPS_Bu_source = sum(abs(er2_EPS_Bu_source));
%         ISEE2_EPS_Bu_source = sum((er2_EPS_Bu_source).^2);
%         ITSEE2_EPS_Bu_source = sum(j*(er2_EPS_Bu_source).^2);
%         ITAE2_EPS_Bu_source = sum(j*abs(er2_EPS_Bu_source));
%     
%      
%         IAE3_EPS_Bu_source = sum(abs(er3_EPS_Bu_source));
%         ISEE3_EPS_Bu_source = sum((er3_EPS_Bu_source).^2);
%         ITSEE3_EPS_Bu_source = sum(k*(er3_EPS_Bu_source).^2);
%         ITAE3_EPS_Bu_source = sum(k*abs(er3_EPS_Bu_source));
%     
%    
%         IAE4_EPS_Bu_source = sum(abs(er4_EPS_Bu_source));
%         ISEE4_EPS_Bu_source = sum((er4_EPS_Bu_source).^2);
%         ITSEE4_EPS_Bu_source = sum(l*(er4_EPS_Bu_source).^2);
%         ITAE4_EPS_Bu_source = sum(l*abs(er4_EPS_Bu_source));
%     
%      
% %         IAE5_EPS_Bu = sum(abs(er5_EPS_Bu)); ISEE5_EPS_Bu =
% %         sum((er5_EPS_Bu).^2); ITSEE5_EPS_Bu = sum(m*(er5_EPS_Bu).^2);
% %         ITAE5_EPS_Bu = sum(m*abs(er5_EPS_Bu));
% %     
% %      
% %         IAE6_EPS_Bu = sum(abs(er6_EPS_Bu)); ISEE6_EPS_Bu =
% %         sum((er6_EPS_Bu).^2); ITSEE6_EPS_Bu = sum(n*(er6_EPS_Bu).^2);
% %         ITAE6_EPS_Bu = sum(n*abs(er6_EPS_Bu));
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     %% Vectors created to plot
%          IAE_EPS_Bu = [IAE1_EPS_Bu_source IAE2_EPS_Bu_source IAE3_EPS_Bu_source IAE4_EPS_Bu_source];% IAE5_EPS_Bu IAE6_EPS_Bu];
%          ISEE_EPS_Bu = [ISEE1_EPS_Bu_source ISEE2_EPS_Bu_source ISEE3_EPS_Bu_source ISEE4_EPS_Bu_source];% ISEE5_EPS_Bu ISEE6_EPS_Bu];
%          ITSEE_EPS_Bu = [ITSEE1_EPS_Bu_source ITSEE2_EPS_Bu_source ITSEE3_EPS_Bu_source ITSEE4_EPS_Bu_source];% ITSEE5_EPS_Bu ITSEE6_EPS_Bu];
%          ITAE_EPS_Bu = [ITAE1_EPS_Bu_source ITAE2_EPS_Bu_source ITAE3_EPS_Bu_source ITAE4_EPS_Bu_source];% ITAE5_EPS_Bu ITAE6_EPS_Bu]; 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% %% Values of errors to PI+SMC buck source variation
%         er1_EPSC_Bu_source = Vref9(i) - Vc9(i);
%         er2_EPSC_Bu_source = Vref9(j) - Vc9(j);
%         er3_EPSC_Bu_source = Vref9(k) - Vc9(k);
%         er4_EPSC_Bu_source = Vref9(l) - Vc9(l);
% %         er5_EPS_Bu = Vref3(m) - Vc3(m); er6_EPS_Bu = Vref3(n) - Vc3(n);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%Calculus to IAE,ITAE,ISE,ITSE to boost system %%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%         IAE1_EPSC_Bu_source = sum(abs(er1_EPSC_Bu_source));
%         ISEE1_EPSC_Bu_source = sum((er1_EPSC_Bu_source).^2);
%         ITSEE1_EPSC_Bu_source = sum(i*(er1_EPSC_Bu_source).^2);
%         ITAE1_EPSC_Bu_source = sum(i*abs(er1_EPSC_Bu_source));
%        
%     
%         IAE2_EPSC_Bu_source = sum(abs(er2_EPSC_Bu_source));
%         ISEE2_EPSC_Bu_source = sum((er2_EPSC_Bu_source).^2);
%         ITSEE2_EPSC_Bu_source = sum(j*(er2_EPSC_Bu_source).^2);
%         ITAE2_EPSC_Bu_source = sum(j*abs(er2_EPSC_Bu_source));
%     
%      
%         IAE3_EPSC_Bu_source = sum(abs(er3_EPSC_Bu_source));
%         ISEE3_EPSC_Bu_source = sum((er3_EPSC_Bu_source).^2);
%         ITSEE3_EPSC_Bu_source = sum(k*(er3_EPSC_Bu_source).^2);
%         ITAE3_EPSC_Bu_source = sum(k*abs(er3_EPSC_Bu_source));
%     
%    
%         IAE4_EPSC_Bu_source = sum(abs(er4_EPSC_Bu_source));
%         ISEE4_EPSC_Bu_source = sum((er4_EPSC_Bu_source).^2);
%         ITSEE4_EPSC_Bu_source = sum(l*(er4_EPSC_Bu_source).^2);
%         ITAE4_EPSC_Bu_source = sum(l*abs(er4_EPSC_Bu_source));
%     
%      
% %         IAE5_EPS_Bu = sum(abs(er5_EPS_Bu)); ISEE5_EPS_Bu =
% %         sum((er5_EPS_Bu).^2); ITSEE5_EPS_Bu = sum(m*(er5_EPS_Bu).^2);
% %         ITAE5_EPS_Bu = sum(m*abs(er5_EPS_Bu));
% %     
% %      
% %         IAE6_EPS_Bu = sum(abs(er6_EPS_Bu)); ISEE6_EPS_Bu =
% %         sum((er6_EPS_Bu).^2); ITSEE6_EPS_Bu = sum(n*(er6_EPS_Bu).^2);
% %         ITAE6_EPS_Bu = sum(n*abs(er6_EPS_Bu));
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     %% Vectors created to plot
%          IAE_EPSC_Bu = [IAE1_EPSC_Bu_source IAE2_EPSC_Bu_source IAE3_EPSC_Bu_source IAE4_EPSC_Bu_source];% IAE5_EPS_Bu IAE6_EPS_Bu];
%          ISEE_EPSC_Bu = [ISEE1_EPSC_Bu_source ISEE2_EPSC_Bu_source ISEE3_EPSC_Bu_source ISEE4_EPSC_Bu_source];% ISEE5_EPS_Bu ISEE6_EPS_Bu];
%          ITSEE_EPSC_Bu = [ITSEE1_EPSC_Bu_source ITSEE2_EPSC_Bu_source ITSEE3_EPSC_Bu_source ITSEE4_EPSC_Bu_source];% ITSEE5_EPS_Bu ITSEE6_EPS_Bu];
%          ITAE_EPSC_Bu = [ITAE1_EPSC_Bu_source ITAE2_EPSC_Bu_source ITAE3_EPSC_Bu_source ITAE4_EPSC_Bu_source];% ITAE5_EPS_Bu ITAE6_EPS_Bu];
%          
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% %% Values of errors to SMC buck source variation
%         er1_SMCC_Bu_source = Vref10(i) - Vc10(i);
%         er2_SMCC_Bu_source = Vref10(j) - Vc10(j);
%         er3_SMCC_Bu_source = Vref10(k) - Vc10(k);
%         er4_SMCC_Bu_source = Vref10(l) - Vc10(l);
% %         er5_EPS_Bu = Vref3(m) - Vc3(m); er6_EPS_Bu = Vref3(n) - Vc3(n);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%Calculus to IAE,ITAE,ISE,ITSE to buck system %%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%         IAE1_SMCC_Bu_source = sum(abs(er1_SMCC_Bu_source));
%         ISEE1_SMCC_Bu_source = sum((er1_SMCC_Bu_source).^2);
%         ITSEE1_SMCC_Bu_source = sum(i*(er1_SMCC_Bu_source).^2);
%         ITAE1_SMCC_Bu_source = sum(i*abs(er1_SMCC_Bu_source));
%        
%     
%         IAE2_SMCC_Bu_source = sum(abs(er2_SMCC_Bu_source));
%         ISEE2_SMCC_Bu_source = sum((er2_SMCC_Bu_source).^2);
%         ITSEE2_SMCC_Bu_source = sum(j*(er2_SMCC_Bu_source).^2);
%         ITAE2_SMCC_Bu_source = sum(j*abs(er2_SMCC_Bu_source));
%     
%      
%         IAE3_SMCC_Bu_source = sum(abs(er3_SMCC_Bu_source));
%         ISEE3_SMCC_Bu_source = sum((er3_SMCC_Bu_source).^2);
%         ITSEE3_SMCC_Bu_source = sum(k*(er3_SMCC_Bu_source).^2);
%         ITAE3_SMCC_Bu_source = sum(k*abs(er3_SMCC_Bu_source));
%     
%    
%         IAE4_SMCC_Bu_source = sum(abs(er4_SMCC_Bu_source));
%         ISEE4_SMCC_Bu_source = sum((er4_SMCC_Bu_source).^2);
%         ITSEE4_SMCC_Bu_source = sum(l*(er4_SMCC_Bu_source).^2);
%         ITAE4_SMCC_Bu_source = sum(l*abs(er4_SMCC_Bu_source));
%     
%      
% %         IAE5_EPS_Bu = sum(abs(er5_EPS_Bu)); ISEE5_EPS_Bu =
% %         sum((er5_EPS_Bu).^2); ITSEE5_EPS_Bu = sum(m*(er5_EPS_Bu).^2);
% %         ITAE5_EPS_Bu = sum(m*abs(er5_EPS_Bu));
% %     
% %      
% %         IAE6_EPS_Bu = sum(abs(er6_EPS_Bu)); ISEE6_EPS_Bu =
% %         sum((er6_EPS_Bu).^2); ITSEE6_EPS_Bu = sum(n*(er6_EPS_Bu).^2);
% %         ITAE6_EPS_Bu = sum(n*abs(er6_EPS_Bu));
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Vectors created to plot
         IAE_SMCC_Bu = [IAE1_SMCC_Bu_source IAE2_SMCC_Bu_source IAE3_SMCC_Bu_source IAE4_SMCC_Bu_source];% IAE5_EPS_Bu IAE6_EPS_Bu];
         ISEE_SMCC_Bu = [ISEE1_SMCC_Bu_source ISEE2_SMCC_Bu_source ISEE3_SMCC_Bu_source ISEE4_SMCC_Bu_source];% ISEE5_EPS_Bu ISEE6_EPS_Bu];
         ITSEE_SMCC_Bu = [ITSEE1_SMCC_Bu_source ITSEE2_SMCC_Bu_source ITSEE3_SMCC_Bu_source ITSEE4_SMCC_Bu_source];% ITSEE5_EPS_Bu ITSEE6_EPS_Bu];
         ITAE_SMCC_Bu = [ITAE1_SMCC_Bu_source ITAE2_SMCC_Bu_source ITAE3_SMCC_Bu_source ITAE4_SMCC_Bu_source];% ITAE5_EPS_Bu ITAE6_EPS_Bu]
         
%      figure(1)
%      plot(tt7,Vc7,'linewidth',1.5);hold on; grid;
%      xlabel('time (s)')
%      ylabel('Output (V)')
%      legend('SMC','Location','NorthWest')
%      legend('boxoff')
%      title('Output Voltage')
    figure(2)   
    plot(var,ISEE_EPSC_Bu,'bx-.','linewidth',1.5);hold on; grid;
    plot(var,ISEE_PIC_BU,'rx--','linewidth',1.5);
    plot(var,ISEE_SMCC_Bu,'gx--','linewidth',1.5);
    xlabel('\Delta\Omega (\Omega)')
    ylabel('Cost function - ISE')
    legend('SMC+EPSAC','SMC+PI','SMC','Location','NorthWest')
    legend('boxoff')
    title('Cost function - ISE buck')
    figure(3)
    plot(var,ITSEE_EPSC_Bu,'bx-.','linewidth',1.5);hold on; grid;
    plot(var,ITSEE_PIC_BU,'rx--','linewidth',1.5);
    plot(var,ITSEE_SMCC_Bu,'gx--','linewidth',1.5)
    xlabel('\Delta\Omega (\Omega)')
    ylabel('Cost function - ITSE')
    legend('SMC+EPSAC','SMC+PI','SMC','Location','NorthWest')
    legend('boxoff')
    title('Cost function - ITSE buck')
    figure(4)
    plot(var,ITAE_EPSC_Bu,'bx-.','linewidth',1.5);hold on; grid;
    plot(var,ITAE_PIC_BU,'rx--','linewidth',1.5);
    plot(var,ITAE_SMCC_Bu,'gx--','linewidth',1.5)
    xlabel('\Delta\Omega (\Omega)')
    ylabel('Cost function - ITAE')
    legend('SMC+EPSAC','SMC+PI','SMC','Location','NorthWest')
    legend('boxoff')
    title('Cost function - ITAE buck')
    figure(5)
    plot(var,IAE_EPSC_Bu,'bx-.','linewidth',1.5);hold on; grid;
    plot(var,IAE_PIC_BU,'rx-.','linewidth',1.5);
    plot(var,IAE_SMCC_Bu,'gx-.','linewidth',1.5);
    xlabel('\Delta\Omega (\Omega)','Fontsize',14)
    ylabel('Cost function - IAE buck','Fontsize',14)
    legend('EPSAC+SMC','PI+SMC','SMC','Location','NorthWest')
    legend('boxoff')
    title('Cost function - IAE buck','Fontsize',14)