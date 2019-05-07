for i = 1:1:length(z)
    ang(i) = data{3}(z(i));
end

plot(ang, beta(3:2+length(z)), 'ro')

figure

plot(ang, beta(3+length(z):2+2*length(z)), 'bo');

figure 

plot(beta(3:2+length(z)), beta(3+length(z):2+2*length(z)), 'bo');