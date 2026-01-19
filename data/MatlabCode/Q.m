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
zr=zeros(201,1);
x1r=zeros(201,1);
x2r=zeros(201,1);
x3r=zeros(201,1);
epr=zeros(201,1);

for i=1:1:201
    ep=0.0001*(i-1)+0.178;
    C = [
        x(1)+x(2)+x(3)==1
        x(1)<=0.5
        x(1)>=0.1
        x(2)<=0.5
        x(2)>=0.1
        x(3)<=0.45
        x(3)>=0.2
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
    disp('/201');
end

xlswrite('C:\Users\PC\Desktop\毕设\Calculate\Q-ep.xlsx',epr,'A2:A202');
xlswrite('C:\Users\PC\Desktop\毕设\Calculate\Q-ep.xlsx',x1r,'B2:B202');
xlswrite('C:\Users\PC\Desktop\毕设\Calculate\Q-ep.xlsx',x2r,'C2:C202');
xlswrite('C:\Users\PC\Desktop\毕设\Calculate\Q-ep.xlsx',x3r,'D2:D202');
xlswrite('C:\Users\PC\Desktop\毕设\Calculate\Q-ep.xlsx',zr,'E2:E202');
disp('Finished')
