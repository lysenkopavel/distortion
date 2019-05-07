function generate_latex_table(beta,ci,name,i,j)
        
    %fprintf('%s_{%d%d}: \n', name,i,j)

    fprintf('\\parbox{.45\\linewidth}{')
    fprintf('\\begin{center}\n')
    fprintf('\\begin{tabular}{c|c|c}\n')
    fprintf('\\hline\n')
    fprintf('n & $\\kappa(n)$ & $\\delta\\alpha(n)$ \\\\ \n')
    fprintf('\\hline\n')
    fprintf('1 & %.2f $\\pm$ %.2f & - \\\\ \n',beta(1)*10^3,(ci(1,2)-ci(1,1))/2*10^3)
    numb = (length(beta)+1)/2;
    for p =2:1:numb
        fprintf('%d & %.2f $\\pm$ %.2f &',p,beta(p)*10^3,(ci(p,2)-ci(p,1))/2*10^3)
        al_num = numb+p-1;
        if (abs(beta(al_num))>2*pi)
            beta(al_num) = mod(beta(al_num),2*pi); 
        end
        fprintf(' %.2f $\\pm$ %.2f \\\\ \n',beta(al_num).*180/pi,(ci(al_num,2)-ci(al_num,1)).*(180/pi)/2)
    end
    fprintf('\\end{tabular}\n')
    fprintf('\\caption{$%s_{%d%d}$}\n', name,i,j)
    fprintf('\\label{tabl:%s%d%d}\n', name,i,j)
    fprintf('\\end{center}\n')
    fprintf('}\n\\hfill\n')
    
end

