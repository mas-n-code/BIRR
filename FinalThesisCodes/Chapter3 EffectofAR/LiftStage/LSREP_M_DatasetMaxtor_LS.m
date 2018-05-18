% LS_REP_M_DatasetMaxtor_LS_
% started on August 9 2016

% Part of the LS Middle Dataset Maxtor series:

% 1. LS_ControlMaxtor_LS
% 2. LSCAE_M_DatasetMaxtor_LS - Done
% 3. LSCPE_M_DatasetMaxtor_LS - dONE

% 4. LS_ControlMaxtor_LS_TOP
% 5. LSCAE_T_DatasetMaxtor_LS - THIS ONE
% 6. LSCPE_T_DatasetMaxtor_LS - THIS ONE


%By Mario Solis
% This scripts USES the datasets with error ls-M-CAE, Rotary Stage Single ACCCISION error. 
% Segments the responses
% Calculates standard and quality metrics
% Saves result and excel tables
% Generates plots to compare effect of error to control values

%%--- Part I Initialization ---

% Initialize MaxtorFile
LS_M_REPs.PD_P1.GName='LS-M-P1-REP';
LS_M_REPs.PD_P2.GName='LS-M-P2-REP';

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

% Copy folder structure!
% robocopy "F:\UserElGuapo\DBOx\Dropbox\ResearchMagic\RandomProyects\160110 12 Effects of AR\MASTER Dataset LiftStage\2 Middle\Precision Errors CPE" "F:\UserElGuapo\DBOx\Dropbox\ResearchMagic\RandomProyects\160110 12 Effects of AR\MASTER Dataset LiftStage\2 Middle\Empty" /e /xf *

f_root='F:\UserElGuapo\DBOx\Dropbox\ResearchMagic\RandomProyects\160110 12 Effects of AR\MASTER Dataset LiftStage\2 Middle';
f_variables=[f_root,'\Reposition REP'];
f_masterSets='F:\UserElGuapo\Google Drive\masterSets\LiftStage\2 Middle';
f_rawData='F:\UserElGuapo\Google Drive\MarioProject2\150922 Effects of Vertical Error\1020 36FullTest\[xy] oficial';

% Load variables

load('F:\UserElGuapo\DBOx\Dropbox\ResearchMagic\RandomProyects\160110 12 Effects of AR\MASTER Dataset LiftStage\2 Middle\Control Scans\LS_M_RegionsControlScan.mat') % Loads the regions segmented from control scans
load('F:\UserElGuapo\DBOx\Dropbox\ResearchMagic\RandomProyects\160110 12 Effects of AR\MASTER Dataset LiftStage\2 Middle\Control Scans\LS_M_RecSettings.mat') % Loads the regions segmented from control scans
cd(f_masterSets); load MiddleRegion_Control;
%load('LS_M_REPs_LEAN_MetricsOnly.mat') -< Not made yet
cd(f_variables)
cd(f_rawData)
cd(f_masterSets)
cd(f_root)



