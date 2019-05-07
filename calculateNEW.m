clear all
choosefile
load(result_name)
sz=size(result);
sz = sz(2);
szz = 512;

data = fitsread(name,'Table');
dsz=size(data{3});
dsz=dsz(1);

numObj = size(result(1).A);
numObj = numObj(1);

r = 5;
A = zeros(sz,2,numObj); 
show_img = zeros(szz,szz);
for i=1:1:numObj
    ROW = result(1).A(i,2);
    COL = result(1).A(i,1);
    A(1,1:2,i) = [ROW, COL];
    show_img(round(ROW), round(COL)) = 1;
    for n = 2:1:sz
        top = ROW-r;
        bottom = ROW+r;
        left = COL-r;
        right = COL+r;
        if top<1, top = 1; end
        if bottom>szz, bottom = szz; end 
        if left<1, left = 1; end
        if right>szz, right = szz; end
        
        nob = size(result(n).A);
        for j=1:1:nob(1)
            coord = result(n).A(j,:);
            if coord(1)>left && coord(1)<right && coord(2)>top && coord(2)<bottom
                ROW = coord(2);
                COL = coord(1);
                A(n,1:2,i) = [ROW, COL];
                
                cx = round(COL);
                cy = round(ROW);
                l = 1;
                top = cy-l;
                bottom = cy+l;
                left = cx-l;
                right = cx+l;
                if top<1, top = 1; end
                if bottom>szz, bottom = szz; end 
                if left<1, left = 1; end
                if right>szz, right = szz; end 

                show_img(top:bottom, left:right) = data{3}(n);
                
                break;
            end
        end
       
        
    end
    %{
    plot(A(:,2,i), A(:,1,i), '*');
    hold on;
    pause(1)
    %}
    
end

figure
imagesc(show_img);
axis xy;
colormap jet
c = colorbar;
c.Label.String = 'Угол поворота призм';
c.Label.FontSize = 18;
axis('image')
set(0,'DefaultAxesFontSize',20,'DefaultAxesFontName','Times New Roman');
set(0,'DefaultTextFontSize',20,'DefaultTextFontName','Times New Roman');
%axis([200 520 0 520])
axis([0 300 0 512])

save(['mass_image_centers' '_' result_name], 'A');

%{
for i = 1:1:CC.NumObjects
    plot(A(1,2,i), A(1,1,i), '+');
    hold on;
    plot(A(10,2,i), A(10,1,i), 'o');
end
%}