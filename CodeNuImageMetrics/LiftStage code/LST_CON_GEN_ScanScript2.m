
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

try cd('F:\UserElGuapo\Google Drive\masterSets\LiftStage\1 Top\LST CON');
catch % Lab CPU
end

% If already existent, load the ProcessedCa and the 
try %load D0816_ProcessedCA;
    load LST_ControlArraysOnly
catch disp('No can do'); % Remove 
    load('TopRegion_Control.mat') 
    
    LSTCON_Arrays.P_P1=LSSet_T.L0.P1.C_Scan.Fig_c_RecZoomFlip_abs;
    LSTCON_Arrays.P_P2=LSSet_T.L0.P2.C_Scan.Fig_c_RecZoomFlip_abs;
    LSTCON_Arrays.RecSettings=LSSet_T.L0.P1.C_Scan.RecSettings;
    
    save LST_ControlArraysOnly LSTCON_Arrays
    
end

%% Load sProps from ROT CON and delete
% CLIM
% Amask
% threshold back and clutter


load 'F:\UserElGuapo\Google Drive\masterSets\RotaryStage\CONTROL SCANS\D0819_sProp.mat'



LsProp.location_tumor=sProp.location_tumor;
LsProp.location_fibro=sProp.location_fibro;
LsProp.radius_target=sProp.radius_target;
LsProp.imx_t=sProp.imx_t;
LsProp.imy_t=sProp.imy_t;
LsProp.Masks=rmfield(sProp.Masks,'cMask'); % Mask now is correct

%NEW
LsProp.radius_phantom=8.5;
LsProp.CLim=[0 5e-9]; % I think its safe to leave it at 5,
LsProp.threshVal_tumor=0; %so far 
LsProp.threshVal_back=0; %so far


%%
DTag=['LSTCON','_0824_'];
sf1=1;

save([DTag,'LsProp'],'LsProp')

%% 01 mask outer region, currently using 14 pixels 
[PC.E1.P_P1.A_masked,~]=mario_cMasker(LSTCON_Arrays.C_P1,14);
[PC.E1.P_P2.A_masked,c_mask]=mario_cMasker(LSTCON_Arrays.C_P2,14);
imshow(c_mask)
% Display masked 

group_plotOfThree_LS(PC.E1,LsProp,DTag,'CON ',sf1)
LsProp.Masks.cMask=c_mask;
save([DTag,'LsProp'],'LsProp')

%% 02 Extracts values from pre-defined regions and masks the array
[PC.E1.P_P1.A_masked,PC.E1.P_P1.R_Values] = mario_segmenter_FromTargetMask_LS(LSTCON_Arrays.C_P1,LsProp.Masks);
[PC.E1.P_P2.A_masked,PC.E1.P_P2.R_Values] = mario_segmenter_FromTargetMask_LS(LSTCON_Arrays.C_P2,LsProp.Masks);

%% 03 Boxplot pixels for each region, 
mario_boxploterOfThree(PC.E1.P_P1.R_Values); title('Control scan 1');
if sf1, savethisone11(DTag,'03a BoxPlot ControlS1'),end

mario_boxploterOfThree(PC.C_P2.R_Values); title('Control scan 2');
if sf1, savethisone11(DTag,'03b BoxPlot ControlS2'),end

%% 04 Generate cALLs

%-% Obtain compound regions from all control sets
call_tumor = [PC.E1.P_P1.R_Values.tumor;
            PC.E1.P_P2.R_Values.tumor];

call_rest= [PC.E1.P_P1.R_Values.rest;
            PC.E1.P_P2.R_Values.rest];
        
call_fibro= [PC.E1.P_P1.R_Values.fibro;
            PC.E1.P_P2.R_Values.fibro];
        
%cALL boxplot
BXCall.tumor=call_tumor;
BXCall.fibro=call_fibro;
BXCall.rest=call_rest;

 mario_boxploterOfThree(BXCall); title('CALL for Control Scan');
 if sf1, savethisone11(DTag,'04 BoxPlot CALL ControlS'),end
%% 05 ROC Tumor Vs Fibro untouched

%1% ROC for one control. Tumor Vs Fibro 

call_posBox = call_tumor;
        
call_negBox = call_fibro;

roc_data = [call_posBox;call_negBox];
roc_flag = [ones(size(call_posBox));zeros(size(call_negBox))];  % positives have a value of one, neg =0
roc_tresholds=0;
roc_alpha=0.05;

roc_TumorVsFibro=roc_M_GC2017([roc_data,roc_flag],roc_tresholds,roc_alpha,1);
if sf1, savethisone11(DTag,'05 ROC FAIL Control Call TumorVSFibro'),end

