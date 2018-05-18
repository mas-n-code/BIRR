function [GroupSet] = Group_RecoQualityMetrics(GroupSet) 
% [GroupSet] = Group_RecoQualityMetrics(GroupSet) 
% Calculates the Radar Reconstruction image quality metrics
% Scr - Signal to clutter ratio
% TfR- Tumor to fibroglandular ratio
% CcR - CtfCR - Contrast (Tumor-Fibro) to clutter
% Built for rotary stage simulated error

% [Note that ImageMetrics must be set in Magnitude, or root of the values ]


%[GroupSet.E1]=nested_RecoQualityMetric(GroupSet.E1);
% [GroupSet.E2]=nested_RecoQualityMetric(GroupSet.E2);
[GroupSet.E4]=nested_RecoQualityMetric(GroupSet.E4);
% [GroupSet.E12]=nested_RecoQualityMetric(GroupSet.E12);

function GroupSet_X= nested_RecoQualityMetric(GroupSet_X)
[GroupSet_X.ImageMetrics]=I_ScR(GroupSet_X.ImageMetrics);  
[GroupSet_X.ImageMetrics]=I_TfR(GroupSet_X.ImageMetrics);
[GroupSet_X.ImageMetrics]=I_CtfCR(GroupSet_X.ImageMetrics);
end


end