%%{
%% --- Part II Load and reconstruct Error Files ---
cd([f_rawData,'\Middle']);

%Load E1 - 0.05cm  Accuracy Error


cd([f_rawData,'\Middle\REP_ACC_M']);

Ref_files = dir('**Mono*[A]***.txt');
TumorFibro_files=dir('*Mono*[C]***.txt');
Tumor_files = dir('**Mono*[B]***.txt');

LS_M_REPs.PD_P1.E1.set_ref=load(Ref_files(1).name);
LS_M_REPs.PD_P2.E1.set_ref=load(Ref_files(2).name);

LS_M_REPs.PD_P1.E1.set_data=load(TumorFibro_files(1).name);
LS_M_REPs.PD_P2.E1.set_data=load(TumorFibro_files(2).name);

LS_M_REPs.PD_P1.E1.set_tumor=load(Tumor_files(1).name);
LS_M_REPs.PD_P2.E1.set_tumor=load(Tumor_files(2).name);


%Save File names
LS_M_REPs.PD_P1.E1.file_ref=Ref_files(1).name;
LS_M_REPs.PD_P1.E1.file_data=TumorFibro_files(1).name;
LS_M_REPs.PD_P1.E1.file_tumor=Tumor_files(1).name;
LS_M_REPs.PD_P2.E1.file_ref=Ref_files(2).name;
LS_M_REPs.PD_P2.E1.file_data=TumorFibro_files(2).name;
LS_M_REPs.PD_P2.E1.file_tumor=Tumor_files(2).name;

%Load E2 - 0.1 cm PREcision Error
cd([f_rawData,'\Middle\REP_PRE_M']);

Ref_files = dir('**Mono*[A]***.txt');
TumorFibro_files=dir('*Mono*[C]***.txt');
Tumor_files = dir('**Mono*[B]***.txt');

LS_M_REPs.PD_P1.E2.set_ref=load(Ref_files(1).name);
LS_M_REPs.PD_P2.E2.set_ref=load(Ref_files(2).name);

LS_M_REPs.PD_P1.E2.set_data=load(TumorFibro_files(1).name);
LS_M_REPs.PD_P2.E2.set_data=load(TumorFibro_files(2).name);

LS_M_REPs.PD_P1.E2.set_tumor=load(Tumor_files(1).name);
LS_M_REPs.PD_P2.E2.set_tumor=load(Tumor_files(2).name);

%Save File names
LS_M_REPs.PD_P1.E2.file_ref=Ref_files(1).name;
LS_M_REPs.PD_P1.E2.file_data=TumorFibro_files(1).name;
LS_M_REPs.PD_P1.E2.file_tumor=Tumor_files(1).name;
LS_M_REPs.PD_P2.E2.file_ref=Ref_files(2).name;
LS_M_REPs.PD_P2.E2.file_data=TumorFibro_files(2).name;
LS_M_REPs.PD_P2.E2.file_tumor=Tumor_files(2).name;

%{
%Load E3 - 0.2 cm PREcision Error
cd([f_rawData,'\Middle\PRE_BL2']);

Ref_files = dir('**Mono*[A]***.txt');
TumorFibro_files=dir('*Mono*[C]***.txt');
Tumor_files = dir('**Mono*[B]***.txt');

LS_T_REPs.PD_P1.E3.set_ref=load(Ref_files(1).name);
LS_T_REPs.PD_P2.E3.set_ref=load(Ref_files(2).name);

LS_T_REPs.PD_P1.E3.set_data=load(TumorFibro_files(1).name);
LS_T_REPs.PD_P2.E3.set_data=load(TumorFibro_files(2).name);

LS_T_REPs.PD_P1.E3.set_tumor=load(Tumor_files(1).name);
LS_T_REPs.PD_P2.E3.set_tumor=load(Tumor_files(2).name);
%}
cd(f_masterSets); save LS_Middle_REPs LS_M_REPs

%%{
%%
%----II.B ----Reconstruct Error Files---------------%
% load([f_masterSets,'\LS_Middle_REPs.mat'])        % % % % % % Take me^% %
close all;
cd([f_variables,'\A_ReconstructedFigures'])

RecSettings.counterWise=1; 
[LS_M_REPs.PD_P1]=PD_RecoSaver_LiftStageREP(LS_M_REPs.PD_P1,'LS M P1-REP',RecSettings);

close all;
RecSettings.counterWise=0;
[LS_M_REPs.PD_P2]=PD_RecoSaver_LiftStageREP(LS_M_REPs.PD_P2,'LS M P2-REP',RecSettings); RecSettings.counterWise=1; 

%[LS_M_CPEs.PD_P1]=PD_RecoSaver_LiftStage(SPEs.PD_P1,'P1-SPE',RecSettings); close all;
cd(f_masterSets); save LS_Middle_REPs LS_M_REPs
close all;

%%{
%% ------Part III Process reconstructed images, segment, evaluate and quantify.------ %%
% 3.þ Preparation {some variables are assigned}
% 3.a Display regions for one image
% 3.b Calculate Standard Metrics per regions
% 3.c Calculate image/difference metrics
% 3.d Calculate radar image quality metrics
% 3.e Save excel values

%%  3.þ Preparation of Magnitude and power limits
close all;
cd([f_variables,'\B_Regions'])

IP_Clim=5e-9;
IM_Clim=7e-5;


% 3.a Display regions for one image
% In case of flies, one specific reconstructed image is separated into strucutres 
% P2.E15 is reconstructed, for no specific reason.

Image4Region1= LSSet_M.L0.P1.C_Scan.Fig_c_RecZoomFlip_abs;
Image4Region2= LS_M_REPs.PD_P1.E2.SCAN.Fig_c_RecZoomFlip_abs;
regions_show(Image4Region1,Image4Region2,Regions,'Control LS M','LS M P1 REP PRE',IP_Clim);

savethisone('RegionsOfSegmentation_LS_M_REP')



%% 3.b Calculate Standard Metrics per regions 
%-------
close all;
cd([f_variables,'\C_RegionMetrics'])
[LS_M_REPs.PD_P1]=Group_RegionSegmenter_LiftStageREP(LS_M_REPs.PD_P1,Regions,IM_Clim,IP_Clim); 
[LS_M_REPs.PD_P2]=Group_RegionSegmenter_LiftStageREP(LS_M_REPs.PD_P2,Regions,IM_Clim,IP_Clim); 

% Change folder and save REPs
cd(f_masterSets); save LS_Middle_REPs LS_M_REPs

%-------

%%{
%% 3.c Calculate image/difference metrics [power]
close all;

cd([f_variables,'\D_ImageDiferences'])
load('F:\UserElGuapo\DBOx\Dropbox\ResearchMagic\RandomProyects\160110 12 Effects of AR\MASTER Dataset LiftStage\2 Middle\Control Scans\D_ImageDiferences\refAverageImage.mat')

refImage=refAverageImage.Image;
RefImageMetrics=refAverageImage.PowMetrics;

[LS_M_REPs.PD_P1]=Group_IQStandardLiftStageREP(LS_M_REPs.PD_P1,refImage,RefImageMetrics);
[LS_M_REPs.PD_P2]=Group_IQStandardLiftStageREP(LS_M_REPs.PD_P2,refImage,RefImageMetrics);
% Change folder and save REPs
cd(f_masterSets); save LS_Middle_REPs LS_M_REPs
%-------

%%{
%% 3.d Calculate radar image quality metrics [based on magnitude, of course]
close all;
%-------

[LS_M_REPs.PD_P1] = Group_RecoQualityMetricsLiftStageREP(LS_M_REPs.PD_P1); 
[LS_M_REPs.PD_P2] = Group_RecoQualityMetricsLiftStageREP(LS_M_REPs.PD_P2); 

cd(f_masterSets); save LS_Middle_REPs LS_M_REPs
%-------

%%{
%% 3.é-F Spatial positioning 
%-------
cd([f_variables,'\F_Positions']);
[LS_M_REPs.PD_P1.E1] = spatialPosSimple(LS_M_REPs.PD_P1.E1);
[LS_M_REPs.PD_P1.E2] = spatialPosSimple(LS_M_REPs.PD_P1.E2);
%[LS_M_REPs.PD_P1.E3] = spatialPosSimple(LS_M_REPs.PD_P1.E3);


[LS_M_REPs.PD_P2.E1] = spatialPosSimple(LS_M_REPs.PD_P2.E1);
[LS_M_REPs.PD_P2.E2] = spatialPosSimple(LS_M_REPs.PD_P2.E2);
%[LS_M_REPs.PD_P2.E3] = spatialPosSimple(LS_M_REPs.PD_P2.E3);

close all;
cd(f_masterSets); save LS_Middle_REPs LS_M_REPs

%-------

%%{
%% 3.e Save excel values
[LS_M_REPs.PD_P1]=Group_summaryMakerLiftStageREP(LS_M_REPs.PD_P1);
[LS_M_REPs.PD_P2]=Group_summaryMakerLiftStageREP(LS_M_REPs.PD_P2);

cd([f_variables,'\E_ExcelFiles']) 
Group_ExcelExporterLiftStageREP(LS_M_REPs.PD_P1,'Group');
Group_ExcelExporterLiftStageREP(LS_M_REPs.PD_P2,'Group');

%-------
%%{

%% 3ü. LeanGroup maker
% removes ref, set and SCAN sections of the files
cd(f_variables)
[LS_M_REPs_LEAN.PD_P1]=Group_LeanGroupMakerLiftStageREP(LS_M_REPs.PD_P1);
[LS_M_REPs_LEAN.PD_P2]=Group_LeanGroupMakerLiftStageREP(LS_M_REPs.PD_P2);

save LS_M_REPs_LEAN LS_M_REPs_LEAN
%}

%%{
%% 3.f Generate error mean average value and mean error Table for error experiment

cd(f_variables)

[LS_M_REPs_LEAN]=ErrorSet_tableLiftStageREP(LS_M_REPs_LEAN);
save LS_M_REPs_LEAN LS_M_REPs_LEAN

cd([f_variables,'\E_ExcelFiles']) 
writetable(LS_M_REPs_LEAN.EeSummarywMeans,['Middle REPs -','EeSummaryMeans','.xlsx'])
writetable(LS_M_REPs_LEAN.IQMSummary,['Middle REPs -','IQMSummary','.xlsx'])

%%{
%% 3.G Generate MSEB compare test

cd([f_variables,'\G_IQMPlots']);
close all; controlCompareSetLIFTSTAGE(LS_M_REPs_LEAN,[0.06,0.35],{'ACC','PRE'},'M REP vs Control valuesD',0.03,'NOT');

cd(f_variables)




%}


%% LOAD LSREP Variable
%cd(f_masterSets); load LS_Middle_REPs; load MiddleRegion_Control;
%cd(f_variables); load LS_M_REPs_LEAN;
