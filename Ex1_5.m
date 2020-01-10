%% Exercise 1.5
close all; clc;

%% d)
% The analytical solution to (1.34) is plotted for fixed psi = 1
% and various values of epsilon.

xtmp = 0.01:0.0001:1;
x = xtmp(2: end-1);

epsilon = [1, 0.01, 0.0001];
u = zeros(length(epsilon), length(x));

for i = 1:length(epsilon)
    u(i,:) = ad_diff(epsilon(i), x);
end

figure(1);
plot(x, u(1,:),'r-','linewidth', 3)
legend('Epsilon = 1','Location','northwest','FontSize',12);
xlim([0 1.05]);
xlabel('x');
ylabel('u(x)');
figure(2);
plot(x, u(2,:),'r-', 'linewidth', 3)
legend('Epsilon = 0.01','Location','northwest','FontSize',12);
xlim([0 1.05]);
xlabel('x');
ylabel('u(x)');
figure(3);
plot(x, u(3,:),'r-','linewidth', 3)
xlim([0 1.05]);
xlabel('x');
ylabel('u(x)');
legend('Epsilon = 0.0001','Location','northwest','FontSize',12);

%% e) 
% A function that solves the boundary value problem (1.35) 
% is made.
L = 1; c = 0; d = 0; psi = 1;

x = linspace(0,1,20);
u_e = BVP1D_e(L, c, d, x, epsilon(1), psi, 1);
u_e2 = BVP1D_e(L, c, d, x, epsilon(2), psi, 1);
u_e3 = BVP1D_e(L, c, d, x, epsilon(3), psi, 1);
% The method is good when we are having diffusion equations,
% but when epsilon -> 0 the equation doesn't contain diffusion
% anymore. Hence, the behaviour of the computed solution looks
% as seen in Figure 3.

% We have tried to solve the problem by multiplying the exact
% solution with a factor. The errors decrease but not enough.

%% e)
% Investigating the convergence

h = zeros(1, 10);
h(1) = 1;

err =  zeros(1,length(h));
for i = 2:length(h)
    h(i) = h(i-1)/2; 
end

exact = @(x1, epsilon) 1/psi* (exp(-psi/epsilon) ...
    + (1 - exp(-psi/epsilon))*x1 ...
    - exp(x1*psi/epsilon ... 
    - psi/epsilon)) / (1 - exp(-psi/epsilon));

for i = 1:10
    x = 0:h(i):1;

    u_e = BVP1D_e(L, c, d, x, epsilon(1), psi,0);
    
    % Using equation (1.33)
    err(i) = max(abs(exact(x, epsilon(1)) - u_e'));

end
figure(1);
loglog(h,err,'b-x');
hold on
plot(h, h.^2, 'r')
xlabel('h');
ylabel('error');
legend('Exact solution', 'O(h^2)','Location','northwest','FontSize',12);
hold off

% Verifying the convergence
for i = 1:9
    disp(err(i)/err(i+1)); 
end
% As expected, the program converges towards 4. 