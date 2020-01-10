

int=my_intergral(0, 1);

a = 0;
b = 1;

error = abs(my_intergral(a, b) - my_trapez(a, b));


%% 

func = @(x) exp(-800*(x - 0.4)^2) + 0.25*exp(-40*(x - 0.8)^2);
VX = [
    0.0;
    0.25;
    0.75
    1.0
    ];


EToV = [
    1, 2;
    2, 3;
    3, 4;
    ];
%%
compute_error_decrease(func, VX, EToV)


%%
idxMarked = [1,3];

EToVfine = zeros(size(EToV,1) + length(idxMarked), 2)
VXfine = zeros(1, size(VX,1) +  length(idxMarked))


EToVfine(:,1) = 1:size(EToVfine,1);
VXfine(:,1) = 1:size(VXfine,1);

for i = 1:length(VXfine)
    if 
end


for i = idxMarked
    x1 = VX( EToV(i,1) )
    x2 = VX( EToV(i,2) )
    xc = x1 + (x2 - x1)/2
    
end
