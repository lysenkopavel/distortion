    function y = modelfunYnew(beta,x)
    
    xc = 128;
    yc = 256;
    sz=512;
    
    numObj = x(1,1);
    N = x(2,1);
    
    i = 1:N;
    j = 1:N;
    
    a(i,j) = reshape(beta,[N, N]);
    yd(:) = x(1,2:numObj+1);
    xd(:) = x(2,2:numObj+1);
    
    for k=1:1:numObj
        s = yd(k)./sz;
        for i=1:1:N
            for j=1:1:N
                s = s + ((((xd(k)-xc)./sz).^(i-1)).*(((yd(k)-yc)./sz).^(j-1))).*a(i,j);
            end
        end
        y(k) = s.*sz;
    end
    
end


