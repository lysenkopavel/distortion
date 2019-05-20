function [a, b] = get_ab(ang, harmonicX, harmonicY)
    
    ang = ang*pi/180;
    
    for i = 1:1:2
        for j = 1:1:2
            a(i,j)=harmonic_function(harmonicX(i,j).beta,ang);
        end
    end

    for i = 1:1:2
        for j = 1:1:2
            b(i,j)=harmonic_function(harmonicY(i,j).beta,ang);
        end
    end

end