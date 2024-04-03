function [retta , M] = retta_due_punti(P1 , P2)
%   INPUT
%   P1 coordinate primo punto
%   P2 coordinate secondo punto
%   OUTPUT
%   retta -> Equazione della retta passante per i due punti.
    syms retta(x1 , x2);
 
    if(P1(1) == P2(1)) && (P1(2) == P2(2))
         M = [0 , 0];
         retta(x1 , x2) = 0*x1 + 0*x2;
    elseif(P1(1) == P2(1))
         M = [1 , 0];
         retta(x1 , x2) = (x1 - P1(1));
    elseif(P1(2) == P2(2))
         M = [0 , 1];
         retta(x1 , x2) = (x2 - P1(2));
         retta = simplify(retta);
    else
        retta(x1 , x2) = (x1 - P1(1))/(P2(1)-P1(1)) - (x2 - P1(2))/(P2(2)-P1(2));
        retta = simplify(retta);
        M = [1/(P2(1)-P1(1)) , -1/(P2(2)-P1(2))];
    end
end

