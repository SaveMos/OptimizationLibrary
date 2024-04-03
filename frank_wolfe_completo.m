% Coefficenti della Funzione
af = -2; 
bf = -1; 
cf = 4; 
df = 2; 
ef = 0; 
% f(x1 , x2) = af*x1^2 + bf*x2^2 + cf*x1 + df*x2 + ef*x1*x2;

xk = [0 , 3];

yk = [ 8 , 0 ];

max_min = 1 ; % max -> 1 ; min -> 0

%-----------FINE PARAMETRI--------------------------------------%

syms f(x1,x2);
assume(x1,'real');
assume(x2,'real');

f(x1 , x2) = af*x1^2 + bf*x2^2 + cf*x1 + df*x2 + ef*x1*x2;

grad_f_xk = [2*af*xk(1) + cf + ef*xk(2) ; 2*bf*xk(2) + df + ef*xk(1) ]

H = [2*af , ef ; ef , 2*bf]; % Calcolo l'hessiana
C  = [cf , df];

[phi, vertice , tk ,dk , xk_successivo] = frank_wolfe(H, C, xk, yk , max_min)

tk = double(tk);
vertice = double(vertice);
xk_successivo = double(xk_successivo);
clear af bf cf df ef C;
