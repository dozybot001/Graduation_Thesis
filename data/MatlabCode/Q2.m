% 清除工作区
clear;clc;close all;

% 创建决策变量，即优化对象
x=sdpvar(1,2,3);
q1=0.6121*x(1)+0.6184*x(2)+0.9*x(3);
q2=0.4*x(1)+0.3*x(2)+0.9*x(3);
q3=0.3*x(1)+0.4669*x(2)+0.9*x(3);
q4=0.5364*x(1)+0.6558*x(2)+0.5329*x(3);
q5=0.6331*x(1)+0.6649*x(2)+0.9*x(3);
ep=0;
zr=zeros(1001,1);
x1r=zeros(1001,1);
x2r=zeros(1001,1);
x3r=zeros(1001,1);
epr=zeros(1001,1);

for i=1:1:211
    ep=0.001*(i-1)+0.17;
    C = [
        x(1)+x(2)+x(3)==1
        x>=0 & x<=1
        abs(q1-q2)<=ep
        abs(q1-q3)<=ep
        abs(q1-q4)<=ep
        abs(q1-q5)<=ep
        abs(q2-q3)<=ep
        abs(q2-q4)<=ep
        abs(q2-q5)<=ep
        abs(q3-q4)<=ep
        abs(q3-q5)<=ep
        abs(q4-q5)<=ep
    ];
    z = 0.5194*x(1)+0.5632*x(2)+0.8696*x(3);
    ops = sdpsettings('verbose',0,'solver','cplex');
    reuslt = optimize(C,-z);
    x1r(i)=x(1);
    x2r(i)=x(2);
    x3r(i)=x(3);
    zr(i)=z;
    epr(i)=ep;
    i
    disp('/211');
end

xlswrite('C:\Users\PC\Desktop\毕设\Calculate\Q-ep.xlsx',epr,'H2:H212');
xlswrite('C:\Users\PC\Desktop\毕设\Calculate\Q-ep.xlsx',x1r,'I2:I212');
xlswrite('C:\Users\PC\Desktop\毕设\Calculate\Q-ep.xlsx',x2r,'J2:J212');
xlswrite('C:\Users\PC\Desktop\毕设\Calculate\Q-ep.xlsx',x3r,'K2:K212');
xlswrite('C:\Users\PC\Desktop\毕设\Calculate\Q-ep.xlsx',zr,'L2:L212');

