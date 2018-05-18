%FP Day 3
%% Change Directory
close all; 

cd('F:\UserElGuapo\Google Drive\MarioProject2\160204 FP Day2\DataSets\Experiment Two') %Guaper

%cd('C:\Users\El Mario\Google Drive\MarioProject2\160204 FP Day2\DataSets\Experiment Two')


%% Load Files 
load('M_set_XA_CW.mat')
load('M_set_XO_CW.mat')

set(0,'defaultAxesFontName', 'Times New Roman')
set(0,'DefaultAxesFontSize',16)
set(0,'DefaultFigureColormap',paruly)
%%
cmap=colormap(paruly);
colores.Tumor=cmap(50,:);
colores.Fibro=cmap(35,:);
colores.Back=cmap(10,:);

close all
%%

%{
O_Mono_files_W = dir('**Mono*O_***aW**.txt');
A_Mono_files_W = dir('**Mono*A_***aW**.txt');
%TumorFibro_files=dir('*Mono*[C]***.txt');
%Tumor_files = dir('**Mono*[B]***.txt');


%{
% Set M_Set_XA_CW
set_AO=load(O_Mono_files_W(1).name); % Chamber + Support
set_CO=load(O_Mono_files_W(2).name); % CS + Fibro + Tumor
set_DO=load(O_Mono_files_W(3).name); % CS + Fibro
set_OO=load(O_Mono_files_W(4).name); %%Chamber
%}

%{
% Set M_Set_X0_CW
set_AA_1=load(A_Mono_files_W(1).name); % Ref no Refill [CS + FAT]
set_AA_2=load(A_Mono_files_W(2).name); % Ref with Refill [CS + FAT]
set_BA=load(A_Mono_files_W(3).name);   % CSF + TUMOR P-1 %[NO FG]
set_CA_2=load(A_Mono_files_W(4).name); % CSF + ExT + FibroGlandular % [no
actual tumor present] 
set_CA_1=load(A_Mono_files_W(5).name); % CSF + Tumor + FG
%}



%}
 
%<<<<<



%% Image Reconstruction Settings
%%{ 
RecSettings.win=1; % Selects wether a window is present or not
RecSettings.w_sup=6; % window at 10 file at 2
RecSettings.w_inf=15; %window at 15 file at 30
RecSettings.speed=2.5e8; %diegospeed 2.7e8 %%calc at 2.5 fiel at 2.5
RecSettings.radius=0.204; % Radious of antenna to center%DiegoRadius 0.285, 10cm are added %%22calc % 204 according to Mario and Diego file at 204
RecSettings.ver=100; % Reconstruction version of algorithm   %%%%%%
RecSettings.Iclims=[0 2.5e-6];
RecSettings.counterWise=0;

RecSettings.wflip=0;
if (RecSettings.counterWise==0);
    RecSettings.wflip=1;
end

RecSettings.fl_low=1e9; % Freq settings for cm conversion Typically fl_low=2e9;
RecSettings.fl_high=8e9; % Freq settings for cm conversion  Typically fl_high=8e9; 

RecSettings.Bdiam=5;
%}
RecSettings.colores=colores;

%{
RecSettings.speed=2.5e8; %diegospeed 2.7e8 %%calc at 2.5
RecSettings.radius=0.205; % Radious of antenna to center%DiegoRadius 0.285, 10cm are added %%22calc
%RecSettings.Iclims=[0 3.5e-6];
%}

%% Reconstruct images OO

% 1) First Reconstruction [Support]
%%{
B_ack=set_OO;
T_arget=set_AO;
supershort='B00 TA0 Support in Chamber'; 

RecSettings.Arrasize=size(B_ack,2)/2;
RecSettings.Iclims = [0 9.5e-7]; %%When fat IS calibrated

RecSettings.Arrasize=size(B_ack,2)/2;
[SCAN_B00_TA0]=...
    monofun_mario_cmS(B_ack,T_arget,RecSettings,supershort);

%}

% 2) Second Rec [Fibro No Fat]
%% {

B_ack=set_AO;
T_arget=set_DO;
supershort='BA0 D0 Only Fibro ChamberCal'; 

RecSettings.Arrasize=size(B_ack,2)/2;
RecSettings.Iclims = [0 5e-6]; %%When fat is not calibrated

RecSettings.Arrasize=size(B_ack,2)/2;
[SCAN_BA0_TD0]=...
    monofun_mario_cmS(B_ack,T_arget,RecSettings,supershort);



%}
%%
% 3) Third Rec [Fibro No Fat]
%%{

B_ack=set_AO;
T_arget=set_CO;
supershort='BA0 TCO Fibro+Tumor NoFat'; 


RecSettings.Arrasize=size(B_ack,2)/2;
RecSettings.Iclims = [0 5e-6]; %%When fat is not calibrated

RecSettings.Arrasize=size(B_ack,2)/2;

[SCAN_BA0_TC0]=...
    monofun_mario_cmS(B_ack,T_arget,RecSettings,supershort);
%}





