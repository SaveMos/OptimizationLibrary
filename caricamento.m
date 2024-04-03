c = [9 ,11 ,23 ,12, 5, 10 , 21];
A = [119 , 129, 55 ,230 ,43 ,73 , 3];
b = [250];

%-------------------------------------------------------------------------

i_n = numel(c);
rendimenti = zeros(1,i_n);
LB = zeros(1,i_n);
UB = zeros(1,i_n);

for i = 1 : i_n
    rendimenti(i) = c(i) / ( double(A(1 , i)));
    UB(i) = 1;
end

[ x_rilassato_continuo_0 , v_rilassato_continuo_0] = linprog(-1*c , A , b , [] , [] , LB , [] );
v_rilassato_continuo_0 = -1*v_rilassato_continuo_0;

A_full = [A ; -1* eye(i_n , i_n)];
n_A = numel(A_full(: , 1));

b_full = b;
for i = 1 : i_n
    b_full = [b_full ; 0];
end

vettore_differenze = b_full - (A_full *  x_rilassato_continuo_0);

B = []; N = [];

for i = 1 : n_A
    if( vettore_differenze(i) == 0)
       B = [B , i];
    else
       N = [N , i];  
    end
end
clear vettore_differenze;

[ x_rilassato_continuo_1 , v_rilassato_continuo_1] = linprog(-1*c , A , b , [] , [] , LB , UB );
v_rilassato_continuo_1 = -1*v_rilassato_continuo_1;

x_valutazione_inferiore_1 = floor(x_rilassato_continuo_1);
v_valutazione_inferiore_1 = c*x_valutazione_inferiore_1;

% Rendimenti
r_dummy  = rendimenti;
x_Alg_rendimenti_continua = zeros(1,i_n);
cap = b(1);

for i = 1 : i_n
    max_rend = -1;
    i_max = 5;
    for j = 1 : i_n
       if(r_dummy(j) < 0)
            continue;
        end
        if(r_dummy(j) > max_rend)
            i_max = j;
            max_rend = rendimenti(j); 
        end
    end
    if(A(1 , i_max) <= cap)
            cap = cap - A(1 , i_max);
            x_Alg_rendimenti_continua(i_max) = 1;
            r_dummy(i_max) = -2;
        else    
            x_Alg_rendimenti_continua(i_max) = (cap /A(1 , i_max));
            cap = 0;
            break;
    end
end

r_dummy  = rendimenti;
x_Alg_rendimenti_binaria = zeros(1,i_n);
cap = b(1);

for i = 1 : i_n
    max_rend = -1;
    i_max = 5;
    for j = 1 : i_n
         if(r_dummy(j) < 0)
            continue;
        end
        if(r_dummy(j) > max_rend)
            i_max = j;
            max_rend = rendimenti(j); 
        end
    end
    if(double(A(1 , i_max)) <= cap)
         cap = cap - A(1 , i_max);
         x_Alg_rendimenti_binaria(i_max) = 1;
         r_dummy(i_max) = -2;
    else
         cap = cap;
         x_Alg_rendimenti_binaria(i_max) = 0;
         r_dummy(i_max) = -2;
    end
end

v_Alg_rendimenti_continua = c * transpose(x_Alg_rendimenti_continua);
v_Alg_rendimenti_binaria = c * transpose(x_Alg_rendimenti_binaria);


clear r_dummy LB UB i_n n_A cap;


