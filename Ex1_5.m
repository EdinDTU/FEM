%% Exercise 1.5
close all; clc;

%% d)
% The analytical solution to (1.34) is plotted for fixed psi = 1
% and various values of epsilon.

xtmp = 0.01:0.0001:1;
x = xtmp(2: end-1);
%x = [0.0, 0.2, 0.4, 0.6, 0.7, 0.9, 1.4, 1.5, 1.8, 1.9, 2.0]; 

epsilon = [1, 0.01, 0.0001];
u = zeros(length(epsilon), length(x));

for i = 1:length(epsilon)
    u(i,:) = ad_diff(epsilon(i), x);
end

figure(1);
plot(x, u(1,:),'r-','linewidth', 3)
legend('Epsilon = 1','Location','northwest','FontSize',12);
xlim([0 1.05]);
figure(2);
plot(x, u(2,:),'r-', 'linewidth', 3)
legend('Epsilon = 0.01','Location','northwest','FontSize',12);
xlim([0 1.05]);
figure(3);
plot(x, u(3,:),'r-','linewidth', 3)
xlim([0 1.05]);
legend('Epsilon = 0.0001','Location','northwest','FontSize',12);

%% e) 
% A function that solve the boundary value problem (1.35) is made.
L = 1; c = 0; d = 0; psi = 1;
% x = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0];

x = linspace(0,1,60);
u_e = BVP1D_e(L, c, d, x, epsilon(1), psi, 1);
u_e2 = BVP1D_e(L, c, d, x, epsilon(2), psi, 1);
u_e3 = BVP1D_e(L, c, d, x, epsilon(3), psi, 1);

%% e)
% Investigating the convergence

h = zeros(1, 10);
h(1) = 1;

err =  zeros(1,length(h));
for i = 2:length(h)
    h(i) = h(i-1)/2; 
end

for i = 1:10
    x = 0:h(i):1;

    u_e = BVP1D_e(L, c, d, x, epsilon(1), psi,0);
    
    % Using equation (1.33)
    err(i) = max(abs(exp(x)-u_e(x)'));

end
figure(1);
loglog(h,err,'b-x');
hold on
plot(h, h.^2, 'r')
legend('Computed', 'O(h^2)');
hold off

%for i = 1:9
%    disp(err(i)/err(i+1)); 
%end