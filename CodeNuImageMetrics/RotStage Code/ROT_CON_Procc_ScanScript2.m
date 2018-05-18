
%--------------------------------------------------------------------------
%---------------------mario_ROT_CON_Procc_ScanScript2-----------------------------
%--------------------------------------------------------------------------

% Process the erroneous scan images, extracts the energy from the tumor and
% fibro at their corresponding locations. Elminate bottom 95% (clutter)
% Generates arrays and ROC curves


%PC stands for Procesed control

% V1 
% works on all datasets. Posibly missing a gneral plottin (curve of ROC and curve of SCR as error increases)
% V0.5 Currently only working of E4 ErrorSet

%% -- Initialize
%Load sProp settings from Control Scans
try cd('F:\UserElGuapo\Google Drive\masterSets\RotaryStage\CONTROL SCANS');
catch % Lab CPU
end

load 'D0819_sProp.mat'



% Load Scan caracteristics 
load ROT_ControlArraysOnly.mat 
% try load CPC_Processed.mat
% catch
% end

%%
DTag=['RPCON','_0823_'];
sf1=1;

%%


%% 01 Extracts values from pre-defined regions and masks the array
[PC]=Exp1_segmenter_FromTargetMask(ControlArrays.C_P1_A,ControlArrays.C_P2_A,ControlArrays.C_P3_A,sProp);

% Generates a plot of three for each deg of error
group_plotOfThree(PC.E1,sProp,DTag,'ROT CON ',sf1)


%% 02 Remove values under background threshold level
close all;
back_thres_val=sProp.threshVal_back;
[PC.E1]= mario_TryThresholdTool(back_thres_val,PC.E1);

% Generates a plot of three for each structue.
s_temp='02 Plot Group w Threshold';
group_plotOfThree_Threshold(PC.E1,sProp,[DTag,'ROT CON ',s_temp],sf1)
clear s_temp

s_temp='02b Group Swarm Scatter';
 group_mario_plotterOfSwarm(PC.E1);  if sf1, savethisone11([DTag,'ROT CON ',s_temp]), end 
clear s_temp


%% 03 Generate group regions (CAll_Arrays)for group analysis   
[PC.E1] = group_CALLcolector(PC.E1);

%The following code is not used for Control SCANS
% s_temp='03 Experiment Call Swarm Scatter';
%  ExpSet_mario_plotterOfSwarm(PC);  if sf1, savethisone11([DTag,'',s_temp]), end 
% clear s_temp


%% 04 Run ROC curve test   
s_temp='04 ROC Curve';
 [PC.E1.ROC]=ROT_ROC_RUN(PC.E1.CALL); if sf1, savethisone11([DTag,'ROT CON ',s_temp]), end  
clear s_temp

% generates a boxplot for each deg of error based on the roc regions,
% compliments roc, % experiment_boxploterOfTwo(E1.ROC.Roc_TumorVsFC,sf1,[DTag,'ROT CON ',s_temp]) 
s_temp='04b BoxPlot for ROC';
 mario_boxploterOfTwo(PC.E1.ROC.Roc_TumorVsFC.call_posBox,PC.E1.ROC.Roc_TumorVsFC.call_negBox,'Tumor','Fibro and Clutter');  if sf1, savethisone11([DTag,'ROT CON ',s_temp]), end 
clear s_temp

close all;


%% 05 Run Hypothesis test to determine if samples are similar

%Two-sample Kolmogorov-Smirnov test
 PC.E1=ExpSet_RUN_Hypothesis(PC.E1);


%% 06 Run SCR test (or other tests)
%changed to after 07

%% 07 Run diagnostic scrpit                   <-------------------------------Under constructions
%Finds tumors avobe thresholds, if more than 2 pixel, it counts and detects
% its center. 
[PC]=Exp1_RUN_DiagnosticScript(PC,sProp);

% Plot tumor location according to diagnostic
ErrorSet_plot_DiagnosticPlot(PC,sProp,sf1,DTag)

%% 06 Run Image metric RetroFix

PC=ErrorSet_ImageMetricsRetroFix(PC); %<- MVF Single most importat function in the game
PC=ErrorSet_RecoQualityMetricsRetroFix(PC); %<- MVF Single most importat function in the game


%% 08 Group quality/ summary constructor Excel spitter

% 3.e Save excel values
PC=Exp1_summaryMaker(PC,DTag);

% Generate eXcel files
ErrorSet_ExcelExporter(PC,'Group',DTag)

%% END Saves CPC_Processed
save([DTag,'PC'],'PC')




