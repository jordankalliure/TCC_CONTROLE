%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all; close all; clf; clc;
%%Data to analyze
%T = 5;
% Ts = 20e-6;
% Nrow = 1;
% q = 0.5;
% L = 2e-3;
% C = 2000e-6;
% R = 4;
% Vs = 15;
% Vdes = 2;
% t = 1:0.1:T;
% Ic = 7; Vc = 20;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Plant of circuit
% iL = 0;
% Vc = 0;
% diL_dt = (1/L)*( Vs - Vc*(1-q) );
% dvc_dt = (1/C)*((-1/R)*Vc + iL*(1-q));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%coeficientes
% a1 = L*(Vdes/Vs); a0 = R*(Vs/Vdes);
% b1 = R*C; b0 = 2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Tranfer function of EPSAC
% Num = [-a1 a0];
% Dem = [b1 b0];
% Fcn_ctn = tf(Num,Dem);
% Fcn_dct = c2d(Fcn_ctn,Ts,'tustin');
% A_n = cell2mat(Fcn_dct.num);
% B_n = cell2mat(Fcn_dct.den);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Running scripts in simulink tool
sim('EPSAC_SM_BOOST')
sim('PI_sm_current_controller_boost')
sim('PI_SM_feedback_buck')
sim('EPSAC_SM_BUCK')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Output of EPSAC+SMC and PI+SMC controller in boost
figure(1)
subplot(2,1,1)
plot(tt,Vc,'r') 
grid;
hold on 
plot(tt1,Vc1,'b')
hold on
plot(tt,Vref,'k')
xlabel('time (s)');
ylabel('Output Voltage (V)');
title('EPSAC+SMC and PI+SMC Controller in boost converter');
legend({'EPSAC BOOST','PI BOOST','REFERÊNCIA'})
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Output of Control action in buck
subplot(2,1,2)
plot(tt,sw1,'r') 
grid;
hold on 
plot(tt1,sw2,'b')
xlabel('time (s)');
ylabel('Output Voltage (V)');
title(' Control Action in boost converter');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Output of PI+SMC and EPSAC+SMC controller in buck
figure(2)
subplot(2,1,1)
plot(tt2,Vc2,'r') 
grid;
hold on 
plot(tt3,Vc3,'b')
hold on
plot(tt3,Vref3,'k')
xlabel('time (s)');
ylabel('Output Voltage (V)');
title('PI+SMC and EPSAC+SMC Controller in buck converter');
legend({'PI BUCK','EPSAC BUCK','REFERÊNCIA'})
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Output of EPSAC+SM controller in buck
subplot(2,1,2)
plot(tt2,sw3,'r') 
grid;
hold on 
plot(tt3,sw4,'b')
xlabel('time (s)');
ylabel('Output Voltage (V)');
title('Control action in buck converter');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
d = [Vc;Vref];
e = sum(d,1);
plot(tt,e)
title('Isso aqui');