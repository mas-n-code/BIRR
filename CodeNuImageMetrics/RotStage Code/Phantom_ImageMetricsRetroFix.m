function [PhantomSet] = Phantom_ImageMetricsRetroFix(PhantomSet) 
% [PhantomSet] =Group_ImageMetricsRetroFix(PhantomSet) 
% Calculates the Image metrics for each error set
%
% Built for rotary stage simulated error



%  [PhantomSet.E1.ImageMetrics]=Single_ImageMetricsRetroFix(PhantomSet.E1);
%  [PhantomSet.E2.ImageMetrics]=Single_ImageMetricsRetroFix(PhantomSet.E2);
  [PhantomSet.E4.ImageMetrics]=Single_ImageMetricsRetroFix(PhantomSet.E4);
%    [PhantomSet.E12.ImageMetrics]=Single_ImageMetricsRetroFix(PhantomSet.E12);

