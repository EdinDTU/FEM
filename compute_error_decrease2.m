function [err] = compute_error_decrease2(xc, xf, uhc, uhf, EToVc, EToVf)
num_intervals = size(EToVc,1);
err = zeros(1, num_intervals);

for i = 1:num_intervals
    x1 = xc( EToVc(i,1) );
    x2 = xc( EToVc(i,2) );
    xm = xf( EToVf(2*i,1) );


    y1 = uhf(EToVc(i,1) );
    y2 = uhf(EToVc(i,1) );
    ym = uhf(EToVf(i+1,1));

    err(i) = my_intergral2(x1, xm, x2, y1, ym, y2);
end


end