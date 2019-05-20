%{
exp 0.3
ADCPeriod 2.5
ADCStep -3
HWPStart 10
EMGain 50
%}

%R
%result_name = 'resultR.mat';
%name = '/media/pasha/SHD/Work/4_distortion/testframes/myframes/SP20180406124542.fits';

%B
%result_name = 'resultB.mat';
%name = 'testframes/myframes/SP20180406125844.fits';

%V
%result_name = 'resultV.mat';
%name = '/media/pasha/SHD/Work/4_distortion/testframes/myframes/SP20180406130345.fits';

%I exp0.5
%result_name = 'resultI.mat';
%name = 'testframes/myframes/SP20180406133121.fits';

%session5R

%{
%550nm
result_name = 'result550.mat';
name = 'testframes/myframes/SP20180508123905.fits';
%}

%{
%625nm
result_name = 'result625.mat';
name = 'testframes/myframes/SP20180508124540.fits';
%}

%{
%880nm (EMGain 500)
result_name = 'result880.mat';
name = 'testframes/myframes/SP20180508131400.fits';
%}



%%%%%%%%%%%

% В левом луче поляриметра

%эксперименты в одном направлении
%{
result_name = 'newOneDirection550.mat';
name = 'newFrames/SP20190324164201.fits';
%}
%
filter = '625';
direction = 'OneDirection';
id = 'new2';
result_name = [id direction filter '.mat'];
name = 'newFrames/SP20190324165348.fits';
%}
%{
result_name = 'newOneDirection880.mat';
name = 'newFrames/SP20190324172254.fits';
%}

%в разных направлениях
%{
result_name = 'newOppositeDirection880.mat';
name = 'newFrames/SP20190324174618.fits';
%}
%{
filter = '625';
direction = 'OppositeDirection';
id = 'new2';
result_name = [id direction filter '.mat'];
name = 'newFrames/SP20190324181155.fits';
%}
%{
result_name = 'newOppositeDirection550.mat';
name = 'newFrames/SP20190324175751.fits';
%}
