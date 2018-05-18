% LSCAE_M_DatasetMaxtor_LS
% started on August 9 2016

% Part of the LS MEDIUM Dataset Maxtor series:

% 1. LS_ControlMaxtor_LS
% 2. LSCAE_M_DatasetMaxtor_LS - This one
% 3. LSCPE_M_DatasetMaxtor_LS - Pending



%By Mario Solis
% This scripts USES the datasets with error ls-m-CAE, Rotary Stage Single Accuracy error. 
% Segments the responses
% Calculates standard and quality metrics
% Saves result and excel tables
% Generates plots to compare effect of error to control values

%%--- Part I Initialization ---

% Initialize MaxtorFile
LS_M_CAEs.PD_P1.GName='LS-P1-CAE';
LS_M_CAEs.PD_P2.GName='LS-P2-CAE';

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

f_root='F:\UserElGuapo\DBOx\Dropbox\ResearchMagic\RandomProyects\160110 12 Effects of AR\MASTER Dataset LiftStage\2 Middle';
cd(f_root);

f_variables=[f_root,'\Accuracy Errors CAE'];
f_masterSets='F:\UserElGuapo\Google Drive\masterSets\LiftStage\2 Middle';
f_rawData='F:\UserElGuapo\Google Drive\MarioProject2\150922 Effects of Vertical Error\1020 36FullTest\[xy] oficial';

% Load variables

load('F:\UserElGuapo\DBOx\Dropbox\ResearchMagic\RandomProyects\160110 12 Effects of AR\MASTER Dataset LiftStage\2 Middle\Control Scans\LS_RegionsControlScans.mat') % Loads the regions segmented from control scans
load('F:\UserElGuapo\DBOx\Dropbox\ResearchMagic\RandomProyects\160110 12 Effects of AR\MASTER Dataset LiftStage\2 Middle\Control Scans\LS_RecSettings.mat') % Loads the regions segmented from control scans

%load('LS_M_CAEs_Lean_MetricsOnly.mat') -< Not made yet
cd(f_variables)




%% --- Part II Load and reconstruct Error Files ---
cd([f_rawData,'\Middle']);

%Load E1 - 0.5cm


cd([f_rawData,'\Middle\ACC_ML05']);

Ref_files = dir('**Mono*[A]***.txt');
TumorFibro_files=dir('*Mono*[C]***.txt');
Tumor_files = dir('**Mono*[B]***.txt');

LS_M_CAEs.PD_P1.E1.set_ref=load(Ref_files(1).name);
LS_M_CAEs.PD_P2.E1.set_ref=load(Ref_files(2).name);

LS_M_CAEs.PD_P1.E1.set_data=load(TumorFibro_files(1).name);
LS_M_CAEs.PD_P2.E1.set_data=load(TumorFibro_files(2).name);

LS_M_CAEs.PD_P1.E1.set_tumor=load(Tumor_files(1).name);
LS_M_CAEs.PD_P2.E1.set_tumor=load(Tumor_files(2).name);

%Load E2 - 1 cm
cd([f_rawData,'\Middle\ACC_ML1']);

Ref_files = dir('**Mono*[A]***.txt');
TumorFibro_files=dir('*Mono*[C]***.txt');
Tumor_files = dir('**Mono*[B]***.txt');

LS_M_CAEs.PD_P1.E2.set_ref=load(Ref_files(1).name);
LS_M_CAEs.PD_P2.E2.set_ref=load(Ref_files(2).name);

LS_M_CAEs.PD_P1.E2.set_data=load(TumorFibro_files(1).name);
LS_M_CAEs.PD_P2.E2.set_data=load(TumorFibro_files(2).name);

LS_M_CAEs.PD_P1.E2.set_tumor=load(Tumor_files(1).name);
LS_M_CAEs.PD_P2.E2.set_tumor=load(Tumor_files(2).name);


%Load E3 - 2 cm
cd([f_rawData,'\Middle\ACC_ML2']);

Ref_files = dir('**Mono*[A]***.txt');
TumorFibro_files=dir('*Mono*[C]***.txt');
Tumor_files = dir('**Mono*[B]***.txt');

LS_M_CAEs.PD_P1.E3.set_ref=load(Ref_files(1).name);
LS_M_CAEs.PD_P2.E3.set_ref=load(Ref_files(2).name);

LS_M_CAEs.PD_P1.E3.set_data=load(TumorFibro_files(1).name);
LS_M_CAEs.PD_P2.E3.set_data=load(TumorFibro_files(2).name);

LS_M_CAEs.PD_P1.E3.set_tumor=load(Tumor_files(1).name);
LS_M_CAEs.PD_P2.E3.set_tumor=load(Tumor_files(2).name);

cd(f_masterSets); save LS_Medium_CAEs LS_M_CAEs


%%
%----II.B ----Reconstruct Error Files---------------%
% load([f_masterSets,'\LS_Medium_CAEs.mat'])        % % % % % % Take me^% %
close all;
cd([f_variables,'\A_ReconstructedFigures'])

RecSettings.counterWise=1;
[LS_M_CAEs.PD_P1]=PD_RecoSaver_LiftStage(LS_M_CAEs.PD_P1,'LSM P1-CAE',RecSettings);

RecSettings.counterWise=0;
[LS_M_CAEs.PD_P2]=PD_RecoSaver_LiftStage(LS_M_CAEs.PD_P2,'LSM P2-CAE',RecSettings); RecSettings.counterWise=1; 

%[LS_M_CAEs.PD_P1]=PD_RecoSaver_LiftStage(SPEs.PD_P1,'P1-SPE',RecSettings); close all;
cd(f_masterSets); save LS_Medium_CAEs LS_M_CAEs

