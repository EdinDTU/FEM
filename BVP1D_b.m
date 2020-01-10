function [u, x] = BVP1D_b(L,c,d,M,plot1)
% Purpose: Solve second-order boundary value problem using FEM.
% Author(s): Edin Sadikovic, Mikkel Gronning, Ida Riis Jensen 

%% INPUT PARAMETERS
%     L : Domain length
%     c : Left boundary condition
%     d : Right boundary condition
%     M : 1D mesh vector x(1:{M})

%% GLOBAL ASSEMBLY
% Assemble A (the upper triangle only) and b. (Algorithm 1)
% If M is used in the call, compute x
if M
    x = linspace(0,L,M);
else
    disp('M must be an input. Otherwise use function BVP1D.'), return
end

% Allocating SPARSE storage for A and FULL for b
A = spalloc(M, M, M*3); b = zeros(M,1);
k = zeros(2,2,M); 
h = diff(x);


% Constructing the upper triangle of A
for i = 1:M-1
    % Using equation (1.26)
    k(1,1,i) = 1/h(i) + h(i)/3;
    k(1,2,i) = -1/h(i) + h(i)/6;
    k(2,2,i) = 1/h(i) + h(i)/3;
    
    A(i,i) = A(i,i) + k(1,1,i);
    A(i,i+1) = k(1,2,i); 
    A(i+1,i+1) = k(2,2,i); 
end 
%% IMPOSE BOUNDARY CONDITIONS
% (Algorithm 2)

b(1) = c;
b(2) = b(2) - A(1,2)*c;
A(1,1) = 1;
A(1,2) = 0;
b(M) = d;
b(M-1) = b(M-1) - A(M-1,M)*d; A(M,M) = 1;
A(M-1,M) = 0;

%% SOLVE SYSTEM
% Solve using the Cholesky factorization of A to solve A*u=b
[U,flag] = chol(A);
if flag == 0
    u = U \ (U' \ b);
else
    disp('A is not positive definite'), return
end

%% OUTPUT
% Visualize solution and output solution
if plot1
    ax = 0:0.0001:2;
    plot(x,u,'r--X', 'linewidth', 3, 'MarkerSize', 10)
    hold on
    grid on
    plot(ax,exp(ax),'b-', 'linewidth', 2)
    legend('Computed', 'Exact')
    hold off
end 