%% 06 ROC Fibro vs Rest

%1% ROC for one control. Tumor Vs Fibro 

call_posBox = call_fibro;
        
call_negBox = call_rest;

roc_data = [call_posBox;call_negBox];
roc_flag = [ones(size(call_posBox));zeros(size(call_negBox))];  % positives have a value of one, neg =0
roc_tresholds=0;
roc_alpha=0.05;

roc_FibroRest=roc_M_GC2017([roc_data,roc_flag],roc_tresholds,roc_alpha,1);
if sf1, savethisone11(DTag,'06a ROC Control Call FibroVSRest'),end


% Make a boxplot with the calculated thresholds
    tag1={'fibro'};
    tag2={'rest'};
    roc_names=  [repmat(tag1,length(call_posBox),1);repmat(tag2,length(call_negBox),1)];
    mario_boxploterOfTwo(call_posBox,call_negBox,'Fibroglandular','Rest of pixels');  
    if sf1, savethisone11(DTag,'06b BoxPlot Control Fibro VS Rest'),end
    close all;
    
    mario_boxploterOfTwo(call_posBox,call_negBox,'Fibroglandular','Rest of pixels'); 
    hold on; 
    l1= plot([0 4],repmat(roc_FibroRest.cutoffPoitns.Max_Sensitivity,2),...
        'LineWidth',2,...
        'LineStyle',':',...
        'Color',[0.3 0.4 0.6]); 

    l2= plot([0 4],repmat(roc_FibroRest.cutoffPoitns.Max_Specificty,2),...
        'LineWidth',2,...
        'LineStyle',':',...
        'Color',[0.3 0.4 0.6]*1.1); 

    l3= plot([0 4],repmat(roc_FibroRest.cutoffPoitns.Cost_Effective,2),...
        'LineWidth',2,...
        'LineStyle','--',...
        'Color',[0.5 0.3 0.4]); 

    l4= plot([0 4],repmat(roc_FibroRest.cutoffPoitns.Max_Efficiency,2),...
        'LineWidth',2,...
        'LineStyle','--',...
        'Color',[0.3 0.4 0.6]*1.1); 

    legend([l1(1) l2(1) l3(1) l4(1)],{'Max Sensitivity','Max Specificity','Cost Effective','Max Efficiency'})

    if sf1, savethisone11([DTag,'06c BoxPlot Control Fibro Vs Rest cutoffs']),end




%% 07 Define Back Threshold

 PC.ROC.roc_FibroVsRest=roc_FibroRest;
 %
% ! FOR THE LIFT STAGE THE THRESHOLD IS DEFINED BY MAX EFICIENCY AND
%           MAX EFFICIENCY:  Cut-off point= 1.67e-10    (Not Younes) %<
%           Which is  shy of half of  Rot CON = 2.1961e-10 (Younes)
%-------------------------------------------------------------------------%
LsProp.threshVal_back= PC.ROC.roc_FibroVsRest.cutoffPoitns.Max_Efficiency;
%-------------------------------------------------------------------------%
%

%% 08 Remove values under background threshold level
close all;
back_thres_val=LsProp.threshVal_back; 


[PC.E1]= mario_TryThresholdTool_LS(back_thres_val,PC.E1);


% Generates a plot of three for each deg of error
s_temp='08a Plot Group w Threshold';
group_plotOfThree_Threshold_LS(PC.E1,LsProp,DTag,['Top CON ',s_temp],sf1)
clear s_temp

close all;
s_temp='08b Group Swarm Scatter';
 group_mario_plotterOfSwarm_LS(PC.E1,LsProp);  if sf1, savethisone11(DTag,['Top CON ',s_temp]), end 

clear s_temp

%% 09 Run thresholded ROC

%Update Call  values to 
call_tumor = [PC.E1.P_P1.R_tValues.tumor;
            PC.E1.P_P2.R_tValues.tumor];
        
call_fibro= [PC.E1.P_P1.R_tValues.fibro;
            PC.E1.P_P2.R_tValues.fibro];
 
call_clutter= [PC.E1.P_P1.R_tValues.clutter;
               PC.E1.P_P2.R_tValues.clutter];
        
        
call_rest= [PC.E1.P_P1.R_Values.rest;
            PC.E1.P_P2.R_Values.rest];

% Add them to Parent structure
PC.E1.CALL.call_tumor=call_tumor;
PC.E1.CALL.call_fibro=call_fibro;
PC.E1.CALL.call_clutter=call_clutter;
PC.E1.CALL.call_rest=call_rest;
          
%5% ROC of Tumor vs Rest+Clutter

call_posBox = call_tumor;
        
call_negBox = [call_fibro;
               call_clutter];

