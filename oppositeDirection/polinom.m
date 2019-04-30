function y = polinom(XY,a)

    xc = 128;
    yc = 256;
    sz=512;
    N = 2;
    
    xd = XY(:,1);
    yd = XY(:,2);
    
    s = 0;
    for i=1:1:N
        for j=1:1:N
            s = s + ((((xd-xc)./sz).^(i-1)).*(((yd-yc)./sz).^(j-1))).*a(i,j);
        end
    end
    y = s.*sz;
    
end

