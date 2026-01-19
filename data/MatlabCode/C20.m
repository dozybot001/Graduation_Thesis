clear;clc;close all;

%读取数据
Ps1=xlsread('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date2.xlsx','A2:A25');
Cs1=xlsread('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date2.xlsx','B2:B25');
Qs1=xlsread('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date2.xlsx','C2:C25');
% Qs1=normrnd(0.3545,0.1,24,1);
% xlswrite('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date2.xlsx',Qs1,'C2:C25');
Ps2=xlsread('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date2.xlsx','E2:E25');
Cs2=xlsread('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date2.xlsx','F2:F25');
Qs2=xlsread('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date2.xlsx','G2:G25');
% Qs2=normrnd(0.6141,0.1,24,1);
% xlswrite('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date2.xlsx',Qs2,'G2:G25');
Ps3=xlsread('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date2.xlsx','I2:I25');
Cs3=xlsread('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date2.xlsx','J2:J25');
Qs3=xlsread('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date2.xlsx','K2:K25');
% Qs3=normrnd(0.6967,0.1,24,1);
% xlswrite('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date2.xlsx',Qs3,'K2:K25');
Pb1=xlsread('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date2.xlsx','M2:M25');
Cb1=xlsread('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date2.xlsx','N2:N25');
Pb2=xlsread('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date2.xlsx','P2:P25');
Cb2=xlsread('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date2.xlsx','Q2:Q25');
Pb3=xlsread('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date2.xlsx','S2:S25');
Cb3=xlsread('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date2.xlsx','T2:T25');
Pb4=xlsread('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date2.xlsx','V2:V25');
Cb4=xlsread('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date2.xlsx','W2:W25');

%创建优化变量-中标指数,s1~b4
s=sdpvar(7,1);
ss1=zeros(24,1);
ss2=zeros(24,1);
ss3=zeros(24,1);
sb1=zeros(24,1);
sb2=zeros(24,1);
sb3=zeros(24,1);
sb4=zeros(24,1);

%24次单优化
ber=ones(24:1);
qi=ones(24:1);
p=ones(24,1);
epr=ones(115,1);
dei=ones(115,1);
dqi=ones(115,1);
berr=ones(115,1);
pr=ones(115,1);
qir=ones(115,1);

for k=1:1:115
	ep=0.005*(k-1);
	for i=1:1:24
		C=[
	        s>=0 & s<=1
	        s(1)*Ps1(i)+s(2)*Ps2(i)+s(3)*Ps3(i)==s(4)*Pb1(i)+s(5)*Pb2(i)+s(6)*Pb3(i)+s(7)*Pb4(i)
	        s(1)*Ps1(i)*(Qs1(i)-ep)+s(2)*Ps2(i)*(Qs2(i)-ep)+s(3)*Ps3(i)*(Qs3(i)-ep)>=0;
			];
		be=s(4)*Pb1(i)*Cb1(i)+s(5)*Pb2(i)*Cb2(i)+s(6)*Pb3(i)*Cb3(i)+s(7)*Pb4(i)*Cb4(i)-s(1)*Ps1(i)*Cs1(i)-s(2)*Ps2(i)*Cs2(i)-s(3)*Ps3(i)*Cs3(i);
		ops = sdpsettings('verbose',0,'solver','cplex');
		reuslt = optimize(C,-be);
		ss1(i)=s(1);ss2(i)=s(2);ss3(i)=s(3);sb1(i)=s(4);sb2(i)=s(5);sb3(i)=s(6);sb4(i)=s(7);ber(i)=be;
		qi(i)=(s(1)*Ps1(i)*Qs1(i)+s(2)*Ps2(i)*Qs2(i)+s(3)*Ps3(i)*Qs3(i))/(s(1)*Ps1(i)+s(2)*Ps2(i)+s(3)*Ps3(i));
	end
	epr(k)=ep;
    berr(k)=sum(ber);
    pr(k)=sum(ss1.*Ps1+ss2.*Ps2+ss3.*Ps3);
	dei(k)=10*berr(k)/pr(k);
    qir(k)=sum(ss1.*Ps1.*Qs1+ss2.*Ps2.*Qs2+ss3.*Ps3.*Qs3);
	dqi(k)=qir(k)/pr(k);
    k
end

xlswrite('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date2.xlsx',epr,'AC2:AC116');
xlswrite('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date2.xlsx',dei,'AD2:AD116');
xlswrite('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date2.xlsx',dqi,'AE2:AE116');
xlswrite('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date2.xlsx',berr,'AF2:AF116');
xlswrite('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date2.xlsx',pr,'AG2:AG116');
xlswrite('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date2.xlsx',qir,'AH2:AH116');

disp('Finished!');

