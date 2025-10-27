syms t s alpha;
assumeAlso(s > 0)
assumeAlso(alpha ~= 0)

%%
Fa = simplify(laplace(sin(alpha*t)/t, t, s))

%%
Fb = simplify(laplace(t^5*sin(alpha*t)))

%%
Fc = simplify(laplace(t^8*cos(alpha*t)))