function [x,v]  = primoes(n,A,b,c,max)
%mettere max=1 se di massimo o 0 se di minimo
%A matrice A dei vincoli
%b vettore colonna b 
%c vettore obiettivo (se max mettere - davanti)
%n numero di incognite

LB = zeros(1,n);
UB = [];
Aeq = [];
beq = [];
[x, v] = linprog(c, A,b, Aeq, beq, LB,UB);
if(max==1)
 v =-v;
end