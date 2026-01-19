clear;clc;close all
x = sdpvar(1,3);
z = 2*x(1) + 3*x(2) + x(3);
c = [x(1) + 4*x(2) + 2*x(3) >= 8
     3*x(1) + 2*x(2) >= 6
     x(1)>=0
     x(2)>=0
     x(3)>=0
     ];

result = optimize(c,z);

if result.problem == 0     % 求解成功
   xresult = value(x);
   zresult = value(z);
else
    disp("求解出错")    
end
