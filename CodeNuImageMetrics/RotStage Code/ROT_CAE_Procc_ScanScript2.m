
%--------------------------------------------------------------------------
%---------------------mario_ROT_CAE_Procc_ScanScript2-----------------------------
%--------------------------------------------------------------------------

% Process the erroneous scan images, extracts the energy from the tumor and
% fibro at their corresponding locations. Elminate bottom 95% (clutter)
% Generates arrays and ROC curves

% V1 
% works on all datasets. Posibly missing a gneral plottin (curve of ROC and curve of SCR as error increases)
% V0.5 Currently only working of E4 ErrorSet

%% -- Initialize
%Load sProp settings from Control Scans
try cd('F:\UserElGuapo\Google Drive\masterSets\RotaryStage\CONTROL SCANS');
catch % Lab CPU
end

load 'D0819_sProp.mat'


% Open directory where Erroneous Images are located
try cd('F:\UserElGuapo\Google Drive\masterSets\RotaryStage\CAE'); %<- Starts with the Single Accuracy Error 5 deg
catch % Lab CPU
end



% Load Scan caracteristics 
try load CAEs_ScansOnly
catch
    load CAEs_wScans
    
    CAEs_ScansOnly.PD_P1.E1.SCAN=rmfield(CAEs_wScans.PD_P1.E1.SCAN,'S11_c_Rec');
    CAEs_ScansOnly.PD_P1.E2.SCAN=rmfield(CAEs_wScans.PD_P1.E2.SCAN,'S11_c_Rec');
    CAEs_ScansOnly.PD_P1.E4.SCAN=rmfield(CAEs_wScans.PD_P1.E4.SCAN,'S11_c_Rec');
    CAEs_ScansOnly.PD_P1.E12.SCAN=rmfield(CAEs_wScans.PD_P1.E12.SCAN,'S11_c_Rec');
    CAEs_ScansOnly.PD_P1.GName=CAEs_wScans.PD_P1.GName;

    CAEs_ScansOnly.PD_P2.E1.SCAN=rmfield(CAEs_wScans.PD_P2.E1.SCAN,'S11_c_Rec');
    CAEs_ScansOnly.PD_P2.E2.SCAN=rmfield(CAEs_wScans.PD_P2.E2.SCAN,'S11_c_Rec');
    CAEs_ScansOnly.PD_P2.E4.SCAN=rmfield(CAEs_wScans.PD_P2.E4.SCAN,'S11_c_Rec');
    CAEs_ScansOnly.PD_P2.E12.SCAN=rmfield(CAEs_wScans.PD_P2.E12.SCAN,'S11_c_Rec');
    CAEs_ScansOnly.PD_P2.GName=CAEs_wScans.PD_P2.GName;

    CAEs_ScansOnly.PD_P3.E1.SCAN=rmfield(CAEs_wScans.PD_P3.E1.SCAN,'S11_c_Rec');
    CAEs_ScansOnly.PD_P3.E2.SCAN=rmfield(CAEs_wScans.PD_P3.E2.SCAN,'S11_c_Rec');
    CAEs_ScansOnly.PD_P3.E4.SCAN=rmfield(CAEs_wScans.PD_P3.E4.SCAN,'S11_c_Rec');
    CAEs_ScansOnly.PD_P3.E12.SCAN=rmfield(CAEs_wScans.PD_P3.E12.SCAN,'S11_c_Rec');
    CAEs_ScansOnly.PD_P3.GName=CAEs_wScans.PD_P3.GName;

    save CAEs_ScansOnly CAEs_ScansOnly
    
end

% try load CAE_Processed.mat
% catch
% end

%%
DTag=['RCAE','_0820_'];
sf1=1;

%%


%% 01 Extracts values from pre-defined regions and masks the array

[PE]=experiment_segmenter_FromTargetMask(CAEs_ScansOnly,sProp);

% Generates a plot of three for each deg of error
group_plotOfThree(PE.E1,sProp,DTag,'E1 ',sf1)
group_plotOfThree(PE.E2,sProp,DTag,'E2 ',sf1)
group_plotOfThree(PE.E4,sProp,DTag,'E4 ',sf1)
group_plotOfThree(PE.E12,sProp,DTag,'E12 ',sf1)




%% 02 Remove values under background threshold level
close all;
back_thres_val=sProp.threshVal_back;

[PE.E1]= mario_TryThresholdTool(back_thres_val,PE.E1);
[PE.E2]= mario_TryThresholdTool(back_thres_val,PE.E2);
[PE.E4]= mario_TryThresholdTool(back_thres_val,PE.E4);
[PE.E12]= mario_TryThresholdTool(back_thres_val,PE.E12);

% Generates a plot of three for each deg of error
s_temp='02 Plot Group w Threshold';
group_plotOfThree_Threshold(PE.E1,sProp,[DTag,'E1 ',s_temp],sf1)
group_plotOfThree_Threshold(PE.E2,sProp,[DTag,'E2 ',s_temp],sf1)
group_plotOfThree_Threshold(PE.E4,sProp,[DTag,'E4 ',s_temp],sf1)
group_plotOfThree_Threshold(PE.E12,sProp,[DTag,'E12 ',s_temp],sf1)
clear s_temp


