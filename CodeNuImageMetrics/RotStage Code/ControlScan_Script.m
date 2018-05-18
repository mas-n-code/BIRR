%--------------------------------------------------------------------------
%---------------------mario_ControlScan_script-----------------------------
%--------------------------------------------------------------------------

% Process the control scan images, extracts the energy from the tumor and
% fibro at their corresponding locations. Elminate bottom 95% (clutter)
% Generate boxplots of three control scans. 
% Runs ROC curve evaluation

% --- Open/Load control arrays ---

% Open directory where files are located

sf1=1; % set sf1 to 1 to activate savefig commands
DTag='D0819_';

try cd('F:\UserElGuapo\Google Drive\masterSets\RotaryStage\CONTROL SCANS');
catch % Lab CPU
end

% If already existent, load the ProcessedCa and the 
try %load D0816_ProcessedCA;
    load ROT_ControlArraysOnly
    load ROTsPropV03uPdated
catch disp('No can do');
end
%% Initialize some variables

% Load Arrays and image coordinates
% load('ROT_ControlArraysOnly.mat')
% imx = ControlArrays.Fig_c_imx;
% imy = ControlArrays.Fig_c_imy;

% 
% % Resolution
% disp(['Image alleged resolution ', num2str(imx(3)-imx(2)),' cm']);
% 
% % Define patch location
% sProp.location_tumor = [-2.25,-3.75];
% sProp.location_fibro = [3.75,-2.25];
% sProp.radius_target = [1]; %diameter 1.5 ;
% sProp.radius_phantom = 8;
% sProp.CLim = [0 5e-9];
% 
% % determine 'adjusted' scale; 
% speed = 2.0e8; 
% zoomf = 20;
% fl_high = 8e9;
% imx_t=linspace(-zoomf,zoomf,(zoomf*2+1)).*(speed*100/(4*(fl_high)));%(Mu/(2*(6e9)))=0.0121 where Mu=1.45e8
% imy_t=imx_t*-1;
% 
% sProp.imx_t=imx_t;
% sProp.imy_t=imy_t;
% 
% sProp.othervalues.imx_old=imx;
% sProp.othervalues.imy_old=imy;
% 
% ProcessedCA.sProp=sProp;

%% --- Display arrays  ---
% Original array:
%plot_ImageofThree(ControlArrays.C_P1_A,ControlArrays.C_P2_A,ControlArrays.C_P3_A,imx_t,imy_t,sProp)

%% mask outer region, currently using 13 pixels
ProcessedCA.C_P1.A_masked=mario_cMasker(ControlArrays.C_P1_A,13);
ProcessedCA.C_P2.A_masked=mario_cMasker(ControlArrays.C_P2_A,13);
ProcessedCA.C_P3.A_masked=mario_cMasker(ControlArrays.C_P3_A,13);

% Display masked 
plot_ImageofThree(ProcessedCA.C_P1.A_masked,ProcessedCA.C_P2.A_masked,ProcessedCA.C_P3.A_masked,sProp)

if sf1, savethisoneAsIs([DTag,'01 Plot ImageofThree Control NoCrop']),end


%% Make regions based on location of tumor / Fibro %<)EEEEEEEEEEEEEEEEEEEEEERRRRRRRRRR needs review due to the exclusizon zone

%
% Segments the control scans based on target location, one by one  //
% [ProcessedCA.C_P1.R_Values,ProcessedCA.C_P1.Masks] = mario_imageSegmenter2(ProcessedCA.C_P1.A_masked,sProp);
% [ProcessedCA.C_P2.R_Values,ProcessedCA.C_P2.Masks] = mario_imageSegmenter2(ProcessedCA.C_P2.A_masked,sProp);
% [ProcessedCA.C_P3.R_Values,ProcessedCA.C_P3.Masks] = mario_imageSegmenter2(ProcessedCA.C_P3.A_masked,sProp);

% Reverse, extract
mask_fibroHand=sProp.Masks.mask_fibroHand;
%mask_fibroHandBig=sProp.Masks.mask_fibroHandBig;
mask_tumorHand=sProp.Masks.mask_tumorHand;
%mask_tumorHandBig=sProp.Masks.mask_tumorHandBig;


imgA=ProcessedCA.C_P1.A_masked;
imgAT=imgA;
imx_t=sProp.imx_t;
imy_t=sProp.imy_t;
cx_cm=sProp.location_fibro(1);
cy_cm=sProp.location_fibro(2);

