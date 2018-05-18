%%---ROT  ICM (Image Contrast Metrics)_Plotter and Exceller----
% This script will read the summary files from control and error file-sets.
% It will create a plot with mean control value and how the metrics change
% as the error increase, 

% It will first make a plot for each type of error for all metrics, but
% IM_Eplot(CON,CAE)

%plots have a 95% sE error using a t-critical value for 3 samples


% IF necesary, I will create another set of graphs, where I evaluate
% metrics by type of error so it will be
%  IM_Gplot_SCR (CON,CAE,CPE,SPE,SAE, RAE, RPE )
%  Gplot_TFR ... and so on
clearvars
%%
sf1=1; DTag='0825_';
xValues=[1.25,2.5,5,15];
xTicksValues=[0,1.25,2.5,5,7.25,10,12.25,15];
xTicksLabels=[{'0°'},{'1.25°'},{'2.5°'},{'5°'},{'7.25°'},{'10°'},{'12.25°'},{'15°'}];

AGoal=0.2;  %
AValue=0.26; % +0.05 uncertainty
PGoal=0.1;  % need verify
PValue=0.08; % verified
%%

%Load Control values, this will be used to compare all the experiments
try cd('F:\UserElGuapo\Google Drive\masterSets\RotaryStage\CONTROL SCANS');
catch % Lab CPU
    cd('E:\TheCloud\\Google Drive\masterSets\RotaryStage\CONTROL SCANS\')
end
load('RPCON_0823_PC.mat')

%%
%----------------------------TIER 1 ---------------------------------------
% 1RSAE Accuracy Single
% 2RCAE Accuracy Colective
% 3RSPE Precision Single 
% 4RCPE Precision Colective



%% 1 RSAE
%Dtags

DTag=['RSAE_','0825_'];

try cd('F:\UserElGuapo\Google Drive\masterSets\RotaryStage\SAE'); %
catch % Lab CPU
end
load('RSAE_0821_PE.mat', 'PE')

%Combines summaries into one with control as the first element
combined_summary=[PC.Set_Summary;PE.Set_Summary];

    %Runs the plotting comand. 
    ROT_ICM_Eplot(combined_summary,xValues,xTicksValues,xTicksLabels);

    %Accuracy Threshold
     plot([0.26; 0.26], [0;40], ':g','LineWidth',1)
     plot([0.2; 0.2], [0;40], ':m','LineWidth',1)
     set(gca,'ylim',[0,30]);

% If enabled, saves the fig
 if sf1, savethisoneAsIs(DTag,'_D Plotted Contrast Metrics'); else end
clear PE
 

%% 2 RCAE
DTag=['RCAE_','0825_'];

try cd('F:\UserElGuapo\Google Drive\masterSets\RotaryStage\CAE'); %
catch % Lab CPU
end
load('RCAE_0820_PE.mat', 'PE')

%Combines summaries into one with control as the first element
combined_summary=[PC.Set_Summary;PE.Set_Summary];

    %Runs the plotting comand. 
    ROT_ICM_Eplot(combined_summary,xValues,xTicksValues,xTicksLabels);

    %Accuracy Threshold
     plot([0.26; 0.26], [0;40], ':g','LineWidth',1)
     plot([0.2; 0.2], [0;40], ':m','LineWidth',1)
     set(gca,'ylim',[0,30]);

% If enabled, saves the fig
 if sf1, savethisoneAsIs(DTag,'D Plotted Contrast Metrics'); else end
clear PE combined_summary DTag
 

%% 3 RSPE
DTag=['RSPE_','0825_'];

 cd('F:\UserElGuapo\Google Drive\masterSets\RotaryStage\SPE'); %

load('RSPE_0821_PE.mat', 'PE')

%Combines summaries into one with control as the first element
combined_summary=[PC.Set_Summary;PE.Set_Summary];

    %Runs the plotting comand. 
    ROT_ICM_Eplot(combined_summary,xValues,xTicksValues,xTicksLabels);

    %Accuracy Threshold
     plot([PValue; PValue], [0;40], ':g','LineWidth',1)
     plot([PGoal; PGoal], [0;40], ':m','LineWidth',1)
     set(gca,'ylim',[0,30]);

% If enabled, saves the fig
 if sf1, savethisoneAsIs(DTag,'D Plotted Contrast Metrics'); else end
clear PE combined_summary DTag


%% 4 RCPE
DTag=['RCPE_','0825_'];

cd('F:\UserElGuapo\Google Drive\masterSets\RotaryStage\CPE'); %

load('RCPE_0821_PE.mat', 'PE')

%Combines summaries into one with control as the first element
combined_summary=[PC.Set_Summary;PE.Set_Summary];

    %Runs the plotting comand. 
    ROT_ICM_Eplot(combined_summary,xValues,xTicksValues,xTicksLabels);

    %Accuracy Threshold
     plot([PValue; PValue], [0;40], ':g','LineWidth',1)
     plot([PGoal; PGoal], [0;40], ':m','LineWidth',1)
     set(gca,'ylim',[0,30]);

% If enabled, saves the fig
 if sf1, savethisoneAsIs(DTag,'D Plotted Contrast Metrics'); else end
clear PE combined_summary DTag


%%
%----------------------------TIER 2 ---------------------------------------
% 5-RRAC 6-RRPE RSinAE* FixCAE* 
%* Not done yet

%% 5 RRAE
DTag=['RRAE_','0825_'];

cd('F:\UserElGuapo\Google Drive\masterSets\RotaryStage\RAE'); %

load('RRAE_0823_PE.mat', 'PE')

%Combines summaries into one with control as the first element
combined_summary=[PC.Set_Summary;PE.Set_Summary];

    %Runs the plotting comand. 
    ROT_ICM_Eplot(combined_summary,xValues,xTicksValues,xTicksLabels);

    %Accuracy Threshold
     plot([AValue; AValue], [0;40], ':g','LineWidth',1)
     plot([AGoal; AGoal], [0;40], ':m','LineWidth',1)
     set(gca,'ylim',[0,30]);

% If enabled, saves the fig
 if sf1, savethisoneAsIs(DTag,'D Plotted Contrast Metrics'); else end
clear PE combined_summary DTag


%% 6 RRPE
DTag=['RRPE_','0825_'];

cd('F:\UserElGuapo\Google Drive\masterSets\RotaryStage\RPE'); %

load('RRPE_0823_PE.mat', 'PE')

%Combines summaries into one with control as the first element
combined_summary=[PC.Set_Summary;PE.Set_Summary];

    %Runs the plotting comand. 
    ROT_ICM_Eplot(combined_summary,xValues,xTicksValues,xTicksLabels);

    %Accuracy Threshold
     plot([PValue; PValue], [0;40], ':g','LineWidth',1)
     plot([PGoal; PGoal], [0;40], ':m','LineWidth',1)
     set(gca,'ylim',[0,30]);

% If enabled, saves the fig
 if sf1, savethisoneAsIs(DTag,'D Plotted Contrast Metrics'); else end
clear PE combined_summary DTag
export_fig('-dpng','-transparent','-nocrop','-m2','upsisepainterstest','-painters');