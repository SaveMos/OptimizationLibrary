Aeq = [-6 7 4 -2 -2 2 ; 10 2 -3 -4 2 -1]; 
% Matrice del problema ( inclusi i vincoli di positività)

beq = [2 ; 1]; 
% Vettore termini noti ( inclusi gli zeri per la positività)

c = [17 28 16 3 3 19]; 
% Funzione obbiettivo

B = [ 5, 6];
N = [1 2 3 4];


%-------------------------------------------------------------------------

A = transpose(Aeq);
b = transpose(c);
c = transpose(beq);

n_n = numel(N);
n_b = numel(B);

n_x = n_n+n_b;

Ab = []; An=[] ; bn = []; bb = []; 

for i = 1 : n_b
    Ab = [Ab ; A(B(i) , :)];
    bb = [bb ; b(B(i) , :)];
end

for i = 1 : n_n
    An = [An ; A(N(i) , :)];
    bn = [bn ; b(N(i) , :)];
end

x = inv(Ab)*bb;

y_p =  c * inv(Ab);
ind_y_p = 1;

y = zeros(1,n_x);

for i = 1 : n_x
    if( find(B == i))
        y(i) = y_p(ind_y_p);  
        ind_y_p = ind_y_p + 1;
    else
         y(i) = 0;  
    end
end

numeratori_rapporti = bn - (An * x);

k = 0;
for i = 1 : n_n
    if(numeratori_rapporti(i) < 0)
        k = N(i);
        break;
    end
end

if(k == 0) % se non siamo all'ottimo
    Risultato = "SIAMO ALL OTTIMO";
     return;
end
W = -1 * inv(Ab);

rapporti = [A(k , :)*W(: , 1) , A(k , :)*W(: , 2) ];

if(rapporti(1) >= 0 && rapporti(2) >= 0)
     Risultato = "PROBLEMA INFINITO";
     return;
elseif(rapporti(1) < 0 && rapporti(2) < 0)
    if (y_p(1) / (-1 * rapporti(1))) <= (y_p(2) / (-1 * rapporti(2)))
        h = B(1);
    else
        h = B(2);
    end
elseif(rapporti(1) >= 0 && rapporti(2) < 0)
    h = B(2);
elseif(rapporti(1) < 0 && rapporti(2) >= 0)
    h = B(1);
end



clear i_minimo An bn bb Ab Aeq beq;
clear n_n n_b i b A c ind_y_p  y_p  n_x;