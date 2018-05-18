function [ImageMetrics]= nested_RecoMetricMagicAllinOne(PhantomSet_X)
[ImageMetrics]=Single_ImageMetricsRetroFix(PhantomSet_X);
[ImageMetrics]=I_ScR(ImageMetrics);  
[ImageMetrics]=I_TfR(ImageMetrics);
[ImageMetrics]=I_CtfCR(ImageMetrics);
end