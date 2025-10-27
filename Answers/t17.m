syms x t w;

%%
f1 = piecewise(0 <= x & x <= 2*pi, x^2*(3*pi - 2*x), 0)
F1 = simplify( fourier(f1, x, w) )
f1_rec = simplify( ifourier(F1, w, x), 'IgnoreAnalyticConstraints', true )
check1 = f1_rec-f1
%%
f2 = piecewise(0 <= t & t <= 2*pi, t^2*(t - 2*pi)^2, 0)
F2 = simplify( fourier(f2, t, w) )
f2_rec = simplify( ifourier(F2, w, t), 'IgnoreAnalyticConstraints', true )
check2 = f2_rec-f2