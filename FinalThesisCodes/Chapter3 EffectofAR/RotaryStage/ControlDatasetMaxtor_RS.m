%% F_Thesis_ControlDatasetsMaxtor  Chapter 3 Program_PartI
% Part I, Control Datasets xxx72xxx
% 1. Constructs 3 Sample 72 Datasets,
% 2. Reconstruct each dataset + 1 tumor location
% 3. Segments the datasets into tissue structures
% 4. Standard metrics obtained from structures
% 5. Image q metrics from such images
%April 24

%% Default settings
set(0,'defaultAxesFontName', 'Times New Roman')
set(0,'DefaultAxesFontSize',14)

%% Working Folder
%@CAD
%cd('C:\Users\El Mario\Documents\DopboxMyAcount\Dropbox\ResearchMagic\RandomProyects\160110 12 Effects of AR\MASTER Dataset\L288xP1');

%guaper
cd('F:\UserElGuapo\DBOx\Dropbox\ResearchMagic\RandomProyects\160110 12 Effects of AR\MASTER Dataset');


%% Load files
%commented to save time
%{
Ref_files = dir('**Mono*[A]***.txt');
TumorFibro_files=dir('*Mono*[C]***.txt');
Tumor_files = dir('**Mono*[B]***.txt');

P1.set_ref=load(Ref_files(1).name);
P1.set_data=load(TumorFibro_files(1).name);
P1.set_tumor=load(Tumor_files(1).name);

P2.set_ref=load(Ref_files(2).name);
P2.set_data=load(TumorFibro_files(2).name);
P2.set_tumor=load(Tumor_files(2).name);

P3.set_ref=load(Ref_files(3).name);
P3.set_data=load(TumorFibro_files(3).name);
P3.set_tumor=load(Tumor_files(3).name);

save L288_P1 P1
save L288_P2 P2
save L288_P3 P3
%}

%% Generate Plus Arrays
SetPlus.P1Plus.Ref=[P1.set_ref,P1.set_ref];
SetPlus.P1Plus.Data=[P1.set_data,P1.set_data];
SetPlus.P2Plus.Ref=[P2.set_ref,P2.set_ref];
SetPlus.P2Plus.Data=[P2.set_data,P2.set_data];
SetPlus.P3Plus.Ref=[P3.set_ref,P3.set_ref];
SetPlus.P3Plus.Data=[P3.set_data,P3.set_data];

save SetPlus SetPlus 


%% Sample into  3 72L files

SL72_P1.set_ref=SampleRaw(4,P1.set_ref);
SL72_P1.set_data=SampleRaw(4,P1.set_data);
SL72_P1.set_tumor=SampleRaw(4,P1.set_tumor);

SL72_P2.set_ref=SampleRaw(4,P2.set_ref);
SL72_P2.set_data=SampleRaw(4,P2.set_data);
SL72_P2.set_tumor=SampleRaw(4,P2.set_tumor);

SL72_P3.set_ref=SampleRaw(4,P3.set_ref);
SL72_P3.set_data=SampleRaw(4,P3.set_data);
SL72_P3.set_tumor=SampleRaw(4,P3.set_tumor);

save SL72_P1 SL72_P1
save SL72_P2 SL72_P2
save SL72_P3 SL72_P3

%% Load variables if closed
load SL72_P1
load SL72_P2
load SL72_P3


%% Image Reconstruction Settings (specific for this experiment see notes inRSARTx288 )
RecSettings.win=1; % Selects wether a window is present or not
RecSettings.w_sup=10; % window at 10
RecSettings.w_inf=15; %window at 15
RecSettings.speed=2.7e8; %diegospeed 2.7e8
RecSettings.radius=0.285; %DiegoRadius 0.285 in meters
RecSettings.ver=100; % Reconstruction version of algorithm   %%%%%%
RecSettings.Iclims=[0 5e-9];
RecSettings.counterWise=1;   %% this might be wrong, dont know. for this experiment lest leave it like this
RecSettings.fl_low=1e9;
RecSettings.fl_high=8e9;
RecSettings.Bdiam=.14; %diameter of the breast <------ particular f this exp in meters
RecSettings.wflip=0;

if (RecSettings.counterWise==0);
    RecSettings.wflip=1;
end


% Set settings for 72L images
RecSettings.Arrasize=size(SL72_P1.set_ref,2)/2;


%% XX Reconstruct 1 tumor
close all
load SL72_P1
supershort='P1 tumor only';
set(0,'defaultAxesFontName', 'Times New Roman')
set(0,'DefaultAxesFontSize',14)
[SCAN_P1Tumor]=...
    monofun_mario_cmS(SL72_P1.set_ref,SL72_P1.set_tumor,RecSettings,supershort);

