%% 1
syms x;
f1 = (3^x+9^x)^(1/x);
limit(f1,x,Inf)

%% 2
syms y;
f2 = x*y / (sqrt(x*y+1) - 1);
limit(limit(f2,x,0),y,0)

%% 3
f3 = (1 - cos(x^2 + y^2)) / ((x^2 + y^2) * exp(x^2 + y^2));
limit(limit(f3,x,0),y,0)