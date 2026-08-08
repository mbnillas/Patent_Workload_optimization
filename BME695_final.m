% Workload Analysis Linear Programming - Industrial Design Optimization
clc; clear;

% Personnel Counts
N_new = 1;   % New Examiner
N_sen = 2;   % Senior Examiners

% Turn-around Times (in months)
tat_c = 0.17; % Current application
tat_b = 5.83; % Backlog application

% Individual Annual Minimum Quotas (per examiner)
quota_ind_new = 360; % Annual quota per New Examiner
quota_ind_sen = 480; % Annual quota per Senior Examiner

% Total Group Minimum Quotas
quota_group_new = N_new * quota_ind_new; % 360
quota_group_sen = N_sen * quota_ind_sen; % 960
total_office_quota = quota_group_new + quota_group_sen; % 1320

% Target Disposals
target_c = 2500; % Current target
target_b = 406;  % Backlog target

% Objective Function Coefficients (Total effort in person-months)
% Variables vector x = [x_1c; x_1b; x_3c; x_3b]
f = [N_new * tat_c; 
    N_new * tat_b; 
    N_sen * tat_c; 
    N_sen * tat_b];

% Inequality Constraints Matrix (A * x <= b)
% Converted >= constraints to <= by multiplying by -1
A = [
    -N_new,      0, -N_sen,      0;  % Current target >= 2500
    0, -N_new,      0, -N_sen;  % Backlog target >= 406
    -1,     -1,      0,      0;  % New Examiner Individual Quota >= 360
    0,      0,     -1,     -1   % Senior Examiner Individual Quota >= 480
    ];

b = [-target_c; -target_b; -quota_ind_new; -quota_ind_sen];

% Lower Bounds
lb = zeros(4, 1);

% Solve Linear Program using linprog
options = optimoptions('linprog', 'Display', 'none');
[x, fval, exitflag] = linprog(f, A, b, [], [], lb, [], options);

% Display Results
if exitflag == 1
    fprintf('=== INDIVIDUAL EXAMINER ANNUAL QUOTAS ===\n');
    fprintf('New Examiner:    %d applications/year\n', quota_ind_new);
    fprintf('Senior Examiner: %d applications/year\n\n', quota_ind_sen);

    fprintf('=== OPTIMAL DISPOSAL PER INDIVIDUAL EXAMINER (Solver Basic Solution) ===\n');
    fprintf('New Examiner:    Current = %7.2f | Backlog = %7.2f | Total = %7.2f\n', x(1), x(2), x(1)+x(2));
    fprintf('Senior Examiner: Current = %7.2f | Backlog = %7.2f | Total = %7.2f\n\n', x(3), x(4), x(3)+x(4));

    fprintf('=== PROPORTIONAL DISPOSAL (Quota Ratio Allocation) ===\n');
    prop_new = quota_group_new / total_office_quota;
    prop_sen = quota_group_sen / total_office_quota;

    c_new_p = target_c * prop_new; b_new_p = target_b * prop_new;
    c_sen_p = target_c * prop_sen; b_sen_p = target_b * prop_sen;

    fprintf('New Group (%d):    Current = %7.2f | Backlog = %7.2f | Total = %7.2f\n', ...
        N_new, c_new_p, b_new_p, c_new_p + b_new_p);
    fprintf('Per New Examiner: Current = %7.2f | Backlog = %7.2f | Total = %7.2f\n', ...
        c_new_p/N_new, b_new_p/N_new, (c_new_p + b_new_p)/N_new);

    fprintf('Senior Group (%d): Current = %7.2f | Backlog = %7.2f | Total = %7.2f\n', ...
        N_sen, c_sen_p, b_sen_p, c_sen_p + b_sen_p);
    fprintf('Per Senior Exam: Current = %7.2f | Backlog = %7.2f | Total = %7.2f\n\n', ...
        c_sen_p/N_sen, b_sen_p/N_sen, (c_sen_p + b_sen_p)/N_sen);

    fprintf('=== TOTAL OFFICE SUMMARY ===\n');
    fprintf('Total Current Disposed: %7.2f applications\n', N_new*x(1) + N_sen*x(3));
    fprintf('Total Backlog Disposed: %7.2f applications\n', N_new*x(2) + N_sen*x(4));
    fprintf('Minimum Total Effort:   %7.2f person-months\n', fval);
else
    disp('Optimization failed to find a feasible solution.');
end

%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"onright"}
%---