save SCAN_SL72_P1_tumor SCAN_P1Tumor
save SCAN_SL72_P1_tumor supershort -append
save SCAN_SL72_P1_tumor RecSettings -append

%% Reconstruct Sampled data
%P1
tic
close all
supershort='P1 sampled at 72 locations ';
[SCAN_72P1]=...
     monofun_mario_cmS(SL72_P1.set_ref,SL72_P1.set_data,RecSettings,supershort);
save SCAN_SL72_P1 SCAN_72P1
save SCAN_SL72_P1 supershort RecSettings -append

toc


%P2
supershort='P2 sampled at 72 locations ';
[SCAN_72P2]=...
     monofun_mario_cmS(SL72_P2.set_ref,SL72_P2.set_data,RecSettings,supershort);
save SCAN_SL72_P2 SCAN_72P2 
save SCAN_SL72_P2 supershort RecSettings -append

%P3
supershort='P3 sampled at 72 locations ';
 [SCAN_72P3]=...
     monofun_mario_cmS(SL72_P3.set_ref,SL72_P3.set_data,RecSettings,supershort);
save SCAN_SL72_P3 SCAN_72P3 
save SCAN_SL72_P3 supershort RecSettings -append
toc




%% 2.- Separate regions of image: Backgorund, Fibro, tumor.
%
% only uses the ref image and tumor images
% separates based on prior knowledge of tumor location.

%% Load images for localization
ITumor=abs(SCAN_P1Tumor.S11_c_RecZoomFlip);
IP1=abs(SCAN_72P1.S11_c_RecZoomFlip);
IP2=abs(SCAN_72P2.S11_c_RecZoomFlip);
IP3=abs(SCAN_72P3.S11_c_RecZoomFlip);

%% Obtain Regions

[Regions.Fibro,Regions.IRefBack,Regions.FExcl,Regions.Tumor,Regions.ITumorBack,Regions.TExcl]=IRegionLocator(ITumor,IP1);

save ExperiemntRegions Regions -append

%% circle region
IClim=5e-5;     %<-
radiusBack=9+3;  %<-

[rr,cc] = meshgrid(1:41);
CircExcl = sqrt((rr-21).^2+(cc-21).^2)<=9+3;
Icanvas=IP1;
figure; 
Icanvas(~CircExcl)=1;
imagesc(Icanvas,[0 IClim]);
%add circle to background
Regions.IRefBack=and(Regions.IRefBack,CircExcl);
Icanvas=IP1;
figure; 
Icanvas(~Regions.IRefBack)=1;
imagesc(Icanvas,[0 IClim]);

%% Add regions sections to ImageMetrics Structures
SCAN_72P1.ImageMetrics.Regions=Regions; 
SCAN_72P2.ImageMetrics.Regions=Regions;
SCAN_72P3.ImageMetrics.Regions=Regions;

% Add names to the image Metrics
SCAN_72P1.ImageMetrics.Name= 'SCAN 72P1';
SCAN_72P2.ImageMetrics.Name= 'SCAN 72P2';
SCAN_72P3.ImageMetrics.Name= 'SCAN 72P3';


%% Save new metrics and regions to the files
save SCAN_SL72_P1 SCAN_72P1 -append
save SCAN_SL72_P2 SCAN_72P2 -append
save SCAN_SL72_P3 SCAN_72P3 -append


%% Display regions localization
IClim=5e-5;
cleanlow=0.5e-5;
figure('name','Regions in IRef Image','Position',[403 106 860 560]);
%Complete image
subplot(3,4,1);

targets=or(Regions.Fibro,Regions.Tumor);
imagesc(IP1,[0 IClim]);
title('SL72 P1')
axis square


%Background
subplot(3,4,2);
Icanvas=IP1;
%Icanvas(~Regions.IRefBack)=cleanlow;
Icanvas(~Regions.IRefBack)=1;
imagesc(Icanvas,[0 IClim]);
title('background (blue)')
axis square


%Exclusion
subplot(3,4,3);
Icanvas=IP1;
Icanvas(~(Regions.TExcl+Regions.FExcl))=cleanlow;
imagesc(Icanvas,[0 IClim]);
title('exclusion zone')
axis square

%Targets only
subplot(3,4,4);
Icanvas=IP1;
Icanvas(~targets)=cleanlow;
imagesc(Icanvas,[0 IClim]);
title('tumor and fibro')
axis square

% new image
subplot(3,4,5);
imagesc(IP2,[0 IClim]);
title('SL72 P2')
axis square

