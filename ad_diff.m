function [u] = ad_diff(epsilon, x)

psi = 1;

u = 1/psi* (exp(-psi/epsilon) + (1 - exp(-psi/epsilon))*x - exp(x*psi/epsilon - psi/epsilon)) / (1 - exp(-psi/epsilon));

end 