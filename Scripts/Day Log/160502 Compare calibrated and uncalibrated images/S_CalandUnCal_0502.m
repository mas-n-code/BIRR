%% Script that compares a uncalibrated and calibrated images. loads SL72_P1 dataset

%%
%%Load dataset
%@ guaper
cd('F:\UserElGuapo\DBOx\Dropbox\ResearchMagic\RandomProyects\160110 12 Effects of AR\MASTER Dataset\L288xP1');
set(0,'DefaultFigureColormap',paruly)


load SL72_P1.mat% Load the file
load RecSettings_ExperimentSL72.mat% Load the file

%% Generate empty array (ceros only)
RefEmtpy=zeros(size(SL72_P1.set_ref));

% 

%% Reconstruct of  background calibration data only
tic

supershort='Control dataset 1, calibration data ';
[SCAN_72P1_CalibrationData]=...
     monofun_mario_cmS(RefEmtpy,SL72_P1.set_ref,RecSettings,supershort);


toc

%hide labels and title
xlabel('');ylabel('');title('');


%%

axes1=gca;
set(gca,...
    'XTickLabel',{'-15','-10','-5','0','5','10','15'},...
    'XTick',[-15 -10 -5 0 5 10 15],...
    'YTickLabel',{'-15','-10','-5','0','5','10','15'},...
    'YTick',[-15 -10 -5 0 5 10 15],...
    'TickDir','out',...
    'TickLength',[0.02 0.02],... 
    'Layer','top',...
    'FontSize',16,...
    'FontName','Times New Roman',...
    'DataAspectRatio',[1 1 1]);
axis square
%   'Position',[0.13 0.11 0.789514884233738 0.815],
colorbar('peer',axes1,'FontSize',16,'FontName','Times New Roman');
%set(gcf,'PaperPositionMode', 'auto');
set(gcf, 'Units', 'centimeters');
set(gcf, 'Position', [0 0 11 9]); %x_width=10cm y_width=15cm
export_fig('-png','-transparent','-nocrop','figurin calibrationData') % '-r300'






%% Reconstruct without background calibration
tic

supershort='Control dataset 1, without calibration ';
[SCAN_72P1_NotCalibrated]=...
     monofun_mario_cmS(RefEmtpy,SL72_P1.set_data,RecSettings,supershort);


toc


%% save the fig

%hide labels and title
xlabel('');ylabel('');title('');


axes1=gca;
set(gca,...
    'XTickLabel',{'-15','-10','-5','0','5','10','15'},...
    'XTick',[-15 -10 -5 0 5 10 15],...
    'YTickLabel',{'-15','-10','-5','0','5','10','15'},...
    'YTick',[-15 -10 -5 0 5 10 15],...
    'TickDir','out',...
    'TickLength',[0.02 0.02],... 
    'Layer','top',...
    'FontSize',16,...
    'FontName','Times New Roman',...
    'DataAspectRatio',[1 1 1]);
axis square
%   'Position',[0.13 0.11 0.789514884233738 0.815],
colorbar('peer',axes1,'FontSize',16,'FontName','Times New Roman');
%set(gcf,'PaperPositionMode', 'auto');
set(gcf, 'Units', 'centimeters');
set(gcf, 'Position', [0 0 11 9]); %x_width=10cm y_width=15cm
export_fig('-png','-transparent','-nocrop','figurin nocalibrad') % '-r300'


%% Reconstruct Sampled data
%P1
tic

supershort='Control dataset 1, calibrated ';
[SCAN_72P1_Calibrated]=...
     monofun_mario_cmS(SL72_P1.set_ref,SL72_P1.set_data,RecSettings,supershort);


toc


%% save the fig for presentation

%hide labels and title
xlabel('');ylabel('');title('');


axes1=gca;
set(gca,...
    'XTickLabel',{'-15','-10','-5','0','5','10','15'},...
    'XTick',[-15 -10 -5 0 5 10 15],...
    'YTickLabel',{'-15','-10','-5','0','5','10','15'},...
    'YTick',[-15 -10 -5 0 5 10 15],...
    'TickDir','out',...
    'TickLength',[0.02 0.02],... 
    'Layer','top',...
    'FontSize',16,...
    'FontName','Times New Roman',...
    'DataAspectRatio',[1 1 1]);
axis square
%   'Position',[0.13 0.11 0.789514884233738 0.815],
colorbar('peer',axes1,'FontSize',16,'FontName','Times New Roman');
%set(gcf,'PaperPositionMode', 'auto');
set(gcf, 'Units', 'centimeters');
set(gcf, 'Position', [0 0 11 9]); %x_width=10cm y_width=15cm
export_fig('-png','-transparent','-nocrop','figurin calibrated') % '-r300'


%% change clim in case dr. p
caxis([0 4.8e-7])

export_fig('-png','-transparent','-nocrop','figurin calibrated CLim') % '-r300'
