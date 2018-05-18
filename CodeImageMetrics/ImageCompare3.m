%Image Compare 3 calculate all the required image metrics that I need.
%Mario©
%
%Notes
%> to mario: Im pretty sure you dont need to do 20log since all the
%imageRec files you have already stored them in power mode
% > review the code that we had in the GUI 

% 1.- Load Original and New Image
% 
% 2.- Separate regions of image: Backgorund, Fibro, tumor.
% 2.b.- Eliminate penumbra
% 
% 3.- Calculate image difference metrics
% a MSE
% b PSE
% c PSNR
% e SSIM
% 
% 
% 4.- Calculate Region specific metrics
% a Average
% b Max
% c Min
% d Std
% e Generate table and graphs if needed
%  
%5.- Calculate Radar metrics
% a ScR
% b TfR
% c CnR
%
% 6- Save table and files

close all

%% 1.- Load Original and New Image

IClim=2.91E-9;
%Guaper
cd('F:\UserElGuapo\DBOx\Dropbox\ResearchMagic\RandomProyects\160110 12 Effects of AR\12_0 Prelude calculate SNR\12_0a\SampletumorData')

%CAD
%cd('C:\Users\El Mario\Documents\DopboxMyAcount\Dropbox\ResearchMagic\RandomProyects\160110 12 Effects of AR\12_0 Prelude calculate SNR\12_0a\SampletumorData')

%Inf
%cd('C:\Users\Mario\Dropbox\ResearchMagic\RandomProyects\160110 12 Effects of AR\12_0 Prelude calculate SNR\12_0a\SampletumorData')


load SF_SampledTarget.mat;
load SPE.mat;

RawWinRef=SF.Com.Win;
IRef=SF.Com.Rec;
INew=SPE.E12.Rec;
ITumor=SF.Tumor.Rec;

New_ImageMetrics.Name= 'SPE 15\circ Error Metrics';
Ref_ImageMetrics.Name= 'Original Image';

%figure; imagesc(IRef);
%title('Ref')

figure; imagesc(ITumor);
title('Tumor')

%% 2.- Separate regions of image: Backgorund, Fibro, tumor.
%
% only uses the ref image and tumor images
% separates based on prior knowledge of tumor location.

%Obtain Tumor Position
[Regions.Fibro,Regions.IRefBack,Regions.FExcl,Regions.Tumor,Regions.ITumorBack,Regions.TExcl]=IRegionLocator(ITumor,IRef);
Ref_ImageMetrics.Regions=Regions;
New_ImageMetrics.Regions=Regions;


%% Display regions localization
figure('name','Regions in IRef Image','Position',[403 106 860 560]);
%Complete image
subplot(2,4,1);
imagesc(IRef,[0 IClim]);
title('reference image')
axis square


%Background
subplot(2,4,2);
Icanvas=IRef;
Icanvas(~Regions.IRefBack)=0.05E-9;
imagesc(Icanvas,[0 IClim]);
title('background')
axis square


%Exclusion
subplot(2,4,3);
Icanvas=IRef;
c=or(Regions.Fibro,Regions.Tumor);
Icanvas(c)=0.05E-9;
Icanvas(Regions.IRefBack)=0.05E-9;
imagesc(Icanvas,[0 IClim]);
title('Exclusion')
axis square

%Targets only
subplot(2,4,4);
Icanvas=IRef;
Icanvas(~c)=0.05E-9;
imagesc(Icanvas,[0 IClim]);
title('tumor and fibro')
axis square

% new image
subplot(2,4,5);
imagesc(INew,[0 IClim]);
title('New image')
axis square

%Background and artifacts
subplot(2,4,6);
Icanvas=INew;
Icanvas(~Regions.IRefBack)=0.05E-9;
imagesc(Icanvas,[0 IClim]);
title('background + artifacts')
axis square

%Exclusion
subplot(2,4,7);
Icanvas=INew;
Icanvas(c)=0.05E-9;
Icanvas(Regions.IRefBack)=0.05E-9;
imagesc(Icanvas,[0 IClim]);
title('Exclusion')
axis square

%Targets only
subplot(2,4,8);
Icanvas=INew;
Icanvas(~c)=0.05E-9;
imagesc(Icanvas,[0 IClim]);
title('tumor and fibro')
axis square

%set(h,'position',[0.25 0.585  0.35 0.35])
% set(gca, 'XColor', [0.1 1 1]);
% set(gca, 'YColor', [0.2 0.2 0.1]);
% set(gca,'FontName','Helvetica','Fontsize',10,'XColor','k')

%% 3.- Calculate Standard Metrics for Regions
[Ref_ImageMetrics]=I_RegionStandard(IRef,Regions,Ref_ImageMetrics);
[New_ImageMetrics]=I_RegionStandard(INew,Regions,New_ImageMetrics);

%% Boxplot region values 
[Ref_ImageMetrics]=I_RegionBoxplot(IRef,Regions,Ref_ImageMetrics);
[New_ImageMetrics]=I_RegionBoxplot(INew,Regions,New_ImageMetrics);

%% 4.- Standar Image quality/difference metrics.  
[New_ImageMetrics,Ref_ImageMetrics]=IQ_Standard(INew,IRef,New_ImageMetrics,Ref_ImageMetrics); % Same, just saved in both Metric Files

%% 5 Caculate Radar Metrics
%% a) Signal [tumor] to Clutter Ratio 
[Ref_ImageMetrics]=I_ScR(Ref_ImageMetrics);
[New_ImageMetrics]=I_ScR(New_ImageMetrics);

%% b) tumor [tumor] to FibroGlandular Ratio 
[Ref_ImageMetrics]=I_TfR(Ref_ImageMetrics);
[New_ImageMetrics]=I_TfR(New_ImageMetrics);

%% c) Contrast [tumor- fibro] to Clutter Ratio 
[Ref_ImageMetrics]=I_CtfCR(Ref_ImageMetrics);
[New_ImageMetrics]=I_CtfCR(New_ImageMetrics);


%% Display values

disp(New_ImageMetrics.IQ.MSE)
disp(Ref_ImageMetrics.IQ.MSE)



% 
% [Pos.Tumor,Pos.TExcl,Pos.TBack]=ITumorLocator2(ITumor,IRef);
% 
% Obtain Fibro Positon
% [Pos.Fibro,Pos.FExcl,Pos.FBack]=IFibroLocator2(ITumor,IRef);


%{
%Check workspace for variables, else opens a uigetfile dialog box
% if ~exist('IRef','var')
%     [FileName,PathName,FilterIndex] = uigetfile('*.txt','Select ORIGINAL image');
% end
% 
% 
% if ~exist('INew','var')
% [FileName,PathName,FilterIndex] = uigetfile('*.txt','Select NEW or IE image');
% end
%} 