hand_excl_tumor=mario_ROIeXcluder(mask_fibroHand,1);
hand_excl_fibro=mario_ROIeXcluder(mask_tumorHand,1);
exclZone=or(hand_excl_tumor,hand_excl_fibro);
targetZone=or(mask_fibroHand,mask_fibroHand);

mask_tumorHandBig=or(mask_tumorHand,hand_excl_tumor);
mask_fibroHandBig=or(mask_fibroHand,hand_excl_fibro);

imgAT(targetZone)=NaN;

figure; image(imx_t,imy_t, imgAT,'AlphaData',~isnan(imgAT),'CDataMapping','scaled'); set(gca,'YDir','normal'); axis equal; hold on;
set(gca,'CLim',[0 5e-9]);
viscircles([cx_cm,cy_cm],1);
viscircles(sProp.location_tumor,1);

imgAT=imgA;


imgAT(or(mask_tumorHandBig,mask_fibroHandBig))=NaN;
%imgAT(sProp.Masks.mask_tumor)=0.5e-9;
%imgAT(sProp.Masks.mask_fibro)=0.5e-9;

figure; image(imx_t,imy_t, imgAT,'AlphaData',~isnan(imgAT),'CDataMapping','scaled'); set(gca,'YDir','normal'); axis equal; hold on;
set(gca,'CLim',[0 5e-9]);
viscircles([cx_cm,cy_cm],1);
viscircles(sProp.location_tumor,1);

sum(sum(mask_tumorHandBig))
sum(sum(mask_tumorHand))


%ProcessedCA.C_P2.Masks.mask_excl_tumor)=0e-9;
%imgAT(ProcessedCA.C_P1.Masks.mask_fibro)=2e-9;
%imgAT(ProcessedCA.C_P2.Masks.mask_tumor)=5e-9;



% - Save
% --
% ---
% sProp.Masks.mask_fibroHand=mask_fibroHand; 
% sProp.Masks.mask_fibroHandBig=mask_fibroHandBig;
% sProp.Masks.mask_tumorHand=mask_tumorHand;
% sProp.Masks.mask_tumorHandBig=mask_tumorHandBig;
% % ---
% --
% -
%% FIX FIX - 02 Extracts values from pre-defined regions and masks the array            %____ added from other scans to compensate for exclusion zone, ideally tumor zone would be bigger

[ProcessedCA.C_P1.A_masked,ProcessedCA.C_P1.R_Values]=mario_segmenter_FromTargetMask(ProcessedCA.C_P1.A_masked,sProp.Masks);
[ProcessedCA.C_P1.A_masked,ProcessedCA.C_P2.R_Values]=mario_segmenter_FromTargetMask(ProcessedCA.C_P2.A_masked,sProp.Masks);
[ProcessedCA.C_P1.A_masked,ProcessedCA.C_P3.R_Values]=mario_segmenter_FromTargetMask(ProcessedCA.C_P3.A_masked,sProp.Masks);
plot_ImageofThree(ProcessedCA.C_P1.A_masked,ProcessedCA.C_P2.A_masked,ProcessedCA.C_P3.A_masked,sProp)
if sf1, savethisoneAsIs([DTag,'02 Plot ImageofThree Control']),end
length(ProcessedCA.C_P1.R_Values.tumor)

%% Boxplot pixels for each region, 
mario_boxploterOfThree(ProcessedCA.C_P1.R_Values); title('Control scan 1');
if sf1, savethisone11([DTag,'03a BoxPlot ControlS1']),end

mario_boxploterOfThree(ProcessedCA.C_P2.R_Values); title('Control scan 2');
if sf1, savethisone11([DTag,'03b BoxPlot ControlS2']),end

mario_boxploterOfThree(ProcessedCA.C_P3.R_Values); title('Control scan 3');
if sf1, savethisone11([DTag,'03c BoxPlot ControlS3']),end
%}

%% --- Display boxplot of three images
%Pending




%% 04 --- Generate ROC --

%-% Obtain compound regions from all control sets
call_tumor = [ProcessedCA.C_P1.R_Values.tumor;
            ProcessedCA.C_P2.R_Values.tumor;
            ProcessedCA.C_P3.R_Values.tumor;];

call_rest= [ProcessedCA.C_P1.R_Values.rest;
            ProcessedCA.C_P2.R_Values.rest;
            ProcessedCA.C_P3.R_Values.rest];
        
call_fibro= [ProcessedCA.C_P1.R_Values.fibro;
            ProcessedCA.C_P2.R_Values.fibro;
            ProcessedCA.C_P3.R_Values.fibro];
        
