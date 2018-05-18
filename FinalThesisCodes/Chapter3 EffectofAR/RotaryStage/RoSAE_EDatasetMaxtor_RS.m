%% SAE DatasetMaxtor_RS

% Finished June 30th. 
%Pending work:

% It is proably best to have the error placed in the worst antenna
% position, right in front of the tumor which is location: XXXX instead of
% 82
%



%By Mario Solis
% This scripts creates! the datasets with error RoSAE, Rotary Stage single accuracy error generated. 
% Segments the responses
% Calculates standard and quality metrics
% Saves result and excel tables
% Generates plots to compare effect of error. 
%% Default settings
set(0,'defaultAxesFontName', 'Times New Roman')
set(0,'DefaultAxesFontSize',16)
set(0,'DefaultFigureColormap',paruly)
cmap=colormap(paruly);
col_Tumor=cmap(50,:);
col_Fibro=cmap(35,:);
col_Back=cmap(10,:);

close all



%% Working Folder
%@ Guaper, 
cd('F:\UserElGuapo\DBOx\Dropbox\ResearchMagic\RandomProyects\160110 12 Effects of AR\MASTER Dataset');

f_variables='F:\UserElGuapo\DBOx\Dropbox\ResearchMagic\RandomProyects\160110 12 Effects of AR\MASTER Dataset\AccuracyErrors\SAE';
f_masterSets='F:\UserElGuapo\Google Drive\masterSets\RotaryStage';
f_root='F:\UserElGuapo\DBOx\Dropbox\ResearchMagic\RandomProyects\160110 12 Effects of AR\MASTER Dataset';

% Load variables
load('L288_P.mat')
load('L288_SetPlus.mat')
load('RecSettings_ExperimentSL72.mat')
load('Regions.mat')

%
cd(f_masterSets)

load('SAEs_Lean_MetricsOnly.mat')
cd(f_variables)

%% Sample into  3 72L files
%{
SL72_P1.set_ref=SampleRaw(4,P1.set_ref);
SL72_P1.set_data=SampleRaw(4,P1.set_data);
SL72_P1.set_tumor=SampleRaw(4,P1.set_tumor);

SL72_P2.set_ref=SampleRaw(4,P2.set_ref);
SL72_P2.set_data=SampleRaw(4,P2.set_data);
SL72_P2.set_tumor=SampleRaw(4,P2.set_tumor);

SL72_P3.set_ref=SampleRaw(4,P3.set_ref);
SL72_P3.set_data=SampleRaw(4,P3.set_data);
SL72_P3.set_tumor=SampleRaw(4,P3.set_tumor);

save SL72_ScanData_P1 SL72_P1
save SL72_ScanData_P2 SL72_P2
save SL72_ScanData_P3 SL72_P3
%}

%% Load those scanned things
load('SL72_ScanData_P1.mat')
load('SL72_ScanData_P2.mat')
load('SL72_ScanData_P3.mat')

