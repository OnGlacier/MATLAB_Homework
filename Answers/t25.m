close all; clear; clc;

%% 情形 A
a = 0.2; b = 0.2; c = 5.7;
x0 = [0;0;0];                                   
opts = odeset('RelTol',1e-8,'AbsTol',1e-10,'MaxStep',0.05);

[tA, XA] = ode45(@(t,x) rhs(t,x,a,b,c), [0 200], x0, opts);

figure('Color','w','Position',[100 100 1100 430]);
tiledlayout(1,2,"Padding","compact","TileSpacing","compact");

nexttile; plot3(XA(:,1),XA(:,2),XA(:,3),'LineWidth',0.9); grid on;
xlabel('x'); ylabel('y'); zlabel('z'); view(45,30);
title('Rössler 3D：a=b=0.2, c=5.7');

nexttile; plot(XA(:,1),XA(:,2),'LineWidth',0.9); grid on; axis equal tight;
xlabel('x'); ylabel('y'); title('x–y 投影');

%% 情形 B
X0_aug = [0;0;0; 0.2;0.5;10];                   % [x;y;z;a;b;c]
[tB, XB]  = ode45(@rhs_aug, [0 150], X0_aug, opts);
xB = XB(:,1); yB = XB(:,2); zB = XB(:,3);

figure('Color','w','Position',[100 100 1100 500]);
tiledlayout(3,1,"Padding","compact","TileSpacing","compact");
nexttile; plot(tB,xB,'LineWidth',0.9); grid on; ylabel('x(t)');
title('时间历程：a=0.2, b=0.5, c=10');
nexttile; plot(tB,yB,'LineWidth',0.9); grid on; ylabel('y(t)');
nexttile; plot(tB,zB,'LineWidth',0.9); grid on; ylabel('z(t)'); xlabel('t');

figure('Color','w','Position',[100 100 560 460]);
plot3(xB,yB,zB,'LineWidth',0.9); grid on; view(45,28);
xlabel('x'); ylabel('y'); zlabel('z');
title('Rössler 3D：a=0.2, b=0.5, c=10');

%% 局部函数
function dx = rhs(~,x,a,b,c)
    X = x(1); Y = x(2); Z = x(3);
    dx = [ -Y - Z;
            X + a*Y;
            b + (X - c)*Z ];
end
function dX = rhs_aug(~,X)
    x = X(1); y = X(2); z = X(3);
    a = X(4); b = X(5); c = X(6);
    dX = [ -y - z;
            x + a*y;
            b + (x - c)*z;
            0; 0; 0 ];
end
