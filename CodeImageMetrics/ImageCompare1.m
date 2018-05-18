%Image Compare 1 helps analyze reconstructed Images
%
%>>>
%



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
