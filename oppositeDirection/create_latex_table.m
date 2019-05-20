function create_latex_table(harmonic,name)
    fprintf('\\begin{table}[!h]\n')
    fprintf('\\begin{center}\n')
    fprintf('\\begin{tabular}{c|c|c||c|c|}\n')
    fprintf('\\hline\n')
    fprintf('n & $\\kappa_{n}$ & $\\delta\\alpha_{n}$ & $\\kappa_{n}$ & $\\delta\\alpha_{n}$ \\\\ \n')
    fprintf('\\hline\n')

    numb = 5;
    j=2;
    for z=1:1:j
        fprintf(' & \\multicolumn{2}{c||}{$%s_{%d1}$} & \\multicolumn{2}{c|}{$%s_{%d2}$} \\\\ \n',name,z,name,z)
        fprintf('\\hline\n')
        fprintf('1 & %.2f $\\pm$ %.2f & - & %.2f $\\pm$ %.2f & - \\\\ \n',harmonic(z,1).beta(1)*10^3,(harmonic(z,1).ci(1,2)-harmonic(z,1).ci(1,1))/2*10^3,harmonic(z,2).beta(1)*10^3,(harmonic(z,2).ci(1,2)-harmonic(z,2).ci(1,1))/2*10^3)
        for p = 2:1:numb
            fprintf('%d & %.2f $\\pm$ %.2f &',p,harmonic(z,1).beta(p)*10^3,(harmonic(z,1).ci(p,2)-harmonic(z,1).ci(p,1))/2*10^3)
            al_num = numb+p-1;
            if (abs(harmonic(z,1).beta(al_num))>2*pi)
                harmonic(z,1).beta(al_num) = mod(harmonic(z,1).beta(al_num),2*pi); 
            end
            fprintf(' %.2f $\\pm$ %.2f',harmonic(z,1).beta(al_num).*180/pi,(harmonic(z,1).ci(al_num,2)-harmonic(z,1).ci(al_num,1)).*(180/pi)/2)

            fprintf('& %.2f $\\pm$ %.2f &',harmonic(z,2).beta(p)*10^3,(harmonic(z,2).ci(p,2)-harmonic(z,2).ci(p,1))/2*10^3)
            al_num = numb+p-1;
            if (abs(harmonic(z,2).beta(al_num))>2*pi)
                harmonic(z,2).beta(al_num) = mod(harmonic(z,2).beta(al_num),2*pi); 
            end
            fprintf(' %.2f $\\pm$ %.2f \\\\ \n',harmonic(z,2).beta(al_num).*180/pi,(harmonic(z,2).ci(al_num,2)-harmonic(z,2).ci(al_num,1)).*(180/pi)/2)

        end
        fprintf('\\hline\n')

    end
    fprintf('\\end{tabular}\n')
    fprintf('\\caption{%s}\n', name)
    fprintf('\\label{tabl:%s}\n', name)
    fprintf('\\end{center}\n')
    fprintf('\\hfill\n')
    fprintf('\\end{table}\n\n')
end
