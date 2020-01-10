%% Exercise 1.6
close all; clc;

%% a) + b) + c)
% A metric which measures the change in approximate solution
% across elements is used to compute the estimated error 
% decrease rate.

func = @(x) exp(-800*(x - 0.4).^2) + 0.25*exp(-40*(x - 0.8).^2);
VX = linspace(0,1,3);

% Initializing a EToV table
EToV = zeros(length(VX)-1, 2);
EToV(:,1) = 1:size(EToV,1);
EToV(:,2) = 2:size(EToV,1)+1;

% Setting the tolerance criterion
tol = 1e-4;

c = 1;

while true
    % Compute the error decrease of the split of all elements
    err = compute_error_decrease(func, VX, EToV);

    idxMarked = EToV(:,1);
    idxMarked = idxMarked(err > tol);

    % Check if convergence is reached
    if isempty(idxMarked)
        disp('Convergence reached')
        break
    end

    % Update EToV, VX
    [EToV, VX] = refine_marked(EToV, VX, idxMarked);
    c = c +1;
end

%% d)
figure(1);
plot(VX, func(VX), 'r','LineWidth',2)
hold on
plot(linspace(0,1, 10000), func(linspace(0,1, 10000)),'--k','LineWidth',2)
xlabel('x');
ylabel('u(x)');
legend('True function','AMR','FontSize',12)
hold off
% DOF = 69, Iterations = 9, tol = 1e-4, Elements = 68

figure(2);
plot(err, 'b.','MarkerSize', 30)
hold on
plot([0 length(err)+2],[tol tol],'r--','LineWidth',3)
hold off
ylim([1e-5 1.15e-4])
xlim([0 length(err)+2])
xlabel('element i');
ylabel('err_i');
legend('Errors','Tolerance','FontSize',12)
