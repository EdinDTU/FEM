%% A

u = @(x) exp(-800*(x - 0.4).^2) + 0.25*exp(-40*(x - 0.8).^2);

x1 = linspace(0,1,10000);
plot(x1, u(x1))

% we expect many node near the exstrme curvatures i.e. around
% x = 0.4, 0.5, 0.8


%%  initial mesh configuration
clear, clc
u = @(x) exp(-800*(x - 0.4).^2) + 0.25*exp(-40*(x - 0.8).^2);

func = @(x) (1003.7500 + 1600.00*x.^2 - 2560.000*x)*exp(-1.6*(5.*x - 4.).^2) ...
    + (407999.00 + 2.560000*10^6*x.^2 - 2.0480000*10.^6*x)*exp(-32.*(5.*x - 2.).^2);

c = u(0);
d = u(1);


x = linspace(0,1,3);
sol = BVP1_7D(1, c, d, x, func);

x2 = linspace(0, 1, 1000);

figure;
plot(x, sol, 'r-', 'linewidth', 3, 'MarkerSize', 10)
hold on
grid on
plot(x2, u(x2), 'b-', 'linewidth', 2)
xlim([0 1.05])
legend('Computed','Exact','Location','northwest')
hold off


%%
xc = linspace(0,1,3);

EToVc = zeros(length(xc)-1, 2);
EToVc(:,1) = 1:size(EToVc,1);
EToVc(:,2) = 2:size(EToVc,1)+1;

tol = 1e-4;
count = 1;
while true
    % Create a finner mesh
    [EToVf, xf]  = refine_marked(EToVc, xc, EToVc(:,1));
    
    uhc = BVP1_7D(1, c, d, xc, func);
    uhf = BVP1_7D(1, c, d, xf, func);
    
    err = compute_error_decrease2(xc, xf, uhc, uhf, EToVc, EToVf);
    
    idxMarked = EToVc(:,1);
    idxMarked = idxMarked(err > tol);

    % Check if convegence is reaced
    if isempty(idxMarked)
        disp('convergence reached')
        break
    end

    % update EToVc, xc
    [EToVc, xc]  = refine_marked(EToVc, xc, EToVc(:,1));
    count = count +1;
end

% DOF = 2049, Iterations = 11, tol = 1e-4, Elements = 2048

%%

x2 = linspace(0, 1, 1000);

figure;
plot(xc, uhc, 'r-', 'linewidth', 3, 'MarkerSize', 10)
hold on
grid on
plot(x2, u(x2), 'b-', 'linewidth', 2)
xlim([0 1.05])
legend('Computed','Exact','Location','northwest')
hold off
%%
plot(err, 'b.','MarkerSize', 30)
hold on
plot([0 length(err)+2],[tol tol],'r--','LineWidth',3)
hold off
ylim([-1e-5 1.15e-4])
xlim([0 length(err)])
legend('Errors','Tolerance','FontSize',14)


