
%--------------------------------------------------------------------------
%---------------------mario_LIFT_REP_Procc_ScanScript2-----------------------------
%--------------------------------------------------------------------------

% Process the erroneous scan images, extracts the energy from the tumor and
% fibro at their corresponding locations. Elminate bottom 95% (clutter)
% Generates arrays and ROC curves

% V1 
% works on all datasets. Posibly missing a gneral plottin (curve of ROC and curve of SCR as error increases)
% V0.5 Currently only working of E4 ErrorSet

% E1 IS A REPEATABILITY SCAN, THE LIFT STAGE WAS PLACED ON THE SAME POS
%

% E2 IS A REPRODUCIBILITY SCAN, IT COULD BE SEEN AS A 3RD CONTROL DATASET,

%% -- Initialize
%Load LsProp settings from Control Scans
clearvars

%%
DTag=['LSTREP','_0826_'];
sf1=1;

% Load the LsProp setting
load('F:\UserElGuapo\Google Drive\masterSets\LiftStage\1 Top\LST CON\LSTCON_0824_LsProp.mat')


% e2 should be better?

% Open directory where Erroneous Images are located
try cd('F:\UserElGuapo\Google Drive\masterSets\LiftStage\1 Top\LST REP');
catch % Lab CPU
    try
    cd('G:\Google Drive\masterSets\LiftStage\3 Bottom\TSB REP')
    catch
        disp('-!nope');
    end
end



% Load Scan caracteristics 
try load TSBREP_ScansOnly
catch
    load 'LS_Top_REPs.mat'
     % might be worth to use -> exist to chect what the name of variable
     % remains as wScans
    LSTREP_ScansOnly.PD_P1.E1.SCAN=rmfield(LS_T_REPs.PD_P1.E1.SCAN,'S11_c_Rec');
    LSTREP_ScansOnly.PD_P1.E2.SCAN=rmfield(LS_T_REPs.PD_P1.E2.SCAN,'S11_c_Rec');

    LSTREP_ScansOnly.PD_P1.GName=LS_T_REPs.PD_P1.GName;

    LSTREP_ScansOnly.PD_P2.E1.SCAN=rmfield(LS_T_REPs.PD_P2.E1.SCAN,'S11_c_Rec');
    LSTREP_ScansOnly.PD_P2.E2.SCAN=rmfield(LS_T_REPs.PD_P2.E2.SCAN,'S11_c_Rec');

    LSTREP_ScansOnly.PD_P2.GName=LS_T_REPs.PD_P2.GName;

    save LSTREP_ScansOnly LSTREP_ScansOnly
    clear LS_Top_REPs
end

% try load REP_Processed.mat
% catch
% end



%% 01 Extracts values from pre-defined regions and masks the array

[PE]=experiment_segmenter_FromTargetMask_LS(LSTREP_ScansOnly,LsProp);

% Generates a plot of three for each deg of error
group_plotOfThree_LS(PE.E1,LsProp,DTag,'E1 ',sf1)
group_plotOfThree_LS(PE.E2,LsProp,DTag,'E2 ',sf1)


%% plot a sample of the target mask over the background image


% add them to LsProp

%% 02 Remove values under background threshold level
close all;
back_thres_val=LsProp.threshVal_back; %! WARNING ! ! USING ROT SETTINGS ! 


[PE.E1]= mario_TryThresholdTool_LS(back_thres_val,PE.E1);
[PE.E2]= mario_TryThresholdTool_LS(back_thres_val,PE.E2);

% Generates a plot of three for each deg of error
s_temp='02 Plot Group w Threshold';
group_plotOfThree_Threshold_LS(PE.E1,LsProp,DTag,['E1 ',s_temp],sf1)
group_plotOfThree_Threshold_LS(PE.E2,LsProp,DTag,['E2 ',s_temp],sf1)
clear s_temp

close all;
s_temp='02b Group Swarm Scatter';
 group_mario_plotterOfSwarm_LS(PE.E1,LsProp);  if sf1, savethisone11(DTag,['E1 ',s_temp]), end 
 group_mario_plotterOfSwarm_LS(PE.E2,LsProp);  if sf1, savethisone11(DTag,['E2 ',s_temp]), end 
clear s_temp



%% 03 Generate group regions (CAll_Arrays)for group analysis    % NOT run

[PE.E1] = group_CALLcolector_LS(PE.E1);
[PE.E2] = group_CALLcolector_LS(PE.E2);
% NOT RUN BECUASE THERE IS NO COMPARISON TO BE MADE BETWEEN E1 AND E2, E1 IS A R
%{
s_temp='03 Experiment Call Swarm Scatter';
ExpSet_mario_plotterOfSwarm_LS(PE,LsProp);  if sf1, savethisone11(DTag,['ErrorSet ',s_temp]), end 
clear s_temp

%}


