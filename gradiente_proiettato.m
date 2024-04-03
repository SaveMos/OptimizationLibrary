function [phi, vertice , massimo_spostamento , dk , tk , xk_successivo , massimo_spostamento_check] = gradiente_proiettato(H,C,xk,yk, dk , max_min)
%   INPUT
%   H: Hessiana
%   C: Vettore lineare della f
%   OUTPUT
%   phi è la f ristretta alla retta
%   vertice è il punto di minimo di phi
    syms f(x,y) phi(t);
    assume(x,'real');
    assume(y,'real');
    assume(t,'real');

    f(x,y) = 0.5*[x;y]'*H*[x;y] + C*[x;y];
    
    phi(t) = f(xk(1)+t*dk(1), xk(2)+t*dk(2));
    phi = simplify(phi);
    %fplot(phi);
    derivata = diff(phi);

    derivata_seconda = diff(derivata);
    vertice_valido = false;

    if( derivata_seconda == 0)
        vertice = NaN;
        vertice_valido = 0;
    else
        vertice = solve(derivata == 0 , t);
        vertice_valido = 1;
    end
    
    massimo_spostamento_check = (((yk(1) - xk(1))/dk(1)) - ((yk(2) - xk(2))/dk(2)));   
    massimo_spostamento_check = round(massimo_spostamento_check , 2);
    % SE massimo_spostamento_check != 0 ALLORA RICONTROLLA I DATI!!
    % se NaN allora il vincolo è una retta , il check non è utile.
   
    massimo_spostamento =  (yk(2) - xk(2)) / dk(2);

    if(isnan(massimo_spostamento))
          massimo_spostamento =  (yk(1) - xk(1)) / dk(1);
    end

    valore1 = phi(massimo_spostamento);
    valore0 = phi(0);

    if(vertice_valido == 1)
            if(vertice > massimo_spostamento ) || (vertice < 0)
                if(max_min)
                    if(valore1 > valore0)
                        tk = massimo_spostamento;
                    else
                        tk = 0;
                    end
                else
                    if(valore1 < valore0)
                        tk = massimo_spostamento;
                    else
                        tk = 0;
                    end
                end
            else
                tk = vertice; 
            end
    else
        if(max_min)
              if(valore1 > valore0)
                     tk = massimo_spostamento;
              else
                     tk = 0;
              end
        else
              if(valore1 < valore0)
                     tk = massimo_spostamento;
              else
                     tk = 0;
              end
        end

    end

    tk = double(tk);

    dk = double(dk);

    xk_successivo = double(transpose(xk) + tk * dk);
    


end
