
%--------------------------------------------------------------------------
%---------------------mario_LIFT_CON_GEN_ScanScript2-----------------------------
%--------------------------------------------------------------------------

% Generates the Control scan images, extracts the energy from the tumor and
% fibro at their corresponding locations. Elminate bottom 95% (clutter)
% Generates arrays and ROC curves

% V1.0 Based a lot on ROT_CON_GEN_Scan_Script.m

% circ mask should go with 14 pixels

sf1=1; % set sf1 to 1 to activate savefig commands
DTag='LSBCON_0824';

try cd('F:\UserElGuapo\Google Drive\masterSets\LiftStage\3 Bottom\LSB CON');
catch % Lab CPU
end

% If already existent, load the ProcessedCa and the 
try %load D0816_ProcessedCA;
    load LSB_ControlArraysOnly
catch disp('No can do'); % Remove 
    load('BoTRegion_Control.mat') 
    
        LSBCAE_ScansOnly.PD_P1.E1.SCAN=rmfield(LS_B_CAEs.PD_P1.E1.SCAN,'S11_c_Rec');
    LSBCAE_ScansOnly.PD_P1.E2.SCAN=rmfield(LS_B_CAEs.PD_P1.E2.SCAN,'S11_c_Rec');
    LSBCAE_ScansOnly.PD_P1.E3.SCAN=rmfield(LS_B_CAEs.PD_P1.E3.SCAN,'S11_c_Rec');
    LSBCAE_ScansOnly.PD_P1.GName=LS_B_CAEs.PD_P1.GName;

    LSBCAE_ScansOnly.PD_P2.E1.SCAN=rmfield(LS_B_CAEs.PD_P2.E1.SCAN,'S11_c_Rec');
    LSBCAE_ScansOnly.PD_P2.E2.SCAN=rmfield(LS_B_CAEs.PD_P2.E2.SCAN,'S11_c_Rec');
    LSBCAE_ScansOnly.PD_P2.E3.SCAN=rmfield(LS_B_CAEs.PD_P2.E3.SCAN,'S11_c_Rec');
    LSBCAE_ScansOnly.PD_P2.GName=LS_B_CAEs.PD_P2.GName;
end







% LEFT becasue decided to work on top lift stage






















%% -- Initialize
%Load sProp settings from Control Scans
clearvars
try cd('F:\UserElGuapo\Google Drive\masterSets\RotaryStage\CONTROL SCANS');
catch % Lab CPU
end

load 'D0819_sProp.mat'

% adjust CLim
sProp.CLim=[0,3e-8 ];

% Open directory where Erroneous Images are located
try cd('F:\UserElGuapo\Google Drive\masterSets\LiftStage\3 Bottom\LSB CAE'); %<- Starts with the Single Accuracy Error 5 deg
catch % Lab CPU
end



% Load Scan caracteristics 
try load LSBCAE_ScansOnly
catch
    load 'LS_BoT_CAEs.mat'
     % might be worth to use -> exist to chect what the name of variable
     % remains as wScans
    LSBCAE_ScansOnly.PD_P1.E1.SCAN=rmfield(LS_B_CAEs.PD_P1.E1.SCAN,'S11_c_Rec');
    LSBCAE_ScansOnly.PD_P1.E2.SCAN=rmfield(LS_B_CAEs.PD_P1.E2.SCAN,'S11_c_Rec');
    LSBCAE_ScansOnly.PD_P1.E3.SCAN=rmfield(LS_B_CAEs.PD_P1.E3.SCAN,'S11_c_Rec');
    LSBCAE_ScansOnly.PD_P1.GName=LS_B_CAEs.PD_P1.GName;

    LSBCAE_ScansOnly.PD_P2.E1.SCAN=rmfield(LS_B_CAEs.PD_P2.E1.SCAN,'S11_c_Rec');
    LSBCAE_ScansOnly.PD_P2.E2.SCAN=rmfield(LS_B_CAEs.PD_P2.E2.SCAN,'S11_c_Rec');
    LSBCAE_ScansOnly.PD_P2.E3.SCAN=rmfield(LS_B_CAEs.PD_P2.E3.SCAN,'S11_c_Rec');
    LSBCAE_ScansOnly.PD_P2.GName=LS_B_CAEs.PD_P2.GName;

    save LSBCAE_ScansOnly LSBCAE_ScansOnly
    clear LS_BoT_CAEs