%1% ROC for one control. Tumor Vs Fibro 
c1_posBox = ProcessedCA.C_P1.R_Values.tumor;
c1_negBox = ProcessedCA.C_P1.R_Values.fibro;

roc_data = [c1_posBox;c1_negBox];
roc_flag = [ones(size(c1_posBox));zeros(size(c1_negBox))];  % positives have a value of one, neg =0
roc_tresholds=0;
roc_alpha=0.05;

roc_M_GC2017([roc_data,roc_flag],roc_tresholds,roc_alpha)

if sf1, savethisone11([DTag,'04a ROC C1 tumorVSfibro']),end


%2$ ROc for one control. Tumor Vs Rest
c1_posBox = ProcessedCA.C_P1.R_Values.tumor;

%rest
rest_sort=sort(ProcessedCA.C_P1.R_Values.rest,'descend');
rest_top=rest_sort(1:end);
c1_negBox = [ProcessedCA.C_P1.R_Values.fibro;rest_top];

roc_data = [c1_posBox;c1_negBox];
roc_flag = [ones(size(c1_posBox));zeros(size(c1_negBox))];  % positives have a value of one, neg =0
roc_tresholds=0;
roc_alpha=0.05;

roc_c1TumorRest=roc_M_GC2017([roc_data,roc_flag],roc_tresholds,roc_alpha,1);
if sf1, savethisone11([DTag,'04b ROC C1 tumorVSrest']),end

%3% ROC for all controls. Tumor Vs Rest
call_posBox = call_tumor;
        
rest_sort=sort(call_rest,'descend');

rest_top=rest_sort(1:end);

call_negBox = [call_fibro;
            rest_top];

roc_data = [call_posBox;call_negBox];
roc_flag = [ones(size(call_posBox));zeros(size(call_negBox))];  % positives have a value of one, neg =0
roc_tresholds=0;
roc_alpha=0.05;

roc_TumorRest=roc_M_GC2017([roc_data,roc_flag],roc_tresholds,roc_alpha,1);
if sf1, savethisone11([DTag,'04c ROC Control Call tumorVSrest']),end
    
%% 05 ROC to Apply threshold

%5% ROC for all controls. Fibro vs Rest <- DR.P IDEA
call_posBox = call_fibro;
        
call_negBox = call_rest;

roc_data = [call_posBox;call_negBox];
roc_flag = [ones(size(call_posBox));zeros(size(call_negBox))];  % positives have a value of one, neg =0
roc_tresholds=0;
roc_alpha=0.05;

roc_FibroRest=roc_M_GC2017([roc_data,roc_flag],roc_tresholds,roc_alpha,1);

if sf1, savethisone11([DTag,'05a ROC Control Call fiborVSrest']),end
    

% Make a boxplot with the calculated thresholds
tag1={'fibro'};
tag2={'rest'};
roc_names=  [repmat(tag1,length(call_posBox),1);repmat(tag2,length(call_negBox),1)];
mario_boxploterOfTwo(call_posBox,call_negBox,'Fibroglandular','Rest of pixels');  
if sf1, savethisone11([DTag,'05b BoxPlot Control fibroVSrest']),end


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

if sf1, savethisone11([DTag,'05c BoxPlot Control FibroVsRest cutoffs']),end

%% Store ROC structure
 ProcessedCA.ROC.roc_FibroVsRest=roc_FibroRest;

%% 5 Generate arrays  above  'Cost Effective' threshold for clutter
% thresh_val= roc_FibroRest.cutoffPoitns.Cost_Effective; % Cost effective from Fibro vs Rest only (no tumor)
thresh_val= ProcessedCA.ROC.roc_FibroVsRest.cutoffPoitns.Cost_Effective;

%% 6 Contrinuation delimi threshold
[ProcessedCA.C_P1,ProcessedCA.C_P2,ProcessedCA.C_P3]=mario_TryThresholdTool(thresh_val,...  %<-- Important function
    ProcessedCA.C_P1,...
    ProcessedCA.C_P2,...
    ProcessedCA.C_P3,sProp);
if sf1, savethisoneAsIs([DTag,'06 Plot Reconstructe control Scans with Back Threshold']),end

%% 07 Genereate ROC with new Thresholded Backgroudn Or clutter

%Update Call  values to 
call_tumor= [ProcessedCA.C_P1.R_tValues.tumor;
            ProcessedCA.C_P2.R_tValues.tumor;
            ProcessedCA.C_P3.R_tValues.tumor];
        
