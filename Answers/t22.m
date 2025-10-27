clear; clc;

p = [592 381 273 55 48 37 23]';                              % 目标系数
w = [3534 2356 1767 589 528 451 304]';                       % 资源系数
B = 119567;                                                  % 右端项
n = numel(p);

f = -p;                              % intlinprog 是极小化,去负号
intcon = 1:n;                        % 全部为整数变量
A = w.';  b = B;                     % 单个不等式 w'*x <= B
Aeq = [];  beq = [];

lb = zeros(n,1);
ub = floor(B ./ w);                  % 合理上界，加速求解

opts = optimoptions('intlinprog', ...
    'Display','iter', ...            
    'CutGeneration','basic', ...
    'Heuristics','advanced');

[x_opt, fval_neg, exitflag, output] = intlinprog(f, intcon, A, b, Aeq, beq, lb, ub, opts);

obj = -fval_neg;                     % 最大目标值
slack = B - w.'*x_opt;               % 资源剩余
is_int = all(abs(x_opt - round(x_opt)) < 1e-9);

fprintf('\n=== 最优解 ===\n');
disp(table((1:n)', x_opt, 'VariableNames',{'var_index','x_opt'}));
fprintf('Max objective = %.0f\n', obj);
fprintf('Capacity used = %.0f / %.0f (slack = %.0f)\n', w.'*x_opt, B, slack);
fprintf('All integers? %d  (exitflag=%d)\n', is_int, exitflag);

% 连续松弛上界
[x_lp, fval_lp_neg] = linprog(f, A, b, Aeq, beq, lb, ub, optimoptions('linprog','Display','none'));
ub_lp = -fval_lp_neg;
fprintf('LP relaxation upper bound = %.6f;  integer optimum = %.6f\n', ub_lp, obj);
