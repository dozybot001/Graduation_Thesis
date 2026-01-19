clear;clc;close all;

%读取数据
Ps1=xlsread('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date1.xlsx','A2:A25');
Cs1=xlsread('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date1.xlsx','B2:B25');
Ps2=xlsread('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date1.xlsx','D2:D25');
Cs2=xlsread('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date1.xlsx','E2:E25');
Ps3=xlsread('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date1.xlsx','G2:G25');
Cs3=xlsread('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date1.xlsx','H2:H25');
Pb1=xlsread('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date1.xlsx','J2:J25');
Cb1=xlsread('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date1.xlsx','K2:K25');
Pb2=xlsread('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date1.xlsx','M2:M25');
Cb2=xlsread('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date1.xlsx','N2:N25');
Pb3=xlsread('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date1.xlsx','P2:P25');
Cb3=xlsread('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date1.xlsx','Q2:Q25');
Pb4=xlsread('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date1.xlsx','S2:S25');
Cb4=xlsread('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date1.xlsx','T2:T25');

%创建优化变量-中标指数
ss1=sdpvar(24,1);
ss2=sdpvar(24,1);
ss3=sdpvar(24,1);
sb1=sdpvar(24,1);
sb2=sdpvar(24,1);
sb3=sdpvar(24,1);
sb4=sdpvar(24,1);

%24次单优化
objr=ones(24:1);
for i=1:1:24
	C=[
        sb1(i)>=0 & sb1(i)<=1
		sb2(i)>=0 & sb2(i)<=1
		sb3(i)>=0 & sb3(i)<=1
		sb4(i)>=0 & sb4(i)<=1
		ss1(i)>=0 & ss1(i)<=1
		ss2(i)>=0 & ss2(i)<=1
		ss3(i)>=0 & ss3(i)<=1
        ss1(i)*Ps1(i)+ss2(i)*Ps2(i)+ss3(i)*Ps3(i)==sb1(i)*Pb1(i)+sb2(i)*Pb2(i)+sb3(i)*Pb3(i)+sb4(i)*Pb4(i)
		];
	obj=sb1(i)*Pb1(i)*Cb1(i)+sb2(i)*Pb2(i)*Cb2(i)+sb3(i)*Pb3(i)*Cb3(i)+sb4(i)*Pb4(i)*Cb4(i)-ss1(i)*Ps1(i)*Cs1(i)-ss2(i)*Ps2(i)*Cs2(i)-ss3(i)*Ps3(i)*Cs3(i);
	ops = sdpsettings('verbose',0,'solver','cplex');
	reuslt = optimize(C,-obj);
	objr(i)=obj;
end

%保存结果
ss1r=zeros(24,1);
ss2r=zeros(24,1);
ss3r=zeros(24,1);
sb1r=zeros(24,1);
sb2r=zeros(24,1);
sb3r=zeros(24,1);
sb4r=zeros(24,1);
for j=1:24
    ss1r(j)=ss1(j);
    ss2r(j)=ss2(j);
    ss3r(j)=ss3(j);
    sb1r(j)=sb1(j);
    sb2r(j)=sb2(j);
    sb3r(j)=sb3(j);
    sb4r(j)=sb4(j);
end

%找到边际电价
p=0;
pr=zeros(24,1);
for k=1:1:24
    if (sb1r(k)~=0 && sb1r(k)~=1)
        p=Cb1(k);
    end
    if (sb2r(k)~=0 && sb2r(k)~=1)
		p=Cb2(k);
    end
    if (sb3r(k)~=0 && sb3r(k)~=1)
		p=Cb3(k);
    end
    if (sb4r(k)~=0 && sb4r(k)~=1)
		p=Cb4(k);
    end
    if (ss1r(k)~=0 && ss1r(k)~=1)
		p=Cs1(k);
    end
    if (ss2r(k)~=0 && ss2r(k)~=1)
        p=Cs2(k);
    end
    if (ss3r(k)~=0 && ss3r(k)~=1)
       p=Cs3(k);
    end
    pr(k)=p;
end

%输出到excel
xlswrite('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date1.xlsx',ss1r,'C2:C25');
xlswrite('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date1.xlsx',ss2r,'F2:F25');
xlswrite('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date1.xlsx',ss3r,'I2:I25');
xlswrite('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date1.xlsx',sb1r,'L2:L25');
xlswrite('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date1.xlsx',sb2r,'O2:O25');
xlswrite('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date1.xlsx',sb3r,'R2:R25');
xlswrite('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date1.xlsx',sb4r,'U2:U25');
xlswrite('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date1.xlsx',objr','V2:V25');
xlswrite('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date1.xlsx',pr,'W2:W25');

%执行完毕反馈
if reuslt.problem == 0
    disp('Success');
else
    disp('Failue');
end