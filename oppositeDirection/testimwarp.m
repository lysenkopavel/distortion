clear all
choosefile;

inf=fitsinfo(name);
sz=inf.PrimaryData.Size;

data = fitsread(name,'Table');
dsz=size(data{3});
dsz=dsz(1);
angle = data{3};

mstart=1;
mend=sz(3);

%harmonicX = load(['harmonicX' '_' result_name]);
harmonicX = load(['harmonicX' '_' 'result625']);
harmonicX = harmonicX.harmonicX;
%harmonicY = load(['harmonicY' '_' result_name]);
harmonicY = load(['harmonicY' '_' 'result625']);
harmonicY = harmonicY.harmonicY;

N=2;
a = zeros(N,N);
b = zeros(N,N);

figure;
axis('image')

j = 16;

ang = data{3}(j);
if ang>180
       ang = ang-360;
end
ang = ang.*pi/180;
for i=1:1:N
    for k = 1:1:N
        a(i,k) = harmonic_function(harmonicX(i,k).betax(:),ang);
        b(i,k) = harmonic_function(harmonicY(i,k).betay(:),ang);
    end
end

for m = mstart:mend
   
    if (m>=data{1}(j) && m<=data{2}(j))

        frame=fitsread(name,'pixelRegion',{[1 sz(1)];[1 sz(2)];[m]});

        %inversefn = @(img)[polinom(img,-a)+img(:,1), polinom(img,-b)+img(:,2)];
        %tform = geometricTransform2d(inversefn);
        %correctFrame = imwarp(frame,tform);

        correctFrame = correctImage(a,b,frame);
        subplot(1,2,1);
        imagesc(frame);
        subplot(1,2,2);
        imagesc(correctFrame);
        pause(0.01)
  
    end
    
    if (m==data{2}(j)+1)
        %j=j+1;
        fprintf("j=%d\n",j)
        if (j>size(data{1}))
            break
        end
        
        ang = data{3}(j);
        if ang>180
               ang = ang-360;
        end
        ang = ang.*pi/180;

        for i=1:1:N
            for k = 1:1:N
                a(i,k) = harmonic_function(harmonicX(i,k).betax(:),ang);
                b(i,k) = harmonic_function(harmonicY(i,k).betay(:),ang);
            end
        end
    end
        
    
end

%}


%{
%UV = transformPointsInverse(tform,XY);
plot(xt, yt, 'b+', 'MarkerSize', 8);
hold on;
plot(UV(:,1), UV(:,2), 'b*', 'MarkerSize', 8);
plot(xd, yd, 'ro', 'MarkerSize', 8);
axis('image')
axis([0 512 0 512])
%}

%{
XY = zeros(s,2);
for k = 1:1:s
    %XY(k,1:2) = [xt(k) yt(k)];
    XY(k,1:2) = [xd(k) yd(k)];
end

%[xr, fr, ex] = fsolve(@(xy)fun2([xt(:) yt(:)], xy, a, b),XY);
%inversefn = @(xr)[polinom(xr,a)+xr(:,1), polinom(xr,b)+xr(:,2)];
%}


