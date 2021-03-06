function E=EnergyFunc(alpha,beta, H, x)

TestFunk = @(x) exp(-alpha.*x.^2 - beta.*x.^4);

psi = TestFunk(x).';

E = psi'*H*psi/(psi'*psi);