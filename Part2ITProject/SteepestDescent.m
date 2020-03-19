close all;
clc;

x0 = 3;
y0 = 4;

dx = 0.00001;
dy = 0.00001;
alpha = 0.0001;

l = 1e-3;
g   = [inf; inf];
while norm(g) > l
    f1 = func(x0 - dx/2, y0);
    f2 = func(x0 + dx/2, y0);
    gx = (f2 - f1)/dx;
    
    f1 = func(x0, y0 - dy/2);
    f2 = func(x0, y0 + dy/2);
    gy = (f2 - f1)/dy;
    g = [gx;gy];
    
    x0 = x0 + alpha*gx;
    y0 = y0 + alpha*gy;
    
end
[x0 y0]