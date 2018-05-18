function [PhantomSet] = Phantom_RecoQualityMetrics(PhantomSet) 
% [PhantomSet] = Phantom_RecoQualityMetrics(PhantomSet) 
% Calculates the Radar Reconstruction image quality metrics
% Scr - Signal to clutter ratio
% TfR- Tumor to fibroglandular ratio
% CcR - CtfCR - Contrast (Tumor-Fibro) to clutter
% Built for rotary stage simulated error

% [Note that ImageMetrics must be set in Magnitude, or root of the values ]


%[PhantomSet.E1]=nested_RecoQualityMetric(PhantomSet.E1);
% [PhantomSet.E2]=nested_RecoQualityMetric(PhantomSet.E2);
[PhantomSet.E4]=nested_RecoQualityMetric(PhantomSet.E4);
%  [PhantomSet.E12]=nested_RecoQualityMetric(PhantomSet.E12);

function PhantomSet_X= nested_RecoQualityMetric(PhantomSet_X)
[PhantomSet_X.ImageMetrics]=I_ScR(PhantomSet_X.ImageMetrics);  
[PhantomSet_X.ImageMetrics]=I_TfR(PhantomSet_X.ImageMetrics);
[PhantomSet_X.ImageMetrics]=I_CtfCR(PhantomSet_X.ImageMetrics);
end


end