call_fibro = [ProcessedCA.C_P1.R_tValues.fibro;
              ProcessedCA.C_P2.R_tValues.fibro;
              ProcessedCA.C_P3.R_tValues.fibro];
        
call_clutter = [ProcessedCA.C_P1.R_tValues.clutter;
              ProcessedCA.C_P2.R_tValues.clutter;
              ProcessedCA.C_P3.R_tValues.clutter];
          
call_rest= [ProcessedCA.C_P1.R_Values.rest; % Note that Call_rest has background information of no use
            ProcessedCA.C_P2.R_Values.rest;
            ProcessedCA.C_P3.R_Values.rest];

% Add them to Parent structure
ProcessedCA.call_Arrays.call_tumor=call_tumor;
ProcessedCA.call_Arrays.call_fibro=call_fibro;
ProcessedCA.call_Arrays.call_clutter=call_clutter;
ProcessedCA.call_Arrays.call_rest=call_rest;
          
%5% ROC of Tumor vs Rest+Clutter

call_posBox = call_tumor;
        
call_negBox = [call_fibro;
               call_clutter];

roc_data = [call_posBox;call_negBox];
roc_flag = [ones(size(call_posBox));zeros(size(call_negBox))];  % positives have a value of one, neg =0
roc_tresholds=0;
roc_alpha=0.05;

roc_TumorVsFibroClutter=roc_M_GC2017([roc_data,roc_flag],roc_tresholds,roc_alpha,1);
if sf1, savethisone11([DTag,'07a ROC Tumor vs FibroAndClutter']),end

%Boxplot for Tumor vs Rest+Clutter
% Make a boxplot with the calculated thresholds
tag1={'fibro'};
tag2={'rest'};
roc_names=  [repmat(tag1,length(call_posBox),1);repmat(tag2,length(call_negBox),1)];
mario_boxploterOfTwo(call_posBox,call_negBox,'Tumor','Rest of pixels (no background)');  
if sf1, savethisone11([DTag,'07b BoxPlot Tumor vs FibroAndClutter (no background)']),end

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
if sf1, savethisone11([DTag,'07c BoxPlot Tumor vs FibroAndClutter cutoffs']),end

%% 07.5 ROC tumor vs fibro
%5% ROC of Tumor vs Rest+Clutter
call_posBox = call_tumor;
        
call_negBox = [call_fibro];

roc_data = [call_posBox;call_negBox];
roc_flag = [ones(size(call_posBox));zeros(size(call_negBox))];  % positives have a value of one, neg =0
roc_tresholds=0;
roc_alpha=0.05;

roc_TumorVsFibro=roc_M_GC2017([roc_data,roc_flag],roc_tresholds,roc_alpha,1);
if sf1, savethisone11([DTag,'07_5 ROC Tumor vs Fibro']),end

ProcessedCA.ROC.roc_TumorVsFibro=roc_TumorVsFibro;


%% 8 Obtain some statistics about the fibroglandular regions
%maximum fibro value on each scan
C1_fmax=max(ProcessedCA.C_P1.R_tValues.fibro);
C2_fmax=max(ProcessedCA.C_P2.R_tValues.fibro);
C3_fmax=max(ProcessedCA.C_P3.R_tValues.fibro);

table(C1_fmax,C2_fmax,C3_fmax)

fibro3std=std([C1_fmax,C2_fmax,C3_fmax]);
fibro3max=([C1_fmax,C2_fmax,C3_fmax]);
fibro3maxmax=max([C1_fmax,C2_fmax,C3_fmax]);
fibro3maxmin=min([C1_fmax,C2_fmax,C3_fmax]);
fibro3maxmean=mean([C1_fmax,C2_fmax,C3_fmax]);

fibro3median=median(ProcessedCA.call_Arrays.call_fibro);

%PLOTFIGURE
close all; figure(1); hold on

%max +3std
base=fibro3maxmean; height=3*fibro3std+base;   %<- play with base  and height
patch([0 0 7 7],[base, height, height,  base],[0.4 0.5 0.6], 'FaceAlpha',0.5 );

%max +2std
height=2*fibro3std+base;
patch([0 0 7 7],[base, height, height,  base],[0.4 0.5 0.6], 'FaceAlpha',0.5 );

%max +1std
height=1*fibro3std+base;
patch([0 0 7 7],[base, height, height,  base],[0.4 0.5 0.6], 'FaceAlpha',0.5 );