end

% try load CPE_Processed.mat
% catch
% end

%%
DTag=['LSBCAEwRCON','_0824_'];
sf1=1;

%% % area p1 to p2 the same?
% E1P1=PE.E1.P_P1.A_masked;
% E1P2=PE.E1.P_P2.A_masked;
% 
% E2P1=PE.E2.P_P1.A_masked;
% E2P2=PE.E2.P_P2.A_masked;
% 
% E3P1=PE.E3.P_P1.A_masked;
% E3P2=PE.E3.P_P2.A_masked;
% 
% compAre1=max(max(E1P1-E1P2));   % Least dfferent
% compAre2=max(max(E2P1-E2P2));   % P1 and P2 are diferent, ant it seems that E1 and E2 are diferent too
% 
% compAreEs1=max(max(E1P1-E2P1));    % Diferent
% compAreEs2=max(max(E1P2-E2P2));   % Its more difeent
% compAreEs3=max(max(E1P1-E3P1));    % Diferent
% compAreEs2=max(max(E1P2-E3P2));   % Its more difeent


%% 01 Extracts values from pre-defined regions and masks the array


%! WARNING ! ! USING ROT SETTINGS ! 
[PE]=experiment_segmenter_FromTargetMask_LS(LSBCAE_ScansOnly,sProp);

% Generates a plot of three for each deg of error
group_plotOfThree_LS(PE.E1,sProp,DTag,'E1 ',sf1)
group_plotOfThree_LS(PE.E2,sProp,DTag,'E2 ',sf1)
group_plotOfThree_LS(PE.E3,sProp,DTag,'E3 ',sf1)

%% plot a sample of the target mask over the background image


% add them to sProp

%% 02 Remove values under background threshold level
close all;
back_thres_val=sProp.threshVal_back; %! WARNING ! ! USING ROT SETTINGS ! 


[PE.E1]= mario_TryThresholdTool_LS(back_thres_val,PE.E1);
[PE.E2]= mario_TryThresholdTool_LS(back_thres_val,PE.E2);
[PE.E3]= mario_TryThresholdTool_LS(back_thres_val,PE.E3);

% Generates a plot of three for each deg of error
s_temp='02 Plot Group w Threshold';
group_plotOfThree_Threshold_LS(PE.E1,sProp,DTag,['E1 ',s_temp],sf1)
group_plotOfThree_Threshold_LS(PE.E2,sProp,DTag,['E2 ',s_temp],sf1)
group_plotOfThree_Threshold_LS(PE.E3,sProp,DTag,['E3 ',s_temp],sf1)
clear s_temp

close all;
s_temp='02b Group Swarm Scatter';
 group_mario_plotterOfSwarm_LS(PE.E1,sProp);  if sf1, savethisone11(DTag,['E1 ',s_temp]), end 
 group_mario_plotterOfSwarm_LS(PE.E2,sProp);  if sf1, savethisone11(DTag,['E2 ',s_temp]), end 
 group_mario_plotterOfSwarm_LS(PE.E3,sProp);  if sf1, savethisone11(DTag,['E3 ',s_temp]), end 
clear s_temp



%% 03 Generate group regions (CAll_Arrays)for group analysis   
[PE.E1] = group_CALLcolector_LS(PE.E1);
[PE.E2] = group_CALLcolector_LS(PE.E2);
[PE.E3] = group_CALLcolector_LS(PE.E3);

s_temp='03 Experiment Call Swarm Scatter';
ExpSet_mario_plotterOfSwarm_LS(PE,sProp);  if sf1, savethisone11(DTag,['ErrorSet ',s_temp]), end 
clear s_temp




