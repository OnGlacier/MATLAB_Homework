%%
syms t a;
x = a*(cos(t)+t*sin(t));
y = a*(sin(t)-t*cos(t));
dx = diff(x,t);
dy = diff(y,t);
ds = sqrt(dx^2+dy^2);
I1 = simplify(int((x^2+y^2)*ds,t,0,2*pi))

%%
clear;
syms a b c t;
x = c/a * cos(t);
y = c/b * sin(t);
dx = diff(x,t);
dy = diff(y,t);

P = y*x^3 + exp(y);
Q = x*y^3 + x*exp(y) - 2*y;
I2 = simplify(int(P*dx + Q*dy, t ,0, pi))
