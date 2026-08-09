% Define the decision variables
x1c = optimvar('x1c', 'LowerBound', 0);
x3c = optimvar('x3c', 'LowerBound', 0);
x1b = optimvar('x1b', 'LowerBound', 0);
x3b = optimvar('x3b', 'LowerBound', 0);
prob=optimproblem('Objective', 6*(2*x1c+3*x3c)+26*(2*x1b+3*x3b), 'ObjectiveSense', 'minimize');
% Add constraints to the optimization problem
prob.Constraints.c1=2*x1c+3*x3c>=760;
prob.Constraints.c2=2*x1b+3*x3b>=379;
prob.Constraints.c3=x1c+x1b>=180;
prob.Constraints.c4=x3c+x3b>=252;
prob.Constraints.c5=180*x3b==252*x1b;
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
