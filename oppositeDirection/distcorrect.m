clear all

choosefile

load(['mass_image_centers' '_' result_name]);
sz=size(A);
numObj = sz(3);
frames = sz(1);
data = fitsread(name,'Table');

angle = data{3};
ansz = size(angle);
angle = angle.*pi/180;

N=2;
bX = zeros(N,N,frames);
bY = zeros(N,N,frames);

for n = 2:1:frames
    aproxdist
    bX(:,:,n) = reshape(betaX,[N, N]);
    bY(:,:,n) = reshape(betaY,[N, N]);
end

figure;
l = 1;
harmonicX(1:N,1:N) = struct('betax',0);
for i=1:1:N
    for j = 1:1:N
        subplot(N,N,l)
        x(:) = bX(i,j,:);
        beta=nlinfit(angle,x',@(beta,x)harmonic_function(beta,x),[1 1 1 1 0 0 0 0]);
        harmonicX(i,j) = struct('betax',beta);
        plot(angle,x,'ro');
        hold on
        plot(angle,harmonic_function(beta,angle),'*-');
        title(sprintf('betaX: i = %d j = %d', i,j))
        l=l+1;
    end
end

figure;
l = 1;
harmonicY(1:N,1:N) = struct('betay',0);
for i=1:1:N
    for j = 1:1:N
        subplot(N,N,l)
        y(:) = bY(i,j,:);
        beta=nlinfit(angle,y',@(beta,x)harmonic_function(beta,x),[1 1 1 1 0 0 0 0]);
        harmonicY(i,j) = struct('betay',beta);
        plot(angle,y,'ro');
        hold on
        plot(angle,harmonic_function(beta,angle),'*-');
        title(sprintf('betaY: i = %d j = %d', i,j))
        l = l+1;
    end
end

save(['harmonicX' '_' result_name], 'harmonicX');
save(['harmonicY' '_' result_name], 'harmonicY');
