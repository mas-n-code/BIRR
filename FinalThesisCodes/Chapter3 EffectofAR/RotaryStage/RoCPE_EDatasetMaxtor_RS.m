
%% RoCPE_EDatasetMaxtor_RS saves at 

% Part of the Dataset Maxtor series:

% ControlDatasetMaxtor_RS
% RoSAE_EDatasetMaxtor_RS - RoSAE_EDatasetMaxtor_RS v1.0
% RoCAE_EDatasetMaxtor_Rs - RoCAE_EDatasetMaxtor_RS v1.0
% RoRAE_EDatasetMaxtor_Rs - Pending
 
% RoCPE_EDatasetMaxtor_RS - This one
% RoCPE_EDatasetMaxtor_Rs - 
% RoRPE_EDatasetMaxtor_Rs - 


% Version 0.1; July - 12


%By Mario Solis
% This scripts creates! the datasets with error RoCPE, Rotary Stage Single PRECISION error. 
% Segments the responses
% Calculates standard and quality metrics
% Saves result and excel tables
% Generates plots to compare effect of error to control values

%%--- Part I Initialization ---



  
%% I.1 Default settings
set(0,'defaultAxesFontName', 'Times New Roman')
set(0,'DefaultAxesFontSize',16)
set(0,'DefaultFigureColormap',paruly)
cmap=colormap(paruly);
col_Tumor=cmap(50,:);
col_Fibro=cmap(35,:);
col_Back=cmap(10,:);

close all


% I.2 Working Folder
%@ Guaper, 
cd('F:\UserElGuapo\DBOx\Dropbox\ResearchMagic\RandomProyects\160110 12 Effects of AR\MASTER Dataset');

f_variables='F:\UserElGuapo\DBOx\Dropbox\ResearchMagic\RandomProyects\160110 12 Effects of AR\MASTER Dataset\AccuracyErrors\CPE';
f_masterSets='F:\UserElGuapo\Google Drive\masterSets\RotaryStage\CPE';
f_root='F:\UserElGuapo\DBOx\Dropbox\ResearchMagic\RandomProyects\160110 12 Effects of AR\MASTER Dataset';

% Load variables
load('L288_P.mat')
load('L288_SetPlus.mat')
load('RecSettings_ExperimentSL72.mat')
load('Regions.mat')
%
cd(f_masterSets)

%load('CPEs_Lean_MetricsOnly.mat') -< Not made yet
cd(f_variables)

%% --- Part II Generate Errors ---

% II.1 Sample original files into  3 72L files
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

%}

% II.2 Load sampled files
cd(f_root)
load('SL72_ScanData_P1.mat')
load('SL72_ScanData_P2.mat')
load('SL72_ScanData_P3.mat')

% II.3 CPE-Gen Collective Accuracy Error generator.

