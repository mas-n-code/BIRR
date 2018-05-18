% LS_CPE_M_DatasetMaxtor_LS_TOP
% started on August 9 2016

% Part of the LS Top Dataset Maxtor series:

% 1. LS_ControlMaxtor_LS
% 2. LSCAE_M_DatasetMaxtor_LS - Done
% 3. LSCPE_M_DatasetMaxtor_LS - dONE

% 4. LS_ControlMaxtor_LS_TOP
% 5. LSCAE_T_DatasetMaxtor_LS - THIS ONE
% 6. LSCPE_T_DatasetMaxtor_LS - THIS ONE


%By Mario Solis
% This scripts USES the datasets with error ls-T-CAE, Rotary Stage Single ACCCISION error. 
% Segments the responses
% Calculates standard and quality metrics
% Saves result and excel tables
% Generates plots to compare effect of error to control values

%%--- Part I Initialization ---

% Initialize MaxtorFile
LS_T_CPEs.PD_P1.GName='LS-T-P1-CPE';
LS_T_CPEs.PD_P2.GName='LS-T-P2-CPE';

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

f_root='F:\UserElGuapo\DBOx\Dropbox\ResearchMagic\RandomProyects\160110 12 Effects of AR\MASTER Dataset LiftStage\1 Top';
f_variables=[f_root,'\Precision Errors CPE'];
f_masterSets='F:\UserElGuapo\Google Drive\masterSets\LiftStage\1 Top';
f_rawData='F:\UserElGuapo\Google Drive\MarioProject2\150922 Effects of Vertical Error\1020 36FullTest\[xy] oficial';

% Load variables

load('F:\UserElGuapo\DBOx\Dropbox\ResearchMagic\RandomProyects\160110 12 Effects of AR\MASTER Dataset LiftStage\1 Top\Control Scans\LS_T_RegionsControlScan.mat') % Loads the regions segmented from control scans
load('F:\UserElGuapo\DBOx\Dropbox\ResearchMagic\RandomProyects\160110 12 Effects of AR\MASTER Dataset LiftStage\1 Top\Control Scans\LS_T_RecSettings.mat') % Loads the regions segmented from control scans
cd(f_masterSets); load TopRegion_Control;
%load('LS_T_CPEs_LEAN_MetricsOnly.mat') -< Not made yet
cd(f_variables)
cd(f_rawData)
cd(f_variables)
cd(f_masterSets)
cd(f_root)



