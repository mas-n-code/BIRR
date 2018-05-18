%Signal to Clutter Ratio [ScR] V1.0
% [ImageMetrics]=I_ScR(ImageMetrics)
function [ImageMetrics]=I_ScR(ImageMetrics)

%Signal to Clutter Ratio [ScR] V1.1

% V1.1
% added value to save to eSummary
%V0.3
% uses mean values of clutter
%V0.2
%> 20*Log since magnitudes 
%> daniel uses max
%> Mario uses means
%Daniel at some point calculated SNR as the signal over mean
%Update V0.10
% Added Bushenber SNR calculation


T_Signal_max=ImageMetrics.Tumor.Max;

%Average of Half Maximum Elements from Tumor response
T_Signal=ImageMetrics.Tumor.Mean;

%Average of Background
Xmean_Back=ImageMetrics.Back.Mean;

%Std of Background
Sigma_Back=ImageMetrics.Back.Std;

%Tumor array
T_Array=ImageMetrics.Tumor.TumorArray;

T_OverBack=sum(sum(T_Array-Xmean_Back));

%ScR 
ImageMetrics.q1ScR.ScR_M  = 20*log10(T_Signal/Xmean_Back);
ImageMetrics.q1ScR.ScR_DF = 20*log10(T_Signal_max/Sigma_Back);
ImageMetrics.q1ScR.ScR_DFbackmean = 20*log10(T_Signal_max/Xmean_Back);
ImageMetrics.q1ScR.ScR_Nikolova = (T_Signal/Sigma_Back);
ImageMetrics.q1ScR.ScR_Bushberg = (T_OverBack/Sigma_Back); % [See 3]

% Save value in case of flies
ImageMetrics.q1ScR.T_OverBack=T_OverBack;
ImageMetrics.q1ScR.T_Signal=T_Signal;
ImageMetrics.q1ScR.T_Signal_max=T_Signal_max;
ImageMetrics.q1ScR.Sigma_Back=Sigma_Back;
ImageMetrics.q1ScR.Xmean_Back=Xmean_Back;

% Save the summarized one
ImageMetrics.q0all.ScR_M  =ImageMetrics.q1ScR.ScR_M;

% Save at the esummary
ImageMetrics.eSummary.ScR_M=ImageMetrics.q1ScR.ScR_M;


% Reference for SCR_DF

% Reference for Scr_Nikolova

% [3] 2011 third Ed J.T. Bushberg The essential Physics of Medical Imaging
% Eq 4-23 in page 92 

%After much cal I concluded that a Back.Std > than 2.587e-5 is required to
%reduce or signal to noise ration bellow the rose criteria