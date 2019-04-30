function y = harmonic_function(beta,x)
    k = numel(beta)/2;
    s = 0;
    for n =1:1:k
        s = s+ beta(n).*cos((n-1).*(x+beta(k+n)));
    end
    y = s;
end

