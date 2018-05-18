function [ImageMetrics]=I_CtfCR(ImageMetrics)
%Contrast tumor-fibroglandular to clutter ratio  [CtfCR] V1.00
%1.0
%Previous version were calculating power wrong.
%must be 10*log.
% added abs value to formula of CcR


%[CtfCR] V0.30
% Mean clutter
% Save to q0three of them


%Contrast to Clutter Ratio [SNR] V0.23
% Flies and 20*log
%[ImageMetrics]=I_ScR(INew,Pos);

%Average of Half Maximum Elements from Tumor response
S_Tumor=ImageMetrics.Tumor.Mean;
S_Tumor_Max=ImageMetrics.Tumor.Max;
%Average of Half Maximum Elements from FibroG response
S_Fibro=ImageMetrics.Fibro.Mean;
S_Fibro_Max=ImageMetrics.Fibro.Max;

% Background
S_Back_sigma=ImageMetrics.Back.Std;
S_Back=ImageMetrics.Back.Mean;

%Tumor to Fibroglandular Ratio 
ImageMetrics.q3CtfCR.CcR_M=10*log10(abs(S_Tumor^2-S_Fibro^2)/S_Back^2); %ups these were wrong, I was doing 20*log(x-y)
ImageMetrics.q3CtfCR.CcR_DF=10*log10((S_Tumor_Max^2-S_Fibro_Max^2)/S_Back_sigma^2);  %ups these were wrong

ImageMetrics.q3CtfCR.T_Signal=S_Tumor;
ImageMetrics.q3CtfCR.T_Signal_max=S_Tumor_Max;
ImageMetrics.q3CtfCR.Theta_Fibro=S_Fibro;
ImageMetrics.q3CtfCR.Theta_Fibro_max=S_Fibro_Max;
ImageMetrics.q3CtfCR.Sigma_Back=S_Back_sigma;

ImageMetrics.q0all.CcR_M=ImageMetrics.q3CtfCR.CcR_M;

% Saves to eSummary
ImageMetrics.eSummary.CcR_M=ImageMetrics.q3CtfCR.CcR_M;

% Reference for SCR_DF Note that daniel used Max values