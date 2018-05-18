function [ErrorSet] = ErrorSet_RecoQualityMetricsRetroFix(ErrorSet) 
% function [ErrorSet] = ErrorSet_RecoQualityMetricsRetroFix(ErrorSet) 
% Calculates the Radar Reconstruction image quality metrics
% Scr - Signal to clutter ratio
% TfR- Tumor to fibroglandular ratio
% CcR - CtfCR - Contrast (Tumor-Fibro) to clutter
% Built for rotary stage simulated error


 [ErrorSet.E1]=nested_groupRecoQualityMetrics(ErrorSet.E1);
 try
 [ErrorSet.E2]=nested_groupRecoQualityMetrics(ErrorSet.E2);
 [ErrorSet.E4]=nested_groupRecoQualityMetrics(ErrorSet.E4);
[ErrorSet.E12]=nested_groupRecoQualityMetrics(ErrorSet.E12);
 catch
     disp('!Single Experiment Mode!');
 end
 
function ExpSet=nested_groupRecoQualityMetrics(ExpSet)
    ExpSet.P_P1=nested_RecoQualityMetric(ExpSet.P_P1);
    ExpSet.P_P2=nested_RecoQualityMetric(ExpSet.P_P2);
    ExpSet.P_P3=nested_RecoQualityMetric(ExpSet.P_P3);
end

function PhantomSet_X= nested_RecoQualityMetric(PhantomSet_X)
    [PhantomSet_X.ImageMetrics]=I_ScR(PhantomSet_X.ImageMetrics);  
    [PhantomSet_X.ImageMetrics]=I_TfR(PhantomSet_X.ImageMetrics);
    [PhantomSet_X.ImageMetrics]=I_CtfCR(PhantomSet_X.ImageMetrics);
end
%end of the original function
end


