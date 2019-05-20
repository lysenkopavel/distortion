function y = harmonic_function(beta,x)
    k = (length(beta)+1)/2;
    s = beta(1);
    for n =2:1:k
        s = s+ beta(n).*cos((n-1).*(x+beta(k+n-1)));
    end
    y = s;
end

