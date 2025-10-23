syms t x y;
f = @(x,y)int(exp(-t^2),t,0,x*y);

simplify(x/y*diff(f,x,2)-2*diff(diff(f,x),y)+diff(f,y,2))