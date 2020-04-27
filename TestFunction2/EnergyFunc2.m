function E=EnergyFunc2(alpha,beta, x1, x2, H, x)

TestFunk = @(x) exp(-alpha.*(x-x1).^2 - beta.*(x-x2).^4);

psi = TestFunk(x).';

E = psi'*H*psi/(psi'*psi);