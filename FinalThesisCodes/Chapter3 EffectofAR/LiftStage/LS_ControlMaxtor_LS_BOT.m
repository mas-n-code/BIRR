%% LS_ControlMaxtor_LS_BOT
% Part of the Dataset Maxtor series:
% Here the control values for the LIFT STAGE values are calculated.
% I belive that 3 levels (3 phantom configurations) are recorded 

%% Experiment notes
%Start of test: Friday October 20
% config: S11
% Antenna Distance: 11 Cm to center, 3cm to phantom edge
% Phantom: Breast D+, 1 FB and 1 tumor
% Tumor Size:15mm
% Patch size:15mm
% 
% RLocations:72
% Z Locations: 4 Per level, and 3 levels. (chest, middle, nipple)
% Top=a2090,000=150mm
% 	L0=a2090k; mm=64.14 
%   L0_5=a2070k; mm=63.74 (-.5mm aprox)
%   L1=a2060k; mm=63.14(-1mm)
%   L2=a2037k; mm=62.14(-2mm)
% 	LR=a2070k; mm=64.00 (0mm (+/-.1) ->  a2090k??
% 
% Middle=a1345,000=115mm
% 	L0=a1345k; mm=\ 
%   L0_5=a1335k; mm=\ (-.5mm aprox)
%   L1=a1328k; mm=\(-1mm)
%   L2=a1310k; mm=\(-2mm)
% 	LR=a1345k; mm=\ (0mm (+/-.1)
% 
% Bottom=a722,000 = 75mm
% 	L0=a722k; mm=9.37 (to a plate attached in the top of tabletop)
%   L0_5=a712k; mm=8.83 (-.5mm aprox)
%   L1=a708k; mm=8.37(-1mm)
%   L2=a692k; mm=(-2mm)
% 	LR=a722k; mm=9.45 (0mm (+/-.1)
% 
% Name code:
% {Section}{Level}{Pair#}[{Config}]{Comments}
% 
% Example:
% Bl1p2[A]Full
% 
% Section: Bottom [B,M,T]
% Level:l1, 1mm decrement [l0,l0_5,l1,l2,l]
% 
% Pair:2, a CounterWise and CounterClockwise datasets
% Config: A, Reference [A reference, B Tumor Only, C Tumor and fibro, D Fibro Only]
% Comments: In this case, a full reference was taken, Targets were taken away from the phantom in contrast to half reference where targets are raised close to the air gap surface.
% 
% In this datafile I arranged files really weirdly. 
% Top
    %Original/ACCURACY pairs TLo_XXX;
    %Precision Pairs Lxx___mim;
    
% Middle
 %(2) Cw and CC for: A half ref
 % %Original/ACCURACY pairs ML0; ML05;ML1;ML2;MLR
    %Precision Pairs CM05;CM1;CM2; CMR

% Bottom
    %Original/ACCURACY pairs BL_XXX; ML05;ML1;ML2;MLR
    %Precision Pairs BL_0
% 
%


%% --- Part I load initial variables

set(0,'defaultAxesFontName', 'Times New Roman')
set(0,'DefaultAxesFontSize',16)
set(0,'DefaultFigureColormap',paruly)
cmap=colormap(paruly);
col_Tumor=cmap(50,:);
col_Fibro=cmap(35,:);
col_Back=cmap(10,:);
close all


f_rawData=('F:\UserElGuapo\Google Drive\MarioProject2\150922 Effects of Vertical Error\1020 36FullTest\[xy] oficial');

f_variables='F:\UserElGuapo\DBOx\Dropbox\ResearchMagic\RandomProyects\160110 12 Effects of AR\MASTER Dataset LiftStage\3 Bottom\Control Scans';
f_masterSets='F:\UserElGuapo\Google Drive\masterSets\LiftStage\3 Bottom';  
f_root='F:\UserElGuapo\DBOx\Dropbox\ResearchMagic\RandomProyects\160110 12 Effects of AR\MASTER Dataset';

cd(f_rawData)
cd(f_variables)
cd(f_masterSets)
cd(f_root)


%%{


%% Load and parse files 1
%% Load files-Save variables Mat File
%commented to save time
%%{

cd([f_rawData,'\Bottom\CTL_BL0'])
Ref_files = dir('**Mono*[A]***.txt');
TumorFibro_files=dir('*Mono*[C]***.txt');
Tumor_files = dir('**Mono*[B]***.txt');


% Load first, CW, experiment files
LSSet_B.L0.P1.file_ref=Ref_files(1).name;
LSSet_B.L0.P1.file_data=TumorFibro_files(1).name;
LSSet_B.L0.P1.file_tumor=Tumor_files(1).name;

LSSet_B.L0.P1.set_ref=load(Ref_files(1).name);
LSSet_B.L0.P1.set_data=load(TumorFibro_files(1).name);
LSSet_B.L0.P1.set_tumor=load(Tumor_files(1).name);

% Second, CC experiment
LSSet_B.L0.P2.file_ref=Ref_files(2).name;
LSSet_B.L0.P2.file_data=TumorFibro_files(2).name;
LSSet_B.L0.P2.file_tumor=Tumor_files(2).name;

LSSet_B.L0.P2.set_ref=load(Ref_files(2).name);
LSSet_B.L0.P2.set_data=load(TumorFibro_files(2).name);
LSSet_B.L0.P2.set_tumor=load(Tumor_files(2).name);


cd(f_masterSets)

save BoTRegion_Control LSSet_B


%}


%%{


%%{
%% ------------------------------------------Reconstruct files-------------------------

% Reconstruct Control C

%% Image Reconstruction Settings (specific for this experiment see notes inRSARTx288 ) <------------This needs to be reviewed.
RecSettings.win=1; % Selects wether a window is present or not
RecSettings.w_sup=10; % window at 10
RecSettings.w_inf=15; %window at 15
RecSettings.speed=2.90e8; %diegospeed 2.7e8
RecSettings.radius=0.285; %DiegoRadius 0.285 in meters
RecSettings.ver=100; % Reconstruction version of algorithm   %%%%%%
RecSettings.Iclims=[0 35e-9]; % LS limit is 5.5    RS limit was 5e-9!
RecSettings.counterWise=1;   %% this might be wrong, dont know. for this experiment lest leave it like this
RecSettings.fl_low=1e9;
RecSettings.fl_high=8e9;
RecSettings.Bdiam=.18; %diameter of the breast <------ particular f this exp in meters 12 for bottom!
RecSettings.wflip=0;

if (RecSettings.counterWise==0);
    RecSettings.wflip=1;
end


% Set settings for 72L images
RecSettings.Arrasize=size(LSSet_B.L0.P1.set_ref,2)/2;
LSSet_B.RecSettings=RecSettings; 

%% Save REC settings
cd(f_variables)
save LS_B_RecSettings RecSettings
%%

%% Reconstruct Bottom Control C
cd([f_variables,'\A_ReconstructedFigures\01 Tumor and Fibro'])

close all

set(0,'defaultAxesFontName', 'Times New Roman')
set(0,'DefaultAxesFontSize',14)



RecSettings.counterWise=1;RecSettings.wflip=0;
supershort='P1 LS BoT [C] Control';
a_Target=LSSet_B.L0.P1.set_data;
a_Reference=LSSet_B.L0.P1.set_ref;
[LSSet_B.L0.P1.C_Scan]=...
    monofun_mario_cmS(a_Reference,a_Target,RecSettings,supershort);


RecSettings.wflip=0;
RecSettings.counterWise=0; 
if (RecSettings.counterWise==0);
    RecSettings.wflip=1;
end

supershort='P2 LS BoT [C] Control';
a_Target=LSSet_B.L0.P2.set_data;
a_Reference=LSSet_B.L0.P2.set_ref;
[LSSet_B.L0.P2.C_Scan]=...
    monofun_mario_cmS(a_Reference,a_Target,RecSettings,supershort);

cd(f_masterSets)

save BoTRegion_Control LSSet_B



%%{

%%
% Reconstruct BoT Control B
cd([f_variables,'\A_ReconstructedFigures\02 Tumor Only'])
close all
set(0,'defaultAxesFontName', 'Times New Roman')
set(0,'DefaultAxesFontSize',14)

%CW Combo:
RecSettings.counterWise=1;RecSettings.wflip=0;

supershort='P1 LS BoT [B] Control';
a_Target=LSSet_B.L0.P1.set_tumor;
a_Reference=LSSet_B.L0.P1.set_ref;
[LSSet_B.L0.P1.TumorScan]=...
    monofun_mario_cmS(a_Reference,a_Target,RecSettings,supershort);

%CC Combo
RecSettings.counterWise=0;RecSettings.wflip=1;

supershort='P2 LS BoT [B] Control';
a_Target=LSSet_B.L0.P2.set_tumor;
a_Reference=LSSet_B.L0.P2.set_ref;
[LSSet_B.L0.P2.TumorScan]=...
    monofun_mario_cmS(a_Reference,a_Target,RecSettings,supershort);

cd(f_masterSets)

save BoTRegion_Control LSSet_B

%%{
%% 2 Use B to obtain regions

ImageControl1=abs(LSSet_B.L0.P1.C_Scan.S11_c_RecZoomFlip);
ImageControl2=abs(LSSet_B.L0.P2.C_Scan.S11_c_RecZoomFlip);
ImageTumor=abs(LSSet_B.L0.P1.TumorScan.S11_c_RecZoomFlip);

[Regions.Fibro,Regions.IRefBack,Regions.FExcl,Regions.Tumor,Regions.ITumorBack,Regions.TExcl]=IRegionLocator(ImageTumor,ImageControl1,12,1);
LSSet_B.Regions=Regions;

cd(f_variables); save LS_B_RegionsControlScan Regions
cd(f_masterSets); save BoTRegion_Control LSSet_B


%% 2.b Regions show
codeName1='Control1';
codeName2='Control2';



IP_Clim=30e-9;
IM_Clim=17e-5;

regions_show(ImageControl1,ImageControl2,LSSet_B.Regions,codeName1,codeName2,IM_Clim);


cd([f_variables,'\B_Regions'])

savethisone('RegionsOfSegmentation_Control1and2_LSBoT')

%% 3 Calculate metrics based on regions

LSSet_B.L0.P1.ImageMetrics.Name= 'C-Scan LS-B Control P1';
LSSet_B.L0.P2.ImageMetrics.Name= 'C-Scan LS-B Control P2';
LSSet_B.L0.P1.PowImageMetrics.Name= 'C-Scan LS-B Control P1 Power';
LSSet_B.L0.P2.PowImageMetrics.Name= 'C-Scan LS-B Control P2 Power';



%% 3.a and b Standard magnitude and power values



close all;
cd([f_variables,'\C_RegionMetrics'])
tresh_magnitude= IM_Clim +0.5e-5; % this value might be overrided




% Calculate values of regions in control scan 1
[LSSet_B.L0.P1.ImageMetrics]=I_RegionStandard(ImageControl1,Regions,LSSet_B.L0.P1.ImageMetrics,tresh_magnitude); 
savethisone('Control P1 magnitude structure mean')

% Calculate values of regions in control scan 2
[LSSet_B.L0.P2.ImageMetrics]=I_RegionStandard(ImageControl2,Regions,LSSet_B.L0.P2.ImageMetrics,tresh_magnitude); 
savethisone('Control P2 magnitude structure mean')

% Calculate values of regions in control scan 1 POWER
[LSSet_B.L0.P1.PowImageMetrics]=I_RegionStandard(ImageControl1.^2,Regions,LSSet_B.L0.P1.PowImageMetrics,IP_Clim); 
savethisone('Control P1 power structure mean')

% Calculate values of regions in control scan 2 POWER
[LSSet_B.L0.P2.PowImageMetrics]=I_RegionStandard(ImageControl2.^2,Regions,LSSet_B.L0.P2.PowImageMetrics,IP_Clim); 
savethisone('Control P2 power structure mean')

cd(f_masterSets); save BoTRegion_Control LSSet_B;




%% CONTROL %%Create AverageImage %% %%
close all; 

cd([f_variables,'\D_ImageDiferences'])
refAverageImage.Image=((ImageControl1+ImageControl2)./2).^2;
figure;imagesc(refAverageImage.Image); colorbar; axis('square');savethisone('AverageControlImageLSBoT')
refAverageImage.PowMetrics.Name='RefImageAverageControlLSBoT';
refAverageImage.PowMetrics=I_RegionStandard(refAverageImage.Image,Regions,refAverageImage.PowMetrics,IP_Clim);
save refAverageImage refAverageImage


%% 3.c Calculate image/difference metrics [power]
close all;
[LSSet_B.L0.P1.PowImageMetrics]=IQ_Standard(ImageControl1.^2,refAverageImage.Image,LSSet_B.L0.P1.PowImageMetrics,refAverageImage.PowMetrics); 
savethisone([LSSet_B.L0.P1.PowImageMetrics.Name 'SSIM vs Average POw']);% Same, just saved in both Metric Files

[LSSet_B.L0.P2.PowImageMetrics]=IQ_Standard(ImageControl2.^2,refAverageImage.Image,LSSet_B.L0.P2.PowImageMetrics,refAverageImage.PowMetrics); 
savethisone([LSSet_B.L0.P2.PowImageMetrics.Name 'SSIM vs Average POw']);% Same, just saved in both Metric Files


cd(f_masterSets); save BoTRegion_Control LSSet_B;

%% 3.d Calculate radar image quality metrics [based on magnitude, of course]
[LSSet_B.L0.P1.ImageMetrics]=I_ScR(LSSet_B.L0.P1.ImageMetrics);  
[LSSet_B.L0.P1.ImageMetrics]=I_TfR(LSSet_B.L0.P1.ImageMetrics);
[LSSet_B.L0.P1.ImageMetrics]=I_CtfCR(LSSet_B.L0.P1.ImageMetrics); 

[LSSet_B.L0.P2.ImageMetrics]=I_ScR(LSSet_B.L0.P2.ImageMetrics);  
[LSSet_B.L0.P2.ImageMetrics]=I_TfR(LSSet_B.L0.P2.ImageMetrics);
[LSSet_B.L0.P2.ImageMetrics]=I_CtfCR(LSSet_B.L0.P2.ImageMetrics); 

cd(f_masterSets); save BoTRegion_Control LSSet_B;
%-------

%% 3.é-F Spatial positioning 
%[SPEs_l]=ErrorSet_table(SPEs_l);
cd([f_variables,'\F_Positions']);
close all;
[LSSet_B.L0.P1] = spatialPos(LSSet_B.L0.P1,ImageControl1);
[LSSet_B.L0.P2] = spatialPos(LSSet_B.L0.P2,ImageControl2);


cd(f_masterSets); save BoTRegion_Control LSSet_B;



%%  4. Summaries and Excels
close all;
% Generate eSummary 
[LSSet_B.L0.P1]=eSummaryMaker(LSSet_B.L0.P1);
[LSSet_B.L0.P2]=eSummaryMaker(LSSet_B.L0.P2);
cd(f_masterSets); save BoTRegion_Control LSSet_B;

% Export such eSummary
cd([f_variables,'\E_ExcelFiles']) 
estructExceler(LSSet_B.L0.P1.ImageMetrics.eSummary,[LSSet_B.L0.P1.ImageMetrics.Name,'eSummary'],1);
estructExceler(LSSet_B.L0.P2.ImageMetrics.eSummary,[LSSet_B.L0.P2.ImageMetrics.Name,'eSummary'],1);





%% LEAN
removeFields={'set_ref','set_data','set_tumor','C_Scan','TumorScan'};
LSSet_B_LEAN=LSSet_B;
LSSet_B_LEAN.L0.P1=rmfield(LSSet_B.L0.P1,removeFields);
LSSet_B_LEAN.L0.P2=rmfield(LSSet_B.L0.P2,removeFields);
cd(f_variables);
save BoTRegion_Control_LEAN LSSet_B_LEAN;

%%   5 Create plots that have IQM as controls. 
load('F:\UserElGuapo\DBOx\Dropbox\ResearchMagic\RandomProyects\160110 12 Effects of AR\MASTER Dataset\ControlSummaryOFF.mat') % Loads uncertainties from rotary stage since they have more experiments

[LScontrolSummaryError]=ContolSet_table(LSSet_B_LEAN.L0);
LSSet_B_LEAN.L0Summary.GroupTable=LScontrolSummaryError.GroupTable;
LSSet_B_LEAN.L0Summary.table2exp=LScontrolSummaryError.table3exp;
LOsummary=LSSet_B_LEAN.L0Summary;
save LiftStageControlSummary LOsummary 

cd(f_variables); save BoTRegion_Control_LEAN LSSet_B_LEAN;

% save to excel files
cd([f_variables,'\E_ExcelFiles']);  
writetable(LSSet_B_LEAN.L0Summary.GroupTable,['BoT Control-','GroupTable','.xlsx'])
writetable(LSSet_B_LEAN.L0Summary.table2exp,['BoT Control-','table2exp','.xlsx'])

writetable(ControlSummaryOFF.table3exp,['RotaryStageControl-','table3exp','.xlsx'])
estructExceler(LSSet_B_LEAN.L0Summary,['BoT Control','LOSummary'],2);






cd([f_variables,'\G_IQMPlots']);
% UNCERTAINTIES ARE OBTAINED FROM RS VALUES
graph_IQM_error_v=repmat([  ControlSummaryOFF.table3exp.ScR_3exp_CI;...
                            ControlSummaryOFF.table3exp.TfR_3exp_CI;...
                            ControlSummaryOFF.table3exp.CcR_3exp_CI],1,3);
           % Mean values ARE OBTAINED FROM LS VALUES             
graph_IQM_mean_v=repmat([   LOsummary.table2exp.ScR_3exp_mean;...
                            LOsummary.table2exp.TfR_3exp_mean;...
                            LOsummary.table2exp.CcR_3exp_mean],1,3);

x1=[0,2,4];
mulineprops.style=':';
mulineprops.width=1;
figure; hold on; mseb(x1,graph_IQM_mean_v,graph_IQM_error_v,mulineprops,1);
ylabel('dB')
ylim([0,40])
savethisone('IQM Control values for LiftStage')


% define indivual value to plot in curve
ScR_v=LScontrolSummaryError.GroupTable.IQ_ScR_M;
TfR_v=LScontrolSummaryError.GroupTable.IQ_TfR_M;
CcR_v=LScontrolSummaryError.GroupTable.IQ_CcR_M;
%%{
laline.style='o--';
x1=[1,2]; 

h=mseb([],[ScR_v';TfR_v';CcR_v'],zeros(3,2),laline,1);

l1=legend([h.mainLine],'ScR','TfR','CcR','Location','Best'); 
set(l1,...
    'Position',[0.40 0.25 0.25 0.15]); %
%}


title('IQM Invidiual lift stage control experiments over average and  95% CI ')
% Define labels on x axis
ax = gca;
set(ax,'XTick', [1 2]);
set(ax,'XTickLabel',{'Exp 1' 'Exp 2'});
ylabel('dB')
ylim([0,40])

savethisone('LS IQM with RS CI uncertainties from 3 samples ')
%

%}


%% Do the same for bottom layer
%% Do the same for BoT layer

%
%% Load variables if required
%load('F:\UserElGuapo\Google Drive\masterSets\LiftStage\1 Bottom\BoTRegion_Control.mat')
%cd(f_variables);load BoTRegion_Control_LEAN;
