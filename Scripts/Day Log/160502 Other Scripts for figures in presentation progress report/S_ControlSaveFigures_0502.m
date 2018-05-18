%% Saves figures for presentation Control Datasets



%% save the fig for presentation

%hide labels and title
xlabel('');ylabel('');title('');



axes1=gca;
set(gca,...
    'XTickLabel',{'-10','0','10'},...
    'XTick',[-10  0  10],...
    'YTickLabel',{'-10','0','10'},...
    'YTick',[-10  0  10],...
    'TickDir','out',...
    'TickLength',[0.02 0.02],... 
    'Layer','top',...
    'FontSize',18,...
    'FontName','Times New Roman',...
    'DataAspectRatio',[1 1 1]);
axis square
%   'Position',[0.13 0.11 0.789514884233738 0.815],
colorbar('peer',axes1,'FontSize',18,'FontName','Times New Roman');
%set(gcf,'PaperPositionMode', 'auto');
set(gcf, 'Units', 'centimeters');
set(gcf, 'Position', [0 0 12 10]); %x_width=10cm y_width=15cm
export_fig('-png','-transparent','-nocrop','figurinP1 calibrated') % '-r300'




%% add error bars to plot figures
load('SCAN_SL72_P1.mat');

%%Error bars
openfig P1' mean powerV per region.fig'
errorbar(1,SCAN_72P1.PowImageMetrics.Tumor.Mean,SCAN_72P1.PowImageMetrics.Tumor.Std,'rx'),hold on;
errorbar(2,SCAN_72P1.PowImageMetrics.Fibro.Mean,SCAN_72P1.PowImageMetrics.Fibro.Std,'rx'),hold on;
errorbar(3,SCAN_72P1.PowImageMetrics.Back.Mean,SCAN_72P1.PowImageMetrics.Back.Std,'rx'),hold on;



%% Save of the plot figure powers
%hide labels and title
%xlabel('');ylabel('');
title('');


axes1=gca;
set(gca,...
    'TickDir','out',...
    'TickLength',[0.02 0.02],... 
    'Layer','top',...
    'FontSize',18,...
    'FontName','Times New Roman');

%   'Position',[0.13 0.11 0.789514884233738 0.815],
%colorbar('peer',axes1,'FontSize',16,'FontName','Times New Roman');
%set(gcf,'PaperPositionMode', 'auto');
set(gcf, 'Units', 'centimeters');
set(gcf, 'Position', [0 0 14.85 9.4]); %x_width=10cm y_width=15cm
export_fig('-png','-transparent','-nocrop','figurin Plot Values power') % '-r300'