s_temp='02b Group Swarm Scatter';
 group_mario_plotterOfSwarm(PE.E1);  if sf1, savethisone11([DTag,'E1 ',s_temp]), end 
 group_mario_plotterOfSwarm(PE.E2);  if sf1, savethisone11([DTag,'E2 ',s_temp]), end 
 group_mario_plotterOfSwarm(PE.E4);  if sf1, savethisone11([DTag,'E4 ',s_temp]), end 
 group_mario_plotterOfSwarm(PE.E12); if sf1, savethisone11([DTag,'E12 ',s_temp]), end 
clear s_temp


%% 03 Generate group regions (CAll_Arrays)for group analysis   
[PE.E1] = group_CALLcolector(PE.E1);
[PE.E2] = group_CALLcolector(PE.E2);
[PE.E4] = group_CALLcolector(PE.E4);
[PE.E12] = group_CALLcolector(PE.E12);

s_temp='03 Experiment Call Swarm Scatter';
 ExpSet_mario_plotterOfSwarm(PE);  if sf1, savethisone11([DTag,'',s_temp]), end 
clear s_temp


%% 04 Run ROC curve test   <%-------Must manualy run the save this one commands
s_temp='04 ROC Curve';
 [PE.E1.ROC]=ROT_ROC_RUN(PE.E1.CALL); if sf1, savethisone11([DTag,'E1 ',s_temp]), end  
 [PE.E2.ROC]=ROT_ROC_RUN(PE.E2.CALL); if sf1, savethisone11([DTag,'E2 ',s_temp]), end 
 [PE.E4.ROC]=ROT_ROC_RUN(PE.E4.CALL); if sf1, savethisone11([DTag,'E4 ',s_temp]), end 
[PE.E12.ROC]=ROT_ROC_RUN(PE.E12.CALL);if sf1, savethisone11([DTag,'E12 ',s_temp]), end 
clear s_temp

% generates a boxplot for each deg of error based on the roc regions,
% compliments roc, % experiment_boxploterOfTwo(E1.ROC.Roc_TumorVsFC,sf1,[DTag,'E1 ',s_temp]) 
s_temp='04b BoxPlot for ROC';
 mario_boxploterOfTwo(PE.E1.ROC.Roc_TumorVsFC.call_posBox,PE.E1.ROC.Roc_TumorVsFC.call_negBox,'Tumor','Fibro and Clutter');  if sf1, savethisone11([DTag,'E1 ',s_temp]), end 
 mario_boxploterOfTwo(PE.E2.ROC.Roc_TumorVsFC.call_posBox,PE.E2.ROC.Roc_TumorVsFC.call_negBox,'Tumor','Fibro and Clutter');  if sf1, savethisone11([DTag,'E2 ',s_temp]), end 
 mario_boxploterOfTwo(PE.E4.ROC.Roc_TumorVsFC.call_posBox,PE.E4.ROC.Roc_TumorVsFC.call_negBox,'Tumor','Fibro and Clutter');  if sf1, savethisone11([DTag,'E4 ',s_temp]), end 
mario_boxploterOfTwo(PE.E12.ROC.Roc_TumorVsFC.call_posBox,PE.E12.ROC.Roc_TumorVsFC.call_negBox,'Tumor','Fibro and Clutter'); if sf1, savethisone11([DTag,'E12 ',s_temp]), end 
clear s_temp




%% 05 Run Hypothesis test to determine if samples are similar

%Two-sample Kolmogorov-Smirnov test

 PE.E1=ExpSet_RUN_Hypothesis(PE.E1);
 PE.E2=ExpSet_RUN_Hypothesis(PE.E2);
 PE.E4=ExpSet_RUN_Hypothesis(PE.E4);
PE.E12=ExpSet_RUN_Hypothesis(PE.E12);



%% 06 Run SCR test (or other tests)
%changed to after 07



%% 07 Run diagnostic scrpit                   <-------------------------------Under constructions
%Finds tumors avobe thresholds, if more than 2 pixel, it counts and detects
% its center. 

[PE]=ErrorSet_RUN_DiagnosticScript(PE,sProp);

% Plot tumor location according to diagnostic
ErrorSet_plot_DiagnosticPlot(PE,sProp,sf1,DTag)

%% 06 Run Image metric RetroFix

PE=ErrorSet_ImageMetricsRetroFix(PE); %<- MVF Single most importat function in the game
PE=ErrorSet_RecoQualityMetricsRetroFix(PE); %<- MVF Single most importat function in the game


%% 08 Group quality/ summary constructor Excel spitter

% 3.e Save excel values
PE=ErrorSet_summaryMaker(PE,DTag);

% Generate eXcel files
ErrorSet_ExcelExporter(PE,'Group',DTag)

%% END Saves CAE_Processed
save([DTag,'PE'],'PE')





