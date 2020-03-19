function E=EnergyFunc(sigma, H, x)

% Write what it does ...

TestFunk = @(x) exp(-x.^2/(4.*sigma.^2));

psi = TestFunk(x).';

E = psi'*H*psi/(psi'*psi);