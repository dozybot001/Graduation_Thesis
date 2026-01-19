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
P3=xlsread('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date3.xlsx','I2:I25');
C3=xlsread('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date3.xlsx','J2:J25');
Q3=xlsread('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date3.xlsx','K2:K25');
% Q3=normrnd(0.6967,0.1,24,1);
% xlswrite('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date3.xlsx',Q3,'K2:K25');
D=xlsread('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date3.xlsx','M2:M25');

%创建优化变量-中标指数
s=sdpvar(3,1);
s1=zeros(24,1);
s2=zeros(24,1);
s3=zeros(24,1);

gcr=ones(24:1);
qb=ones(24:1);

ep=0;
epr=ones(533,1);
gcrr=ones(533,1);
qbr=ones(533,1);
dei=ones(533,1);
dqi=ones(533,1);

for k=1:1:534
	ep=0.001*(k-1);
	for i=1:1:24
		C=[
	        s>=0 & s<=1
	        s(1)*P1(i)+s(2)*P2(i)+s(3)*P3(i)==D(i)
	        s(1)*P1(i)*(Q1(i)-ep)+s(2)*P2(i)*(Q2(i)-ep)+s(3)*P3(i)*(Q3(i)-ep)>=0;
			];
		gc=s(1)*P1(i)*C1(i)+s(2)*P2(i)*C2(i)+s(3)*P3(i)*C3(i);
		ops = sdpsettings('verbose',0,'solver','cplex');
		reuslt = optimize(C,gc);
		s1(i)=s(1);s2(i)=s(2);s3(i)=s(3);gcr(i)=gc;
	end
	epr(k)=ep;
    gcrr(k)=sum(gcr);
	dei(k)=gcrr(k)/sum(D);
    qbr(k)=sum(s1.*P1.*Q1+s2.*P2.*Q2+s3.*P3.*Q3);
	dqi(k)=qbr(k)/sum(D);
    k
end

xlswrite('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date3.xlsx',epr,'T2:T535');
xlswrite('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date3.xlsx',gcrr,'U2:U535');
xlswrite('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date3.xlsx',dei,'V2:V535');
xlswrite('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date3.xlsx',qbr,'W2:W535');
xlswrite('C:\Program Files\Polyspace\R2020b\bin\MatlabCode\date3.xlsx',dqi,'X2:X535');

disp('Finished!');

