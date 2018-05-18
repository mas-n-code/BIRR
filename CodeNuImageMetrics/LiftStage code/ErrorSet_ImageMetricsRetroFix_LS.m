function [ErrorSet] = ErrorSet_ImageMetricsRetroFix_LS(ErrorSet) 
%  [ExpSet] = ExpSet_ImageMetricsRetroFix(ExpSet) 
% Calculates the Image metrics for each error set
%
% Built for rotary stage simulated error

 [ErrorSet.E1]=nested_ImageMetricsRetroFix(ErrorSet.E1);
 try
 [ErrorSet.E2]=nested_ImageMetricsRetroFix(ErrorSet.E2);
 [ErrorSet.E3]=nested_ImageMetricsRetroFix(ErrorSet.E3);

 catch
     disp('!Single Experiment mode or something!')
 end
 

function ExpSet=nested_ImageMetricsRetroFix(ExpSet)
ExpSet.P_P1.ImageMetrics=Single_ImageMetricsRetroFix(ExpSet.P_P1);
ExpSet.P_P2.ImageMetrics=Single_ImageMetricsRetroFix(ExpSet.P_P2);
