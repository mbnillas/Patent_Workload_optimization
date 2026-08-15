%% INTEGER LINEAR PROGRAMMING USING OPTIMVAR
clear; clc;

%% Define integer decision variables

N1 = optimvar('N1','LowerBound',1,'Type','integer');
N2 = optimvar('N2','LowerBound',0,'Type','integer');
N3 = optimvar('N3','LowerBound',2,'Type','integer');

x1c = optimvar('x1c','LowerBound',0,'Type','integer');
x2c = optimvar('x2c','LowerBound',0,'Type','integer');
x3c = optimvar('x3c','LowerBound',0,'Type','integer');

x1b = optimvar('x1b','LowerBound',0,'Type','integer');
x2b = optimvar('x2b','LowerBound',0,'Type','integer');
x3b = optimvar('x3b','LowerBound',0,'Type','integer');

%% Define optimization problem

prob = optimproblem( ...
    'Objective',N1+N2+N3, ...
    'ObjectiveSense','minimize');

%% Application disposal requirements

prob.Constraints.current = ...
    x1c + x2c + x3c >= 2500;

prob.Constraints.backlog = ...
    x1b + x2b + x3b >= 406;

%% Examiner workload capacity

prob.Constraints.newCapacity = ...
   5.56*x1c + 41.67*x1b <= 2000*N1;

prob.Constraints.juniorCapacity = ...
    4.76*x2c + 35.71*x2b <= 2000*N2;

prob.Constraints.seniorCapacity = ...
   4.17*x3c + 31.25*x3b <= 2000*N3;

%% Backlog Disposal Ratio

prob.Constraints.ratio1 = ...
    420*x1b==360*x2b;

prob.Constraints.ratio2 = ...
    480*x2b==420*x3b;

%% Current Disposal Ratio

prob.Constraints.ratio3 = ...
    420*x1c==360*x2c;

prob.Constraints.ratio4 = ...
    480*x2c==420*x3c;
%% Convert optimization problem to solver structure

problem = prob2struct(prob);

%% Solve using INTLINPROG

options = optimoptions('intlinprog', ...
    'Display','iter');

[sol,fval,exitflag,output] = intlinprog( ...
    problem.f, ...
    problem.intcon, ...
    problem.Aineq, ...
    problem.bineq, ...
    problem.Aeq, ...
    problem.beq, ...
    problem.lb, ...
    problem.ub, ...
    options);

%% Display results

if exitflag == 1

    disp('Optimal solution:');
    disp(sol);
    disp('Objective function value:');
    disp(fval);

    fprintf('\nOptimization succeeded.\n');

else

    fprintf('\nOptimization failed.\n');
    fprintf('Exit flag = %d\n',exitflag);

end