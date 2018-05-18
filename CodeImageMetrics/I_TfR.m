function [ImageMetrics]=I_TfR(ImageMetrics)
%Signal to Clutter Ratio [SNR] V1.3

% V1.3: 
% now saves to eSummary to save time

%Signal to Clutter Ratio [SNR] V0.20
%Version changes to 20db
%daniel uses max

%[ImageMetrics]=I_ScR(INew,Pos);

%% Load region values
%Average of Half Maximum Elements from Tumor response
T_Signal=ImageMetrics.Tumor.Mean;
T_Signal_max=ImageMetrics.Tumor.Max;
%Average of Half Maximum Elements from FibroG response
Theta_Fibro=ImageMetrics.Fibro.Mean;
Theta_Fibro_max=ImageMetrics.Fibro.Max;

%% [CREAM] Tumor to Fibroglandular Ratio 
ImageMetrics.q2TfR.TfR_M=20*log10(T_Signal/Theta_Fibro);
ImageMetrics.q2TfR.TfR_DF=20*log10(T_Signal_max/Theta_Fibro_max);


%% Save value in case of flies
ImageMetrics.q2TfR.Theta_Fibro=Theta_Fibro;
ImageMetrics.q2TfR.T_Signal=T_Signal;
ImageMetrics.q2TfR.T_Signal_max=T_Signal_max;
ImageMetrics.q2TfR.Theta_Fibro_max=Theta_Fibro_max;

% Save all one
ImageMetrics.q0all.TfR_M=ImageMetrics.q2TfR.TfR_M;

% Save to the eSummary
ImageMetrics.eSummary.TfR_M=ImageMetrics.q2TfR.TfR_M;

% Reference for SCR_DF Note that daniel used Max values