%% SAE Single Accuracy Error
% A single antenna element is shifted by PD in both  of the scans;
% 
% %{


SAEs.PD_P1.Name='Single Aaccuracy Errors P1';

x_p=81; % Error or antenna location

% Generate SAE errors based on three control groups.
[SAEs.PD_P1]=SAE_Generator(81,L288_P1,SL72_P1);
[SAEs.PD_P2]=SAE_Generator(81,L288_P2,SL72_P2);
[SAEs.PD_P3]=SAE_Generator(81,L288_P3,SL72_P3);


SAEs.PD_P1.GName='P1-SAE';
SAEs.PD_P2.GName='P2-SAE';
SAEs.PD_P3.GName='P3-SAE';

%save variables 
cd(f_masterSets);
save SAEs SAEs;

%{
%How SAE Generator works
[SAE.E1.A,SAE.E1.B]=SAcc_Err(1,x_p,setA_fold72,setB_fold72,setA,setB); % 1/4 Step
[SAE.E2.A,SAE.E2.B]=SAcc_Err(2,x_p,setA_fold72,setB_fold72,setA,setB); % 1/2 Step
[SAE.E4.A,SAE.E4.B]=SAcc_Err(4,x_p,setA_fold72,setB_fold72,setA,setB); % 1 Step
[SAE.E12.A,SAE.E12.B]=SAcc_Err(12,x_p,setA_fold72,setB_fold72,setA,setB); % 3 Step
%}


%% Reconstruct images, save figures and save variables 
close all;
cd(f_figures)

tic
%Reconstruct with positional deviations 

[SAEs.PD_P1]=PD_RecoSaver_Rotary(SAEs.PD_P1,'P1-SAE',RecSettings);
[SAEs.PD_P2]=PD_RecoSaver_Rotary(SAEs.PD_P2,'P2-SAE',RecSettings);
[SAEs.PD_P3]=PD_RecoSaver_Rotary(SAEs.PD_P3,'P3-SAE',RecSettings);



% Save variables  
cd(f_masterSets)
save SAEs_wScans SAEs
close all

toc



%% ------3 Process reconstructed images, segment, evaluate and quantify.------ %%
% 3 Preparation {some variables are assigned}
% 3.a Display regions for one image
% 3.b Calculate Standard Metrics per regions
% 3.c Calculate image/difference metrics
% 3.d Calculate radar image quality metrics
% 3.e Save excel values

%% 3 Preparation
f_SAE_Evaluation='F:\UserElGuapo\DBOx\Dropbox\ResearchMagic\RandomProyects\160110 12 Effects of AR\MASTER Dataset\AccuracyErrors\SAE\Eval';
IP_Clim=5e-9;
IM_Clim=7e-5;
cd(f_SAE_Evaluation);

%% 3.a Display regions for one image
% In case of flies, one specific reconstructed image is separated into strucutres 
% P2.E15 is reconstructed, for no specific reason.

regions_show(SAEs.PD_P2.E1.SCAN.Fig_c_RecZoomFlip_abs,SAEs.PD_P2.E12.SCAN.Fig_c_RecZoomFlip_abs,Regions,'SAE P2',IP_Clim);
cd([f_SAE_Evaluation,'\3a Regions'])
savethisone('RegionsOfSegmentationSAE')

%% 3.b Calculate Standard Metrics per regions

close all;
cd([f_SAE_Evaluation,'\3b StandardMetrics'])
[SAEs.PD_P1]=Group_RegionSegmenter_Rotary(SAEs.PD_P1,Regions,IM_Clim,IP_Clim); 
[SAEs.PD_P2]=Group_RegionSegmenter_Rotary(SAEs.PD_P2,Regions,IM_Clim,IP_Clim); 
[SAEs.PD_P3]=Group_RegionSegmenter_Rotary(SAEs.PD_P3,Regions,IM_Clim,IP_Clim); 


% Change folder and save SAEs
cd(f_masterSets)
save SAEs_wScans SAEs

%% 3.c Calculate image/difference metrics [power]
% Calculate image diferences to ->average scan<-
cd([f_variables,'\D_ImageDiferences'])
load('F:\UserElGuapo\DBOx\Dropbox\ResearchMagic\RandomProyects\160110 12 Effects of AR\MASTER Dataset\Control Scans\Average_SCAN72Rec.mat')

refImage=abs(Average_SCAN72Rec.PAVE).^2;
RefImageMetrics=SAEs.PD_P1.E1.PowImageMetrics;

%[SAEs.PD_P1.E1.PowImageMetrics]=IQ_Standard(NEWIMAGE,REFIMAGE,(SAEs.PD_P1.E1.PowImageMetrics),Average_SCAN72Rec.PowImageMetrics); savethisone([SAEs.PD_P1.E1.ImageMetrics.Name 'SSIM vs Average POw']);% Same, just saved in both Metric Files
[SAEs.PD_P1]=Group_IQStandard(SAEs.PD_P1,refImage,RefImageMetrics);
[SAEs.PD_P2]=Group_IQStandard(SAEs.PD_P2,refImage,RefImageMetrics);
[SAEs.PD_P3]=Group_IQStandard(SAEs.PD_P3,refImage,RefImageMetrics);

%save files
cd(f_masterSets)
save SAEs_wScans SAEs

%% 3.d Calculate radar image quality metrics [based on magnitude, of course]
[SAEs.PD_P1] = Group_RecoQualityMetrics(SAEs.PD_P1); 
[SAEs.PD_P2] = Group_RecoQualityMetrics(SAEs.PD_P2); 
[SAEs.PD_P3] = Group_RecoQualityMetrics(SAEs.PD_P3); 

cd(f_masterSets)
save SAEs_wScans SAEs

%% 3.xx Patching 
%[SAEs_l]=ErrorSet_table(SAEs_l);
cd([f_variables,'\F_Positions']);
[SAEs.PD_P1.E1] = spatialPos(SAEs.PD_P1.E1);
[SAEs.PD_P1.E2] = spatialPos(SAEs.PD_P1.E2);
[SAEs.PD_P1.E4] = spatialPos(SAEs.PD_P1.E4);
[SAEs.PD_P1.E12] = spatialPos(SAEs.PD_P1.E12);


[SAEs.PD_P2.E1] = spatialPos(SAEs.PD_P2.E1);
[SAEs.PD_P2.E2] = spatialPos(SAEs.PD_P2.E2);
[SAEs.PD_P2.E4] = spatialPos(SAEs.PD_P2.E4);
[SAEs.PD_P2.E12] = spatialPos(SAEs.PD_P2.E12);

[SAEs.PD_P3.E1] = spatialPos(SAEs.PD_P3.E1);
[SAEs.PD_P3.E2] = spatialPos(SAEs.PD_P3.E2);
[SAEs.PD_P3.E4] = spatialPos(SAEs.PD_P3.E4);
[SAEs.PD_P3.E12] = spatialPos(SAEs.PD_P3.E12);
cd(f_masterSets)
save SAEs_wScans SAEs

%% 3.e Save excel values

% Generate eSummary so exporting is easier
[SAEs.PD_P1]=Group_summaryMaker(SAEs.PD_P1);
[SAEs.PD_P2]=Group_summaryMaker(SAEs.PD_P2);
[SAEs.PD_P3]=Group_summaryMaker(SAEs.PD_P3);
cd(f_masterSets)
save SAEs_wScans SAEs

%%
cd([f_variables,'\E_ExcelFiles']) 
Group_ExcelExporter(SAEs.PD_P1,'Group');
Group_ExcelExporter(SAEs.PD_P2,'Group');
Group_ExcelExporter(SAEs.PD_P3,'Group');

% Export individual eSummary to excel
%{
Group_ExcelExporter(SAEs.PD_P1) 
Group_ExcelExporter(SAEs.PD_P2) 
Group_ExcelExporter(SAEs.PD_P3) 
%}

%% 3f LeanGroup maker
% removes ref, set and SCAN sections of the files

cd(f_masterSets)
[SAEs_l.PD_P1]=Group_LeanGroupMaker(SAEs.PD_P1);
[SAEs_l.PD_P2]=Group_LeanGroupMaker(SAEs.PD_P2);
[SAEs_l.PD_P3]=Group_LeanGroupMaker(SAEs.PD_P3);

save SAEs_Lean_MetricsOnly SAEs_l
cd(f_variables)
save SAEs_Lean_MetricsOnly SAEs_l




%% Copy specific elements to the lean structure
% This function was made in the dare case that I were to miss some
% variables after making the lean files
%{
[SAEs_l.PD_P1.E1]= structureTransfer_Rot(SAEs.PD_P1.E1,SAEs_l.PD_P1.E1);
[SAEs_l.PD_P1.E2]= structureTransfer_Rot(SAEs.PD_P1.E2,SAEs_l.PD_P1.E2);
[SAEs_l.PD_P1.E4]= structureTransfer_Rot(SAEs.PD_P1.E4,SAEs_l.PD_P1.E4);
[SAEs_l.PD_P1.E12]= structureTransfer_Rot(SAEs.PD_P1.E12,SAEs_l.PD_P1.E12);

[SAEs_l.PD_P2.E1]= structureTransfer_Rot(SAEs.PD_P2.E1,SAEs_l.PD_P2.E1);
[SAEs_l.PD_P2.E2]= structureTransfer_Rot(SAEs.PD_P2.E2,SAEs_l.PD_P2.E2);
[SAEs_l.PD_P2.E4]= structureTransfer_Rot(SAEs.PD_P2.E4,SAEs_l.PD_P2.E4);
[SAEs_l.PD_P2.E12]= structureTransfer_Rot(SAEs.PD_P2.E12,SAEs_l.PD_P2.E12);

[SAEs_l.PD_P3.E1]= structureTransfer_Rot(SAEs.PD_P3.E1,SAEs_l.PD_P3.E1);
[SAEs_l.PD_P3.E2]= structureTransfer_Rot(SAEs.PD_P3.E2,SAEs_l.PD_P3.E2);
[SAEs_l.PD_P3.E4]= structureTransfer_Rot(SAEs.PD_P3.E4,SAEs_l.PD_P3.E4);
[SAEs_l.PD_P3.E12]= structureTransfer_Rot(SAEs.PD_P3.E12,SAEs_l.PD_P3.E12);
save SAEs_Lean_MetricsOnly SAEs_l
%}

%% 3.f Generate error mean average value and mean error Table for error experiment
clc
cd(f_variables)
%[SAES_lwSummary]=ErrorSet_table(SAEs_l);% <- correct one
[SAES_lwSummary]=ErrorSet_table(SAEs_l);


%save SAES_lwSummary SAES_lwSummary;

%% 3.G  Generate MSEB compare test
cd([f_variables,'\G_IQMPlots']);
close all; controlCompareSet(SAES_lwSummary,[1.25,2.5,5,15],{'1.25°  ','    2.5°','5°','15°'},'SAE vs Control valuesD');

cd(f_variables)
 %Generate plot with MSEB of control groups and IQM of TCA2

% ScR_v=[FP_DataMetrics.TCA1.ImageMetrics.eSummary.ScR_M];
% TfR_v=[FP_DataMetrics.TCA1.ImageMetrics.eSummary.TfR_M];
% CcR_v=[FP_DataMetrics.TCA1.ImageMetrics.eSummary.CcR_M];
% 
% controlCompare(ScR_v,TfR_v,CcR_v,1,{'1'},'one tumor');
% savethisone('graph TCA1 vs Control')
