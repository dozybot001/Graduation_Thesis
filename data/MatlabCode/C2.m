clear;clc;close all;

%读取数据
Ps1=xlsread('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date2.xlsx',2,'A2:A25');
Cs1=xlsread('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date2.xlsx',2,'B2:B25');
Qs1=xlsread('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date2.xlsx',2,'C2:C25');
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
qb=ones(24:1);
p=ones(24,1);
ep=0;
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
	qb(i)=(s(1)*Ps1(i)*Qs1(i)+s(2)*Ps2(i)*Qs2(i)+s(3)*Ps3(i)*Qs3(i));
    p(i)=s(1)*Ps1(i)+s(2)*Ps2(i)+s(3)*Ps3(i);
end

%输出到excel
xlswrite('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date20.xlsx',ss1,'B2:B25');
xlswrite('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date20.xlsx',ss2,'C2:C25');
xlswrite('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date20.xlsx',ss3,'D2:D25');
xlswrite('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date20.xlsx',sb1,'E2:E25');
xlswrite('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date20.xlsx',sb2,'F2:F25');
xlswrite('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date20.xlsx',sb3,'G2:G25');
xlswrite('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date20.xlsx',sb4,'H2:H25');
xlswrite('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date20.xlsx',ber','I2:I25');
xlswrite('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date20.xlsx',qb','J2:J25');

pr=sum(p);
xlswrite('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date20.xlsx',pr,1,'K4');
dei=sum(ber)/pr;
xlswrite('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date20.xlsx',dei,1,'K6');
dqi=sum(qb)/pr;
xlswrite('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date20.xlsx',dqi,1,'K8');
IC1=sum(ss1.*Ps1.*Cs1);
xlswrite('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date20.xlsx',IC1,1,'B26');
IC2=sum(ss2.*Ps2.*Cs2);
xlswrite('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date20.xlsx',IC2,1,'C26');
IC3=sum(ss3.*Ps3.*Cs3);
xlswrite('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date20.xlsx',IC3,1,'D26');

disp('Finished!');
