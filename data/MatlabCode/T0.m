% 清除工作区
clear;clc;close all;

% 创建决策变量，即优化对象
x = sdpvar(1,2);

% 添加约束条件
C = [
    x(1) + x(2)  >= 2
    x(2)-x(1) <=1
    x(1)<=1
    ];

% 目标函数
z = (x(1)+2*x(2))/(2*x(1)+x(2));

% 配置
ops = sdpsettings('verbose',0,'solver','cplex');

% 求解，yalmip默认求解最小值故加负号
reuslt = optimize(C,-z);

%输出，problem =0 代表求解成功
if reuslt.problem == 0
    value(x)
    value(z)
else
    disp('Error');

end