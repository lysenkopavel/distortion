function y = oneDirection(beta,xyd,al,a,b,ss,ndata)

    N = ndata(1);
    sz = ndata(1);
    length_z = ndata(3);

    xc = beta(1);
    yc = beta(2);
    
    indx_end = 1;
    for j=1:1:length_z    
        ang = al(j);
        s=ss(j);
        
        clear xd yd
        
        M = [cos(ang) -sin(ang); sin(ang) cos(ang)];
        xd(1:s) = xyd(1,indx_end:indx_end+s-1);
        yd(1:s) = xyd(1,indx_end+s:indx_end+2*s-1);
        
        for k=1:1:s

                XY = [xd(k)-xc; yd(k)-yc];
                XYn=M*XY;

                xn(k) = XYn(1) + xc;
                yn(k) = XYn(2) + yc;

        end

        input = [s; N];
        input(1:2, 2:(s+1)) = [yn; xn];

        xncorrect = modelfunXnew(a,input);
        yncorrect = modelfunYnew(b,input);

        for k=1:1:s

                XYn = [xncorrect(k)-xc; yncorrect(k)-yc];
                XY=M\XYn;
                y(1,indx_end+k-1) = XY(1) + xc;
                y(1,indx_end+k-1+s) = XY(2) + yc;

        end
        
        indx_end = indx_end+2*s;
        
    end
        
end

