clear all
choosefile
load(result_name)
sz=size(result);

data = fitsread(name,'Table');
dsz=size(data{3});
dsz=dsz(1);

bw = (result(:,:,1)>0);
CC = bwconncomp(bw,8);

r = 15;
A = zeros(sz(3),2,CC.NumObjects); 
show_img = zeros(sz(1), sz(2));
for i=1:1:CC.NumObjects
    [ROW,COL] = ind2sub(CC.ImageSize,CC.PixelIdxList{i});
    A(1,1:2,i) = [ROW,COL];
    show_img(A(1,2,i), A(1,1,i)) = 1;
    for n = 2:1:sz(3)
        top = ROW-r;
        bottom = ROW+r;
        left = COL-r;
        right = COL+r;
        if top<1, top = 1; end
        if bottom>sz(1), bottom = sz(1); end 
        if left<1, left = 1; end
        if right>sz(2), right = sz(2); end 
        [row,col] = find(result(top:bottom,left:right,n));
        if isempty(row)
            A(n,:,i) = [0,0];
        else
            A(n,:,i) = [row(1)+top,col(1)+left];
            ROW = A(n,1,i);
            COL = A(n,2,i);
            
            cx = A(n,2,i);
            cy = A(n,1,i);
            l = 1;
            top = cy-l;
            bottom = cy+l;
            left = cx-l;
            right = cx+l;
            if top<1, top = 1; end
            if bottom>sz(1), bottom = sz(1); end 
            if left<1, left = 1; end
            if right>sz(2), right = sz(2); end 

            show_img(top:bottom, left:right) = data{3}(n);
           
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