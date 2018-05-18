function [INoiseMetrics]=IQ_Standard(INoise,IRef,INoiseMetrics,IRefMetrics)
%Image Quality Metrics, standard 
%[INoiseMetrics]=IQ_Standard(INoise,IRef,INoiseMetrics,IRefMetrics)

%originalImage= (IRef);
%noisyImage= (INoise); 
%noise = double(noisyImage) - double(originalImage); % assume additive noise

IMetrics.IQ.Label= ['Image difference between ' INoiseMetrics.Name ' and ' IRefMetrics.Name]; 

%% Quality metrics based on Matlab Code
[IMetrics.IQ.PSNR.PSNR_Matlab, IMetrics.IQ.SNR.SNR_Matlab] = psnr(INoise, IRef);

try

IMetrics.IQ.MSE.MSE_Matlab = immse(INoise,IRef);
MeanSE=IMetrics.IQ.MSE.MSE_Matlab;
catch err
    IMetrics.IQ.MSE.MSE_MatlabInternal=images.internal.mse(INoise,IRef);
    MeanSE=IMetrics.IQ.MSE.MSE_MatlabInternal;
end
IMetrics.IQ.RMSE.RMSE_Matlab= sqrt(MeanSE);
[IMetrics.IQ.SSIM.SSIM_Matlab,IMetrics.IQ.SSIM.SSIMmap]=ssim(mat2gray(INoise),mat2gray(IRef)); %% Only accepts grayscale images

%Prin the SSIm difference
 %fprintf('The SSIM value is %0.4f.\n',IMetrics.IQ.SSIM.SSIM_Matlab);
 figure, h=imshow(IMetrics.IQ.SSIM.SSIMmap,[],'InitialMagnification', 800); 
  title(sprintf('SSIM Index Map - Mean SSIM Value is %0.4f',IMetrics.IQ.SSIM.SSIM_Matlab));

%% Quality metrics based on Michael Chan Code

% 1. Mean squared error, MSE 
% 2. Root Mean squared error, RMSE 
% 3. Peak signal to signal noise ratio, PSNR 
% (NOt) Mean absolute error, MAE (NOT)
% 5. Signal to signal noise ratio, SNR 
% 6. Universal Image Quality Index 
% (NOt) Enhancement Measurement Error, EME (NOT)
% 8. Pearson Correlation Coefficient

IMetrics.IQ.MSE.MSE_Chan=meanAbsoluteError(IRef, INoise);
IMetrics.IQ.RMSE_Chan=RMSE2(IRef, INoise);
IMetrics.IQ.PSNR.PSNR_Chan=PSNR(IRef, INoise);

IMetrics.IQ.SNR.SNR_Chan = SNR(IRef, (double(INoise) - double(IRef)));
IMetrics.IQ.IQI.IQI_Chan=imageQualityIndex(IRef, INoise);

IMetrics.IQ.PCC.PCC_Chan=compute_PearsonCorrelationCoefficient(IRef, INoise);

%% Save to Ref and New Metrics structures
INoiseMetrics.IQ=IMetrics.IQ;


  







