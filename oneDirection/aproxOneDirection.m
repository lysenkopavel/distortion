clear yd xd xt yt input xyt
indx_end = 1;
for j=1:1:length(z)
    n = z(j);
    s = 0;
    for k = 1:1:numObj
        ydist = A(n,1,k);
        xdist = A(n,2,k);
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
end

ndata = [N 512 length(z)];

beta0 = [112 218];

correct = oneDirection(beta0,xyd,dang,a,b,ss,ndata);

colour = ['r' 'b' 'g'];
hold on;
indx_end = 1;
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
    
    indx_end = indx_end+2*s;
end

set(0,'DefaultAxesFontSize',14,'DefaultAxesFontName','Times New Roman');
set(0,'DefaultTextFontSize',14,'DefaultTextFontName','Times New Roman'); 
axis('image')

pause(0.01)

