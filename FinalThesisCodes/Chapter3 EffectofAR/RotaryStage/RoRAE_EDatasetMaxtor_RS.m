%% RoRAE_EDatasetMaxtor_RS



% Part of the Dataset Maxtor series:

% ControlDatasetMaxtor_RS
% RoSAE_EDatasetMaxtor_RS
% RoCAE_EDatasetMaxtor_Rs
% RoRAE_EDatasetMaxtor_Rs

% RANDOM ACCURACY Error Data set maxtor


% Version 0.1; August 29



%By Mario Solis
% This scripts creates! the datasets with error RoRAE, Rotary Stage Collective Random Accuracy error. 
    % random erro is generated in one of the datasets.
    % Antenna positioning variations are randomly calculated being 1.5 the
    % smallest posible 
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

%% I.2 Working Folder
%@ Guaper, 
cd('F:\UserElGuapo\DBOx\Dropbox\ResearchMagic\RandomProyects\160110 12 Effects of AR\MASTER Dataset');

f_variables='F:\UserElGuapo\DBOx\Dropbox\ResearchMagic\RandomProyects\160110 12 Effects of AR\MASTER Dataset\AllErrors\RAE';
f_masterSets='F:\UserElGuapo\Google Drive\masterSets\RotaryStage\RAE';
f_root='F:\UserElGuapo\DBOx\Dropbox\ResearchMagic\RandomProyects\160110 12 Effects of AR\MASTER Dataset';
cd(f_variables)
cd(f_masterSets)
cd(f_root)

% Load variables
load('L288_P.mat')
load('L288_SetPlus.mat')
load('RecSettings_ExperimentSL72.mat')
load('Regions.mat')
%


%load('RAEs_Lean_MetricsOnly.mat') -< Not made yet
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

% II.2 Load sampled files
cd(f_root)
load('SL72_ScanData_P1.mat')
load('SL72_ScanData_P2.mat')
load('SL72_ScanData_P3.mat')

% II.3 RAE-Gen Collective Accuracy Error generator.

