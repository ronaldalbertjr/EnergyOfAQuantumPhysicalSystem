clear
close all;
clc;

%Starting constants
n = 200;
l = 20;
h = l/n;

%Setting up the space to plot the graph
X = linspace(-l/2, l/2, n);

%Finding the true minimal in order to compare with the aproximated one
[lowestEigenValue, H] = PlotLowestEigenValue2(X);

x = 4;
y = 3;
x1 = 1;
x2 = 1;

dx = 0.0001;
dy = 0.0001;
dx1 = 0.0001;
dx2 = 0.0001;
alpha = 0.001;

e = 1e-3;
g = [inf; inf; inf; inf];

while norm(g) > e
    f1 = EnergyFunc2(x - dx/2, y, x1, x2, H, X);
    f2 = EnergyFunc2(x + dx/2, y, x1, x2, H, X);
    gx = (f2 - f1)/dx;
    
    f1 = EnergyFunc2(x, y - dy/2, x1, x2, H, X);
    f2 = EnergyFunc2(x, y + dy/2, x1, x2,H, X);
    gy = (f2 - f1)/dy;
    
    f1 = EnergyFunc2(x, y, x1 - dx1/2, x2, H, X);
    f2 = EnergyFunc2(x, y, x1 + dx1/2, x2, H, X);
    gx1 = (f2 - f1)/dx1;
    
    f1 = EnergyFunc2(x, y, x1, x2 - dx2/2, H, X);
    f2 = EnergyFunc2(x, y, x1, x2 + dx2/2, H, X);
    gx2 = (f2 - f1)/dx2;
    
    g = [gx;gy;gx1;gx2];

    x = x - alpha * gx;
    y = y - alpha * gy;
    x1 = x1 - alpha * gx1;
    x2 = x2 - alpha * gx2;
    
end

EnergyFunc2(x, y, x1, x2, H, X)

error =  (1 - (EnergyFunc2(x,y,x1,x2,H,X)/lowestEigenValue)) * 100