% CPE Collective Accuracy Error
% All antenna elements are shifted by PD in both  of the scans;
% 
% %{


x_p=65*2+1; % Error or antenna location worst location is 48 multiplied by 2 + 1 since matrix starts at 1
% Generate CPE errors based on three control groups.
[CPEs.PD_P1]=CPE_Generator(L288_P1,SL72_P1);
[CPEs.PD_P2]=CPE_Generator(L288_P2,SL72_P2);
[CPEs.PD_P3]=CPE_Generator(L288_P3,SL72_P3);

CPEs.PD_P1.GName='P1-CPE';
CPEs.PD_P2.GName='P2-CPE';
CPEs.PD_P3.GName='P3-CPE';
%---------%  save variables 
cd(f_masterSets); save CPEs CPEs;

%-------%-------% Reconstruct with positional deviations %-------%-------% 
close all;
cd([f_variables,'\A_ReconstructedFigures'])
tic

[CPEs.PD_P1]=PD_RecoSaver_Rotary(CPEs.PD_P1,'P1-CPE',RecSettings); close all;
[CPEs.PD_P2]=PD_RecoSaver_Rotary(CPEs.PD_P2,'P2-CPE',RecSettings);close all;
[CPEs.PD_P3]=PD_RecoSaver_Rotary(CPEs.PD_P3,'P3-CPE',RecSettings); 

cd(f_masterSets)
save CPEs_wScans CPEs
close all

toc



%% ------Part III Process reconstructed images, segment, evaluate and quantify.------ %%
% 3.þ Preparation {some variables are assigned}
% 3.a Display regions for one image
% 3.b Calculate Standard Metrics per regions
% 3.c Calculate image/difference metrics
% 3.d Calculate radar image quality metrics
% 3.e Save excel values

%%  3.þ Preparation of Magnitude and power limits
close all;
IP_Clim=5e-9; % Power Standard 5e-9 // CPE-> 13e-9
IM_Clim=7e-5; % Magnitude Standard 7e-5 // CPE-> 1.2e-4


% 3.a Display regions for one image
% In case of flies, one CPEcific reconstructed image is separated into strucutres 
% P2.E15 is reconstructed, for no CPEcific reason.

regions_show(CPEs.PD_P2.E1.SCAN.Fig_c_RecZoomFlip_abs,CPEs.PD_P2.E12.SCAN.Fig_c_RecZoomFlip_abs,Regions,'CPE P2',IP_Clim);
cd([f_variables,'\B_Regions'])

savethisone('RegionsOfSegmentation_CPE')




%% 3.b Calculate Standard Metrics per regions 
close all;
cd([f_variables,'\C_RegionMetrics'])
[CPEs.PD_P1]=Group_RegionSegmenter_Rotary(CPEs.PD_P1,Regions,IM_Clim,IP_Clim); close all;
[CPEs.PD_P2]=Group_RegionSegmenter_Rotary(CPEs.PD_P2,Regions,IM_Clim,IP_Clim); close all;
[CPEs.PD_P3]=Group_RegionSegmenter_Rotary(CPEs.PD_P3,Regions,IM_Clim,IP_Clim); 


% Change folder and save CPEs
cd(f_masterSets); save CPEs_wScans CPEs
%-------



%% 3.c Calculate image/difference metrics [power]
% Calculate image diferences to ->average scan<-
close all;
cd([f_variables,'\D_ImageDiferences'])
load('F:\UserElGuapo\DBOx\Dropbox\ResearchMagic\RandomProyects\160110 12 Effects of AR\MASTER Dataset\Control Scans\Average_SCAN72Rec.mat')

refImage=abs(Average_SCAN72Rec.PAVE).^2;
RefImageMetrics=CPEs.PD_P1.E1.PowImageMetrics;

%[CPEs.PD_P1.E1.PowImageMetrics]=IQ_Standard(NEWIMAGE,REFIMAGE,(CPEs.PD_P1.E1.PowImageMetrics),Average_SCAN72Rec.PowImageMetrics); savethisone([CPEs.PD_P1.E1.ImageMetrics.Name 'SSIM vs Average POw']);% Same, just saved in both Metric Files
[CPEs.PD_P1]=Group_IQStandard(CPEs.PD_P1,refImage,RefImageMetrics);
[CPEs.PD_P2]=Group_IQStandard(CPEs.PD_P2,refImage,RefImageMetrics);
[CPEs.PD_P3]=Group_IQStandard(CPEs.PD_P3,refImage,RefImageMetrics);

%Change folder and save CPEs
cd(f_masterSets); save CPEs_wScans CPEs
%-------

%% 3.d Calculate radar image quality metrics [based on magnitude, of course]
[CPEs.PD_P1] = Group_RecoQualityMetrics(CPEs.PD_P1); 
[CPEs.PD_P2] = Group_RecoQualityMetrics(CPEs.PD_P2); 
[CPEs.PD_P3] = Group_RecoQualityMetrics(CPEs.PD_P3); 

cd(f_masterSets); save CPEs_wScans CPEs
%-------

%% 3.é-F Spatial positioning 
%[CPEs_l]=ErrorSet_table(CPEs_l);
cd([f_variables,'\F_Positions']);
[CPEs.PD_P1.E1] = spatialPos(CPEs.PD_P1.E1);
[CPEs.PD_P1.E2] = spatialPos(CPEs.PD_P1.E2);
[CPEs.PD_P1.E4] = spatialPos(CPEs.PD_P1.E4);
[CPEs.PD_P1.E12] = spatialPos(CPEs.PD_P1.E12);

[CPEs.PD_P2.E1] = spatialPos(CPEs.PD_P2.E1);
[CPEs.PD_P2.E2] = spatialPos(CPEs.PD_P2.E2);
[CPEs.PD_P2.E4] = spatialPos(CPEs.PD_P2.E4);
[CPEs.PD_P2.E12] = spatialPos(CPEs.PD_P2.E12);

[CPEs.PD_P3.E1] = spatialPos(CPEs.PD_P3.E1);
[CPEs.PD_P3.E2] = spatialPos(CPEs.PD_P3.E2);
[CPEs.PD_P3.E4] = spatialPos(CPEs.PD_P3.E4);
[CPEs.PD_P3.E12] = spatialPos(CPEs.PD_P3.E12);
close all;
cd(f_masterSets); save CPEs_wScans CPEs




%% 3.e Save excel values

% Generate eSummary so exporting is easier
[CPEs.PD_P1]=Group_summaryMaker(CPEs.PD_P1);
[CPEs.PD_P2]=Group_summaryMaker(CPEs.PD_P2);
[CPEs.PD_P3]=Group_summaryMaker(CPEs.PD_P3);
cd(f_masterSets); save CPEs_wScansat42 CPEs

cd([f_variables,'\E_ExcelFiles']) 
Group_ExcelExporter(CPEs.PD_P1,'Group');
Group_ExcelExporter(CPEs.PD_P2,'Group');
Group_ExcelExporter(CPEs.PD_P3,'Group');


%-------

%% 3ü. LeanGroup maker
% removes ref, set and SCAN sections of the files

cd(f_variables)
[CPEs_l.PD_P1]=Group_LeanGroupMaker(CPEs.PD_P1);
[CPEs_l.PD_P2]=Group_LeanGroupMaker(CPEs.PD_P2);
[CPEs_l.PD_P3]=Group_LeanGroupMaker(CPEs.PD_P3);

save CPEs_Lean_MetricsOnly CPEs_l


% Copy CPEcific elements to the lean structure
% This function was made in the dare case that I were to miss some
% variables after making the lean files
%{
[CPEs_l.PD_P1.E1]= structureTransfer_Rot(CPEs.PD_P1.E1,CPEs_l.PD_P1.E1);
[CPEs_l.PD_P1.E2]= structureTransfer_Rot(CPEs.PD_P1.E2,CPEs_l.PD_P1.E2);
[CPEs_l.PD_P1.E4]= structureTransfer_Rot(CPEs.PD_P1.E4,CPEs_l.PD_P1.E4);
[CPEs_l.PD_P1.E12]= structureTransfer_Rot(CPEs.PD_P1.E12,CPEs_l.PD_P1.E12);

[CPEs_l.PD_P2.E1]= structureTransfer_Rot(CPEs.PD_P2.E1,CPEs_l.PD_P2.E1);
[CPEs_l.PD_P2.E2]= structureTransfer_Rot(CPEs.PD_P2.E2,CPEs_l.PD_P2.E2);
[CPEs_l.PD_P2.E4]= structureTransfer_Rot(CPEs.PD_P2.E4,CPEs_l.PD_P2.E4);
[CPEs_l.PD_P2.E12]= structureTransfer_Rot(CPEs.PD_P2.E12,CPEs_l.PD_P2.E12);

[CPEs_l.PD_P3.E1]= structureTransfer_Rot(CPEs.PD_P3.E1,CPEs_l.PD_P3.E1);
[CPEs_l.PD_P3.E2]= structureTransfer_Rot(CPEs.PD_P3.E2,CPEs_l.PD_P3.E2);
[CPEs_l.PD_P3.E4]= structureTransfer_Rot(CPEs.PD_P3.E4,CPEs_l.PD_P3.E4);
[CPEs_l.PD_P3.E12]= structureTransfer_Rot(CPEs.PD_P3.E12,CPEs_l.PD_P3.E12);
save CPEs_Lean_MetricsOnly CPEs_l
%}


%% 3.f Generate error mean average value and mean error Table for error experiment

cd(f_variables)

[CPEs_lwSummary]=ErrorSet_table(CPEs_l);
save CPEs_lwSummary CPEs_lwSummary;

%% 3.G Generate MSEB compare test

cd([f_variables,'\G_IQMPlots']);
close all; controlCompareSet(CPEs_lwSummary,[1.25,2.5,5,15],{'1.25°  ','    2.5°','5°','15°'},'CPE vs Control valuesD');

cd(f_variables)


%}