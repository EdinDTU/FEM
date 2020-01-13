function [u] = BVP1D_e(L, c, d, x, epsilon, psi, plot1)
% Purpose: Solve second-order boundary value problem using FEM.
% Author(s): Edin Sadikovic, Mikkel Gronning, Ida Riis Jensen 

%% INPUT PARAMETERS
%     L : Domain length
%     c : Left boundary condition
%     d : Right boundary condition
%     x : 1D mesh vector x(1:{M})
%epsilon: Coefficient vector, e_i > 0
%   psi : Real-valued constant on ]0,1[

%% GLOBAL ASSEMBLY
% Assemble A (the upper triangle only) and b. (Algorithm 1)

% Defining M
M = length(x);

% Allocating SPARSE storage for A and FULL for b
A = spalloc(M, M, M*3); 
b = zeros(M,1);
k = zeros(2,2,M); 
h = diff(x);

% Constructing the upper triangle of A
for i = 1:M-1
    % Using equation (1.26)
    k(1,1,i) = psi/2 + epsilon/h(i);
    k(1,2,i) = psi/2 - epsilon/h(i);
    k(2,1,i) = -psi/2 - epsilon/h(i);
    k(2,2,i) = -psi/2 + epsilon/h(i);
    
    A(i, i) = A(i,i) + k(1,1,i);
    A(i, i+1) = k(1,2,i); 
    A(i+1, i) = k(2,1,i);
    A(i+1, i+1) = k(2,2,i); 
    b(i) = h(i);
end 

%% IMPOSE BOUNDARY CONDITIONS
% (Algorithm 2)

b(1) = c;
b(2) = b(2) - A(1,2)*c;
A(1,1) = 1;
A(1,2) = 0;
A(2,1) = 0;

b(M) = d;
b(M-1) = b(M-1) - A(M-1,M)*d;

A(M,M) = 1;
A(M-1,M) = 0; 
A(M,M-1) = 0;

%% SOLVE SYSTEM
% Solve using the Cholesky factorization of A to solve A*u=b
u = A \ b;

%[U,flag] = chol(A);
%if flag == 0
%    u = U \ (U' \ b);
%else
%    disp('A is not positive definite'), return
%end

%% OUTPUT
% Visualize solution and output solution

if plot1 
    exact = @(x1) 1/psi* (exp(-psi/epsilon) + (1 - exp(-psi/epsilon))*x1 - exp(x1*psi/epsilon - psi/epsilon)) / (1 - exp(-psi/epsilon));
    % exact = @(x1) 1/psi*( (1+(exp(psi/epsilon)-1)*x1 - exp(x1*psi/epsilon))/(exp(psi/epsilon) - 1)); 
    x2 = linspace(0, L, 640);

    figure;
    plot(x,u,'r--X', 'linewidth', 3, 'MarkerSize', 10)
    hold on
    grid on
    plot(x2, exact(x2), 'b-', 'linewidth', 2)
    xlim([0 1.05])
    xlabel('x');
    ylabel('u(x)');
    legend('Computed with BVP1D_e','Exact','Location','northwest','FontSize',12)
    hold off
end
