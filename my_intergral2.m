


function A = my_intergral2(x1, xc, x2, y1, yc, y2)

a1 = (yc - y1)/(xc - x1);
b1 = y1 - a1 * x1;

a = (y2 - y1)/(x2 - x1);
b = y1 - a * x1;

a2 = (y2 - yc)/(x2 - xc);
b2 = yc - a2 * xc;


A = (-a + a1)^2*(-x1^3 + xc^3)/3 + (-b + b1)*(-a + a1)*(-x1^2 + xc^2) ... 
    + (-b + b1)^2*(xc - x1) + (-a + a2)^2*(x2^3 - xc^3)/3 ...
    + (-b + b2)*(-a + a2)*(x2^2 - xc^2) + (-b + b2)^2*(x2 - xc);

A = sqrt(A);

end

