clear; clc; rng(1);

lb = [-10; -10];
ub = [ 10;  10];

opts = optimoptions('fmincon', ...
    'Algorithm','interior-point', ...
    'Display','iter', ...
    'SpecifyObjectiveGradient',true, ...
    'SpecifyConstraintGradient',true, ...
    'HessianFcn',@(x,lambda) hesslag(x,lambda), ...
    'OptimalityTolerance',1e-10, ...
    'StepTolerance',1e-12, ...
    'ConstraintTolerance',1e-12);

starts = [0 0; -2 1; 1 -2; -3 -1; -1 -3; 2 -2; 4 -4; -6 5; 5 -6];
bestF = inf; bestX = []; bestOut = []; bestLambda = [];

for i = 1:size(starts,1)
    x0 = starts(i,:).';
    [x,f,flag,out,lambda] = fmincon(@objfun, x0, [],[],[],[], lb,ub, @nlcons, opts);
    if flag > 0 && f < bestF
        bestF = f; bestX = x; bestOut = out; bestLambda = lambda;
    end
end

fprintf('\n===== 最优结果 =====\n');
x = bestX; f = bestF; lambda = bestLambda; out = bestOut;
fprintf('x* = [%.12g, %.12g]^T\n', x(1), x(2));
fprintf('f(x*) = %.12g\n', f);

% -------------- 可行性检查 --------------
[c,ceq] = nlcons(x);
fprintf('\n[可行性] 约束 c(x)<=0：\n'); disp(c);
fprintf('[可行性] |ceq(x)|：\n'); disp(abs(ceq));

% -------------- KKT 平稳性残差（忽略边界活跃项） --------------
[g] = objfun(x);              % 第二个输出是梯度
[~,~,GC] = nlcons(x);         % 非线性不等式梯度（2×3），按列为每个约束的梯度
gradL = g + GC*lambda.ineqnonlin;   % 拉格朗日梯度
fprintf('[KKT] ||∇_x L(x*,λ*)||_2 = %.3e\n', norm(gradL));

%% ========== 目标函数、梯度 ==========
function [f,g] = objfun(x)
    x1 = x(1); x2 = x(2);
    gpoly = 4*x1^2 + 2*x2^2 + 4*x1*x2 + 2*x2 + 1;
    ex1 = exp(x1);
    f = ex1 * gpoly;
    if nargout > 1
        g1 = ex1 * ( gpoly + 8*x1 + 4*x2 );    % ∂f/∂x1
        g2 = ex1 * ( 4*x2 + 4*x1 + 2 );        % ∂f/∂x2
        g = [g1; g2];
    end
end

%% ========== 非线性约束、梯度 ==========
function [c,ceq,GC,GE] = nlcons(x)
    x1 = x(1); x2 = x(2);
    c1 = x1 + x2;
    c2 = 1.5 + x1*x2 - x1 - x2;
    c3 = -10 - x1*x2;
    c = [c1; c2; c3];
    ceq = [];
    if nargout > 2

        GC = [ 1,       x2-1,   -x2;
               1,       x1-1,   -x1 ];
        GE = [];
    end
end

%% ========== 拉格朗日 Hessian ==========
% H = ∇²f + λ2*∇²c2 + λ3*∇²c3  (c1 二阶为 0)
function H = hesslag(x,lambda)
    x1 = x(1); x2 = x(2);
    gpoly = 4*x1^2 + 2*x2^2 + 4*x1*x2 + 2*x2 + 1;
    ex1 = exp(x1);
    % ∇²f
    H11 = ex1*( gpoly + 16*x1 + 8*x2 + 8 );
    H12 = ex1*( 4*x2 + 4*x1 + 6 );
    H22 = ex1*4;
    Hf  = [H11, H12; H12, H22];
    % ∇²c2 = [0 1; 1 0],  ∇²c3 = [0 -1; -1 0]
    H = Hf + (lambda.ineqnonlin(2) - lambda.ineqnonlin(3)) * [0 1; 1 0];
end