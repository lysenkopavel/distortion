clear all;
choosefile

inf=fitsinfo(name);
sz=inf.PrimaryData.Size;

data = fitsread(name,'Table');
dsz=size(data{3});
dsz=dsz(1);

mstart=1;
mend=sz(3);

frm=zeros(sz(1),sz(2));
frmnum = 0;
%result = zeros(sz(1), sz(2), dsz);
result(1:dsz) = struct('A',0);

j=1;
for m=mstart:mend

    if (m>=data{1}(j) && m<=data{2}(j)) 
        frame=fitsread(name,'pixelRegion',{[1 sz(1)];[1 sz(2)];[m]});
        frm=frm+frame;
        frmnum = frmnum+1;

    end
    if (m==data{2}(j)+1)
        frm=frm./frmnum;  
        %frm(:,1:200) = 0;
        frm(:,300:512) = 0;
        frm = imgaussfilt(frm, 4);
        bw = (frm>max(max(frm))/2000);
        CC = bwconncomp(bw,8);
        %A=zeros(sz(1),sz(2));
        A = [];
        [ A ] = divideimage(CC, frm, bw, A, "centerofmass");
        result(j) = struct('A',A);
        %result(:,:,j) = A;

        subplot(1, 2, 1)
        imagesc(frm(1:512, 1:310))
        colormap(gray)
        axis('image')
        axis xy;
        
        subplot(1, 2, 2)
        %imagesc(A)
        %caxis ([100,1000])
        plot(A(:,1),A(:,2),'bo')
        xlim([1 310])
        ylim([1 512])
        %axis([1 310 1 512])
        %axis('image')
        
        pause(0.1)
        frm=zeros(sz(1),sz(2));
        j=j+1;
        frmnum = 0;
        fprintf("j=%d\n",j)
        if (j>size(data{1}))
            break
        end
    end
        
end

save(result_name, 'result');