%% AA Fat Only-> Full Ref
% 1) CA_1 [CompletePhantom]
%%{

B_ack=set_AO;
T_arget=set_AA_2;
supershort='BA0 TAA2 Only Fatty breast'; 


RecSettings.Arrasize=size(B_ack,2)/2;
RecSettings.Iclims = [0 5e-6]; %%When fat is not calibrated

RecSettings.Arrasize=size(B_ack,2)/2;

[SCAN_BA0_TAA2]=...
    monofun_mario_cmS(B_ack,T_arget,RecSettings,supershort);
%}


%% Fat Breast with Tumor only
% 1) BA [TumorOnly]
%%{

B_ack=set_AA_2; %Full Ref
T_arget=set_BA;
supershort='BAA2 TBA Tumor on fatty breast FatCal'; 

RecSettings.Arrasize=size(B_ack,2)/2;
RecSettings.Iclims = [0 9.5e-7]; %%When fat IS calibrated

[SCAN_BAA2_TBA]=...
    monofun_mario_cmS(B_ack,T_arget,RecSettings,supershort);
%}


%% { 

B_ack=set_AO; 
T_arget=set_BA;
supershort='BA0 TBA Tumor on fatty breast [Not Calibrated]'; 

RecSettings.Arrasize=size(B_ack,2)/2;
RecSettings.Iclims = [0 5e-6]; %%When fat is not calibrated

[SCAN_BA0_TBA]=...
    monofun_mario_cmS(B_ack,T_arget,RecSettings,supershort);
%}



%% AC version Complete with tumor
% 
% Fat Calibrated

B_ack=set_AA_2; 
T_arget=set_CA_1;
supershort='BAA2 TCA1 Tumor and Fibro in fatty breast calFat'; 

RecSettings.Arrasize=size(B_ack,2)/2;
RecSettings.Iclims = [0 9.5e-7]; %%When fat is calibrated
[SCAN_BAA2_TCA1]=...
    monofun_mario_cmS(B_ack,T_arget,RecSettings,supershort);
%}
%Save SCAN_BAA2_TCA1 SCAN_BAA2_TCA1

% Fat not calibrated

B_ack=set_AO; 
T_arget=set_CA_1;
supershort='BA0 TCA1 Tumor and Fibro in fatty breast unCalFat'; 

RecSettings.Iclims = [0 5e-6]; %%When fat is not calibrated
RecSettings.Arrasize=size(B_ack,2)/2;

[SCAN_BA0_TCA1]=...
    monofun_mario_cmS(B_ack,T_arget,RecSettings,supershort);

%save SCAN_BA0_TCA1 SCAN_BA0_TCA1
%}

%% AC-EX1 version Complete with EXtumor // tumor does not apears in image, it proably fell off
% 
%%{

B_ack=set_AA_2;
T_arget=set_CA_2;
supershort='BAA2 TCA2 EXT+FG in fatty breast FATCAL'; 

RecSettings.Arrasize=size(B_ack,2)/2;
RecSettings.Iclims = [0 9.5e-7]; %%When fat is calibrated

[SCAN_BAA2_TCA2]=...
    monofun_mario_cmS(B_ack,T_arget,RecSettings,supershort);
%}


%%{

B_ack=set_AO; 
T_arget=set_CA_2;
supershort='BA0 TCA2 EXT+FG in fatty breast unCAlFat'; 

RecSettings.Iclims = [0 5e-6]; %%When fat is not calibrated
RecSettings.Arrasize=size(B_ack,2)/2;

[SCAN_BA0_TCA2]=...
    monofun_mario_cmS(B_ack,T_arget,RecSettings,supershort);
%}





%% Region locator using tumor info from the T_BA a T_CA1 Files, Background has a radius of 12 pixels or 12 cm allegedly

ITumor=abs(SCAN_BAA2_TBA.S11_c_RecZoomFlip);
IComplete=abs(SCAN_BAA2_TCA1.S11_c_RecZoomFlip);
IFibro=abs(SCAN_BAA2_TCA2.S11_c_RecZoomFlip);

[FP_Regions.Fibro,FP_Regions.IRefBack,FP_Regions.FExcl,FP_Regions.Tumor,FP_Regions.ITumorBack,FP_Regions.TExcl]=IRegionLocator(ITumor,IComplete,12,3);

save FP_Regions FP_Regions

% display images regionized background FP
IRegionDisplay(IComplete.^2,[0.5e-7,9.5e-7],FP_Regions);
savethisone('Regions of the Image')



%% calculate FP region standard metrics
% For TCA1, the complete image

FP_DataMetrics.TCA1.ImageMetrics.Name='TCA1 Complete Image Metrics';
FP_DataMetrics.TCA1.PowImageMetrics.Name='TCA1 Complete Power metrics';
% tresh 5e-9
% tresh7e-5
tresh_magnitude= 9e-4; % this value might be overrided
powtresh_magnitude= 8e-7; % this value might be overrided
 figure;imagesc(IComplete,[0 tresh_magnitude]);
 figure;imagesc(IComplete.^2,[0 powtresh_magnitude]);
 
