% Define the decision variables
x1c = optimvar('x1c', 'LowerBound', 0);
x3c = optimvar('x3c', 'LowerBound', 0);
x1b = optimvar('x1b', 'LowerBound', 0);
x3b = optimvar('x3b', 'LowerBound', 0);
prob=optimproblem('Objective', 2*(x1c+2*x3c)+15*(x1b+2*x3b), 'ObjectiveSense', 'minimize');
% Add constraints to the optimization problem
prob.Constraints.c1=x1c+2*x3c>=2500;
prob.Constraints.c2=x1b+2*x3b>=406;
prob.Constraints.c3=x1c+x1b>=360;
prob.Constraints.c4=x3c+x3b>=480;
prob.Constraints.c5=480*x1b==360*x3b;
problem = prob2struct(prob);
[sol,fval,exitflag,output]=linprog(problem)
% Display the results of the optimization
disp('Optimal solution:');
disp(sol);
disp('Objective function value:');
disp(fval);
% Check if the optimization was successful
if exitflag == 1
    fprintf('Optimization succeeded.\n');
else
    fprintf('Optimization failed with exit flag: %d\n', exitflag);
end
