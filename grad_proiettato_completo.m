% Coefficenti della Funzione
af = -2; 
bf = -1; 
cf = 4; 
df = 2; 
ef = 0; 
% f(x1 , x2) = af*x1^2 + bf*x2^2 + cf*x1 + df*x2 + ef*x1*x2;
P1 = [ 0 , 2 ];  P2 = [ 0 , 4];

xk = [0 , 3];

yk = [ 0 , 2 ];

max_min = 1 ; % max -> 1 ; min -> 0

%-----------------------------FINE PARAMETRI------------------------------%
syms f(x1,x2);
assume(x1,'real');
assume(x2,'real');

f(x1 , x2) = af*x1^2 + bf*x2^2 + cf*x1 + df*x2 + ef*x1*x2;

grad_f_xk = [2*af*xk(1) + cf + ef*xk(2) ; 2*bf*xk(2) + df + ef*xk(1) ];

[retta , M] = retta_due_punti(P1 , P2);

H = math(M); % Matrice di Proiezione

dk = H * grad_f_xk; % Direzione

if max_min == 0
    dk = -1 * dk;
end

Hf = [2*af , ef ; ef , 2*bf]; % Calcolo l'hessiana
C  = [cf , df];

[phi, vertice_phi , massimo_spostamento , dk , tk , xk_successivo , massimo_spostamento_check] = gradiente_proiettato(Hf,C,xk,yk, dk , max_min)

clear x1;
clear x2;
clear P1;
clear P2;
clear af bf cf df ef C f;
