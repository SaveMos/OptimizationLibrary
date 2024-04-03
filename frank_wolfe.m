function [phi, vertice , tk ,dk , xk_successivo] = frank_wolfe(H, C, xk, yk , max_min)
%   [phi, vertice, dk] = frank_wolfe(H,C,xk,yk)
%   INPUT
%   H: Hessiana
%   C: Vettore lineare
%   max_min : problema di massimo o di minimo ( 1 o 0 )
%   OUTPUT
%   phi: è la f ristretta alla retta
%   vertice: è il vertice di phi
%   dk : direzione spostamento
%   tk : passo
%   xk_successivo : prossimo punto

    syms f(x,y) phi(t);
    assume(x,'real');
    assume(y,'real');
    assume(t,'real')
    f(x,y) = 0.5*[x;y]'*H*[x;y] + C*[x;y];
    dk=(yk-xk);

    phi(t) = f(xk(1)+t*dk(1), xk(2)+t*dk(2));
    phi = simplify(phi);
   % fplot(phi)
    derivata = diff(phi);
    vertice = solve(derivata == 0 , t);

    valore1 = phi(1);
    valore0 = phi(0);

    if(vertice > 1 ) || (vertice < 0)
        if(max_min)
            if(valore1 > valore0)
                tk = 1;
            else
                tk = 0;
            end
        else
            if(valore1 < valore0)
                tk = 1;
            else
                tk = 0;
            end
        end
    else
        tk = vertice;

    end

    xk_successivo = xk + tk * dk;
        
 
end
