clear all;
choosefile

inf=fitsinfo(name);
sz=inf.PrimaryData.Size;

data = fitsread(name,'Table');
dsz=size(data{3});
dsz=dsz(1);

mstart=1;
mend=sz(3);

m = 250;

frame=fitsread(name,'pixelRegion',{[1 sz(1)];[1 sz(2)];[m]});

imagesc(frame)
axis('image')
axis xy;
axis([0 300 0 512])
colormap gray
caxis([300 3000])

