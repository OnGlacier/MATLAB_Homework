t1 = [-1:0.0001:-0.0001,0.0001:0.0001:1];
y1 = sin(1./t1);
subplot(1,2,1);
plot(y1);
title("func1");
t2 = [-pi:0.0001:-pi/2-0.0001,-pi/2+0.0001:0.0001:pi/2-0.0001,pi/2+0.0001:0.0001:pi];
y2 = sin(tan(t2))-tan(sin(t2));
subplot(1,2,2);
plot(y2);
title("func2");

