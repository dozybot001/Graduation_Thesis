clear;clc;close all;

%读取数据
P1=xlsread('‪C:\Users\PC\Desktop\Code\date3.xls','A2:A25');
C1=xlsread('‪C:\Users\PC\Desktop\Code\date3.xls','B2:B25');
Q1=xlsread('‪C:\Users\PC\Desktop\Code\date3.xls','C2:C25');
% Q1=normrnd(0.3545,0.1,24,1);
% xlswrite('‪C:\Users\PC\Desktop\Code\date3.xls',Q1,'C2:C25');
P2=xlsread('‪C:\Users\PC\Desktop\Code\date3.xls','E2:E25');
C2=xlsread('‪C:\Users\PC\Desktop\Code\date3.xls','F2:F25');
Q2=xlsread('‪C:\Users\PC\Desktop\Code\date3.xls','G2:G25');
% Q2=normrnd(0.6141,0.1,24,1);
% xlswrite('‪C:\Users\PC\Desktop\Code\date3.xls',Q2,'G2:G25');
P3=xlsread('‪C:\Users\PC\Desktop\Code\date3.xls','I2:I25');
C3=xlsread('‪C:\Users\PC\Desktop\Code\date3.xls','J2:J25');
Q3=xlsread('‪C:\Users\PC\Desktop\Code\date3.xls','K2:K25');
% Q3=normrnd(0.6967,0.1,24,1);
% xlswrite('‪C:\Users\PC\Desktop\Code\date3.xls',Q3,'K2:K25');
D=xlsread('‪C:\Users\PC\Desktop\Code\date3.xls','M2:M25');

%创建优化变量-中标指数
s=sdpvar(3,1);
s1=zeros(24,1);
s2=zeros(24,1);
s3=zeros(24,1);

%24次单优化
gcr=ones(24:1);
qb=ones(24:1);
ep=0;
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
xlswrite('‪C:\Users\PC\Desktop\Code\date3.xls',s1,'D2:D25');
xlswrite('‪C:\Users\PC\Desktop\Code\date3.xls',s2,'H2:H25');
xlswrite('‪C:\Users\PC\Desktop\Code\date3.xls',s3,'L2:L25');
xlswrite('‪C:\Users\PC\Desktop\Code\date3.xls',gcr','N2:N25');
xlswrite('‪C:\Users\PC\Desktop\Code\date3.xls',qb','O2:O25');

disp('Finished!');
