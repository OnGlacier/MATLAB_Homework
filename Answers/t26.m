clear; clc; close all;

% 初值 (给定于 t=1)
t0 = 1;
X0 = [  2;   4;   -2;   7;   6 ];  % [x(1); x'(1); y(1); y'(1); y''(1)]

% 时间区间
Tend = 20;           
opts = odeset('RelTol',1e-8,'AbsTol',1e-10,'MaxStep',0.01);

% 数值积分
[t, X] = ode45(@rhs, [t0 Tend], X0, opts);

% 取出量
x  = X(:,1);  xd = X(:,2);
y  = X(:,3);  yd = X(:,4);  ydd = X(:,5);

%% 作图：相平面/相空间
figure('Color','w','Position',[80 80 1150 430]);
tiledlayout(1,3,"Padding","compact","TileSpacing","compact");

% (a) x- x' 相平面
nexttile; plot(x, xd, 'LineWidth', 1.0);
grid on; xlabel('x'); ylabel('x''');
title('x - x'' 相平面');

% (b) y- y' 相平面
nexttile; plot(y, yd, 'LineWidth', 1.0);
grid on; xlabel('y'); ylabel('y''');
title('y - y'' 相平面');

% (c) 三维相空间 (x, y, y')
nexttile; plot3(x, y, yd, 'LineWidth', 1.0);
grid on; xlabel('x'); ylabel('y'); zlabel('y''');
title('相空间轨迹 (x, y, y'')'); view(45,30);

%% 时间历程，方便检查收敛/稳定性
figure('Color','w','Position',[100 100 1100 520]);
tiledlayout(3,1,"Padding","compact","TileSpacing","compact");
nexttile; plot(t, x,  t, y, 'LineWidth',1.0); grid on;
legend('x','y'); ylabel('states'); title('x(t), y(t)');
nexttile; plot(t, xd, t, yd, 'LineWidth',1.0); grid on;
legend('x''','y'''); ylabel('1st derivs');
nexttile; plot(t, ydd, 'LineWidth',1.0); grid on; ylabel('y'''''); xlabel('t');

%% 右端函数
function dX = rhs(t, X)
    x1 = X(1);  x2 = X(2);    % x, xdot
    y1 = X(3);  y2 = X(4);    % y, ydot
    y3 = X(5);                % yddot

    dX = zeros(5,1);
    dX(1) = x2;
    dX(2) = -x1 - y1 - (3*x2)^2 + (y2)^3 + 6*y2 + 2*t;
    dX(3) = y2;
    dX(4) = y3;
    % 若题目第二式右端应为  -y2 - xdot - exp(-x1) - t  ，把下面一行改成：
    % dX(5) = -y2 - x2 - exp(-x1) - t;
    dX(5) = -y2 - x1 - exp(-x1) - t;
end