i=0.75;
plot(rand(length(ProcessedCA.C_P1.R_tValues.fibro),1)/2 +i,ProcessedCA.C_P1.R_tValues.fibro,'ko','MarkerFaceColor',[0.1 0.8 0.2].^(1)); i=i+1;
plot(rand(length(ProcessedCA.C_P2.R_tValues.fibro),1)/2 +i,ProcessedCA.C_P2.R_tValues.fibro,'ko','MarkerFaceColor',[0.1 0.8 0.2].^(.5)); i=i+1;
plot(rand(length(ProcessedCA.C_P3.R_tValues.fibro),1)/2 +i,ProcessedCA.C_P3.R_tValues.fibro,'ko','MarkerFaceColor',[0.1 0.8 0.2].^(0.25)); i=i+1;

%plot tumor
plot(rand(length(ProcessedCA.C_P1.R_tValues.tumor),1)/2 +i,ProcessedCA.C_P1.R_tValues.tumor,'ko','MarkerFaceColor',[0.8 0.2 0.2].^(1)); i=i+1;
plot(rand(length(ProcessedCA.C_P2.R_tValues.tumor),1)/2 +i,ProcessedCA.C_P2.R_tValues.tumor,'ko','MarkerFaceColor',[0.8 0.2 0.2].^(.5)); i=i+1;
plot(rand(length(ProcessedCA.C_P3.R_tValues.tumor),1)/2 +i,ProcessedCA.C_P3.R_tValues.tumor,'ko','MarkerFaceColor',[0.8 0.2 0.2].^(0.25)); i=i+1;

xlim([0 7]); ylim([0 5e-9])
plot([1.5 1.5],[0 6e-9],'k');
plot([2.5 2.5],[0 6e-9],'k');
plot([3.5 3.5],[0 6e-9],'k');
plot([4.5 4.5],[0 6e-9],'k');
plot([5.5 5.5],[0 6e-9],'k');
set(gca,'XTick', [1 2 3 4 5 6],...
    'XTickLabel',{'F 1' 'F 2' 'F 3' 'T 1' 'T 2' 'T 3'});

% What if its on the lowest 


if sf1, savethisone11([DTag,'08 Scattered values for fibroglandular across three scans T2 MeanFMax']),end

%maximum + 1/sd ,2/s 3/sd

%% Stat evaluation of difference

Effect_Size=(mean(ProcessedCA.call_Arrays.call_tumor) - mean(ProcessedCA.call_Arrays.call_fibro))/std(ProcessedCA.call_Arrays.call_tumor);

%Two-sample Kolmogorov-Smirnov test
% Determines whether two independent samples come from the same distribution
% if h=1 then the null hypothesis (same dist) is rejected at the alpha level (0.05%)
% if h=1 At the 95% confidence interval, the null hypothesis that both samples come from the same distribution is rejected 

[h1 p1]=kstest2(ProcessedCA.call_Arrays.call_tumor,ProcessedCA.call_Arrays.call_fibro,'Alpha', 0.05);
 
[h2 p2]=kstest2(ProcessedCA.call_Arrays.call_tumor,[ProcessedCA.call_Arrays.call_fibro;ProcessedCA.call_Arrays.call_clutter],'Alpha', 0.05);
ProcessedCA.Hypothesis.RejectTumorSameasFibro=[h1,p1];
ProcessedCA.Hypothesis.RejectTumorSameasRest=[h2,p2];

%% Run image metricsas
%
[ProcessedCA.C_P1.ImageMetrics]= nested_RecoMetricMagicAllinOne(ProcessedCA.C_P1);
[ProcessedCA.C_P2.ImageMetrics]= nested_RecoMetricMagicAllinOne(ProcessedCA.C_P2);
[ProcessedCA.C_P3.ImageMetrics]= nested_RecoMetricMagicAllinOne(ProcessedCA.C_P3);




%% Save final elements to the  ControlSet parent structure

ProcessedCA.ROC.roc_TumorVsFibroClutter = roc_TumorVsFibroClutter;
ProcessedCA.ROC.roc_FibroVsRest = roc_FibroRest;

%Update sProp
sProp.threshVal_back = thresh_val;
sProp.othervalues.fibro3std=fibro3std; 
sProp.othervalues.fibro3max=fibro3max; 
sProp.Masks=sProp.Masks;
sProp.threshVal_tumor = fibro3maxmean+2*fibro3std;  %<- threshold value for tumor

save([DTag,'ProcessedCA'],'ProcessedCA')


save([DTag,'sProp'],'sProp');


