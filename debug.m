c = [9 ,11 ,23 ,12, 5, 10 , 21];
A = [119 , 129, 55 ,230 ,43 ,73 , 3];
b = [250];

x = [0 ; 0 ; 0 ; 0 ; 0 ; 0 ; 83.3333];
r = 7;

n_x = numel(x);
num_var_non_scarto = numel(A(1 , :));
num_var_scarto = numel(A(: , 1));
A_or = A;
A = [A , eye(numel(A(: , 1)) , numel(A(: , 1)))];

syms f(xf);
eval(strcat("syms xf [" , string(n_x) , " , 1]"));
assume(xf , 'real'); f(xf) = b - (A_or * xf);

call = "f(";
for i = 1 : (n_x - 1)
    call = strcat(call , string(x(i)) , ",");
end
call = strcat(call , string(x(n_x)) , ");");
var_scarto = double(eval(call)); clear call;
var_scarto = round(var_scarto , 2);


rangoA = rank(A);
B = [];
N = [];

 %trova il primo elem. frazionario di x
    for i = 1 : size(x , 2)
        if (x(i) - floor(x(i)) ~= 0)
            r_x = i;
            break;
        end
    end

  % sistemo A e b con i nuovi vincoli di x del rilassato continuo
   for i = 1: size(x , 2)
        b = [b; x(i)];
        temp = zeros(1, size(A,2));
        temp(i) = 1;
        A = [A; temp];  
   end
    
    x = linsolve(A,b);
    A = A(1:rangoA,:); % I vincoli originali di A + Var. di Scarto.
    b = b(1:rangoA,:);

    %sistemo il float approx. error
    for i = 1 : size(x , 2) 
        if (x(i) < 0.0001 || x(i) > -0.0001)
            x(i) = 0;
        end
        %creo la base B
        if x(1) > 0
            B = [B,i];
        else
            N = [N,i];
        end
    end

    %calcolo matrici Ab, An , At e Ab^-1
    Ab = A(:,B);
    An = A(:,N);
    At = Ab/An;
    invAb = inv(Ab);
   
%x = [ 0 , 4.6 , 0 , 7.8]
%vettore di Arj parte frazionaria

    fract = [];
    for j = 1:size(An,2)
       % arj = At(r_x , j);
        arj = 1;
        fract = [fract , arj-floor(arj)];
    end
    taglio = [fract, x(r_x+ r -1) - floor(x(r_x+r-1))];
gomory()