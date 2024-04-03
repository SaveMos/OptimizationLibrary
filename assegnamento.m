function [x,v] = assegnamento(n, c)
arguments
    n (1,1) double
    c (1,:) double 
end
%n: numero di vincoli
%c: vettore degli assegnamenti
%
%   Risolve il problema dell'assegnamento, 
%   sia coop che non.
A = [];
b = [];

Id = repmat(eye(n), 1, n);

% n vincoli
Aeq = eye(n);
Aeq = repelem(Aeq,1,n);

% altri n vincoli
Aeq = [Aeq; Id];

beq = ones(1, 2*n)';

LB = zeros(1, n^2)';
UB = ones(1, n^2)';

[x,v] = linprog(c,A,b,Aeq,beq,LB,UB);
end