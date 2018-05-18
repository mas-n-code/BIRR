%% SAE DatasetMaxtor_RS
%By Mario Solis
% This scripts creates! the datasets with error R-SAE single accuracy error generated. 
% Segments the responses
% Calculates standard and quality metrics
% Saves result and excel tables
% 
%% Default settings
set(0,'defaultAxesFontName', 'Times New Roman')
set(0,'DefaultAxesFontSize',16)
set(0,'DefaultFigureColormap',paruly)
cmap=colormap(paruly);
Tumor_col=cmap(50,:);
Fibro_col=cmap(35,:);
Back_col=cmap(10,:);

close all



%% Working Folder
%@ Guaper, 
cd('F:\UserElGuapo\DBOx\Dropbox\ResearchMagic\RandomProyects\160110 12 Effects of AR\MASTER Dataset');

f_variables='F:\UserElGuapo\DBOx\Dropbox\ResearchMagic\RandomProyects\160110 12 Effects of AR\MASTER Dataset\AccuracyErrors\SAE';
f_masterSets='F:\UserElGuapo\Google Drive\masterSets\RotaryStage';
f_root='F:\UserElGuapo\DBOx\Dropbox\ResearchMagic\RandomProyects\160110 12 Effects of AR\MASTER Dataset';

%% Load variables
load('L288_P.mat')
load('L288_SetPlus.mat')
load('RecSettings_ExperimentSL72.mat')
load('Regions.mat')


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




