syms t;
x = log(cos(t));
y = cos(t) - t*sin(t);

dxdt = diff(x,t);
dydt = diff(y,t);

dydx = simplify(dydt / dxdt)
d2ydx2 = simplify(diff(dydx,t) / dxdt);

t0 = sym(pi) / 3;
d2ydx2_t0 = simplify(subs(d2ydx2,t,t0))
%vpa(d2ydx2_t0,10)