%Background and artifacts
subplot(3,4,6);
Icanvas=IP2;
Icanvas(~Regions.IRefBack)=cleanlow;
Icanvas(~Regions.IRefBack)=1;
imagesc(Icanvas,[0 IClim]);
title('background (blue)')
axis square

%Exclusion
subplot(3,4,7);
Icanvas=IP2;
Icanvas(~(Regions.TExcl+Regions.FExcl))=cleanlow;
imagesc(Icanvas,[0 IClim]);
title('exclusion zone')
axis square

%Targets only
subplot(3,4,8);
Icanvas=IP2;
Icanvas(~targets)=cleanlow;
imagesc(Icanvas,[0 IClim]);
title('tumor and fibro')
axis square


% new image
subplot(3,4,9);
imagesc(IP3,[0 IClim]);
title('SL72 P3')
axis square

%Background and artifacts
subplot(3,4,10);
Icanvas=IP3;
Icanvas(~Regions.IRefBack)=cleanlow;
Icanvas(~Regions.IRefBack)=1;
imagesc(Icanvas,[0 IClim]);
title('background (blue)')
axis square

%Exclusion
subplot(3,4,11);
Icanvas=IP3;
Icanvas(~(Regions.TExcl+Regions.FExcl))=cleanlow;
imagesc(Icanvas,[0 IClim]);
title('exclusion zone')
axis square

%Targets only
subplot(3,4,12);
Icanvas=IP3;
Icanvas(~targets)=cleanlow;
imagesc(Icanvas,[0 IClim]);
title('tumor and fibro')
axis square
supershort_savetitle='structure segmentation for LS72_P1 _P2 and _P3 xMagnitude';
savethisone


%% Show real, phase and abs images
close all
ii=1;
figure; hold on

subplot(2,2,ii); 
imagesc(real(SCAN_72P1.S11_c_RecZoomFlip));
title('Real')
colorbar
axis square

ii=ii+1; 
subplot(2,2,ii);

imagesc(imag(SCAN_72P1.S11_c_RecZoomFlip));
title('Imaginary')
colorbar
axis square

ii=ii+1;
subplot(2,2,ii);
imagesc(abs(SCAN_72P1.S11_c_RecZoomFlip));
title('Magnitude')
colorbar
axis square

ii=ii+1;
subplot(2,2,ii);

imagesc(abs(SCAN_72P1.S11_c_RecZoomFlip).^2);
title('Power')
colorbar
axis square

%supershort_savetitle='Real imaginary magnitude and power of rec image';
%savethisone

%% Curve amp vs curve power
% 
figure; hold on; 
magni=abs(SCAN_72P1.S11_c_RecZoomFlip);
powi=abs(SCAN_72P1.S11_c_RecZoomFlip).^2;
subplot(1,2,1); plot(magni(28,:));
subplot(1,2,2); plot(powi(28,:));
supershort_savetitle='Curve magn vs curve power at max tumor row '
savethisone
%


%% 3. Image Metrics %%
% set colors
ccc_map=colormap;
ccc_tumor=ccc_map(50,:);
ccc_fibro=ccc_map(35,:);
ccc_back=ccc_map(10,:);

%% Introduce Power image metrics
SCAN_72P1.PowImageMetrics=SCAN_72P1.ImageMetrics;
SCAN_72P2.PowImageMetrics=SCAN_72P2.ImageMetrics;
SCAN_72P3.PowImageMetrics=SCAN_72P3.ImageMetrics;


%% CREATE an AVERAGe IMAGE  --- Or use an unsampled one?
PAVE=(abs(SCAN_72P1.S11_c_RecZoomFlip)+abs(SCAN_72P2.S11_c_RecZoomFlip)+abs(SCAN_72P3.S11_c_RecZoomFlip))/3;
figure; imagesc(PAVE); axis square;  supershort_savetitle='P-Average Magnitude'; savethisone;
figure; imagesc(PAVE.^2); axis square; supershort_savetitle='P-Average Power'; savethisone;
Average_SCAN72Rec.PAVE=PAVE;
Average_SCAN72Rec.Name='Mean SL Scans magnitude';
Average_SCAN72Rec.ImageMetrics.Name='Mean SL Scans magnitude';
save Average_SCAN72Rec Average_SCAN72Rec

%% Calculate Standard Metrics for Regions
close all;
tresh_magnitude= 7e-5; % this value might be overrided
[SCAN_72P1.ImageMetrics]=I_RegionStandard(abs(SCAN_72P1.S11_c_RecZoomFlip),Regions,SCAN_72P1.ImageMetrics,tresh_magnitude); supershort_savetitle='P1 meanV per region'; savethisone;
[SCAN_72P2.ImageMetrics]=I_RegionStandard(abs(SCAN_72P2.S11_c_RecZoomFlip),Regions,SCAN_72P2.ImageMetrics,tresh_magnitude); supershort_savetitle='P2 meanV per region'; savethisone;
[SCAN_72P3.ImageMetrics]=I_RegionStandard(abs(SCAN_72P3.S11_c_RecZoomFlip),Regions,SCAN_72P3.ImageMetrics,tresh_magnitude); supershort_savetitle='P3 meanV per region'; savethisone;

