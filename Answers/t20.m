syms c x;
J = simplify( int( (exp(x) - c*x)^2, x, 0, 1 ) );
dJ = diff(J, c);   
c_extreme = solve(dJ == 0, c)
J_min = simplify( subs(J, c, c_extreme) )
d2J = simplify( diff(J, c, 2) )   %极小值，凹函数，二阶导应该>0