syms x y;
f1=x^2+y^2;
f2=(x-1)^2+(y-1)^2;

constr=[x+y<=1,x>=0,y>=0];

problem=optimproblem;
problem.Objective=[f1,f2];
problem.Constraints=constr;

options=optimoptions('cplex');
options.Display='iter';

[xopt,fval]=solve(problem,'Options',options);

disp('Best Consequence:');
disp(xopt);
disp('Target:');
disp(fval);
