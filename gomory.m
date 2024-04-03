function [y, invAb, A_tilde, taglio]= gomory(A, b, x, r)
%    [x, invAb, At, taglio]= gomory(A, b, x, r)
%   INPUT
%   A: matrice A
%   senza vincoli di positività o variabili di scarto
%   es : A = [14 13 ; 9 19]
%   b: vettore b
%   senza vincoli di positività
%   x: soluzione del rilassato continuo(senza le variabili di scarto)
%   es: x = [ 6 , 7 ]
%   r: Indice del taglio da fare, ATTENZIONE! L'indice 1 parte dal primo 
%      elemento non intero. ESEMPIO: x = [5, 5.24], per fare il taglio su
%      5.24 si deve mettere r = 1
%   OUTPUT
%   x: soluzione del duale
%   invAb: inversa di Ab
%   At: matrice A tilde
%   taglio: vettore con i coefficienti del taglio
  
 
 n_x = numel(x);
 n_A = numel(A(: , 1));

 valore_scarti = b - A * x;
 valore_scarti = round(valore_scarti , 2);

 x_con_scarti = [x ; valore_scarti];
 B = []; N = [];
 Ab = []; An = [];

 for i = 1 : numel(x_con_scarti)
     if(x_con_scarti(i) > 0)
         B = [B , i];       
     else
         N = [N , i];
     end
 end

 A = [A , eye(numel(A(: , 1)) , numel(A(: , 1)))];

  for i = 1 : n_A
      Ab = [Ab , A(: , B(i))];
  end

  for i = 1 : n_x
      An = [An , A(: , N(i))];
  end

  A_tilde = inv(Ab) * An;

  indice_variabile_target = 0;
% TROVO LA R-ESIMA VARIABILE FRAZIONARIA
  for i = 1 : numel(x_con_scarti)
      fraz = x_con_scarti(i) - floor(x_con_scarti(i));
      if (fraz == 0)
          continue;
      else
          indice_variabile_target = indice_variabile_target + 1;
          if(indice_variabile_target == r)
              indice_variabile_target = i;
              break;
          end
      end
  end
    
  taglio = zeros((n_x + 1) , 1);
  for i = 1 : n_x
      taglio(i) =  A_tilde(r , i) - floor(A_tilde(r , i));
  end

  taglio(n_x+1) = (x_con_scarti(indice_variabile_target) - floor(x_con_scarti(indice_variabile_target)));

  invAb = inv(Ab);
  y = x_con_scarti;
end
   
