A = sym([ -2   1/2  -1/2   1/2;
           0  -3/2   1/2  -1/2;
           2   1/2  -9/2   1/2;
           2    1    -2    -2 ]);
[P,J] = jordan(A);

P = simplify(P)
J = simplify(J)