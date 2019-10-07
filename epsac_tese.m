%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EPSAC applied to the Boost Converter %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Ns = 600; %Number of simulation steps
Ts = 20e-6; % Sampling time of the data
st = 50e-6;
beta= 0.98;
%%% Reference Definition %%%
DT = 20;
r = [0*ones(125,1);DT*ones(475,1)];
I_plant = 4.5*ones(Ns,1);
%I_plant = 2.38*ones(Ns,1);
%I_plant = 7.56*ones(Ns,1);
V_plant = 460*ones(Ns,1);
%V_plant = 330*ones(Ns,1);
%V_plant = 590*ones(Ns,1);
V_model = ones(Ns,1);
%%% Variables for Linear models %%%
uq = zeros(Ns,1);
yq = zeros(Ns,1);
ylin = zeros(Ns,1);
%for the boost linearized model V/I
L=1e-3;
C=100e-6;
R=200;
REF=460;
%REF=330;
REF=590;
%Vg=230;
Vdes=460;
%Vdes=330;
Vdes=590;
%transfer function Vo/I
num=[-((200e-6*230)/590) (R*230)/590];
den=[R*C 2];
Inom=4.5;
%Inom=2.38;
%Inom=7.56;
Ides=4.5;
%Ides=2.38;
%Ides=7.56;
I=0;
i=0;
%Datos nominales
Icoil=3.45;
%Icoil=1.68;
%Icoil=6.16;
Vcap=460;
%Vcap=330;
%Vcap=590;
State=[Icoil Vcap Icoil Vcap];
Si=2e-7;
Nrow=1;
Ni=round(Ts/Si);
% Transfer function
Tfq_cont = tf(num,den);
Tfq_disc = c2d(Tfq_cont,Ts);
B_q = cell2mat(Tfq_disc.num);
A_q = cell2mat(Tfq_disc.den);
bq0 = B_q(1); bq1 = B_q(2);
aq0 = A_q(1); aq1 = A_q(2);
Npm = zeros(Ns,1);
nf_p = 0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% MBPC design variables
N = 12; % Number of samples for prediction
Nu = 1; % Control horizon
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Uopt = zeros(Nu,1);
Ubase1 = 0;
Xbase1 = 0;
Xbase = zeros(N,1);
Nbase = zeros(N,1);
Ybase = zeros(N,1);
%%% G matrix computation %%%
h = impulse(Tfq_disc,Ts:Ts:Ts*30); %%
g = step(Tfq_disc,Ts:Ts:Ts*30); %%
i = 0; j = 0;
for i = 1:N,
for j = 1: Nu,
if 1-j+i <= 0
G(i,j) = 0;
else
if j < Nu
G(i,j) = h(1-j+i);
else
G(i,j) = g(1-j+i);
end
end
end
end
% K matrix %
K = inv(G'*G)*G';
%%% Simulation %%%
%second part%
for k = 3:Ns,
k
if k==125,
REF=610;
end;
if k==300,
Vg=180;
end;
if k==450,
R=150;
end;
%if k>750, Inom=Ides; end;
%%% Disturbance filter %%%
Taud = Ts/10;
ad = 0; %exp(-Ts/Taud);
bd = 1; %(1-ad);
%%%%%%%%%%%%%%%%%%%%%%%%%%
Nf(k-1) = ad*nf_p + bd*Npm(k-1);
nf_p = Nf(k-1);
Ubase1 = uq(k-2); %definition of the base control policy
Xbase1 = yq(k-1);
Rbase = r(k)*ones(N,1);
for i = 1:N,
Xbase(i) = -aq1*Xbase1+bq1*Ubase1;
Xbase1 = Xbase(i);
Nbase(i) = Nf(k-1);
Ybase(i) = Xbase(i) + Nbase(i);
end
Uopt = K*(Rbase-Ybase); % Computation of the optimal control law
uq(k-1) = Uopt(1)+ Ubase1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Non-linear plant response %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
I= uq(k-1)+Ides;
[T,State]=sim('plant_st',60e-6,simset('InitialState',State(Nrow,:)));
Nrow=size(State,1);
if State(Nrow,1)<0,
State(Nrow,1)=0;
end;
Icoil=State(Nrow,1); Vcap=State(Nrow,2);
nI = size(Ides,1);
Ides=Ides(nI,1);
I_plant(k)=Icoil;
V_plant(k)=Vcap;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Linear model response %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
u(k-1) = uq(k-1);
yq(k) = -aq1*yq(k-1)+bq1*u(k-1);
V_model(k)= yq(k)+Vdes;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Npm(k) = V_plant(k) - V_model(k); % error between plant and model
end % Simulation
ref = r+Vdes;
%time scaling
tim=1:1:Ns;
time=(tim/100)*2;
V_plant_460=V_plant;
I_plant_460=I_plant;
%ploting the results
subplot(2,1,1);
plot(time,V_plant_460);
xlabel('time (ms)');
ylabel('Output Voltage (V)');
Title('EPSAC+SMC Controller Performance');
subplot(2,1,2);
plot(time,I_plant_460);
xlabel('time (ms)');
ylabel('Inductor Current (A)');