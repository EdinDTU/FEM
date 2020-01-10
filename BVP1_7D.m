function [u, x] = BVP1_7D(L, c, d, x, func)
% Purpose: Solve second-order boundary value problem using FEM.
% Author(s): Edin Sadikovic, Mikkel Gronning, Ida Riis Jensen 

%% INPUT PARAMETERS
%     L : Domain length
%     c : Left boundary condition
%     d : Right boundary condition

%% GLOBAL ASSEMBLY
% Assemble A (the upper triangle only) and b. (Algorithm 1)

% Allocating SPARSE storage for A and FULL for b
M = length(x);

A = spalloc(M, M, M*3);
B = spalloc(M, M, M*3);
k = zeros(2,2,M); 
k2 = zeros(2,2,M);
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
    
    k2(1,1,i) = h(i)/3;
    k2(1,2,i) = h(i)/6;
    k2(2,2,i) = h(i)/3;
    k2(2,1,i) = h(i)/3;
    
    B(i,i) = B(i,i) + k(1,1,i);
    B(i,i+1) = k(1,2,i); 
    B(i+1,i+1) = k(2,2,i); 
end 

F = func(x);
b = B * F';

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
[U,flag] = chol(A);
if flag == 0
    u = U \ (U' \ b);
else
    disp('A is not positive definite'), return
end
