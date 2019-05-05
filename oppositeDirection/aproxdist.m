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

xcorrect = modelfunXnew(betaX,input);
ycorrect = modelfunYnew(betaY,input);

plot(xd, yd, 'bo', 'MarkerSize', 8);
hold on;
plot(xcorrect, ycorrect, 'r*',  'MarkerSize', 8);
plot(xt, yt, 'k+', 'MarkerSize', 14);
hold on;

lgd = legend({'distortion','calculated','correct'},'Location','bestoutside', 'FontSize',18);
legend('boxoff')
title(lgd,'Data')
axis('image')
axis([0 310 0 512])
set(0,'DefaultAxesFontSize',18,'DefaultAxesFontName','Times New Roman');
set(0,'DefaultTextFontSize',18,'DefaultTextFontName','Times New Roman'); 

pause(0.01)

end
