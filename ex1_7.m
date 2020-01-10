u = @(x) exp(-800*(x - 0.4).^2) + 0.25*exp(-40*(x - 0.8).^2);

x1 = linspace(0,1,10000);
plot(x1, u(x1))

% we expect many node near the exstrme curvatures i.e. around
% x = 0.4, 0.5, 0.8


%%
u   = @(x) exp(-800.*(x - 0.4).^2) + 0.25.*exp(-40.*(x - 0.8).^2);
u__ = @(x) (1004.0000 + 1600.00.*x.^2 - 2560.000.*x).*exp(-1.6.*(5.*x - 4.).^2) ...
    + (408000.00 + 2.560000.*10.^6.*x.^2 - 2.0480000.*10.^6.*x).*exp(-32.*(5.*x - 2.).^2);

func = @(x) u__(x) - u(x);

%%
c = func(0);
d = func(1);

x = linspace(0,1,10);
BVP1_7D(1, 0, 1, x, func)