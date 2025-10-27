%%
syms t u(t)                           
ode1 = diff(u,t,2) + 2*t*diff(u,t) + t^2*u == t + 1;
u_general = simplify(dsolve(ode1)) 
%校验
res1 = simplify( subs(lhs(ode1)-rhs(ode1), u, u_general) )

%%
syms x y(x)
ode2 = diff(y,x) + 2*x*y == x*exp(-x^2);
y_general = simplify(dsolve(ode2))
%校验
res2 = simplify( subs(lhs(ode2)-rhs(ode2), y, y_general) )