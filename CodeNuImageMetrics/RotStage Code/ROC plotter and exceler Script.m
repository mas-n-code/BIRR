%%---ROC_Plotter and Exceller----
% will be a function that will be passed a PC and PE erroSet structres and
% a folder, where the variables will be saved and a DTag and a FIGName,
% which is the name of the figure(CAE errors)

clearvars
%Load Control values, this will be used to compare all the experiments
try cd('F:\UserElGuapo\Google Drive\masterSets\RotaryStage\CONTROL SCANS');
catch % Lab CPU
end
load('RPCON_0823_PC.mat')

%Load only the ROC values of interest

Control_ROC=PC.E1.ROC.Roc_TumorVsFC;

F_name='F_RocSummary Excel';
%%
%----------------------------TIER 1 ---------------------------------------
% 1RSAE Accuracy Single
% 2RCAE Accuracy Colective
% 3RSPE Precision Single 
% 4RCPE Precision Colective



%% 1 RSAE
clear PE Nu DTag
 
load('F:\UserElGuapo\Google Drive\masterSets\RotaryStage\CONTROL SCANS\RPCON_0823_PC.mat')
Control_ROC=PC.E1.ROC.Roc_TumorVsFC;
DTag='RSAE_0823_';  

% Open directory where Erroneous Images are located
try cd('F:\UserElGuapo\Google Drive\masterSets\RotaryStage\SAE'); %
catch % Lab CPU
end
load('RSAE_0821_PE.mat', 'PE')

% PRoces ROC
% Generate excel
Nu=ROC_MetaExceler(Control_ROC,PE);
estructExceler2table(Nu,[cd,'\',DTag,F_name],[DTag,F_name])

% Generate plot
 ROC_MetaPlotter(Control_ROC,PE,'Soft')
 if sf1, savethisoneAsIs(DTag,'10 ROC Curves together'); else end

%% 2 RCAE
clear PE Nu DTag
 
load('F:\UserElGuapo\Google Drive\masterSets\RotaryStage\CONTROL SCANS\RPCON_0823_PC.mat')
Control_ROC=PC.E1.ROC.Roc_TumorVsFC;

DTag='RCAE_0823_';  
% Open directory where Erroneous Images are located
try cd('F:\UserElGuapo\Google Drive\masterSets\RotaryStage\CAE'); %
catch % Lab CPU
end
load('RCAE_0820_PE.mat', 'PE')

% PRoces ROC
% Generate excel
Nu=ROC_MetaExceler(Control_ROC,PE);
estructExceler2table(Nu,[cd,'\',DTag,F_name],[DTag,F_name])

% Generate plot
 ROC_MetaPlotter(Control_ROC,PE,'Strong')
 if sf1, savethisoneAsIs(DTag,'10 ROC Curves together'); else end
clear PE DTag Nu

%% 3 RSPE
clear PE Nu DTag
 
load('F:\UserElGuapo\Google Drive\masterSets\RotaryStage\CONTROL SCANS\RPCON_0823_PC.mat')
Control_ROC=PC.E1.ROC.Roc_TumorVsFC;

DTag='RSPE_0823_';  
% Open directory where Erroneous Images are located
try cd('F:\UserElGuapo\Google Drive\masterSets\RotaryStage\SPE'); %
catch % Lab CPU
end
load('RSPE_0821_PE.mat', 'PE')

% PRoces ROC
% Generate excel
Nu=ROC_MetaExceler(Control_ROC,PE);
estructExceler2table(Nu,[cd,'\',DTag,F_name],[DTag,F_name])

% Generate plot
 ROC_MetaPlotter(Control_ROC,PE,'Soft')
 if sf1, savethisoneAsIs(DTag,'10 ROC Curves together'); else end
clear PE DTag Nu

%% 4 RCPE
clear PE Nu DTag
 
load('F:\UserElGuapo\Google Drive\masterSets\RotaryStage\CONTROL SCANS\RPCON_0823_PC.mat')
Control_ROC=PC.E1.ROC.Roc_TumorVsFC;

% change to CPE
DTag='RCPE_0823_';  
% Open directory where Erroneous Images are located
try cd('F:\UserElGuapo\Google Drive\masterSets\RotaryStage\CPE'); %
catch % Lab CPU
end
load('RCPE_0821_PE.mat', 'PE')

% PRoces ROC
% Generate excel
Nu=ROC_MetaExceler(Control_ROC,PE);
estructExceler2table(Nu,[cd,'\',DTag,F_name],[DTag,F_name])

% Generate plot
 ROC_MetaPlotter(Control_ROC,PE,'Strong')
 if sf1, savethisoneAsIs(DTag,'10 ROC Curves together'); else end
clear PE DTag Nu
%%
%----------------------------TIER 2 ---------------------------------------
% 5-RRAC 6-RRPE RSinAE* FixCAE* 
%* Not done yet

%% 5 RRAE
clear PE Nu DTag
 
load('F:\UserElGuapo\Google Drive\masterSets\RotaryStage\CONTROL SCANS\RPCON_0823_PC.mat')
Control_ROC=PC.E1.ROC.Roc_TumorVsFC;

% change to CPE
DTag='RRAE_0823_';  
% Open directory where Erroneous Images are located
try cd('F:\UserElGuapo\Google Drive\masterSets\RotaryStage\RAE'); %
catch % Lab CPU
end
load('RRAE_0823_PE.mat', 'PE')

% PRoces ROC
% Generate excel
Nu=ROC_MetaExceler(Control_ROC,PE);
estructExceler2table(Nu,[cd,'\',DTag,F_name],[DTag,F_name])

% Generate plot
 ROC_MetaPlotter(Control_ROC,PE,'Strong')
 if sf1, savethisoneAsIs(DTag,'10 ROC Curves together'); else end
clear PE DTag Nu

%% 6 RRPE
clear PE Nu DTag
 
load('F:\UserElGuapo\Google Drive\masterSets\RotaryStage\CONTROL SCANS\RPCON_0823_PC.mat')
Control_ROC=PC.E1.ROC.Roc_TumorVsFC;

% change to CPE
DTag='RRPE_0823_';  
% Open directory where Erroneous Images are located
try cd('F:\UserElGuapo\Google Drive\masterSets\RotaryStage\RPE'); %
catch % Lab CPU
end
load('RRPE_0823_PE.mat', 'PE')

% PRoces ROC
% Generate excel
Nu=ROC_MetaExceler(Control_ROC,PE);
estructExceler2table(Nu,[cd,'\',DTag,F_name],[DTag,F_name])

% Generate plot
 ROC_MetaPlotter(Control_ROC,PE,'Strong')
 if sf1, savethisoneAsIs(DTag,'10 ROC Curves together'); else end
clear PE DTag Nu