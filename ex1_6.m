
func = @(x) exp(-800*(x - 0.4).^2) + 0.25*exp(-40*(x - 0.8).^2);
VX = linspace(0,1,3);


EToV = zeros(length(VX)-1, 2);
EToV(:,1) = 1:size(EToV,1);
EToV(:,2) = 2:size(EToV,1)+1;


tol = 1e-4;

c = 1;
while true
    % compute the error improvement of the splitting all elements
    err = compute_error_decrease(func, VX, EToV);

    idxMarked = EToV(:,1);
    idxMarked = idxMarked(err > tol);

    % Check if convegence is reaced
    if isempty(idxMarked)
        disp('convergence reached')
        break
    end

    % update EToV, VX
    [EToV, VX] = refine_marked(EToV, VX, idxMarked);
    c = c +1;
end
%%
plot(VX, func(VX), 'r','LineWidth',2)
hold on
plot(linspace(0,1, 10000), func(linspace(0,1, 10000)),'--k','LineWidth',2)
legend('True function','AMR','FontSize',14)
hold off
% DOF = 69, Iterations = 9, tol=1e-4, Elements=

%%
plot(err, 'b.','MarkerSize', 30)
hold on
plot([0 length(err)+2],[tol tol],'r--','LineWidth',3)
hold off
ylim([1e-5 1.15e-4])
xlim([0 length(err)+2])
legend('Errors','Tolerance','FontSize',14)