%% ------Part III Process reconstructed images, segment, evaluate and quantify.------ %%
% 3.þ Preparation {some variables are assigned}
% 3.a Display regions for one image
% 3.b Calculate Standard Metrics per regions
% 3.c Calculate image/difference metrics
% 3.d Calculate radar image quality metrics
% 3.e Save excel values

%%  3.þ Preparation of Magnitude and power limits
close all;
IP_Clim=5e-9;
IM_Clim=7e-5;

% 3.a Display regions for one image
% In case of flies, one specific reconstructed image is separated into strucutres 
% P2.E15 is reconstructed, for no specific reason.

Image4Region1= LS_M_CAEs.PD_P1.E3.SCAN.Fig_c_RecZoomFlip_abs;
Image4Region2= LSSet_M.L0.P1.C_Scan.Fig_c_RecZoomFlip_abs;
regions_show(Image4Region1,Image4Region2,Regions,'Control LS M','LS M P1 CAE 2cm',IP_Clim);
cd([f_variables,'\B_Regions'])

savethisone('RegionsOfSegmentation_CAE')



%% 3.b Calculate Standard Metrics per regions 
%-------
close all;
cd([f_variables,'\C_RegionMetrics'])
[LS_M_CAEs.PD_P1]=Group_RegionSegmenter_LiftStage(LS_M_CAEs.PD_P1,Regions,IM_Clim,IP_Clim); 
[LS_M_CAEs.PD_P2]=Group_RegionSegmenter_LiftStage(LS_M_CAEs.PD_P2,Regions,IM_Clim,IP_Clim); 

% Change folder and save CAEs
cd(f_masterSets); save LS_Medium_CAEs LS_M_CAEs

%-------


%% 3.c Calculate image/difference metrics [power]
close all;

cd([f_variables,'\D_ImageDiferences'])
load('F:\UserElGuapo\DBOx\Dropbox\ResearchMagic\RandomProyects\160110 12 Effects of AR\MASTER Dataset LiftStage\2 Middle\Control Scans\D_ImageDiferences\refAverageImage.mat')

refImage=refAverageImage.Image;
RefImageMetrics=refAverageImage.PowMetrics;

[LS_M_CAEs.PD_P1]=Group_IQStandardLiftStage(LS_M_CAEs.PD_P1,refImage,RefImageMetrics);
[LS_M_CAEs.PD_P2]=Group_IQStandardLiftStage(LS_M_CAEs.PD_P2,refImage,RefImageMetrics);
% Change folder and save CAEs
cd(f_masterSets); save LS_Medium_CAEs LS_M_CAEs
%-------

%% 3.d Calculate radar image quality metrics [based on magnitude, of course]
close all;
%-------

[LS_M_CAEs.PD_P1] = Group_RecoQualityMetricsLiftStage(LS_M_CAEs.PD_P1); 
[LS_M_CAEs.PD_P2] = Group_RecoQualityMetricsLiftStage(LS_M_CAEs.PD_P2); 

cd(f_masterSets); save LS_Medium_CAEs LS_M_CAEs
%-------

%% 3.é-F Spatial positioning 
%-------
cd([f_variables,'\F_Positions']);
[LS_M_CAEs.PD_P1.E1] = spatialPosSimple(LS_M_CAEs.PD_P1.E1);
[LS_M_CAEs.PD_P1.E2] = spatialPosSimple(LS_M_CAEs.PD_P1.E2);
[LS_M_CAEs.PD_P1.E3] = spatialPosSimple(LS_M_CAEs.PD_P1.E3);


[LS_M_CAEs.PD_P2.E1] = spatialPosSimple(LS_M_CAEs.PD_P2.E1);
[LS_M_CAEs.PD_P2.E2] = spatialPosSimple(LS_M_CAEs.PD_P2.E2);
[LS_M_CAEs.PD_P2.E3] = spatialPosSimple(LS_M_CAEs.PD_P2.E3);

close all;
cd(f_masterSets); save LS_Medium_CAEs LS_M_CAEs

%-------

%% 3.e Save excel values
[LS_M_CAEs.PD_P1]=Group_summaryMakerLiftStage(LS_M_CAEs.PD_P1);
[LS_M_CAEs.PD_P2]=Group_summaryMakerLiftStage(LS_M_CAEs.PD_P2);

cd([f_variables,'\E_ExcelFiles']) 
Group_ExcelExporterLiftStage(LS_M_CAEs.PD_P1,'Group');
Group_ExcelExporterLiftStage(LS_M_CAEs.PD_P2,'Group');

%-------

%% 3ü. LeanGroup maker
% removes ref, set and SCAN sections of the files
cd(f_variables)
[LS_M_CAEs_LEAN.PD_P1]=Group_LeanGroupMakerLiftStage(LS_M_CAEs.PD_P1);
[LS_M_CAEs_LEAN.PD_P2]=Group_LeanGroupMakerLiftStage(LS_M_CAEs.PD_P2);

save LS_M_CAEs_LEAN LS_M_CAEs_LEAN
%}


%% 3.f Generate error mean average value and mean error Table for error experiment

cd(f_variables)

[LS_M_CAEs_LEAN]=ErrorSet_tableLiftStage(LS_M_CAEs_LEAN);
save LS_M_CAEs_LEAN LS_M_CAEs_LEAN


%% 3.G Generate MSEB compare test

cd([f_variables,'\G_IQMPlots']);
close all; controlCompareSetLIFTSTAGE(LS_M_CAEs_LEAN,[0.05,0.15,0.25],{'0.05  ','0.15','0.25'},'M CAE vs Control valuesD',0.025);

cd(f_variables)



%}


%% LOAD LSCAE Variable
cd(f_masterSets); load LS_Medium_CAEs; load MiddleRegion_Control;
cd(f_variables); load LS_M_CAEs_LEAN;
