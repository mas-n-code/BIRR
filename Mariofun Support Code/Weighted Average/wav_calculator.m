function [X_wav, Sigma_wav]=wav_calculator(X_v,U_v)
%[X_wav, Sigma_wav]=wav_calculator(X_v,U_v);
% Note: (X_v,U_v) must be a 1 row vector
% Created by Mario
%where X_v is a vector with the N means
%U_v is a vector with N uncertainties of each mean
% X_wav is the weighted mean and Sigma_wav is the weighted uncertainty
% wU_v is the weight of each uncertainty = 1/(U^2)

% Weight of each uncertainty
wU_v=1./(U_v.^2);

%Weighted mean X_wav
X_wav=(X_v*wU_v')/sum(wU_v);

%Uncertainty of the weighted mean.
Sigma_wav=1/sqrt(sum(wU_v));


% Refence
% Taylor; Error and uncertainties. 
% Example
%X_v= [11,12,10];U_v=[1 1 3]
%R= 11.4 ± 0.7 