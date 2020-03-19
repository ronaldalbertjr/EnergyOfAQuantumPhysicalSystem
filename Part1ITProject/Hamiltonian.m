clear

close all;
clc;
%Starting constants
n = 100;
l = 10;
s = 10;
w = 4;
Vo = -3;


h = l/n;

%Setting up the space to plot the graph
X = linspace(-l/2, l/2, n);

%Setting up the function
func = @(x) Vo./(exp(s*(abs(x) - w/2)) + 1);  
%func = @(x) (x.^2).*2;

%Setting up the matrix for aproximating the value of the second derivative
d2 = zeros(n,n);
d2(1,1)= -2;
d2(1,2) = 1;
d2(n,(n-1)) = 1;
d2(n,n) = -2;
for i = 2: n - 1
    d2(i, (i-1)) = 1;
    d2(i, i) = -2;
    d2(i, (i + 1)) = 1;
end

d2 = 1/h^2 * d2;
d2 = -1/2 * d2;

%Applying the equation
H = d2 + diag(func(X));
[V, E] = eig(H);

%Getting the lowest eigenvalue
[E, ind] = sort(diag(E));
V=V(:,ind);

lastValue = 99999999;
sigma = 0.00001;
count = 1;

%Plot
figure(1)
plot(X, abs(V(:,1))/sqrt(h),'k');

% Minimizing the sigma
for i = 0.01: 0.001: 10
    currValue = abs(EnergyFunc(i, H, X) - E(1,1));
    if  lastValue < currValue
        sigma = i;
        break;
    end
    lastValue = currValue;
end
 
% Plotting the test function
EnergyTestMinimal = EnergyFunc(sigma, H, X);
TestFunk = @(x) exp(-x.^2/(4.*sigma.^2));
psiTest = TestFunk(X);
normTestFunk = trapz(X, abs(psiTest).^2);
psiTest = psiTest/sqrt(normTestFunk); 
figure(1);
hold on;
plot(X, psiTest,'r');
hold off;
legend('From eig','Our test function')

for j = 0.01: 0.01: 2
    SIGMA(count) = j;
    En(count) = EnergyFunc(j, H, X);
    count = count + 1;
end

%hold on;
figure(2);
plot(SIGMA, En);
hold on
yline(E(1,1));
hold off;
axis([0 2 Vo 0])

error =  (1 - (EnergyTestMinimal/E(1,1))) * 100
