syms t;
A = sym([ -9/2,  0,    1/2, -3/2;  
          -1/2, -4,   1/2, -1/2;    
           3/2,  1,  -5/2,  3/2;    
             0, -1,   -1,   -3 ]);  
EAt = simplify(exp(A*t))
sinAt = simplify(sin(A*t))
result = simplify(EAt*sin(A^2*EAt*t))