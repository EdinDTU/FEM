%% Exercise 1.2
close all; clc;

%% a)
% Test case
L = 2; c = 1; d = exp(2);
x = [0.0, 0.2, 0.4, 0.6, 0.7, 0.9, 1.4, 1.5, 1.8, 1.9, 2.0];  

[u] = BVP1D(L, c, d, x);


%% b)
% Test case
M = 11;
[u_b, x_b] = BVP1D_b(L, c, d, M);

%% c) 
% The functions compare the computed solutions with the exact solution of
% Ex. 1.1

% Validation by comparing with Ex. 1.1 b):
M = 3;
[u_c, x_c] = BVP1D_b(L, c, d, M);
% As the computed solution follows the exact solution but with small
% deviations we conclude that the functions are valid. 

%% d) 