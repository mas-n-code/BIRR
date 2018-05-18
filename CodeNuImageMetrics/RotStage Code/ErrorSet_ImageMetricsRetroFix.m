function [ErrorSet] = ErrorSet_ImageMetricsRetroFix(ErrorSet) 
%  [ExpSet] = ExpSet_ImageMetricsRetroFix(ExpSet) 
% Calculates the Image metrics for each error set
%
% Built for rotary stage simulated error

 [ErrorSet.E1]=nested_ImageMetricsRetroFix(ErrorSet.E1);
 try
 [ErrorSet.E2]=nested_ImageMetricsRetroFix(ErrorSet.E2);
 [ErrorSet.E4]=nested_ImageMetricsRetroFix(ErrorSet.E4);
[ErrorSet.E12]=nested_ImageMetricsRetroFix(ErrorSet.E12);
 catch
     disp('!Single Experiment mode!')
 end
 

function ExpSet=nested_ImageMetricsRetroFix(ExpSet)
ExpSet.P_P1.ImageMetrics=Single_ImageMetricsRetroFix(ExpSet.P_P1);
ExpSet.P_P2.ImageMetrics=Single_ImageMetricsRetroFix(ExpSet.P_P2);
ExpSet.P_P3.ImageMetrics=Single_ImageMetricsRetroFix(ExpSet.P_P3);