function [u] = BVP1_7D(L, c, d, x, func)
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
b = zeros(M,1);
h = diff(x);

% Constructing the upper triangle of A
for i = 1:M-1
    % Using equation (1.26)
    k11 = 1/h(i) + h(i)/3;
    k12 = -1/h(i) + h(i)/6;
    
    A(i, i) = A(i,i) + k11;
    A(i, i+1) = k12; 
    A(i+1, i+1) = k11; 
    
end 

for i = 2:M-1
   b(i) = -(....
       func(x(i-1)) * h(i-1)/6 ...
       + func(x(i)) * ( h(i-1)/3 + h(i)/3 ) ...
       + func(x(i+1)) * h(i)/6 ...
   );
end

%% IMPOSE BOUNDARY CONDITIONS
% (Algorithm 2)

b(1)=c;
b(2)=b(2)-A(1,2)*c;
A(1,1)=1;
A(1,2)=0;
b(M)=d;
b(M-1)= b(M-1) - A(M-1,M)*d;
A(M,M)=1;
A(M-1,M)=0;
%% SOLVE SYSTEM
% Solve using the Cholesky factorization of A to solve A*u=b
[U,flag] = chol(A);
if flag == 0
    u = U \ (U' \ b);
else
    disp('A is not positive definite'), return
end
