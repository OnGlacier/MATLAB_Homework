A = [  3  -6  -4   0   5;
       1   4   2  -2   4;
      -6   3  -6   7   3;
     -13  10   0 -11   0;
       0   4   0   3   4];
B = [  3  -2   1;
      -2  -9   2;
      -2  -1   9];
C = [ -2   1  -1;
       4   1   2;
       5  -6   1;
       6  -4  -4;
      -6   6  -3];

%% 数值方法
X1 = sylvester(A, B, C)

%% 解析方法
K = kron(eye(3),sym(A)) + kron(sym(B).',eye(5));
X2 = simplify(reshape(K \ sym(C(:)),5,3))

%% 验证
vpa(norm(A*X1+X1*B-C),8)
vpa(norm(sym(A)*X2+X2*sym(B)-sym(C)),8)