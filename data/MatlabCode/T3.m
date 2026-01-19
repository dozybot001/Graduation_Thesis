clear;clc;close all;

%读取数据
Ps1=xlsread('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date2.xlsx','A2:A25');
Cs1=xlsread('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date2.xlsx','B2:B25');
Qs1=xlsread('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date2.xlsx','C2:C25');
Ps2=xlsread('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date2.xlsx','E2:E25');
Cs2=xlsread('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date2.xlsx','F2:F25');
Qs2=xlsread('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date2.xlsx','G2:G25');
Ps3=xlsread('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date2.xlsx','I2:I25');
Cs3=xlsread('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date2.xlsx','J2:J25');
Qs3=xlsread('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date2.xlsx','K2:K25');
Pb1=xlsread('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date2.xlsx','M2:M25');
Cb1=xlsread('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date2.xlsx','N2:N25');
Pb2=xlsread('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date2.xlsx','P2:P25');
Cb2=xlsread('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date2.xlsx','Q2:Q25');
Pb3=xlsread('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date2.xlsx','S2:S25');
Cb3=xlsread('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date2.xlsx','T2:T25');
Pb4=xlsread('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date2.xlsx','V2:V25');
Cb4=xlsread('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date2.xlsx','W2:W25');

fitnessfcn = @my_first_multi;
nvars = 7;
lb = [0,0,0,0,0,0,0];
ub = [1,1,1,1,1,1,1];
A = [];
b = [];
Aeq = [110,103,60,-38,-40,-60,-65];
beq = [0];
options = gaoptimset('ParetoFraction',0.7,'PopulationSize',200,'Generations',200,'StallGenLimit',200,'TolFun',1e-100,'PlotFcns',@gaplotpareto);

[x,fval] = gamultiobj(fitnessfcn,nvars, A,b,Aeq,beq,lb,ub,options);
