function [lowestEigenValue, HA] = PlotLowestEigenValue2(X)

n = size(X);
n = n(2);
l = abs(X(1)).* 2;
h = l/n;
s = 5;
w = 6;
Vo = -5;

%Setting up the function
func = @(x) Vo./(exp(s*(abs(x-1) - w/2)) + 1) + x.^2/50;  
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

%Plot
figure(1)
plot(X, func(X));

lowestEigenValue = E(1,1);
HA = H;
