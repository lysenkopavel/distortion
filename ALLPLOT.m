clear all;
choosefile

inf=fitsinfo(name);
sz=inf.PrimaryData.Size;

data = fitsread(name,'Table');
dsz=size(data{3});
dsz=dsz(1);

mstart=1;
mend=sz(3);

set(0,'DefaultAxesFontSize',16,'DefaultAxesFontName','Times New Roman');
set(0,'DefaultTextFontSize',16,'DefaultTextFontName','Times New Roman'); 

subplot(1,2,1);
m = 1;
frame=fitsread(name,'pixelRegion',{[1 sz(1)];[1 sz(2)];[m]});
imagesc(frame)
axis('image')
axis xy;
axis([0 300 0 512])
colormap gray
caxis([300 3000])
title('Изображение без дисторсии.')

subplot(1,2,2);
m = 250;
frame=fitsread(name,'pixelRegion',{[1 sz(1)];[1 sz(2)];[m]});
imagesc(frame)
axis('image')
axis xy;
axis([0 300 0 512])
colormap gray
caxis([300 3000])
title(sprintf('Изображение с дисторсией.\n Растяжение объектов из-за дисперсии.'))
