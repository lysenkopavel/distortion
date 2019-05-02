clear yd xd xt yt input xyt
indx_end = 1;
for j=1:1:length(z)
    n = z(j);
    s = 0;
    for k = 1:1:numObj
        ydist = ydd(n,k);
        xdist = xdd(n,k);
        xtrue = xtrue_opposite(k);
        ytrue = ytrue_opposite(k);
        if ydist~=0 && xdist~=0 && xdist>15 && ydist>15 && ydist<497
            s = s+1;
            yd(s) = ydist;
            xd(s) = xdist;
            xt(s) = xtrue;
            yt(s) = ytrue;
        end
    end
    
    xyt(1,indx_end:indx_end+s-1) = xt;
    xyt(1,indx_end+s:indx_end+2*s-1) = yt;

    xyd(1,indx_end:indx_end+s-1) = xd;
    xyd(1,indx_end+s:indx_end+2*s-1) = yd;

    ss(j)=s;    
    indx_end = indx_end+2*s;
    
    clear xt yt xd yd
end

ndata = [N 512 length(z)];

beta = [112 218];

%
[beta,R,J,CovB,MSE,ErrorModelInfo]=nlinfit(xyd,xyt,@(beta,xyd)oneDirection(beta,xyd,dang,a,b,ss,ndata),beta);
ci = nlparci(beta, R, 'jacobian', J);
%}
correct = oneDirection(beta,xyd,dang,a,b,ss,ndata);

colour = ['r' 'b' 'g' 'm' 'k'];
hold on;
indx_end = 1;
dx = 0;
dy = 0;
for j=1:1:length(z)
    s = ss(j);
    
    xcorrect = correct(indx_end:indx_end+s-1);  
    ycorrect = correct(indx_end+s:indx_end+2*s-1);
    plot(xcorrect, ycorrect, [colour(j) '*'],  'MarkerSize', 4);
    
    xt = xyt(1,indx_end:indx_end+s-1);
    yt = xyt(1,indx_end+s:indx_end+2*s-1);
    plot(xt, yt, 'k+', 'MarkerSize', 10);
    
    xd = xyd(1,indx_end:indx_end+s-1);
    yd = xyd(1,indx_end+s:indx_end+2*s-1);
    plot(xd, yd, [colour(j) 'o'], 'MarkerSize', 4);
    
    dx = dx + sum((xcorrect - xt).^2);
    dy = dy + sum((ycorrect - yt).^2);
    
    %
    for p=1:1:s
        fprintf("%d %f %f\n", p, xcorrect(p) - xt(p), ycorrect(p) - yt(p))
    end
    fprintf("#####################\n")
    %}
    
    indx_end = indx_end+2*s;
    
end

fprintf('xc = %f\t yc = %f\n dx = %f\t dy = %f\n', beta(1), beta(2), sqrt(dx), sqrt(dy));

set(0,'DefaultAxesFontSize',14,'DefaultAxesFontName','Times New Roman');
set(0,'DefaultTextFontSize',14,'DefaultTextFontName','Times New Roman'); 
axis('image')

pause(0.01)
