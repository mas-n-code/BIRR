%Image Compare 2 helps analyze reconstructed Images using Pattern offset
%Mario©
%
%>>>
%

%% Load Rod distance examples
close all; 

%@Guaper
 cd('F:\UserElGuapo\Google Drive\\MarioProject2\160208 DistanceCal') %Guaper

%CAD
%cd('C:\Users\El Mario\Google Drive\MarioProject2\160208 DistanceCal');

load('D1 11 RecImage.mat')
D1_Rec=S11_Reconstructed;
load('D3 53 RecImage.mat')
D3_Rec=S11_Reconstructed;



Fig1=figure; fig_c=4; fig_r=2; fig_in=0;




%% Determine Edges
edge_index=2;
% D1
iclim=[0 6.2e-05];
fig_in=fig_in+1;subplot(fig_r,fig_c,fig_in); imagesc(D1_Rec,iclim) 
title('Distance 1')



D1FWHM=IFWHM(D1_Rec);
D1Edge=IEdge_Locator(D1_Rec,edge_index);
D1Back=~(D1FWHM+D1Edge);


D1_Canvas=zeros(size(D1_Rec));
D1_Canvas(D1FWHM)=4;
D1_Canvas(D1Edge)=3;
D1_Canvas(D1Back)=2;
figure(Fig1)
fig_in=fig_in+1;subplot(fig_r,fig_c,fig_in);imagesc(D1_Canvas) 
title('D1 Segments')

D1_Sharp=D1_Rec;
D1_Sharp(D1Edge)=mean(mean(D1_Rec(D1Back)));

D1_Pen=D1_Rec;
D1_Pen(D1FWHM)=mean(mean(D1_Rec(D1Back)));
fig_in=fig_in+1;subplot(fig_r,fig_c,fig_in);imagesc(D1_Pen,iclim) 
title('D1 Pen')


D1_BackOnly=D1_Rec;
D1_BackOnly(~D1Back)=mean(mean(D1_Rec(D1Back)));
fig_in=fig_in+1;subplot(fig_r,fig_c,fig_in);imagesc(D1_BackOnly,iclim)
title('D1 Back + Artifacts')


% D3
D3_Rec(4,4)=7e-6;

iclim=[0 1e-5];
fig_in=fig_in+1;subplot(fig_r,fig_c,fig_in);imagesc(D3_Rec,iclim); 
title('Distance 3')

D3FWHM=IFWHM(D3_Rec);
D3Edge=IEdge_Locator(D3_Rec,edge_index);
D3Back=~(D3FWHM+D3Edge);


D3_Canvas=zeros(size(D3_Rec));

D3_Canvas(D3Edge)=3;
D3_Canvas(D3Back)=2;
D3_Canvas(D3FWHM)=4;

figure(Fig1)
fig_in=fig_in+1;subplot(fig_r,fig_c,fig_in);imagesc(D3_Canvas) 
title('D3 Segments')

D3_Sharp=D3_Rec;
D3_Sharp(D3Edge)=mean(mean(D3_Rec(D3Back)));
D3_Sharp(D3Back)=mean(mean(D3_Rec(D3Back)));

D3_Pen=D3_Rec;
D3_Pen(D3FWHM)=mean(mean(D3_Rec(D3Back)));
D3_Pen(D3Back)=mean(mean(D3_Rec(D3Back)));
fig_in=fig_in+1;subplot(fig_r,fig_c,fig_in);imagesc(D3_Pen,iclim) 
title('D3 Pen')

D3_BackOnly=D3_Rec;
D3_BackOnly(~D3Back)=mean(mean(D3_Rec(D3Back)));
fig_in=fig_in+1;subplot(fig_r,fig_c,fig_in);imagesc(D3_BackOnly,iclim) 
title('D1 Back + Artifacts')