%and average
[Average_SCAN72Rec.ImageMetrics]=I_RegionStandard(PAVE,Regions,Average_SCAN72Rec.ImageMetrics,tresh_magnitude); supershort_savetitle='Paverage mean V per region'; savethisone;


%% Plot mean values per scan with +- sd 
close all
figure; hold on
tresh_magnitude= 7e-5; % this value might be overrided

tplot=plot([SCAN_72P1.ImageMetrics.Tumor.Mean,SCAN_72P2.ImageMetrics.Tumor.Mean,SCAN_72P3.ImageMetrics.Tumor.Mean]);
tplot.Color=ccc_tumor;
tplot.LineWidth=1.75;

maxtplot=plot([SCAN_72P1.ImageMetrics.Tumor.Max,SCAN_72P2.ImageMetrics.Tumor.Max,SCAN_72P3.ImageMetrics.Tumor.Max]);
maxtplot.MarkerSize=8;
maxtplot.MarkerEdgeColor='k';
maxtplot.MarkerFaceColor=ccc_tumor+0.05;
maxtplot.LineStyle='none';
maxtplot.Marker='o';

fplot=plot([SCAN_72P1.ImageMetrics.Fibro.Mean,SCAN_72P2.ImageMetrics.Fibro.Mean,SCAN_72P3.ImageMetrics.Fibro.Mean]);
fplot.Color=ccc_fibro;
fplot.LineWidth=1.75;


maxfplot=plot([SCAN_72P1.ImageMetrics.Fibro.Max,SCAN_72P2.ImageMetrics.Fibro.Max,SCAN_72P3.ImageMetrics.Fibro.Max]);
maxfplot.MarkerSize=8;
maxfplot.MarkerEdgeColor='k';
maxfplot.MarkerFaceColor=ccc_fibro-0.05;
maxfplot.LineStyle='none';
maxfplot.Marker='o';


bplot=plot([SCAN_72P1.ImageMetrics.Back.Mean,SCAN_72P2.ImageMetrics.Back.Mean,SCAN_72P3.ImageMetrics.Back.Mean]);
bplot.Color=ccc_back;
bplot.LineWidth=1.75;


errorbar([1,2,3],[SCAN_72P1.ImageMetrics.Tumor.Mean,SCAN_72P2.ImageMetrics.Tumor.Mean,SCAN_72P3.ImageMetrics.Tumor.Mean]...
    ,[SCAN_72P1.ImageMetrics.Tumor.Std,SCAN_72P2.ImageMetrics.Tumor.Std,SCAN_72P3.ImageMetrics.Tumor.Std],'Color', ccc_tumor-0.2 ),hold on;

errorbar([1,2,3],[SCAN_72P1.ImageMetrics.Fibro.Mean,SCAN_72P2.ImageMetrics.Fibro.Mean,SCAN_72P3.ImageMetrics.Fibro.Mean]...
    ,[SCAN_72P1.ImageMetrics.Fibro.Std,SCAN_72P2.ImageMetrics.Fibro.Std,SCAN_72P3.ImageMetrics.Fibro.Std],'Color', ccc_fibro-0.2 ),hold on;

errorbar([1,2,3],[SCAN_72P1.ImageMetrics.Back.Mean,SCAN_72P2.ImageMetrics.Back.Mean,SCAN_72P3.ImageMetrics.Back.Mean]...
    ,[SCAN_72P1.ImageMetrics.Back.Std,SCAN_72P2.ImageMetrics.Back.Std,SCAN_72P3.ImageMetrics.Back.Std],'Color', ccc_back ),hold on;

ylim([0 tresh_magnitude])
xlim([0.25 5.5])

ax = gca;
ax.XTick = [1 2 3];
ax.XTickLabel = {'P1' 'P2' 'P3'};

legend([tplot,maxtplot,fplot,maxfplot,bplot],'Mean tumor','Max tumor','Mean fibro','Max fibro','Mean background')

supershort_savetitle='Plot tumor, fibro and back levels '
savethisone


