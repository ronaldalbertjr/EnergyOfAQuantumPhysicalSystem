clear
close all;
clc;
%Starting constants
n = 100;
l = 10;
h = l/n;

%Setting up the space to plot the graph
X = linspace(-l/2, l/2, n);

%Finding the true minimal in order to compare with the aproximated one
[lowestEigenValue, H] = PlotLowestEigenValue(X);

alpha = 0.00001;
count = 1;

% Minimizing the alpha
alpha = MinimizeFunction(@EnergyFunc, alpha, lowestEigenValue, H, X);
 
% Plotting the test function
EnergyTestMinimal = EnergyFunc(alpha, 0, H, X);
TestFunk = @(x) exp(-alpha.*x.^2);
psiTest = TestFunk(X);
normTestFunk = trapz(X, abs(psiTest).^2);
psiTest = psiTest/sqrt(normTestFunk); 
figure(1);
hold on;
plot(X, psiTest,'r');
hold off;
legend('From eig','Our test function')

for j = 0.01: 0.01: 2
    ALPHA(count) = j;
    En(count) = EnergyFunc(j, 0, H, X);
    count = count + 1;
end
figure(2);
plot(ALPHA, En);
hold on
yline(lowestEigenValue);
hold off;
axis([0 2 -3 0])

% Minimizing the alpha and beta
lowestPoint = SteepestDescent(@EnergyFunc, 3, 4, H, X);
x = lowestPoint(1);
y = lowestPoint(2);

%Plotting the EnergyFunction
figure(3);
x1 = linspace(x - l/2, x + l/2, n);
y1 = linspace(y - l/2, y + l/2, n);
[Y1, X1] = meshgrid(y1, x1);
F = EnergyFunc(X1, Y1, H, X);
surf(x1, y1, F);
hold on;
F2 = lowestEigenValue * ones(length(Y1), length(X1));
surf(X1, Y1, F2);
hold off;
 
%Printing the error
error1 =  (1 - (EnergyTestMinimal/lowestEigenValue)) * 100
error2 =  (1 - (EnergyFunc(x,y,H,X)/lowestEigenValue)) * 100