%{ 



%% Load Ref-ginal and New-Image and tumor mage

%@ Inferno
%cd('C:\Users\Mario\Dropbox\ResearchMagic\RandomProyects\160110 12 Effects of AR\12_0 Prelude calculate SNR\12_0a\SampletumorData')

%@ Guaper
cd('F:\UserElGuapo\DBOx\Dropbox\ResearchMagic\RandomProyects\160110 12 Effects of AR\12_0 Prelude calculate SNR\12_0a\SampletumorData')

load SF_SampledTarget.mat;
load SPE.mat;

IRef=SF.Com.Rec;
INew=SPE.E12.Rec;

ITumor=SF.Tumor.Rec;

NewMetrics.Name= 'SPE 15\circ Error Metrics';
RefMetrics.Name= 'Original Image';


IEdge_Locator(ITumor);

%% Element Localization
%Obtain Tumor Position
[Pos.Tumor,Pos.TExcl,Pos.TBack]=ITumorLocator(ITumor,IRef);

%Obtain Fibro Positon
[Pos.Fibro,Pos.FExcl,Pos.FBack]=IFibroLocator(ITumor,IRef);

%% 1st Metric: Standard IQM  %NEEDS REVIEW
[NewMetrics]=IQ_Standard(INew,IRef,NewMetrics);



%% 2nd Metric: Signla [tumor] to Clutter Ratio

[RefMetrics]=I_ScR(IRef,Pos,RefMetrics);
[NewMetrics]=I_ScR(INew,Pos,NewMetrics);

%% 3rd Metric: Tumor to Fibroglandular Ratio 


%% 4t Metric: Contrast to Clutter Ration
%% Display Metrics

disp(NewMetrics)
disp(RefMetrics)
%{
 [IMetrics.PeakSnr, IMetrics.snr] = psnr(INoise, IRef);
  IMetrics.mse = immse(INoise,IRef);
  IMetrics.rmseMario= sqrt(IMetrics.mse);
% second source  
  
originalImage= double(IRef);
noisyImage= double(INoise); 
IMetrics.PeakSnr2=PSNR(originalImage, noisyImage);
IMetrics.mse2=meanAbsoluteError(originalImage, noisyImage);
IMetrics.RMSE=RMSE2(originalImage, noisyImage);
IMetrics.IQI=imageQualityIndex(originalImage, noisyImage);
IMetrics.PCC=compute_PearsonCorrelationCoefficient(originalImage, noisyImage);

noise = double(noisyImage) - double(originalImage); % assume additive noise

IMetrics.snr_power = SNR(originalImage, noise)

  
  %}

%% Sampler
%   ref = imread('pout.tif');
%   A = imnoise(ref,'salt & pepper', 0.12);
  
%{

ref=SF.Rec;
A=SPE.E12.Rec;
figure;
   subplot(1,2,1), imagesc(ref);
   subplot(1,2,2), imagesc(A);
   
  [peaksnr, snr] = psnr(A, ref);
  err = images.internal.mse(A,ref);
    
  fprintf('\n The Peak-SNR value is %0.4f', peaksnr);
  fprintf('\n The SNR value is %0.4f \n', snr);
  fprintf('\n The MSE value is %0.4f \n', err);


%

err = images.internal.mse(A,ref);

peaksnr = 10*log10(peakval.^2/err);

if nargout > 1
    if isinteger(ref)  
        ref = double(ref);
    end                      
    snr = 10*log10(mean(ref(:).^2)/err);
psnr

ssim


% ref = imread('pout.tif');
%  H = fspecial('Gaussian',[15 15],18.5);
%  A = imfilter(ref,H,'replicate');

  subplot(1,2,1); imagesc(ref); title('Reference Image');
  subplot(1,2,2); imagesc(A);   title('Blurred Image');

  [ssimval, ssimmap] = ssim(A,ref);

  fprintf('The SSIM value is %0.4f.\n',ssimval);

  figure, imshow(ssimmap,[]);
  title(sprintf('SSIM Index Map - Mean SSIM Value is %0.4f',ssimval));
%}
%% Generate Image A


%% Generate

%%Image Quality Calculator
% A1: B-Oriented 
% Load B Image 
% Detect HM FW of tumor energy; save location;
% Detect Tumor Max signal, Tumor mean, Tumor Std
% 

%}

figure;
subplot(1,4,1)
plot(D3_Rec(23,:))
ylim([0 9e-6]);

subplot(1,4,2)
plot(D3_Sharp(23,:))
ylim([0 9e-6]);

subplot(1,4,3)
plot(D3_Pen(23,:))
ylim([0 9e-6]);

subplot(1,4,4)
plot(D3_BackOnly(23,:))
ylim([0 9e-6]);

figure; hold on
plot(D3_Rec(23,:),'.-')
plot(D3_Sharp(23,:))
plot(D3_Pen(23,:))
plot(D3_BackOnly(23,:))


