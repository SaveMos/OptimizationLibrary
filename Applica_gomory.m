
A = [4 ,3 ; 1, -1 ; -3 ,-1];
b = [12 ; 0 ; -3];
x = [12/7 ; 12/7];
r = 2;

[y, invAb, A_tilde, taglio]= gomory(A, b, x, r);

gomory_cut = "";
ind_cut = 1;
for i = 1 : numel(y)
    if(y(i) == 0)
        if(taglio(ind_cut) == 0)
            continue;
        end
        if(taglio(ind_cut) > 0)
            segno = "+";
        else
            segno = "";
        end
        
        gomory_cut = strcat(gomory_cut , segno ,  string(taglio(ind_cut)) , "*x" , string(i));
        ind_cut = ind_cut+1;
    end
end
gomory_cut = strcat(gomory_cut , " >= " , string(taglio(ind_cut)));

clear segno r i taglio ind_cut b A x;
