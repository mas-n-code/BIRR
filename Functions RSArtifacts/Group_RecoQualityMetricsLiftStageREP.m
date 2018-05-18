function [GroupSet] = Group_RecoQualityMetricsLiftStageREP(GroupSet) 
% [GroupSet] = Group_RecoQualityMetrics(GroupSet) LIFTSTAGE
% Calculates the Radar Reconstruction image quality metrics
% Scr - Signal to clutter ratio
% TfR- Tumor to fibroglandular ratio
% CcR - CtfCR - Contrast (Tumor-Fibro) to clutter
% Built for rotary stage simulated error





[GroupSet.E1]=nested_RecoQualityMetric(GroupSet.E1);
[GroupSet.E2]=nested_RecoQualityMetric(GroupSet.E2);
%[GroupSet.E3]=nested_RecoQualityMetric(GroupSet.E3);


function GroupSet_X= nested_RecoQualityMetric(GroupSet_X)
[GroupSet_X.ImageMetrics]=I_ScR(GroupSet_X.ImageMetrics);  
[GroupSet_X.ImageMetrics]=I_TfR(GroupSet_X.ImageMetrics);
[GroupSet_X.ImageMetrics]=I_CtfCR(GroupSet_X.ImageMetrics);
end


end