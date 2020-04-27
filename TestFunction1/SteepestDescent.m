function [S, xValues, yValues, zValues]=SteepestDescent(func,x0, y0, H, X)

x = x0;
y = y0;

count = 1; 

dx = 0.00001;
dy = 0.00001;
alpha = 0.01;

l = 1e-3;
g   = [inf; inf];

while norm(g) > l
    f1 = func(x - dx/2, y, H, X);
    f2 = func(x + dx/2, y, H, X);
    gx = (f2 - f1)/dx;
    
    f1 = func(x, y - dy/2, H, X);
    f2 = func(x, y + dy/2, H, X);
    gy = (f2 - f1)/dy;
    g = [gx;gy];
    
    x = x - alpha*gx;
    y = y - alpha*gy;
    
    xValues(count) = x;
    yValues(count) = y;
    zValues(count) = func(x, y, H, X);
    count = count + 1;
end
S = [x, y];