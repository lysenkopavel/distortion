function [ A ] = divideimage(CC, frm, bw, A, typeresult)
    sz=size(frm);
    for i=1:1:CC.NumObjects
        
        mask=zeros(sz(1),sz(2));
        mask(CC.PixelIdxList{i}) = bw(CC.PixelIdxList{i});
        image = frm.*mask;
        
        %1.4 1.3 1.2
        ph = [40 30 20 10 5 2 1.8 1.6 1.5];
        sizeph = size(ph);
        j = 1;
        pnew = ph(j);
        divideimg=1;
        while (divideimg==1)&&(j<sizeph(2)+1)
            pnew = ph(j);
            bwnew = (frm>max(max(frm))/pnew);
            CCnew = bwconncomp(bwnew,8);
            divideimg = CCnew.NumObjects;
            j=j+1;
        end
        
        if (divideimg~=1)
            [A] = divideimage(CCnew, image, bwnew, A, typeresult);
        else
            
            if (strcmp(typeresult, "mask"))
                A = A + mask;
            else 
                if (max(max(image)) ~= 0)
                    mass = sum(sum(image));
                    y = sum(image,2);
                    x = sum(image);
                    [n k] = meshgrid(1:sz(1),1:sz(2));
                    center_of_mass_x = sum(n(1,:).*x)/mass;
                    center_of_mass_y = sum(k(:,1).*y)/mass;
                    
                    sza = size(A);
                    w = sza(1)+1;
                    A(w,1) = center_of_mass_x;
                    A(w,2) = center_of_mass_y;
                    
                    %{
                    cy = round(center_of_mass_y);
                    cx = round(center_of_mass_x);
                    l = 0;
                    top = cy-l;
                    bottom = cy+l;
                    left = cx-l;
                    right = cx+l;
                    if top<1, top = 1; end
                    if bottom>sz(1), bottom = sz(1); end 
                    if left<1, left = 1; end
                    if right>sz(2), right = sz(2); end 

                    A(top:bottom, left:right) = mass;
                    %}
                end
            end
        end
    end
end
