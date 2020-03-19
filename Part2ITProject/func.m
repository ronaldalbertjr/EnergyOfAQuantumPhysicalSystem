function E=EnergyFunc(sigma)

% Write what it does ...

%Starting constants
n = 1000;
l = 20;
s = 10;
w = 4;
Vo = -3;

TestFunk = @(x) exp(-x.^2/(4.*sigma.^2));

h = l/n;

%Setting up the space to plot the graph
X = linspace(-l/2, l/2, n).';

%Setting up the function
func = @(x) Vo./(exp(s*(abs(x) - w/2)) + 1);  

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

psi = TestFunk(X);

E = psi'*H*psi/(psi'*psi);