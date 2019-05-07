clear all

choosefile

load(['mass_image_centers' '_' result_name]);
sz=size(A);
numObj = sz(3);
frames = sz(1);
data = fitsread(name,'Table');

angle = data{3};
ansz = size(angle);
%
for i=1:1:ansz
    angle(i) = (angle(i) - (180 - angle(i)))/2;
end
%}
angle = angle.*pi/180;

N=2;
bX = zeros(N,N,frames);
bY = zeros(N,N,frames);

figure
for n = 2:1:frames
    aproxdist
    bX(:,:,n) = reshape(betaX,[N, N]);
    bY(:,:,n) = reshape(betaY,[N, N]);
end
lgd = legend({'distortion','calculated','correct'},'Location','bestoutside', 'FontSize',18);
legend('boxoff')
title(lgd,'Data')
axis('image')
axis([0 310 0 512])
set(0,'DefaultAxesFontSize',18,'DefaultAxesFontName','Times New Roman');
set(0,'DefaultTextFontSize',18,'DefaultTextFontName','Times New Roman'); 
pause(0.01)


figure;
l = 1;
harmonicX(1:N,1:N) = struct('betax',0);
fprintf('\\begin{table}[!ht]\n')
for i=1:1:N
    for j = 1:1:N
        subplot(N,N,l)
        x(:) = bX(i,j,:);
        [beta,R,J]=nlinfit(angle,x',@(beta,x)harmonic_function(beta,x),[1 1 1 1 1 0 0 0 0]);
        ci = nlparci(beta, R, 'jacobian', J);
        
        harmonicX(i,j) = struct('betax',beta);
        
        generate_latex_table(beta,ci,'A',i,j)
        
        plot(angle.*(180/pi),x,'bo');
        hold on
        plot(angle.*(180/pi),harmonic_function(beta,angle),'r*');
        title(sprintf('A_{%d%d}', i,j))
        xlabel('angle [deg]','FontSize',14)
        xlim([0 360])
        lgd = legend({'calculated','approximated'},'Location','best', 'FontSize',12);
        legend('boxon')
        title(lgd,'distortion coefficient')
        
        l=l+1;
    end
end
fprintf('\\end{table}\n\n')

figure;
l = 1;
harmonicY(1:N,1:N) = struct('betay',0);
fprintf('\\begin{table}[!ht]\n')
for i=1:1:N
    for j = 1:1:N
        subplot(N,N,l)
        y(:) = bY(i,j,:);
        [beta,R,J]=nlinfit(angle,y',@(beta,x)harmonic_function(beta,x),[1 1 1 1 1 0 0 0 0]);
        ci = nlparci(beta, R, 'jacobian', J);
        
        harmonicY(i,j) = struct('betay',beta);
        
        generate_latex_table(beta,ci,'B',i,j)
        
        plot(angle.*(180/pi),y,'bo');
        hold on
        plot(angle.*(180/pi),harmonic_function(beta,angle),'r*');
        title(sprintf('B_{%d%d}', i,j))
        xlabel('angle [deg]','FontSize',14)
        xlim([0 360])
        lgd = legend({'calculated','approximated'},'Location','best', 'FontSize',12);
        legend('boxon')
        title(lgd,'distortion coefficient')
        
        l = l+1;
    end
end
fprintf('\\end{table}\n\n')

save(['harmonicX' '_' result_name], 'harmonicX');
save(['harmonicY' '_' result_name], 'harmonicY');
