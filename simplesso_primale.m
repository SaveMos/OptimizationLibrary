A = [4 3 ; 1 -1 ; -3 -1]; 
% Matrice del problema ( senza vincoli di positività)

b = [12 ; 0 ; -3]; 
% Vettore termini noti (senza zeri per la positività)

c = [ 3 , 2]; 
% Funzione obbiettivo

x_v = [0 ; 4]; % Soluzione di partenza

pos = 0; 
% mettere a 1 se si vuole impostare manualmente la positività
% o negatività delle variabili
%pos_matr = [1 0 ; 0 1];

%-------------------------------------------------------------------------

n_x = numel(x_v); % Dimensione dell array x
n_A_g = numel(A(: , 1));  % Numero di Vincoli (esclusi quelli di positività)
n_A = n_A_g + n_x; % Numero di Vincoli in Totale
n_b = n_x;
n_n = n_A - n_x;

if(pos == 0)
    A = [A ; -1 * eye(n_x , n_x)];
else
    A = [A ; pos_matr];
end

for i = 1 : n_x
    b = [b ; 0];
end

[soluzione_ottima_PL , v_ottima_PL] = linprog(-1*c , A , b , [] , [] , [] , []);
[soluzione_ottima_PLI , v_ottima_PLI] = intlinprog(-1*c ,[1 , n_x] ,A , b , [] , [] , [] , []);
v_ottima_PLI = -1 * v_ottima_PLI;
v_ottima_PL = -1 * v_ottima_PL;

B = []; % Indici in Base
N = []; % Indici NON in Base
 

vettore_differenze = b - (A * x_v);

for i = 1 : n_A
    if( vettore_differenze(i) == 0)
       B = [B , i];
    else
       N = [N , i];  
    end
end

Ab = []; An=[] ; bn = []; bb = []; 

for i = 1 : n_b
    Ab = [Ab ; A(B(i) , :)];
    bb = [bb ; b(B(i) , :)];
end

for i = 1 : n_n
    An = [An ; A(N(i) , :)];
    bn = [bn ; b(N(i) , :)];
end

y_p =  c * inv(Ab);

if(all( y_p >= 0))
    Risultato = "OTTIMO RAGGIUNTO"; 
end

W = -1 * inv(Ab);

ind_y_p = 1;

y = zeros(1,n_A);

for i = 1 : n_A
    if( find(B == i))
        y(i) = y_p(ind_y_p);  
        ind_y_p = ind_y_p + 1;
    else
         y(i) = 0;  
    end
end

h = 0;
for i = 1 : n_A
    if( find(B == i))
           if(y(i) < 0)
               h = i;
               break;     
           end
    end
    if(i == n_A)
        h = -1; % siamo all'ottimo
        break;
    end
end

h_w = B == h;

denominatori_rapporti = An * W(: , h_w);

if( all( denominatori_rapporti <= 0))
    Risultato = "NO SOLUZIONE -> PROBLEMA INFINITO";
    clear y_p W An bn Ab bb vettore_differenze h denominatori_rapporti;
    clear h_w;
    return; 
end

numeratori_rapporti = bn - (An * x_v);

k = N(1);
v_minimo = (numeratori_rapporti(1)/denominatori_rapporti(1));
for i = 2 : n_n
    
    if(denominatori_rapporti(i) > 0)
        s = (numeratori_rapporti(i)/denominatori_rapporti(i));
        if(s < v_minimo)
            v_minimo = s;
            k = N(i);
        end
            
    end

end

h_w = B == h;
k_w = N == k;

vecchio_B = B;
vecchio_N = N;

temp = B(h_w);
B(h_w) = N(k_w);
N(k_w) = temp;

B = sort(B ,1 , 'ascend');
N = sort(N ,1 , 'ascend');

nuova_bb = []; nuova_Ab = [];

for i = 1 : n_b
    nuova_Ab = [nuova_Ab ; A(B(i) , :)];
    nuova_bb = [nuova_bb ; b(B(i) , :)];
end

nuovo_x_v = inv(nuova_Ab) * nuova_bb;
nuovo_y = c * inv(nuova_Ab);
nuovo_v = c * nuovo_x_v;

if( all(nuovo_y >= 0))
    Risultato = "OTTIMO RAGGIUNTO AL PASSO SUCCESSIVO";
else
    Risultato = "OTTIMO NON RAGGIUNTO AL PASSO SUCCESSIVO";
end

vecchio_x_v = x_v;
vecchio_y = y;
vecchia_v = c*vecchio_x_v;

nuovo_B = B;
nuovo_N = N;

indice_uscente_H = h;
indice_entrante_K = k;

clear x_v A b c;
clear vettore_differenze;
clear numeratori_rapporti;
clear denominatori_rapporti;
clear g bb Ab bn An n_A_g;
clear W h k;
clear i;
clear s;
clear h_w;
clear k_w y;
clear temp pos y_p;
clear n_n;
clear ind_y_p N B;
clear n_A;
clear n_x;
clear n_b pos_matr;

clear v_minimo;
clear nuova_Ab;
clear nuova_bb;


