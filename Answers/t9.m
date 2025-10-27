%%
syms k n;
t1 = 1 / ((2*k)^2 - 1);
S1 = simplify(symsum(t1,k,1,n));
S1_m = limit(S1,n,inf)

%%
t2 = 1 / (n^2 + k*n*sym(pi));
S2 = simplify(n*symsum(t2,k,1,n));
S2_m = simplify(limit(S2,n,inf))