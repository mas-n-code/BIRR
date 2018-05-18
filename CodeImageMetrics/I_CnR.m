function [ImageMetrics]=I_CcR(ImageMetrics)
%Signal to Clutter Ratio [SNR] V0.9
%[ImageMetrics]=I_ScR(INew,Pos);

%Average of Half Maximum Elements from Tumor response
T_Signal=ImageMetrics.Tumor.Mean;

%Average of Half Maximum Elements from FibroG response
Theta_Fibro=ImageMetrics.Fibro.Mean;

%Std of Background
Sigma_Back=ImageMetrics.Back.Std;

%Tumor to Fibroglandular Ratio 
ImageMetrics.q3CcR.CcR_DF=10*log10((T_Signal-Theta_Fibro)/Sigma_Back);




% Reference for SCR_DF Note that daniel used Max values