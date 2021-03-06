function XF = Homotopy(F, Xi, N)
    syms x1 x2 x3 
    
    F0 = double(subs(F, [x1, x2, x3], Xi'));
    h = 1 / N;
    b = -h .* F0;
    for i = 1:N
        A = double(subs(jacobian(F, [x1, x2, x3]), [x1, x2, x3], Xi'));
        k1 = inv(A) * b';
        
        A = double(subs(jacobian(F, [x1, x2, x3]), [x1, x2, x3], Xi' + 0.5 .* k1'));
        k2 = inv(A) * b';
        
        A = double(subs(jacobian(F, [x1, x2, x3]), [x1, x2, x3], Xi' + 0.5 .* k2'));
        k3 = inv(A) * b';
        
        A = double(subs(jacobian(F, [x1, x2, x3]), [x1, x2, x3], Xi' + k3'));
        k4 = inv(A) * b';
        
        Xi = Xi + (k1 + 2*k2 + 2*k3 + k4) ./ 6;
    end
    XF = Xi;
end