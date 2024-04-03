syms x r1 rr bd;
syms g1(x1,x2) g2(x1 ,x2) ;
syms h1(x1 , x2);
syms f(x1 , x2);

n_g = 2;
n_h = 0;

% Coefficenti della Funzione 
af = -1; 
bf = -2; 
cf = 0; 
df = 8; 
ef = 0;
tn = 0;
f(x1 , x2) = af*x1^2 + bf*x2^2 + cf*x1 + df*x2 + ef*x1*x2 + tn;
grad_f_xk = [2*af*xk(1) + cf + ef*xk(2) ; 2*bf*xk(2) + df + ef*xk(1) ];

% Coefficenti della Funzione 
af = -1; 
bf = -1; 
cf = 0; 
df = 0; 
ef = 0;
tn = 1;
g1(x1 , x2) = af*x1^2 + bf*x2^2 + cf*x1 + df*x2 + ef*x1*x2 + tn;

% Coefficenti della Funzione 
af = 1; 
bf = 0; 
cf = 0; 
df = -1; 
ef = 0;
tn = -2;
g2(x1 , x2) = af*x1^2 + bf*x2^2 + cf*x1 + df*x2 + ef*x1*x2 + tn;
