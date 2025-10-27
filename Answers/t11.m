syms a b c d e;
v = [a b c d e];
A = vander(v);

simplify(det(A))