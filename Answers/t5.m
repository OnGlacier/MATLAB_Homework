f = @(x,y) 1./sqrt((1-x).^2+y.^2)+1./sqrt((1+x).^2+y.^2);
[x,y] = meshgrid(linspace(-2,2,100));
z = f(x,y);
z(abs(x)==1 & y==0) = NaN;
subplot(2,2,1);
surf(x,y,z)
subplot(2,2,2);
mesh(x,y,z),view(90,0)
subplot(2,2,3);
mesh(x,y,z),view(0,0)
subplot(2,2,4);
mesh(x,y,z),view(0,90)