%% 04 Run ROC curve test   <%-------Must manualy run the save this one commands
s_temp='04 ROC Curve';
 [PE.E1.ROC]=ROT_ROC_RUN(PE.E1.CALL); if sf1, savethisone11(DTag,['E1 ',s_temp]), end  
 [PE.E2.ROC]=ROT_ROC_RUN(PE.E2.CALL); if sf1, savethisone11(DTag,['E2 ',s_temp]), end 
clear s_temp

% generates a boxplot for each deg of error based on the roc regions,
% compliments roc, % experiment_boxploterOfTwo(E1.ROC.Roc_TumorVsFC,sf1,[DTag,'E1 ',s_temp]) 
s_temp='04b BoxPlot for ROC';
 mario_boxploterOfTwo(PE.E1.ROC.Roc_TumorVsFC.call_posBox,PE.E1.ROC.Roc_TumorVsFC.call_negBox,'Tumor','Fibro and Clutter');  if sf1, savethisone11(DTag,['E1 ',s_temp]), end 
 mario_boxploterOfTwo(PE.E2.ROC.Roc_TumorVsFC.call_posBox,PE.E2.ROC.Roc_TumorVsFC.call_negBox,'Tumor','Fibro and Clutter');  if sf1, savethisone11(DTag,['E2 ',s_temp]), end 
clear s_temp

close all;

%% 05 Run Hypothesis test to determine if samples are similar

%Two-sample Kolmogorov-Smirnov test

 PE.E1=ExpSet_RUN_Hypothesis(PE.E1);
 PE.E2=ExpSet_RUN_Hypothesis(PE.E2);

disp('-> dope')

%% 06 Run SCR test (or other tests)
%changed to after 07

%% 07 Run diagnostic scrpit                 
%Finds tumors avobe thresholds, if more than 2 pixel, it counts and detects
% its center. 
[PE]=ErrorSet_RUN_DiagnosticScript_LS(PE,LsProp);  

% Plot tumor location according to diagnostic
ErrorSet_plot_DiagnosticPlot_LS(PE,LsProp,sf1,DTag)


%% 06 Run Image metric RetroFix

PE=ErrorSet_ImageMetricsRetroFix_LS(PE); %<- MVF Single most importat function in the game

PE=ErrorSet_RecoQualityMetricsRetroFix_LS(PE); %<- MVF Single most importat function in the game
disp('-> -> dope')


%% 08 Group quality/ summary constructor Excel spitter

% 3.e MAke summary table values
PE=ErrorSet_summaryMaker_LS_REP(PE,DTag);

% Generate eXcel files
ErrorSet_ExcelExporter(PE,'Group',DTag)

disp('-> -> dope')
%% 09 ROC Ploter and Exceler

load('F:\UserElGuapo\Google Drive\masterSets\LiftStage\1 Top\LST CON\LSTCON_0824_PC.mat')
Control_ROC=PC.E1.ROC.Roc_TumorVsFC;


% PRoces ROC
% Generate excel
Nu=ROC_MetaExceler(Control_ROC,PE,DTag);

% Generate plot
 ROC_MetaPlotter_LS_REP(Control_ROC,PE,'Soft')
 if sf1, savethisoneAsIs(DTag,'10 ROC Curves together'); else end

%%------------------------------------------
%% 10 ICM Plotter
%Plotting not done, too much work, will do if needed.!
xValues=[1,2,3];
xTicksValues=0:1:3;
xTicksLabels=[{''},{'Control'},{'Rep'},{'Reproducibility'}];

AGoal= .20;  % Goal was 2mm accuracy
AValue= .203; % +0.05 uncertainty
PGoal= 0.10;  %  Goal was 1 mm precision,
PValue=0.192; % verified
%{

%Combines summaries into one with control as the first element
combined_summary=[PC.Set_Summary;PE.Set_Summary];

    %Runs the plotting comand. 
    LS_ICM_Eplot(combined_summary,xValues,xTicksValues,xTicksLabels);

    %Accuracy Threshold
     plot([PGoal; PGoal], [0;40], ':g','LineWidth',1)
     plot([PValue; PValue], [0;40], ':m','LineWidth',1)


% If enabled, saves the fig
 if sf1, savethisoneAsIs(DTag,'D Plotted Contrast Metrics'); else end
 %}
 
%Save the xlxs file for later use

 mario_estructExceler2table(combined_summary,[cd(),'\'],[DTag,'D Plotted of Contrast Metrics'])


 
%---------------------------------------------------------

%% END Saves REP_Processed
save([DTag,'PE'],'PE')

disp('')
disp('---')
disp('--')
disp('-')
disp('!')
disp('Done, Thanks!')