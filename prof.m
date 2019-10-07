clear all; clc;
Ts = 1e-3;
format long
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Simulation of system
sim('EPSAC_SM_BOOST');
sim('PI_sm_current_controller_boost');
sim('PI_SM_feedback_buck');
sim('EPSAC_SM_BUCK');

% Var conv Boost (SMC+EPSAC Boost)
er1_smcepsac_bo = Vref(1:(1/Ts)-1) - Vc(1:(1/Ts)-1);
er2_smcepsac_bo = Vref(1:(2/Ts)-1) - Vc(1:(2/Ts)-1);
er3_smcepsac_bo = Vref(1:(3/Ts)-1) - Vc(1:(3/Ts)-1);
er4_smcepsac_bo = Vref(1:(4/Ts)-1) - Vc(1:(4/Ts)-1);
er5_smcepsac_bo = Vref(1:(5/Ts)-1) - Vc(1:(5/Ts)-1);
% er6_smcepsac_bo = Vref(1:(6/Ts)-1) - Vc(1:(6/Ts)-1);

% Var conv Boost (SMC+PI Boost)

er1_smcpi_bo = Vref1(1:(1/Ts)-1) - Vc1(1:(1/Ts)-1);
er2_smcpi_bo = Vref1(1:(2/Ts)-1) - Vc1(1:(2/Ts)-1);
er3_smcpi_bo = Vref1(1:(3/Ts)-1) - Vc1(1:(3/Ts)-1);
er4_smcpi_bo = Vref1(1:(4/Ts)-1) - Vc1(1:(4/Ts)-1);
er5_smcpi_bo = Vref1(1:(5/Ts)-1) - Vc1(1:(5/Ts)-1);
% er6_smcpi_bo = Vref1(1:(6/Ts)-1) - Vc1(1:(6/Ts)-1);

% Var conv Buck (SMC+PI Bbuck)

er1_smcpi_bu = Vref2(1:(1/Ts)-1) - Vc3(1:(1/Ts)-1);
er2_smcpi_bu = Vref2(1:(2/Ts)-1) - Vc3(1:(2/Ts)-1);
er3_smcpi_bu = Vref2(1:(3/Ts)-1) - Vc3(1:(3/Ts)-1);
er4_smcpi_bu = Vref2(1:(4/Ts)-1) - Vc3(1:(4/Ts)-1);
er5_smcpi_bu = Vref2(1:(5/Ts)-1) - Vc3(1:(5/Ts)-1);
% er6_smcpi_bu = Vref2(1:(6/Ts)-1) - Vc3(1:(6/Ts)-1);

% Var conv Buck (SMC+EPSAC Buck)
er1_smcepsac_bu = Vref3(1:(1/Ts)-1) - Vc3(1:(1/Ts)-1);
er2_smcepsac_bu = Vref3(1:(2/Ts)-1) - Vc3(1:(2/Ts)-1);
er3_smcepsac_bu = Vref3(1:(3/Ts)-1) - Vc3(1:(3/Ts)-1);
er4_smcepsac_bu = Vref3(1:(4/Ts)-1) - Vc3(1:(4/Ts)-1);
er5_smcepsac_bu = Vref3(1:(5/Ts)-1) - Vc3(1:(5/Ts)-1);
% er6_smcepsac_bu = Vref3(1:(6/Ts)-1) - Vc3(1:(6/Ts)-1);

% Calculo do ISAE
% Var conv Boost (SMC+EPSAC Boost)
ISAE_e1_smcepsac_bo =  sum(abs(er1_smcepsac_bo));
ISAE_e2_smcepsac_bo =  sum(abs(er2_smcepsac_bo));
ISAE_e3_smcepsac_bo =  sum(abs(er3_smcepsac_bo));
ISAE_e4_smcepsac_bo =  sum(abs(er4_smcepsac_bo));
ISAE_e5_smcepsac_bo =  sum(abs(er5_smcepsac_bo));
% ISAE_e6_smcepsac_bo =  sum(abs(er6_smcepsac_bo));

ISAE_SMCEPSAC_BO = [ISAE_e1_smcepsac_bo ISAE_e2_smcepsac_bo ISAE_e3_smcepsac_bo ISAE_e4_smcepsac_bo ISAE_e5_smcepsac_bo]; % ISAE_e6_smcepsac_bo];

% Var conv Boost (SMC+EPSAC Boost)
ISAE_e1_smcpi_bo =  sum(abs(er1_smcpi_bo));
ISAE_e2_smcpi_bo =  sum(abs(er2_smcpi_bo));
ISAE_e3_smcpi_bo =  sum(abs(er3_smcpi_bo));
ISAE_e4_smcpi_bo =  sum(abs(er4_smcpi_bo));
ISAE_e5_smcpi_bo =  sum(abs(er5_smcpi_bo));
% ISAE_e6_smcpi_bo =  sum(abs(er6_smcpi_bo));
        
ISAE_SMCPI_BO = [ISAE_e1_smcpi_bo ISAE_e2_smcpi_bo ISAE_e3_smcpi_bo ISAE_e4_smcpi_bo ISAE_e5_smcpi_bo]; % ISAE_e6_smcpi_bo]


% Calculo do ISE
% Var conv Boost (SMC+EPSAC Boost)
ISE_e1_smcepsac_bo =  sum((er1_smcepsac_bo).^2);
ISE_e2_smcepsac_bo =  sum((er2_smcepsac_bo).^2);
ISE_e3_smcepsac_bo =  sum((er3_smcepsac_bo).^2);
ISE_e4_smcepsac_bo =  sum((er4_smcepsac_bo).^2);
ISE_e5_smcepsac_bo =  sum((er5_smcepsac_bo).^2);
% ISAE_e6_smcepsac_bo =  sum(abs(er6_smcepsac_bo));





