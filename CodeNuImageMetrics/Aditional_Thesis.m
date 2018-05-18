%thesis Additional scripts.
TPath='G:\Dropbox\ResearchMagic\T H E S I S\Chapter 4\FigFolder\';
%% Open the fig for the ROC of fibro vs background.


RocFig=open('G:\Google Drive\masterSets\RotaryStage\CONTROL SCANS\Prev Images and Figures\D0819_05a ROC Control Call fiborVSrest\D0819_05a ROC Control Call fiborVSrest.fig');
 savethisoneTS(TPath,'402_ROCThreshold_a',8.25,8.88,'no'); % SAVE to thesis Doc path ;)

BoxPlotFig=open('G:\Google Drive\masterSets\RotaryStage\CONTROL SCANS\Prev Images and Figures\D0819_05c BoxPlot Control FibroVsRest cutoffs\D0819_05c BoxPlot Control FibroVsRest cutoffs MENOS.fig');
 savethisoneTS(TPath,'402_ROCThreshold_b',8.25,8.31,'no'); % SAVE to thesis Doc path ;)
 title('');