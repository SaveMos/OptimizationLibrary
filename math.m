function H = math(M)
I = [1 0 ;0 1];
B = transpose(M);
H = I -B*(M*B)^-1*M;
end