% Plotando

%Var = [-2 -1 1 2 3]
Var = [1 2 -2 -1 -2]

plot(Var,ISAE_SMCEPSAC_BO,'bx-.','linewidth',1.5); hold on; grid on;
plot(Var,ISAE_SMCPI_BO,'rs--','linewidth',1.5);
xlabel('\Delta V (V)')
ylabel('Cost function - ISAE')
legend('SMC+EPSAC','SMC+PI','Location','NorthWest')
legend('boxoff')
title('Cost function - ISAE')


% tt = tt;
%         tit = 'IAE  of EPSAC BOOST';
%         tit1 = 'ITAE  of EPSAC BOOST';
%         tit2 = 'ISE  of EPSAC BOOST';
%         tit3 = 'ITSE  of EPSAC BOOST';
%     elseif a == 2
%         er2 = Vref1 - Vc1;
%         tt = tt1;
%         tit = 'IAE  of PI BOOST';
%         tit1 = 'ITAE  of PI BOOST';
%         tit2 = 'ISE  of PI BOOST';
%         tit3 = 'ITSE  of PI BOOST';
%     elseif a == 3
%         er3 = Vref2 - Vc2;
%         tt = tt2;
%         tit = 'IAE  of PI BUCK';
%         tit1 = 'ITAE  of PI BUCK';
%         tit2 = 'ISE  of PI BUCK';
%         tit3 = 'ITSE  of PI BUCK';
%     elseif a == 4
%         er4 = Vref3 - Vc3;
%         tt = tt3;
%         tit = 'IAE  of EPSAC BUCK';
%         tit1 = 'ITAE  of EPSAC BUCK';
%         tit2 = 'ISE  of EPSAC BUCK';
%         tit3 = 'ITSE  of EPSAC BUCK';
%     end
%         
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%Calculus to IAE,ITAE,ISE,ITSE to all systems  %%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% if a == 3 | a == 4
%     for i = 501:600
%         ITSEE1 = sum(er*(er')*i);
%         ITAE1 = abs(er)*i;
%     end
%     ITSEE1 = sum(ITSEE1);
%     ITAE1 = sum(ITAE1);
%     for j = 1001:1100
%         ITSEE2 = sum(er*(er')*j);
%         ITAE2 = abs(er)*j;
%     end
%     ITSEE2 = sum(ITSEE2);
%     ITAE2 = sum(ITAE2);
%     for k = 1501:1600
%         ITSEE3 = sum(er*(er')*k);
%         ITAE3 = abs(er)*k;
%     end
%     ITSEE3 = sum(ITSEE3);
%     ITAE3 = sum(ITAE3);
%     for l = 2001:2100
%         ITSEE4 = sum(er*(er')*l);
%         ITAE4 = abs(er)*l;
%     end
%     ITSEE4 = sum(ITSEE4);
%     ITAE4 = sum(ITAE4);
%     for m = 2501:2600
%         ITSEE5 = sum(er*(er')*m);
%         ITAE5 = abs(er)*m;
%     end
%     ITSEE5 = sum(ITSEE5);
%     ITAE5 = sum(ITAE5);
%     for n = 3001:3100
%         ITSEE6 = sum(er*(er')*n);
%         ITAE6 = abs(er)*n;
%     end
%     ITSEE6 = sum(ITSEE6);
%     ITAE6 = sum(ITAE6);
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     %% Vectors created to plot
%         ITSEE = [ITSEE5;ITSEE4;ITSEE3+ITSEE6;ITSEE1;ITSEE2];
%         ITAE = [ITAE5;ITAE4;ITAE3+ITAE6;ITAE1;ITAE2];
%         amp = [1;2;3;4;5];
% else
%     for i = 1001:1100
%         ITSEE1 = sum(er*(er')*i);
%         ITAE1 = abs(er)*i;
%     end
%     ITSEE1 = sum(ITSEE1);
%     ITAE1 = sum(ITAE1);
%     for j = 3001:3100
%         ITSEE2 = sum(er*(er')*j);
%         ITAE2 = abs(er)*j;
%     end
%     ITSEE2 = sum(ITSEE2);
%     ITAE2 = sum(ITAE2);
%     for k = 4001:4100
%         ITSEE3 = sum(er*(er')*k);
%         ITAE3 = abs(er)*k;
%     end
%     ITSEE3 = sum(ITSEE3);
%     ITAE3 = sum(ITAE3);
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     %%Vectors created to plot
%         ITSEE = [ITSEE3;ITSEE2;ITSEE1];
%         ITAE = [ITAE3;ITAE2;ITAE1];
%         amp = [20;23;25];
% end
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     IAE = abs(er);
%     figure()
%     subplot(2,1,1)
%     plot(tt,IAE,'r');
%     grid;
%     xlabel('tempo (s)');
%     ylabel(' Absolute Error value (V)');
%     title(tit);
% 
%     subplot(2,1,2)
%     p = plot(amp,ITAE,'b');
%     p.Marker = '*';
%     grid;
%     xlabel('amplitude (V)');
%     ylabel('Absolute Error value (V)');
%     title(tit1);
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     ISEE = sum(er*er');
%     figure()
%     subplot(2,1,1)
%     plot(tt,ISEE,'r');
%     grid;
%     xlabel('time (s)');
%     ylabel('Error value (V)');
%     title(tit2);
% 
%     subplot(2,1,2)
%     p = plot(amp,ITSEE,'b');
%     p.Marker = '*';
%     grid;
%     xlabel('amplitude (V)');
%     ylabel('Error value (V)');
%     title(tit3);
% end



    