%% Calculate Standard Metrics for POWER Regions
close all;
tresh_power= 5e-9; % this value might be overrided
[SCAN_72P1.PowImageMetrics]=I_RegionStandard(abs(SCAN_72P1.S11_c_RecZoomFlip).^2,Regions,SCAN_72P1.ImageMetrics,tresh_power); %supershort_savetitle='P1 mean powerV per region'; savethisone;
[SCAN_72P2.PowImageMetrics]=I_RegionStandard(abs(SCAN_72P2.S11_c_RecZoomFlip).^2,Regions,SCAN_72P2.ImageMetrics,tresh_power); %supershort_savetitle='P2 mean powerV per region'; savethisone;
[SCAN_72P3.PowImageMetrics]=I_RegionStandard(abs(SCAN_72P3.S11_c_RecZoomFlip).^2,Regions,SCAN_72P3.ImageMetrics,tresh_power);% supershort_savetitle='P3 mean powerV per region'; savethisone;
[Average_SCAN72Rec.PowImageMetrics]=I_RegionStandard(Average_SCAN72Rec.PAVE.^2,Regions,Average_SCAN72Rec.ImageMetrics,tresh_power); %supershort_savetitle='Paverage mean V per region'; savethisone;


%% Plot mean values per scan with +- sd  for POWER
close all
figure; hold on
tresh_magnitude= 5e-9; % this value might be overrided

tplot=plot([SCAN_72P1.PowImageMetrics.Tumor.Mean,SCAN_72P2.PowImageMetrics.Tumor.Mean,SCAN_72P3.PowImageMetrics.Tumor.Mean]);
tplot.Color=ccc_tumor;
tplot.LineWidth=1.75;

maxtplot=plot([SCAN_72P1.PowImageMetrics.Tumor.Max,SCAN_72P2.PowImageMetrics.Tumor.Max,SCAN_72P3.PowImageMetrics.Tumor.Max]);
maxtplot.MarkerSize=8;
maxtplot.MarkerEdgeColor='k';
maxtplot.MarkerFaceColor=ccc_tumor+0.05;
maxtplot.LineStyle='none';
maxtplot.Marker='o';


fplot=plot([SCAN_72P1.PowImageMetrics.Fibro.Mean,SCAN_72P2.PowImageMetrics.Fibro.Mean,SCAN_72P3.PowImageMetrics.Fibro.Mean]);
fplot.Color=ccc_fibro;
fplot.LineWidth=1.75;

maxfplot=plot([SCAN_72P1.PowImageMetrics.Fibro.Max,SCAN_72P2.PowImageMetrics.Fibro.Max,SCAN_72P3.PowImageMetrics.Fibro.Max]);
maxfplot.MarkerSize=8;
maxfplot.MarkerEdgeColor='k';
maxfplot.MarkerFaceColor=ccc_fibro-0.05;
maxfplot.LineStyle='none';
maxfplot.Marker='o';

bplot=plot([SCAN_72P1.PowImageMetrics.Back.Mean,SCAN_72P2.PowImageMetrics.Back.Mean,SCAN_72P3.PowImageMetrics.Back.Mean]);
bplot.Color=ccc_back;
bplot.LineWidth=1.75;




errorbar([1,2,3],[SCAN_72P1.PowImageMetrics.Tumor.Mean,SCAN_72P2.PowImageMetrics.Tumor.Mean,SCAN_72P3.PowImageMetrics.Tumor.Mean]...
    ,[SCAN_72P1.PowImageMetrics.Tumor.Std,SCAN_72P2.PowImageMetrics.Tumor.Std,SCAN_72P3.PowImageMetrics.Tumor.Std],'Color', ccc_tumor-0.2 ),hold on;

errorbar([1,2,3],[SCAN_72P1.PowImageMetrics.Fibro.Mean,SCAN_72P2.PowImageMetrics.Fibro.Mean,SCAN_72P3.PowImageMetrics.Fibro.Mean]...
    ,[SCAN_72P1.PowImageMetrics.Fibro.Std,SCAN_72P2.PowImageMetrics.Fibro.Std,SCAN_72P3.PowImageMetrics.Fibro.Std],'Color', ccc_fibro-0.2 ),hold on;

errorbar([1,2,3],[SCAN_72P1.PowImageMetrics.Back.Mean,SCAN_72P2.PowImageMetrics.Back.Mean,SCAN_72P3.PowImageMetrics.Back.Mean]...
    ,[SCAN_72P1.PowImageMetrics.Back.Std,SCAN_72P2.PowImageMetrics.Back.Std,SCAN_72P3.PowImageMetrics.Back.Std],'Color', ccc_back ),hold on;

ylim([0 tresh_magnitude])
xlim([0.25 5.5])

ax = gca;
ax.XTick = [1 2 3];
ax.XTickLabel = {'P1' 'P2' 'P3'};