roc_data = [call_posBox;call_negBox];
roc_flag = [ones(size(call_posBox));zeros(size(call_negBox))];  % positives have a value of one, neg =0
roc_tresholds=0;
roc_alpha=0.05;

roc_TumorVsFibroClutter=roc_M_GC2017([roc_data,roc_flag],roc_tresholds,roc_alpha,1);
if sf1, savethisone11(DTag,'09a ROC Tumor vs FibroAndClutter'),end

    %Boxplot for Tumor vs Rest+Clutter
    % Make a boxplot with the calculated thresholds
    tag1={'fibro'};
    tag2={'rest'};
    roc_names=  [repmat(tag1,length(call_posBox),1);repmat(tag2,length(call_negBox),1)];
    mario_boxploterOfTwo(call_posBox,call_negBox,'Tumor','Rest of pixels (no background)');  
    if sf1, savethisone11(DTag,'09b BoxPlot Tumor vs FibroAndClutter (no background)'),end ; close all;
    mario_boxploterOfTwo(call_posBox,call_negBox,'Tumor','Rest of pixels (no background)');  
    hold on; 
    l1= plot([0 4],repmat(roc_TumorVsFibroClutter.cutoffPoitns.Max_Sensitivity,2),...
        'LineWidth',2,...
        'LineStyle',':',...
        'Color',[0.3 0.4 0.6]); 

    l2= plot([0 4],repmat(roc_TumorVsFibroClutter.cutoffPoitns.Max_Specificty,2),...
        'LineWidth',2,...
        'LineStyle',':',...
        'Color',[0.3 0.4 0.6]*1.1); 

    l3= plot([0 4],repmat(roc_TumorVsFibroClutter.cutoffPoitns.Cost_Effective,2),...
        'LineWidth',2,...
        'LineStyle','--',...
        'Color',[0.5 0.3 0.4]); 

    l4= plot([0 4],repmat(roc_TumorVsFibroClutter.cutoffPoitns.Max_Efficiency,2),...
        'LineWidth',2,...
        'LineStyle','--',...
        'Color',[0.3 0.4 0.6]*1.1); 

    legend([l1(1) l2(1) l3(1) l4(1)],{'Max Sensitivity','Max Specificity','Cost Effective','Max Efficiency'})
    if sf1, savethisone11(DTag,['09c BoxPlot Tumor vs FibroAndClutter cutoffs']),end



%% Unofical ROC  07.5 ROC tumor vs fibro
%5% ROC of Tumor vs Rest+Clutter
call_posBox = call_tumor;
        
call_negBox = [call_fibro];

roc_data = [call_posBox;call_negBox];
roc_flag = [ones(size(call_posBox));zeros(size(call_negBox))];  % positives have a value of one, neg =0
roc_tresholds=0;
roc_alpha=0.05;

roc_TumorVsFibro=roc_M_GC2017([roc_data,roc_flag],roc_tresholds,roc_alpha,1);
if sf1, savethisone11(DTag,['09_5 ROC Tumor vs Fibro with Thresholds']),end

PC.ROC.roc_TumorVsFibroThresh=roc_TumorVsFibro;



%% 10 Oficial Run ROC curve test  
s_temp='10a TumorVsRest ROC Curve';
 [PC.E1.ROC]=ROT_ROC_RUN(PC.E1.CALL); if sf1, savethisone11(DTag,['Top CON ',s_temp]), end  

clear s_temp

% generates a boxplot for each deg of error based on the roc regions,
% compliments roc, % experiment_boxploterOfTwo(E1.ROC.Roc_TumorVsFC,sf1,[DTag,'E1 ',s_temp]) 
s_temp='10b BoxPlot for ROC';
 mario_boxploterOfTwo(PC.E1.ROC.Roc_TumorVsFC.call_posBox,PC.E1.ROC.Roc_TumorVsFC.call_negBox,'Tumor','Fibro and Clutter');  if sf1, savethisone11(DTag,['Top CON ',s_temp]), end 

clear s_temp

close all;

PC.E1.P_P1.R_tValues

%% 11 Obtain some statistics about the fibroglandular regions
%maximum fibro value on each scan
C1_fmax=max(PC.E1.P_P1.R_tValues.fibro);
C2_fmax=max(PC.E1.P_P2.R_tValues.fibro);


table(C1_fmax,C2_fmax)

fibro3std=std([C1_fmax,C2_fmax]);
fibro3se=fibro3std/sqrt(2);
fibro3max=([C1_fmax,C2_fmax]);
fibro3maxmax=max([C1_fmax,C2_fmax]);
fibro3maxmin=min([C1_fmax,C2_fmax]);
fibro3maxmean=mean([C1_fmax,C2_fmax]);

