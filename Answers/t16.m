syms s t a b;
assumeAlso(s > 0)
assumeAlso(a ~= b)

%%
Fa  = 1/(sqrt(s^2) * (s^2 - a^2) * (s + b));
fa  = simplify(ilaplace(Fa, s, t))

%%
Fb  = sqrt(s - a) - sqrt(s - b);
%fb  = simplify(simplify(ilaplace(Fb, s, t)))
assumeAlso(t > 0)
assumeAlso(s > a); assumeAlso(s > b);
fb_closed = -(exp(a*t) - exp(b*t)) / (2*sqrt(sym(pi))*t^(3/2))

%%
Fc  = log((s - a)/(s - b));
fc  = simplify(ilaplace(Fc, s, t))  