legend([tplot,maxtplot,fplot,maxfplot,bplot],'Mean tumor','Max tumor','Mean fibro','Max fibro','Mean background')

supershort_savetitle='Plot tumor, fibro and back power levels '
savethisone

%% %% Boxplot region values  
close all;
[SCAN_72P1.ImageMetrics]=I_RegionBoxplot(abs(SCAN_72P1.S11_c_RecZoomFlip),Regions,SCAN_72P1.ImageMetrics); title('P1'); supershort_savetitle='P1 boxplot per region'; savethisone;
[SCAN_72P2.ImageMetrics]=I_RegionBoxplot(abs(SCAN_72P2.S11_c_RecZoomFlip),Regions,SCAN_72P2.ImageMetrics); title('P2'); supershort_savetitle='P2 boxplot per region'; savethisone;
[SCAN_72P3.ImageMetrics]=I_RegionBoxplot(abs(SCAN_72P3.S11_c_RecZoomFlip),Regions,SCAN_72P3.ImageMetrics); title('P3'); supershort_savetitle='P3 boxplot per region'; savethisone;

%% %% Boxplot region values  power
close all;
[SCAN_72P1.PowImageMetrics]=I_RegionBoxplot(abs(SCAN_72P1.S11_c_RecZoomFlip).^2,Regions,SCAN_72P1.PowImageMetrics); title('P1 Power'); supershort_savetitle='P1 boxplot per region Power'; savethisone;
[SCAN_72P2.PowImageMetrics]=I_RegionBoxplot(abs(SCAN_72P2.S11_c_RecZoomFlip).^2,Regions,SCAN_72P2.PowImageMetrics); title('P2 Power'); supershort_savetitle='P2 boxplot per region Power'; savethisone;
[SCAN_72P3.PowImageMetrics]=I_RegionBoxplot(abs(SCAN_72P3.S11_c_RecZoomFlip).^2,Regions,SCAN_72P3.PowImageMetrics); title('P3 Power'); supershort_savetitle='P3 boxplot per region Power'; savethisone;

%% Save so far to the files
save SCAN_SL72_P1 SCAN_72P1 -append
save SCAN_SL72_P2 SCAN_72P2 -append
save SCAN_SL72_P3 SCAN_72P3 -append
save Average_SCAN72Rec Average_SCAN72Rec -append



%% C Standard Image quality metrics/difference metrics.  
close all;


[SCAN_72P1.ImageMetrics,PAverageStruct]=IQ_Standard(abs(SCAN_72P1.S11_c_RecZoomFlip),Average_SCAN72Rec,SCAN_72P1.ImageMetrics,PAverageStruct); % Same, just saved in both Metric Files
supershort_savetitle='P1 SSIM vs Average'; savethisone;

[SCAN_72P2.ImageMetrics,PAverageStruct]=IQ_Standard(abs(SCAN_72P2.S11_c_RecZoomFlip),Average_SCAN72Rec,SCAN_72P2.ImageMetrics,PAverageStruct); % Same, just saved in both Metric Files
supershort_savetitle='P2 SSIM vs Average'; savethisone;

[SCAN_72P3.ImageMetrics,PAverageStruct]=IQ_Standard(abs(SCAN_72P3.S11_c_RecZoomFlip),Average_SCAN72Rec,SCAN_72P3.ImageMetrics,PAverageStruct); % Same, just saved in both Metric Files
supershort_savetitle='P3 SSIM vs Average'; savethisone;

%%
%%%%%% Here I remember that  (abs(SCAN_72P1.S11_c_RecZoomFlip) == IP1




%% PODER Standard Image quality metrics/difference metrics.  
close all;
PAverageStruct.Name='Mean SL Scans';

[SCAN_72P1.PowImageMetrics,PAverageStruct]=IQ_Standard(IP1.^2,Average_SCAN72Rec.^2,SCAN_72P1.PowImageMetrics,PAverageStruct); % Same, just saved in both Metric Files
supershort_savetitle='P1 SSIM vs Average POWERS'; savethisone;

[SCAN_72P2.PowImageMetrics,PAverageStruct]=IQ_Standard(IP2.^2,Average_SCAN72Rec.^2,SCAN_72P2.PowImageMetrics,PAverageStruct); % Same, just saved in both Metric Files
supershort_savetitle='P2 SSIM vs Average POWERS'; savethisone;

[SCAN_72P3.PowImageMetrics,PAverageStruct]=IQ_Standard(IP3.^2,Average_SCAN72Rec.^2,SCAN_72P3.PowImageMetrics,PAverageStruct); % Same, just saved in both Metric Files
supershort_savetitle='P3 SSIM vs Average POWERS'; savethisone;



%% 5 Caculate Radar Metrics
%% a) Signal [tumor] to Clutter Ratio for Magnitude