fibro3median=median(PC.E1.CALL.call_fibro);

%PLOTFIGURE
close all; figure(1); hold on

%max +3std 
base=fibro3maxmean; height=tinv(1-(0.005/2),1)*fibro3std+base;   %<- play with base  and height
l1=patch([0 0 7 7],[base, height, height,  base],[0.4 0.5 0.6], 'FaceAlpha',1,'EdgeColor',[0.4 0.5 0.6]);

%max +2std
height=tinv(1-(0.01/2),1)*fibro3std+base;
l2= patch([0 0 7 7],[base, height, height,  base],[0.4 0.5 0.6].^0.5, 'FaceAlpha',1,'EdgeColor',[0.4 0.5 0.6].^0.5 );

%max +1std
height=tinv(1-(0.05/2),1)*fibro3std+base;
l3=patch([0 0 7 7],[base, height, height,  base],[0.4 0.5 0.6].^0.25, 'FaceAlpha',1,'EdgeColor',[0.4 0.5 0.6].^0.25 );

i=0.75;
plot(rand(length(PC.E1.P_P1.R_tValues.fibro),1)/2 +i,PC.E1.P_P1.R_tValues.fibro,'ko','MarkerFaceColor',[0.1 0.8 0.2].^(1)); i=i+1;
plot(rand(length(PC.E1.P_P2.R_tValues.fibro),1)/2 +i,PC.E1.P_P2.R_tValues.fibro,'ko','MarkerFaceColor',[0.1 0.8 0.2].^(.5)); i=i+1;

%plot tumor
plot(rand(length(PC.E1.P_P1.R_tValues.tumor),1)/2 +i,PC.E1.P_P1.R_tValues.tumor,'ko','MarkerFaceColor',[0.8 0.2 0.2].^(1)); i=i+1;
plot(rand(length(PC.E1.P_P2.R_tValues.tumor),1)/2 +i,PC.E1.P_P2.R_tValues.tumor,'ko','MarkerFaceColor',[0.8 0.2 0.2].^(.5)); i=i+1;

xlim([0 5]); ylim([0 5e-9])
plot([1.5 1.5],[0 6e-9],'k');
plot([2.5 2.5],[0 6e-9],'k');
plot([3.5 3.5],[0 6e-9],'k');

set(gca,'XTick', [1 2 3 4 ],...
    'XTickLabel',{'F 1' 'F 2' 'T 1' 'T 2'});

legend([l1,l2,l3],'99.5%','99.0%','95.0%','Location','northwest')


if sf1, savethisone11(DTag,['11 Scattered values for fibroglandular across two scans MeanFMax']),end

tumor_thres_val=base + tinv(1-(0.01/2),1)*fibro3std;
plot([0 3.5],[tumor_thres_val tumor_thres_val],'k');


% ! FOR THE LIFT STAGE THE THRESHOLD IS DEFINED BY 99% t-critical value of
% a 2 sample mean fibro 
%           LS TUmor Cut-off point= 1.67e-9    (Mean+t(a99)Sd) %<
%           Which is  shy of half of  Rot CON = [2.96-09] (2 +sd )
%-------------------------------------------------------------------------%
LsProp.threshVal_tumor= tumor_thres_val;
%-------------------------------------------------------------------------%
%



%% 12 Run Hypothesis test to determine if samples are similar

%Two-sample Kolmogorov-Smirnov test

 PC.E1=ExpSet_RUN_Hypothesis(PC.E1);


%% 13 Run SCR test (or other tests)
%changed to after 07

%% 12 but 07 on saveFig Run diagnostic scrpit                 
%Finds tumors avobe thresholds, if more than 2 pixel, it counts and detects
% its center. 
[PC]=Exp1_RUN_DiagnosticScript(PC,LsProp);  

% Plot tumor location according to diagnostic
ErrorSet_plot_DiagnosticPlot_LS(PC,LsProp,sf1,DTag)


%% 06 Run Image metric RetroFix

PC=ErrorSet_ImageMetricsRetroFix_LS(PC); %<- MVF Single most importat function in the game

PC=ErrorSet_RecoQualityMetricsRetroFix_LS(PC); %<- MVF Single most importat function in the game


%% 08 Group quality/ summary constructor Excel spitter

% 3.e MAke summary table values
PC=Exp1_summaryMaker_LS(PC,DTag);

% Generate eXcel files
ErrorSet_ExcelExporter(PC,'Group',DTag)


%% END Saves CPE_Processed
save([DTag,'PC'],'PC')
save([DTag,'LsProp'],'LsProp')

disp('')
disp('---')
disp('--')
disp('-')
disp('!')
disp('Done, Thanks!')
