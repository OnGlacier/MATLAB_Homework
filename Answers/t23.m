syms x y(x)
ode = diff(y,x,2) - (2 - 1/x)*diff(y,x) + (1 - 1/x)*y == x^2*exp(-5*x);

%% 通解
y_general = dsolve(ode);              
disp('General solution y(x) ='); pretty(y_general)

%% 解析解
y_bc = dsolve(ode, y(1)==sym(pi), y(sym(pi))==sym(1));
y_bc = simplify(y_bc);
disp('Boundary-value solution y(x) ='); pretty(y_bc)