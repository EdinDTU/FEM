

function [err] = compute_error_decrease(fun, VX, EToV)
    num_intervals = size(EToV,1);

    err = zeros(1, num_intervals);

    for i = 1:num_intervals

        x1 = VX( EToV(i,1) );
        x2 = VX( EToV(i,2) );
        xc = x1 + (x2 - x1)/2;

        
        err(i) = my_intergral(fun, x1, xc, x2);

    end
end