choosefile

load(['harmonicY_' result_name]);
load(['harmonicX_' result_name]);

f = figure;
f.PaperType = 'a4';
f.PaperOrientation = 'landscape';

%[ha, pos] = tight_subplot(4,2,[0.0 .08],[.1 .05],[.1 .1]);
[ha, pos] = tight_subplot(4,2,[.0 .1],[.1 .05],[.1 .1]);

set(0,'DefaultAxesFontSize',18,'DefaultAxesFontName','Times New Roman');

i=1;
for ii = 1:1:4
    
    h = harmonicX(ii);
    axes(ha(i));
    plot(h.angle.*(180/pi),h.data,'bo');
    hold on
    plot(h.angle.*(180/pi),harmonic_function(h.beta,h.angle),'r*');
    xlim([0 270])
    ax = gca;
    ax.YAxis.Exponent = -2;
    [I,J] = ind2sub([2 2],ii);
    ylabel(sprintf('A_{%d%d}', I,J),'FontSize',14);
    grid on
    grid minor
    if mod(ii,2)~=1
        ax.YAxisLocation = 'right';
    end
        
    
    i=i+1;
    
    h = harmonicY(ii);
    axes(ha(i));
    plot(h.angle.*(180/pi),h.data,'bo');
    hold on
    plot(h.angle.*(180/pi),harmonic_function(h.beta,h.angle),'r*');
    xlim([0 270])
    ax = gca;
    ax.YAxis.Exponent = -2;
    [I,J] = ind2sub([2 2],ii);
    ylabel(sprintf('B_{%d%d}', I,J),'FontSize',18);
    if mod(ii,2)~=1
        ax.YAxisLocation = 'right';
    end
    grid on
    grid minor
    
    i=i+1;
    
end

axes(ha(7));
xlabel('angle [deg]','FontSize',14)
axes(ha(8));
xlabel('angle [deg]','FontSize',14)

set(ha(1:6),'XTickLabel',''); 
%set(ha,'YTickLabel','')

lgd = legend({'calculated','approximated'},'Location','best', 'FontSize',12);
axes(ha(8))
legend('boxon')
%title(lgd,'distortion coefficient')
legend('Orientation','horizontal')
