%% Exercise 1.2
close all; clc;

%% a)
% Solving the boundary value problem gien in Ex. 1.1 using 
% classical FEM.

% Test case 
L = 2; c = 1; d = exp(2);
x = [0.0, 0.2, 0.4, 0.6, 0.7, 0.9, 1.4, 1.5, 1.8, 1.9, 2.0];  

u = BVP1D(L, c, d, x, 1);



%% b)
% Now the input px is replaced by the number of nodes, M. 

% Test case
M = 11;
[u_b, x_b] = BVP1D_b(L, c, d, M, 1);

%% c) 
% The functions compare the computed solutions with the exact 
% solution of Ex. 1.1 which can be seen in the above figures.

% Validation by comparing with Ex. 1.1 b):
M = 3;
[u_c, x_c] = BVP1D_b(L, c, d, M, 1);
% As the computed solution follows the exact solution but with 
% small deviations we conclude that the functions are valid. 

%% d) 
% Verification by looking at error bounds

h = zeros(1, 10);
h(1) = 1;

err =  zeros(1,length(h));
for i = 2:length(h)
    h(i) = h(i-1)/2;
end

for i = 1:10
    x = 0:h(i):2;
    
    u_d = BVP1D(L,c,d,x,0);
    
    % Using equation (1.33)
    err(i) = max(abs(exp(x)-u_d'));
end
% Verifying the convergence in a plot
loglog(h,err,'b-x');
hold on
plot(h, h.^2, 'r')
xlabel('h');
ylabel('error');
legend('Computed','O(h^2)','Location','northwest','FontSize',12);
hold off

for i = 1:9
    disp(err(i)/err(i+1)); 
end
% The program converges towards 4 as expected. 