%%{
%% --- Part II Load and reconstruct Error Files ---
cd([f_rawData,'\Top']);

%Load E1 - 0.05cm  Precision Error


cd([f_rawData,'\Top\PRE_TL05']);

Ref_files = dir('**Mono*[A]***.txt');
TumorFibro_files=dir('*Mono*[C]***.txt');
Tumor_files = dir('**Mono*[B]***.txt');

LS_T_CPEs.PD_P1.E1.set_ref=load(Ref_files(1).name);
LS_T_CPEs.PD_P2.E1.set_ref=load(Ref_files(2).name);

LS_T_CPEs.PD_P1.E1.set_data=load(TumorFibro_files(1).name);
LS_T_CPEs.PD_P2.E1.set_data=load(TumorFibro_files(2).name);

LS_T_CPEs.PD_P1.E1.set_tumor=load(Tumor_files(1).name);
LS_T_CPEs.PD_P2.E1.set_tumor=load(Tumor_files(2).name);

%Load E2 - 0.1 cm PREcision Error
cd([f_rawData,'\Top\PRE_TL1']);

Ref_files = dir('**Mono*[A]***.txt');
TumorFibro_files=dir('*Mono*[C]***.txt');
Tumor_files = dir('**Mono*[B]***.txt');

LS_T_CPEs.PD_P1.E2.set_ref=load(Ref_files(1).name);
LS_T_CPEs.PD_P2.E2.set_ref=load(Ref_files(2).name);

LS_T_CPEs.PD_P1.E2.set_data=load(TumorFibro_files(1).name);
LS_T_CPEs.PD_P2.E2.set_data=load(TumorFibro_files(2).name);

LS_T_CPEs.PD_P1.E2.set_tumor=load(Tumor_files(1).name);
LS_T_CPEs.PD_P2.E2.set_tumor=load(Tumor_files(2).name);


%Load E3 - 0.2 cm PREcision Error
cd([f_rawData,'\Top\PRE_TL2']);

Ref_files = dir('**Mono*[A]***.txt');
TumorFibro_files=dir('*Mono*[C]***.txt');
Tumor_files = dir('**Mono*[B]***.txt');

LS_T_CPEs.PD_P1.E3.set_ref=load(Ref_files(1).name);
LS_T_CPEs.PD_P2.E3.set_ref=load(Ref_files(2).name);

LS_T_CPEs.PD_P1.E3.set_data=load(TumorFibro_files(1).name);
LS_T_CPEs.PD_P2.E3.set_data=load(TumorFibro_files(2).name);

LS_T_CPEs.PD_P1.E3.set_tumor=load(Tumor_files(1).name);
LS_T_CPEs.PD_P2.E3.set_tumor=load(Tumor_files(2).name);

cd(f_masterSets); save LS_Top_CPEs LS_T_CPEs

%%{
%%
%----II.B ----Reconstruct Error Files---------------%
% load([f_masterSets,'\LS_Top_CPEs.mat'])        % % % % % % Take me^% %
close all;
cd([f_variables,'\A_ReconstructedFigures'])

RecSettings.counterWise=1;
[LS_T_CPEs.PD_P1]=PD_RecoSaver_LiftStage(LS_T_CPEs.PD_P1,'LST P1-CPE',RecSettings);

close all;
RecSettings.counterWise=0;
[LS_T_CPEs.PD_P2]=PD_RecoSaver_LiftStage(LS_T_CPEs.PD_P2,'LST P2-CPE',RecSettings); RecSettings.counterWise=1; 

%[LS_M_CPEs.PD_P1]=PD_RecoSaver_LiftStage(SPEs.PD_P1,'P1-SPE',RecSettings); close all;
cd(f_masterSets); save LS_Top_CPEs LS_T_CPEs
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

Image4Region1= LSSet_T.L0.P1.C_Scan.Fig_c_RecZoomFlip_abs;
Image4Region2= LS_T_CPEs.PD_P1.E3.SCAN.Fig_c_RecZoomFlip_abs;
regions_show(Image4Region1,Image4Region2,Regions,'Control LS T','LS T P1 CPE 2cm',IP_Clim);

savethisone('RegionsOfSegmentation_LS_T_CPE')



%% 3.b Calculate Standard Metrics per regions 
%-------
close all;
cd([f_variables,'\C_RegionMetrics'])
[LS_T_CPEs.PD_P1]=Group_RegionSegmenter_LiftStage(LS_T_CPEs.PD_P1,Regions,IM_Clim,IP_Clim); 
[LS_T_CPEs.PD_P2]=Group_RegionSegmenter_LiftStage(LS_T_CPEs.PD_P2,Regions,IM_Clim,IP_Clim); 

% Change folder and save CPEs
cd(f_masterSets); save LS_Top_CPEs LS_T_CPEs

%-------

%%{
%% 3.c Calculate image/difference metrics [power]
close all;

cd([f_variables,'\D_ImageDiferences'])
load('F:\UserElGuapo\DBOx\Dropbox\ResearchMagic\RandomProyects\160110 12 Effects of AR\MASTER Dataset LiftStage\1 Top\Control Scans\D_ImageDiferences\refAverageImage.mat')

refImage=refAverageImage.Image;
RefImageMetrics=refAverageImage.PowMetrics;

[LS_T_CPEs.PD_P1]=Group_IQStandardLiftStage(LS_T_CPEs.PD_P1,refImage,RefImageMetrics);
[LS_T_CPEs.PD_P2]=Group_IQStandardLiftStage(LS_T_CPEs.PD_P2,refImage,RefImageMetrics);
% Change folder and save CPEs
cd(f_masterSets); save LS_Top_CPEs LS_T_CPEs
%-------

%%{
%% 3.d Calculate radar image quality metrics [based on magnitude, of course]
close all;
%-------

[LS_T_CPEs.PD_P1] = Group_RecoQualityMetricsLiftStage(LS_T_CPEs.PD_P1); 
[LS_T_CPEs.PD_P2] = Group_RecoQualityMetricsLiftStage(LS_T_CPEs.PD_P2); 

cd(f_masterSets); save LS_Top_CPEs LS_T_CPEs
%-------

%%{
%% 3.é-F Spatial positioning 
%-------
cd([f_variables,'\F_Positions']);
[LS_T_CPEs.PD_P1.E1] = spatialPosSimple(LS_T_CPEs.PD_P1.E1);
[LS_T_CPEs.PD_P1.E2] = spatialPosSimple(LS_T_CPEs.PD_P1.E2);
[LS_T_CPEs.PD_P1.E3] = spatialPosSimple(LS_T_CPEs.PD_P1.E3);


[LS_T_CPEs.PD_P2.E1] = spatialPosSimple(LS_T_CPEs.PD_P2.E1);
[LS_T_CPEs.PD_P2.E2] = spatialPosSimple(LS_T_CPEs.PD_P2.E2);
[LS_T_CPEs.PD_P2.E3] = spatialPosSimple(LS_T_CPEs.PD_P2.E3);

close all;
cd(f_masterSets); save LS_Top_CPEs LS_T_CPEs

%-------

%%{
%% 3.e Save excel values
[LS_T_CPEs.PD_P1]=Group_summaryMakerLiftStage(LS_T_CPEs.PD_P1);
[LS_T_CPEs.PD_P2]=Group_summaryMakerLiftStage(LS_T_CPEs.PD_P2);

cd([f_variables,'\E_ExcelFiles']) 
Group_ExcelExporterLiftStage(LS_T_CPEs.PD_P1,'Group');
Group_ExcelExporterLiftStage(LS_T_CPEs.PD_P2,'Group');

%-------
%%{

%% 3ü. LeanGroup maker
% removes ref, set and SCAN sections of the files
cd(f_variables)
[LS_T_CPEs_LEAN.PD_P1]=Group_LeanGroupMakerLiftStage(LS_T_CPEs.PD_P1);
[LS_T_CPEs_LEAN.PD_P2]=Group_LeanGroupMakerLiftStage(LS_T_CPEs.PD_P2);

save LS_T_CPEs_LEAN LS_T_CPEs_LEAN
%}

%%{
%% 3.f Generate error mean average value and mean error Table for error experiment

cd(f_variables)

[LS_T_CPEs_LEAN]=ErrorSet_tableLiftStage(LS_T_CPEs_LEAN);
save LS_T_CPEs_LEAN LS_T_CPEs_LEAN

cd([f_variables,'\E_ExcelFiles']) 
writetable(LS_T_CPEs_LEAN.EeSummarywMeans,['Top CPEs -','EeSummaryMeans','.xlsx'])
writetable(LS_T_CPEs_LEAN.IQMSummary,['Top CPEs -','IQMSummary','.xlsx'])

%%{
%% 3.G Generate MSEB compare test

cd([f_variables,'\G_IQMPlots']);
close all; controlCompareSetLIFTSTAGE(LS_T_CPEs_LEAN,[0.05,0.15,0.25],{'0.05  ','0.15','0.25'},'T CPE vs Control valuesD',0.03,'PRE');

cd(f_variables)




%}


%% LOAD LSCPE Variable
cd(f_masterSets); load LS_Top_CPEs; load TopRegion_Control;
cd(f_variables); load LS_T_CPEs_LEAN;