%% 04 Run ROC curve test   <%-------Must manualy run the save this one commands
s_temp='04 ROC Curve';
 [PE.E1.ROC]=ROT_ROC_RUN(PE.E1.CALL); if sf1, savethisone11(DTag,['E1 ',s_temp]), end  
 [PE.E2.ROC]=ROT_ROC_RUN(PE.E2.CALL); if sf1, savethisone11(DTag,['E2 ',s_temp]), end 
 [PE.E3.ROC]=ROT_ROC_RUN(PE.E3.CALL); if sf1, savethisone11(DTag,['E3 ',s_temp]), end 
clear s_temp

% generates a boxplot for each deg of error based on the roc regions,
% compliments roc, % experiment_boxploterOfTwo(E1.ROC.Roc_TumorVsFC,sf1,[DTag,'E1 ',s_temp]) 
s_temp='04b BoxPlot for ROC';
 mario_boxploterOfTwo(PE.E1.ROC.Roc_TumorVsFC.call_posBox,PE.E1.ROC.Roc_TumorVsFC.call_negBox,'Tumor','Fibro and Clutter');  if sf1, savethisone11(DTag,['E1 ',s_temp]), end 
 mario_boxploterOfTwo(PE.E2.ROC.Roc_TumorVsFC.call_posBox,PE.E2.ROC.Roc_TumorVsFC.call_negBox,'Tumor','Fibro and Clutter');  if sf1, savethisone11(DTag,['E2 ',s_temp]), end 
 mario_boxploterOfTwo(PE.E3.ROC.Roc_TumorVsFC.call_posBox,PE.E3.ROC.Roc_TumorVsFC.call_negBox,'Tumor','Fibro and Clutter');  if sf1, savethisone11(DTag,['E3 ',s_temp]), end 
clear s_temp

close all;

%% 05 Run Hypothesis test to determine if samples are similar

%Two-sample Kolmogorov-Smirnov test

 PE.E1=ExpSet_RUN_Hypothesis(PE.E1);
 PE.E2=ExpSet_RUN_Hypothesis(PE.E2);
 PE.E3=ExpSet_RUN_Hypothesis(PE.E3);


%% 06 Run SCR test (or other tests)
%changed to after 07

%% 07 Run diagnostic scrpit                 
%Finds tumors avobe thresholds, if more than 2 pixel, it counts and detects
% its center. 
[PE]=ErrorSet_RUN_DiagnosticScript_LS(PE,sProp);  %!Warning! using tumor threshold from ROT

% Plot tumor location according to diagnostic
ErrorSet_plot_DiagnosticPlot_LS(PE,sProp,sf1,DTag)


%% 06 Run Image metric RetroFix

PE=ErrorSet_ImageMetricsRetroFix_LS(PE); %<- MVF Single most importat function in the game

PE=ErrorSet_RecoQualityMetricsRetroFix_LS(PE); %<- MVF Single most importat function in the game


%% 08 Group quality/ summary constructor Excel spitter

% 3.e MAke summary table values
PE=ErrorSet_summaryMaker_LS(PE,DTag);

% Generate eXcel files
ErrorSet_ExcelExporter(PE,'Group',DTag)


%% 09 ROC Ploter and Exceler
% ! Warning, using ROT CON!
load('F:\UserElGuapo\Google Drive\masterSets\RotaryStage\CONTROL SCANS\RPCON_0823_PC.mat')
Control_ROC=PC.E1.ROC.Roc_TumorVsFC;
% ! Warning ! Warning

% PRoces ROC
% Generate excel
Nu=ROC_MetaExceler(Control_ROC,PE,DTag);

% Generate plot
 ROC_MetaPlotter_LS(Control_ROC,PE,'Soft')
 if sf1, savethisoneAsIs(DTag,'10 ROC Curves together'); else end



%% END Saves CPE_Processed
save([DTag,'PE'],'PE')

disp('')
disp('---')
disp('--')
disp('-')
disp('!')
disp('Done, Thanks!')