[Average_SCAN72Rec.ImageMetrics]=I_ScR(Average_SCAN72Rec.ImageMetrics); 
[SCAN_72P1.ImageMetrics]=I_ScR(SCAN_72P1.ImageMetrics);
[SCAN_72P2.ImageMetrics]=I_ScR(SCAN_72P2.ImageMetrics);
[SCAN_72P3.ImageMetrics]=I_ScR(SCAN_72P3.ImageMetrics);

%% b) tumor [tumor] to FibroGlandular Ratio 

[Average_SCAN72Rec.ImageMetrics]=I_TfR(Average_SCAN72Rec.ImageMetrics); 
[SCAN_72P1.ImageMetrics]=I_TfR(SCAN_72P1.ImageMetrics);
[SCAN_72P2.ImageMetrics]=I_TfR(SCAN_72P2.ImageMetrics);
[SCAN_72P3.ImageMetrics]=I_TfR(SCAN_72P3.ImageMetrics);

%% c) Contrast [tumor- fibro] to Clutter Ratio 

[Average_SCAN72Rec.ImageMetrics]=I_CtfCR(Average_SCAN72Rec.ImageMetrics); 
[SCAN_72P1.ImageMetrics]=I_CtfCR(SCAN_72P1.ImageMetrics);
[SCAN_72P2.ImageMetrics]=I_CtfCR(SCAN_72P2.ImageMetrics);
[SCAN_72P3.ImageMetrics]=I_CtfCR(SCAN_72P3.ImageMetrics);

%% Save so far to the files
save SCAN_SL72_P1 SCAN_72P1 -append
save SCAN_SL72_P2 SCAN_72P2 -append
save SCAN_SL72_P3 SCAN_72P3 -append
save Average_SCAN72Rec Average_SCAN72Rec -append

%% Load P values
load SCAN_SL72_P1 
load SCAN_SL72_P2 
load SCAN_SL72_P3 
load Average_SCAN72Rec 

%% Save excel files
estructExceler(Average_SCAN72Rec.ImageMetrics.q0all,'PAverage-excel IQM')
estructExceler(SCAN_72P1.ImageMetrics.q0all,'P1-excel IQM')
estructExceler(SCAN_72P2.ImageMetrics.q0all,'P2-excel IQM')
estructExceler(SCAN_72P3.ImageMetrics.q0all,'P3-excel IQM')

%% Create summary files
[Average_SCAN72Rec.ImageMetrics]=eSummaryMaker(Average_SCAN72Rec.ImageMetrics); 
[SCAN_72P1.ImageMetrics]=eSummaryMaker(SCAN_72P1.ImageMetrics);
[SCAN_72P2.ImageMetrics]=eSummaryMaker(SCAN_72P2.ImageMetrics);
[SCAN_72P3.ImageMetrics]=eSummaryMaker(SCAN_72P3.ImageMetrics);

%% Create summary files POWER
[Average_SCAN72Rec.PowImageMetrics]=eSummaryMaker(Average_SCAN72Rec.PowImageMetrics); 
[SCAN_72P1.PowImageMetrics]=eSummaryMaker(SCAN_72P1.PowImageMetrics);
[SCAN_72P2.PowImageMetrics]=eSummaryMaker(SCAN_72P2.PowImageMetrics);
[SCAN_72P3.PowImageMetrics]=eSummaryMaker(SCAN_72P3.PowImageMetrics);


%% Save excel files
estructExceler(Average_SCAN72Rec.ImageMetrics.eSummary,'PAverage-excel Summary_mag')
estructExceler(SCAN_72P1.ImageMetrics.eSummary,'P1-excel summary_mag')
estructExceler(SCAN_72P2.ImageMetrics.eSummary,'P2-excel summary_mag')
estructExceler(SCAN_72P3.ImageMetrics.eSummary,'P3-excel summary_mag')

estructExceler(Average_SCAN72Rec.PowImageMetrics.eSummary,'PAverage-excel Summary_pow')
estructExceler(SCAN_72P1.PowImageMetrics.eSummary,'P1-excel Summary_pow')
estructExceler(SCAN_72P2.PowImageMetrics.eSummary,'P2-excel Summary_pow')
estructExceler(SCAN_72P3.PowImageMetrics.eSummary,'P3-excel Summary_pow')


%% Save so far to the files
save Regions
save SCAN_SL72_P1 SCAN_72P1 -append
save SCAN_SL72_P2 SCAN_72P2 -append
save SCAN_SL72_P3 SCAN_72P3 -append
save Average_SCAN72Rec Average_SCAN72Rec -append

