s = 0;
clear yd xd xt yt
for k = 1:1:numObj
    ydist = A(n,1,k);
    xdist = A(n,2,k);
    xtrue = A(1,2,k);
    ytrue = A(1,1,k);
    %if ydist~=0 && xdist~=0 && xdist<497 && ydist>15 && ydist<497
    if ydist~=0 && xdist~=0 && xdist>15 && ydist>15 && ydist<497
        s = s+1;
        yd(s) = ydist;
        xd(s) = xdist;
        xt(s) = xtrue;
        yt(s) = ytrue;
    end
end

if s>0

beta0 = [reshape(ones(N), [1, N*N])];

input = [s; N];
input(1:2, 2:(s+1)) = [yd; xd];

betaX=nlinfit(input,xt,@(beta,x)modelfunXnew(beta,x),beta0);
betaY=nlinfit(input,yt,@(beta,x)modelfunYnew(beta,x),beta0);

set(0,'DefaultAxesFontSize',14,'DefaultAxesFontName','Times New Roman');
set(0,'DefaultTextFontSize',14,'DefaultTextFontName','Times New Roman'); 
%colormap gray
hold on;
plot(xd, yd, 'ro', 'MarkerSize', 6);
plot(xt, yt, 'k+', 'MarkerSize', 6);
axis('image')
%axis([200 512 0 512])

hold on;
xcorrect = modelfunXnew(betaX,input);
ycorrect = modelfunYnew(betaY,input);
plot(xcorrect, ycorrect, 'b*',  'MarkerSize', 6);
hold on;

pause(0.01)

end
