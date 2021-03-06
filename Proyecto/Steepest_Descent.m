function XF = Steepest_Descent(g, Xi, epsilon, N)
    syms alp x1 x2 x3
    k = 1;
    Xj = Xi';
    Xf = [];
    while(k <= N)
        k;
        Xj;
        g1 = double(subs(g, [x1, x2, x3], Xj));
        z = subs(gradient(g), [x1, x2, x3], Xj);
        z0 = double(norm(z));
        if(z0 == 0)
            Xf = Xj;
            break
        end
        z = (1/z0) .* z;
        alp1 = 0;
        alp3 = 1;
        g3 = double(subs(g, [x1, x2, x3], Xj - alp3 .* z'));
        
        while(g3 >= g1)
            alp3 = alp3 / 2;
            g3 = double(subs(g, [x1, x2, x3], Xj - alp3 .* z'));
            if(alp3 < epsilon / 2)
                Xf = Xj;
            end
        end
        
        alp2 = alp3 / 2;
        g2 = double(subs(g, [x1, x2, x3], Xj - alp2 .* z'));
        
        h1 = (g2 - g1) / alp2;
        h2 = (g3 - g2) / (alp3 - alp2);
        h3 = (h2 - h1) / alp3;
        P = g1 + h1 * alp + h3 * alp * (alp - alp2);
        alpha = real(Muller([0, alp2, alp3], P, 0.05, 100));
        
        alp0 = 0.5 * (alp2 - h1 / h3);
        g0 = double(subs(g, [x1, x2, x3], Xj - alp0 .* z'));
        g_alp = double(subs(g, [x1, x2, x3], Xj - alpha .* z'));
        Xj = double(Xj - alpha * z');
        if(abs(g_alp - g1) < epsilon)
            Xf = Xj;
        end
        k = k + 1;
    end
    if(k >= N)
        XF = N
    else
        XF = Xf
    end
    Xf
end