%% Figure with Plot things

ScR_v=[SCAN_72P1.PowImageMetrics.q0all.ScR_M,SCAN_72P2.PowImageMetrics.q0all.ScR_M,SCAN_72P3.PowImageMetrics.q0all.ScR_M];
TfR_v=[SCAN_72P1.PowImageMetrics.q0all.TfR_M,SCAN_72P2.PowImageMetrics.q0all.TfR_M,SCAN_72P3.PowImageMetrics.q0all.TfR_M];
CcR_v=[SCAN_72P1.PowImageMetrics.q0all.CcR_M,SCAN_72P2.PowImageMetrics.q0all.CcR_M,SCAN_72P3.PowImageMetrics.q0all.CcR_M];

%%
x1=[1,2,3];
figure; hold on; plot(x1,ScR_v,x1,TfR_v,x1,CcR_v);
%hide labels and title


%% Print it
xlabel('');ylabel('');title('');


axes1=gca;
set(gca,...
    'TickLength',[0.02 0.02],... 
    'Layer','top',...
    'FontSize',18,...
    'FontName','Times New Roman');
%axis square
%   'Position',[0.13 0.11 0.789514884233738 0.815],
%colorbar('peer',axes1,'FontSize',16,'FontName','Times New Roman');
%set(gcf,'PaperPositionMode', 'auto');
set(gcf, 'Units', 'centimeters');
%set(gcf, 'Position', [0 0 11 9]); %x_width=10cm y_width=15cm
export_fig('-png','-transparent','-nocrop','figuring Ploteado IQM') % '-r300'


%% Lean  file maker
cd('F:\UserElGuapo\DBOx\Dropbox\ResearchMagic\RandomProyects\160110 12 Effects of AR\MASTER Dataset\Control Scans')
load SCAN_SL72_P1.mat

load SCAN_SL72_P2.mat
load SCAN_SL72_P3.mat



cSET_SL72_L.SCAN_SL72_P1.ImageMetrics=SCAN_72P1.ImageMetrics;   
cSET_SL72_L.SCAN_SL72_P1.PowMetrics=SCAN_72P1.PowImageMetrics;

cSET_SL72_L.SCAN_SL72_P2.ImageMetrics=SCAN_72P2.ImageMetrics;   
cSET_SL72_L.SCAN_SL72_P2.PowMetrics=SCAN_72P2.PowImageMetrics;

cSET_SL72_L.SCAN_SL72_P3.ImageMetrics=SCAN_72P3.ImageMetrics;   
cSET_SL72_L.SCAN_SL72_P3.PowMetrics=SCAN_72P3.PowImageMetrics;

save ControlSet_Lean_MetricsOnly cSET_SL72_L


%% Group Summary maker

[controlSummaryError]=ContolSet_table(cSET_SL72_L);

save ControlSummaryErrorinCcR controlSummaryError


%% Plot MSEB graph with IQM with CO from 3 samples



graph_IQM_error_v=repmat([  controlSummaryError.table3exp.ScR_3exp_CI;...
                            controlSummaryError.table3exp.TfR_3exp_CI;...
                            controlSummaryError.table3exp.CcR_3exp_CI],1,3);
                        
graph_IQM_mean_v=repmat([   controlSummaryError.table3exp.ScR_3exp_mean;...
                            controlSummaryError.table3exp.TfR_3exp_mean;...
                            controlSummaryError.table3exp.CcR_3exp_mean],1,3);

x1=[0,2,4];
mulineprops.style=':';
mulineprops.width=1;
figure; hold on; mseb(x1,graph_IQM_mean_v,graph_IQM_error_v,mulineprops,1);


% define indivual value to plot in curve
ScR_v=controlSummaryError.GroupTable.IQ_ScR_M;
TfR_v=controlSummaryError.GroupTable.IQ_TfR_M;
CcR_v=controlSummaryError.GroupTable.IQ_CcR_M;
%{
laline.style='o--';
x1=[1,2,3];
h=mseb(x1,[ScR_v;TfR_v;CcR_v],zeros(3,3),laline,1);
l1=legend([h.mainLine],'ScR','TfR','CcR','Location','Best');
set(l1,...
    'Position',[0.40 0.25 0.25 0.15]); %
%}

title('IQM Invidiual experiments values over average and CI')



% Define labels on x axis
ax = gca;
set(ax,'XTick', [1 2 3]);
set(ax,'XTickLabel',{'CS 1' 'CS 2' 'CS 3'});
%
%% hide labels and title
%
xlim([0.5,3.5])
ylabel('dB')
title('')
savethisone('IQM with CI uncertainties from 3 samples')



