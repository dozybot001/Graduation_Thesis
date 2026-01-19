clear;clc;close all;

%读取数据
P1=xlsread('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date3.xlsx','A2:A25');
C1=xlsread('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date3.xlsx','B2:B25');
Q1=xlsread('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date3.xlsx','C2:C25');
% Q1=normrnd(0.3545,0.1,24,1);
% xlswrite('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date3.xlsx',Q1,'C2:C25');
P2=xlsread('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date3.xlsx','E2:E25');
C2=xlsread('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date3.xlsx','F2:F25');
Q2=xlsread('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date3.xlsx','G2:G25');
% Q2=normrnd(0.6141,0.1,24,1);
% xlswrite('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date3.xlsx',Q2,'G2:G25');
P3=xlsread('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date3.xlsx',2,'I2:I25');
C3=xlsread('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date3.xlsx',2,'J2:J25');
Q3=xlsread('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date3.xlsx',2,'K2:K25');
% Q3=normrnd(0.6967,0.1,24,1);
% xlswrite('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date3.xlsx',Q3,'K2:K25');
D=xlsread('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date3.xlsx','M2:M25');

%创建优化变量-中标指数
s=sdpvar(3,1);
s1=zeros(24,1);
s2=zeros(24,1);
s3=zeros(24,1);

%24次单优化
gcr=ones(24:1);
qb=ones(24:1);
ep=0.223;
for i=1:1:24
	C=[
        s>=0 & s<=1
        s(1)*P1(i)+s(2)*P2(i)+s(3)*P3(i)==D(i)
        s(1)*P1(i)*(Q1(i)-ep)+s(2)*P2(i)*(Q2(i)-ep)+s(3)*P3(i)*(Q3(i)-ep)>=0
		];
	gc=s(1)*P1(i)*C1(i)+s(2)*P2(i)*C2(i)+s(3)*P3(i)*C3(i);
	ops = sdpsettings('verbose',0,'solver','cplex');
	reuslt = optimize(C,gc);
	s1(i)=s(1);s2(i)=s(2);s3(i)=s(3);gcr(i)=gc;
	qb(i)=s(1)*P1(i)*Q1(i)+s(2)*P2(i)*Q2(i)+s(3)*P3(i)*Q3(i);
end

%输出到excel
xlswrite('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date30.xlsx',s1,'B2:B25');
xlswrite('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date30.xlsx',s2,'C2:C25');
xlswrite('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date30.xlsx',s3,'D2:D25');
xlswrite('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date30.xlsx',gcr','E2:E25');
xlswrite('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date30.xlsx',qb','F2:F25');
xlswrite('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date30.xlsx',ep,1,'G2');
dei=sum(gcr)/sum(D);
dqi=sum(qb)/sum(D);
xlswrite('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date30.xlsx',dei,1,'G4');
xlswrite('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date30.xlsx',dqi,1,'G6');
IC1=sum(s1.*P1.*C1);
IC2=sum(s2.*P2.*C2);
IC3=sum(s3.*P3.*C3);
xlswrite('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date30.xlsx',IC1,1,'B26');
xlswrite('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date30.xlsx',IC2,1,'C26');
xlswrite('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date30.xlsx',IC3,1,'D26');

disp('Finished!');
