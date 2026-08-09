% Define the decision variables
x1c = optimvar('x1c', 'LowerBound', 0);
x2c = optimvar('x2c', 'LowerBound', 0);
x3c = optimvar('x3c', 'LowerBound', 0);
x1b = optimvar('x1b', 'LowerBound', 0);
x2b = optimvar('x2b', 'LowerBound', 0);
x3b = optimvar('x3b', 'LowerBound', 0);
prob=optimproblem('Objective', 51*(17*x1c+10*x2c+7*x3c)+75*(17*x1b+10*x2b+7*x3b), 'ObjectiveSense', 'minimize');
% Add constraints to the optimization problem
prob.Constraints.c1=17*x1c+10*x2c+7*x3c>=2230;
prob.Constraints.c2=17*x1b+10*x2b+7*x3b>=414;
prob.Constraints.c3=x1c+x1b>=60;
prob.Constraints.c4=x2c+x2b>=72;
prob.Constraints.c5=x3c+x3b>=84;
prob.Constraints.c6=72*x1b==60*x2b;
prob.Constraints.c7=84*x1b==60*x3b;
problem = prob2struct(prob);
[sol,fval,exitflag,output]=linprog(problem) %[output:011a5ad9] %[output:0fa2f956] %[output:81eaedd5] %[output:7500cd17] %[output:7d1013c9]
% Display the results of the optimization
disp('Optimal solution:'); %[output:2781e741]
disp(sol); %[output:203ea3de]
disp('Objective function value:'); %[output:4795fc7b]
disp(fval); %[output:699c17b9]
% Check if the optimization was successful
if exitflag == 1 %[output:group:0677b1a2]
    fprintf('Optimization succeeded.\n'); %[output:34d4de15]
else
    fprintf('Optimization failed with exit flag: %d\n', exitflag);
end %[output:group:0677b1a2]

%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"onright","rightPanelPercent":30.7}
%---
%[output:011a5ad9]
%   data: {"dataType":"text","outputData":{"text":"\nOptimal solution found.\n\n","truncated":false}}
%---
%[output:0fa2f956]
%   data: {"dataType":"matrix","outputData":{"columns":1,"name":"sol","rows":6,"type":"double","value":[["10.6701"],["49.3299"],["12.8041"],["59.1959"],["14.9381"],["114.2047"]]}}
%---
%[output:81eaedd5]
%   data: {"dataType":"textualVariable","outputData":{"name":"fval","value":"144780"}}
%---
%[output:7500cd17]
%   data: {"dataType":"textualVariable","outputData":{"name":"exitflag","value":"1"}}
%---
%[output:7d1013c9]
%   data: {"dataType":"textualVariable","outputData":{"header":"struct with fields:","name":"output","value":"         iterations: 0\n    constrviolation: 0\n            message: 'Optimal solution found.'\n          algorithm: 'dual-simplex-highs'\n      firstorderopt: 0\n"}}
%---
%[output:2781e741]
%   data: {"dataType":"text","outputData":{"text":"Optimal solution:\n","truncated":false}}
%---
%[output:203ea3de]
%   data: {"dataType":"text","outputData":{"text":"   10.6701\n   49.3299\n   12.8041\n   59.1959\n   14.9381\n  114.2047\n\n","truncated":false}}
%---
%[output:4795fc7b]
%   data: {"dataType":"text","outputData":{"text":"Objective function value:\n","truncated":false}}
%---
%[output:699c17b9]
%   data: {"dataType":"text","outputData":{"text":"      144780\n\n","truncated":false}}
%---
%[output:34d4de15]
%   data: {"dataType":"text","outputData":{"text":"Optimization succeeded.\n","truncated":false}}
%---
