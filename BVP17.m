function [u] = BVP17(L,c,d,x,fun)
% Purpose: Solve second-order boundary value problem using FEM.
% Author(s): Simon Troelsgård
%% INPUT PARAMETERS
% L : Domain length
% c : Left boundary condition
% d : Right boundary condition
% x : 1D mesh vector x(1:{M})
%% GLOBAL ASSEMBLY
% Assemble A (the upper triangle only) and b. (Algorithm 1)
M = length(x);
h = x(2:M)-x(1:M-1);
a = spalloc(M,M,3*M-2);
for i = 1:(M-1)
    k11 = 1/(x(i+1)-x(i))+(x(i+1)-x(i))/3;
    k12 = -1/(x(i+1)-x(i))+(x(i+1)-x(i))/6;
    a(i,i) = a(i,i)+k11;
    a(i,i+1)= k12;
    a(i+1,i+1)=k11;
end
%% IMPOSE BOUNDARY CONDITIONS
% (Algorithm 2)
b = zeros(M,1);
for i=2:M-1
   b(i) = -(fun(x(i-1)) * h(i-1)/6 + fun(x(i)) * (h(i-1)/3+h(i)/3) + fun(x(i+1))*h(i)/6);
end
b(1)=c;
b(2)=b(2)-a(1,2)*c;
a(1,1)=1;
a(1,2)=0;
b(M)=d;
b(M-1)= b(M-1)-a(M-1,M)*d;
a(M,M)=1;
a(M-1,M)=0;
A=a;
%% SOLVE SYSTEM
% Solve using the Cholesky factorization of A to solve A*u=b
[U,flag] = chol(A);
if flag == 0
u = U \ (U' \ b);
else
disp('A is not positive definite'), return
end
%% OUTPUT
%and output solution
%tt=x;
%tempsol=zeros(length(tt),1);
%syms basis(t)
%basis(t)= piecewise(0<=t<=x(1+1),1-(t-x(1))/(x(1+1)-x(1)),0);
%tempsol = basis(tt)*u(1);
%for i =2:M-1
   %syms basis(t)
   %basis(t)=piecewise(x(i-1)<=t<=x(i),(t-x(i-1))/(x(i)-x(i-1)),x(i)<=t<=x(i+1),1-(t-x(i))/(x(i+1)-x(i)),0);
   %tempsol = basis(tt)*u(i)+tempsol;
%end
%syms basis(t)
%basis(t)=piecewise(x(M-1)<=t<=x(M),(t-x(M-1))/(x(M)-x(M-1)),0);
%tempsol=tempsol+u(M)*basis(tt);
%sol=tempsol;