[FP_DataMetrics.TCA1.ImageMetrics]=I_RegionStandard(IComplete,FP_Regions,FP_DataMetrics.TCA1.ImageMetrics,tresh_magnitude);
[FP_DataMetrics.TCA1.PowImageMetrics]=I_RegionStandard(IComplete.^2,FP_Regions,FP_DataMetrics.TCA1.PowImageMetrics,powtresh_magnitude);

[FP_DataMetrics.TCA1.ImageMetrics]=I_ScR(FP_DataMetrics.TCA1.ImageMetrics);  
[FP_DataMetrics.TCA1.ImageMetrics]=I_TfR(FP_DataMetrics.TCA1.ImageMetrics);
[FP_DataMetrics.TCA1.ImageMetrics]=I_CtfCR(FP_DataMetrics.TCA1.ImageMetrics);
[FP_DataMetrics.TCA1]=eSummaryMaker(FP_DataMetrics.TCA1);

%**************************************************************************
% For TCA2, the fibro only image

FP_DataMetrics.TCA2.ImageMetrics.Name='TCA2 Fibro Only Image Metrics';
FP_DataMetrics.TCA2.PowImageMetrics.Name='TCA2 Fibro Only Power metrics';

tresh_magnitude= 9e-4; % this value might be overrided
powtresh_magnitude= 8e-7; % this value might be overrided
figure;imagesc(IFibro,[0 tresh_magnitude]);
figure;imagesc(IFibro.^2,[0 powtresh_magnitude]);
 
[FP_DataMetrics.TCA2.ImageMetrics]=I_RegionStandard(IFibro,FP_Regions,FP_DataMetrics.TCA2.ImageMetrics,tresh_magnitude);
[FP_DataMetrics.TCA2.PowImageMetrics]=I_RegionStandard(IFibro.^2,FP_Regions,FP_DataMetrics.TCA2.PowImageMetrics,powtresh_magnitude);

[FP_DataMetrics.TCA2.ImageMetrics]=I_ScR(FP_DataMetrics.TCA2.ImageMetrics);  
[FP_DataMetrics.TCA2.ImageMetrics]=I_TfR(FP_DataMetrics.TCA2.ImageMetrics);
[FP_DataMetrics.TCA2.ImageMetrics]=I_CtfCR(FP_DataMetrics.TCA2.ImageMetrics);
[FP_DataMetrics.TCA2]=eSummaryMaker(FP_DataMetrics.TCA2);

%**************************************************************************
% For TBA, the tumor only image
FP_DataMetrics.TBA.ImageMetrics.Name='TBA Tumor Only Image Metrics';
FP_DataMetrics.TBA.PowImageMetrics.Name='TBA Tumor Only Power metrics';

tresh_magnitude= 9e-4; % this value might be overrided
powtresh_magnitude= 8e-7; % this value might be overrided
 figure;imagesc(ITumor,[0 tresh_magnitude]);
 figure;imagesc(ITumor.^2,[0 powtresh_magnitude]);
 
[FP_DataMetrics.TBA.ImageMetrics]=I_RegionStandard(ITumor,FP_Regions,FP_DataMetrics.TBA.ImageMetrics,tresh_magnitude);
[FP_DataMetrics.TBA.PowImageMetrics]=I_RegionStandard(ITumor.^2,FP_Regions,FP_DataMetrics.TBA.PowImageMetrics,powtresh_magnitude);

[FP_DataMetrics.TBA.ImageMetrics]=I_ScR(FP_DataMetrics.TBA.ImageMetrics);  
[FP_DataMetrics.TBA.ImageMetrics]=I_TfR(FP_DataMetrics.TBA.ImageMetrics);
[FP_DataMetrics.TBA.ImageMetrics]=I_CtfCR(FP_DataMetrics.TBA.ImageMetrics);
[FP_DataMetrics.TBA]=eSummaryMaker(FP_DataMetrics.TBA);


%%
save FP_DataMetrics FP_DataMetrics

estructExceler(FP_DataMetrics.TCA1.ImageMetrics.eSummary,[FP_DataMetrics.TCA1.ImageMetrics.Name,' eSummary']);
estructExceler(FP_DataMetrics.TCA2.ImageMetrics.eSummary,[FP_DataMetrics.TCA2.ImageMetrics.Name,' eSummary']);
estructExceler(FP_DataMetrics.TBA.ImageMetrics.eSummary,[FP_DataMetrics.TBA.ImageMetrics.Name,' eSummary']);

%% Generate plot with MSEB of control groups and IQM of TCA2

ScR_v=[FP_DataMetrics.TCA1.ImageMetrics.eSummary.ScR_M];
TfR_v=[FP_DataMetrics.TCA1.ImageMetrics.eSummary.TfR_M];
CcR_v=[FP_DataMetrics.TCA1.ImageMetrics.eSummary.CcR_M];

controlCompare(ScR_v,TfR_v,CcR_v,1,{'1'},'one tumor');
savethisone('graph TCA1 vs Control')