% RAE Collective Accuracy Error
% All antenna elements are shifted by PD in both  of the scans;
% 
% %{


 %% Generate RAE errors based on three control groups.

%x_p=81; % Error or antenna location
% 


[RoRAEs.PD_P1]=RAE_Generator(L288_P1,SL72_P1);
[RoRAEs.PD_P2]=RAE_Generator(L288_P2,SL72_P2);
[RoRAEs.PD_P3]=RAE_Generator(L288_P3,SL72_P3);

RoRAEs.PD_P1.GName='P1-RAE';
RoRAEs.PD_P2.GName='P2-RAE';
RoRAEs.PD_P3.GName='P3-RAE';

%---------%  save variables 
cd(f_masterSets); save RAEs RoRAEs;



%%  -----%-------% Reconstruct with positional deviations %-------%-------% 
%--
close all;
cd([f_variables,'\A_ReconstructedFigures'])
tic

RecSettings.Bdiam=0.175;


[RoRAEs.PD_P1]=PD_RecoSaver_Rotary(RoRAEs.PD_P1,'P1-RAE',RecSettings);
[RoRAEs.PD_P2]=PD_RecoSaver_Rotary(RoRAEs.PD_P2,'P2-RAE',RecSettings);
[RoRAEs.PD_P3]=PD_RecoSaver_Rotary(RoRAEs.PD_P3,'P3-RAE',RecSettings);

cd(f_masterSets)
save RAEs_wScans RoRAEs
close all

toc
%%{

%% ------Part III Process reconstructed images, segment, evaluate and quantify.------ %%
% 3.� Preparation {some variables are assigned}
% 3.a Display regions for one image
% 3.b Calculate Standard Metrics per regions
% 3.c Calculate image/difference metrics
% 3.d Calculate radar image quality metrics
% 3.e Save excel values

%%  3.� Preparation of Magnitude and power limits
IP_Clim=5e-9;
IM_Clim=7e-5;


% 3.a Display regions for one image
% In case of flies, one specific reconstructed image is separated into strucutres 
% P2.E15 is reconstructed, for no specific reason.

regions_show(RoRAEs.PD_P2.E1.SCAN.Fig_c_RecZoomFlip_abs,RoRAEs.PD_P2.E12.SCAN.Fig_c_RecZoomFlip_abs,Regions,'RAE P2 E1', 'RAE P2 E12',IP_Clim);
cd([f_variables,'\B_Regions'])

savethisone('RegionsOfSegmentation_RAE')

%% 3.b Calculate Standard Metrics per regions 
close all;
cd([f_variables,'\C_RegionMetrics'])
[RoRAEs.PD_P1]=Group_RegionSegmenter_Rotary(RoRAEs.PD_P1,Regions,IM_Clim,IP_Clim); 
[RoRAEs.PD_P2]=Group_RegionSegmenter_Rotary(RoRAEs.PD_P2,Regions,IM_Clim,IP_Clim); 
[RoRAEs.PD_P3]=Group_RegionSegmenter_Rotary(RoRAEs.PD_P3,Regions,IM_Clim,IP_Clim); 


% Change folder and save RAEs
cd(f_masterSets); save RAEs_wScans RoRAEs
close all
%-------



%% 3.c Calculate image/difference metrics [power]
% Calculate image diferences to ->average scan<-
cd([f_variables,'\D_ImageDiferences'])
load('F:\UserElGuapo\DBOx\Dropbox\ResearchMagic\RandomProyects\160110 12 Effects of AR\MASTER Dataset\Control Scans\Average_SCAN72Rec.mat')

refImage=abs(Average_SCAN72Rec.PAVE).^2;
RefImageMetrics=RoRAEs.PD_P1.E1.PowImageMetrics;

%[RAEs.PD_P1.E1.PowImageMetrics]=IQ_Standard(NEWIMAGE,REFIMAGE,(RAEs.PD_P1.E1.PowImageMetrics),Average_SCAN72Rec.PowImageMetrics); savethisone([RAEs.PD_P1.E1.ImageMetrics.Name 'SSIM vs Average POw']);% Same, just saved in both Metric Files
[RoRAEs.PD_P1]=Group_IQStandard(RoRAEs.PD_P1,refImage,RefImageMetrics);
[RoRAEs.PD_P2]=Group_IQStandard(RoRAEs.PD_P2,refImage,RefImageMetrics);
[RoRAEs.PD_P3]=Group_IQStandard(RoRAEs.PD_P3,refImage,RefImageMetrics);

%Change folder and save RAEs
cd(f_masterSets); save RAEs_wScans RoRAEs
%-------

%% 3.d Calculate radar image quality metrics [based on magnitude, of course]
[RoRAEs.PD_P1] = Group_RecoQualityMetrics(RoRAEs.PD_P1); 
[RoRAEs.PD_P2] = Group_RecoQualityMetrics(RoRAEs.PD_P2); 
[RoRAEs.PD_P3] = Group_RecoQualityMetrics(RoRAEs.PD_P3); 

cd(f_masterSets); save RAEs_wScans RoRAEs
%-------

%% 3.�-F Spatial positioning 
%[RAEs_l]=ErrorSet_table(RAEs_l);
close all;
cd([f_variables,'\F_Positions']);
[RoRAEs.PD_P1.E1] = spatialPosSimple(RoRAEs.PD_P1.E1);
[RoRAEs.PD_P1.E2] = spatialPosSimple(RoRAEs.PD_P1.E2);
[RoRAEs.PD_P1.E4] = spatialPosSimple(RoRAEs.PD_P1.E4);
[RoRAEs.PD_P1.E12] = spatialPosSimple(RoRAEs.PD_P1.E12);

[RoRAEs.PD_P2.E1] = spatialPosSimple(RoRAEs.PD_P2.E1);
[RoRAEs.PD_P2.E2] = spatialPosSimple(RoRAEs.PD_P2.E2);
[RoRAEs.PD_P2.E4] = spatialPosSimple(RoRAEs.PD_P2.E4);
[RoRAEs.PD_P2.E12] = spatialPosSimple(RoRAEs.PD_P2.E12);

[RoRAEs.PD_P3.E1] = spatialPosSimple(RoRAEs.PD_P3.E1);
[RoRAEs.PD_P3.E2] = spatialPosSimple(RoRAEs.PD_P3.E2);
[RoRAEs.PD_P3.E4] = spatialPosSimple(RoRAEs.PD_P3.E4);
[RoRAEs.PD_P3.E12] = spatialPosSimple(RoRAEs.PD_P3.E12);
close all;
cd(f_masterSets); save RAEs_wScans RoRAEs




%% 3.e Save excel values

% Generate eSummary so exporting is easier
[RoRAEs.PD_P1]=Group_summaryMaker(RoRAEs.PD_P1);
[RoRAEs.PD_P2]=Group_summaryMaker(RoRAEs.PD_P2);
[RoRAEs.PD_P3]=Group_summaryMaker(RoRAEs.PD_P3);
cd(f_masterSets); save RAEs_wScans RoRAEs

cd([f_variables,'\E_ExcelFiles']) 
Group_ExcelExporter(RoRAEs.PD_P1,'Group');
Group_ExcelExporter(RoRAEs.PD_P2,'Group');
Group_ExcelExporter(RoRAEs.PD_P3,'Group');


%-------

%% 3�. LeanGroup maker
% removes ref, set and SCAN sections of the files

cd(f_variables)
[RAEs_l.PD_P1]=Group_LeanGroupMaker(RoRAEs.PD_P1);
[RAEs_l.PD_P2]=Group_LeanGroupMaker(RoRAEs.PD_P2);
[RAEs_l.PD_P3]=Group_LeanGroupMaker(RoRAEs.PD_P3);

save RAEs_Lean_MetricsOnly RAEs_l


% Copy specific elements to the lean structure
% This function was made in the dare case that I were to miss some
% variables after making the lean files
%{
[RAEs_l.PD_P1.E1]= structureTransfer_Rot(RAEs.PD_P1.E1,RAEs_l.PD_P1.E1);
[RAEs_l.PD_P1.E2]= structureTransfer_Rot(RAEs.PD_P1.E2,RAEs_l.PD_P1.E2);
[RAEs_l.PD_P1.E4]= structureTransfer_Rot(RAEs.PD_P1.E4,RAEs_l.PD_P1.E4);
[RAEs_l.PD_P1.E12]= structureTransfer_Rot(RAEs.PD_P1.E12,RAEs_l.PD_P1.E12);

[RAEs_l.PD_P2.E1]= structureTransfer_Rot(RAEs.PD_P2.E1,RAEs_l.PD_P2.E1);
[RAEs_l.PD_P2.E2]= structureTransfer_Rot(RAEs.PD_P2.E2,RAEs_l.PD_P2.E2);
[RAEs_l.PD_P2.E4]= structureTransfer_Rot(RAEs.PD_P2.E4,RAEs_l.PD_P2.E4);
[RAEs_l.PD_P2.E12]= structureTransfer_Rot(RAEs.PD_P2.E12,RAEs_l.PD_P2.E12);

[RAEs_l.PD_P3.E1]= structureTransfer_Rot(RAEs.PD_P3.E1,RAEs_l.PD_P3.E1);
[RAEs_l.PD_P3.E2]= structureTransfer_Rot(RAEs.PD_P3.E2,RAEs_l.PD_P3.E2);
[RAEs_l.PD_P3.E4]= structureTransfer_Rot(RAEs.PD_P3.E4,RAEs_l.PD_P3.E4);
[RAEs_l.PD_P3.E12]= structureTransfer_Rot(RAEs.PD_P3.E12,RAEs_l.PD_P3.E12);
save RAEs_Lean_MetricsOnly RAEs_l
%}


%% 3.f Generate error mean average value and mean error Table for error experiment

cd(f_variables)

[RAEs_lwSummary]=ErrorSet_table(RAEs_l);
save RAEs_lwSummary RAEs_lwSummary;

%% 3.G Generate MSEB compare test

cd([f_variables,'\G_IQMPlots']);
close all; controlCompareSet(RAEs_lwSummary,[1.25,2.5,5,15],{'1.25�  ','    2.5�','5�','15�'},'RAE vs Control valuesD');

cd(f_variables)

%}

%% Load saved variables
cd(f_masterSets); load RAEs_wScans
