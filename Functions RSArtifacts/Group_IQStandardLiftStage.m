function [GroupSet]=Group_IQStandardLiftStage(GroupSet,refImage,RefImageMetrics)
%GroupSet=Group_IQStandard(GroupSet,refImage,RefImageMetrics)
% Ref image metrics are only needed for the name
% Newimage and refimage must be double, non-complex matrixes
newImage1=abs(GroupSet.E1.SCAN.S11_c_RecZoomFlip).^2;
newImage2=abs(GroupSet.E2.SCAN.S11_c_RecZoomFlip).^2;
newImage3=abs(GroupSet.E3.SCAN.S11_c_RecZoomFlip).^2;


[GroupSet.E1.PowImageMetrics]=IQ_Standard(newImage1,refImage,(GroupSet.E1.PowImageMetrics),RefImageMetrics); savethisone([GroupSet.E1.ImageMetrics.Name 'SSIM vs Average POw']);% Same, just saved in both Metric Files
[GroupSet.E2.PowImageMetrics]=IQ_Standard(newImage2,refImage,(GroupSet.E2.PowImageMetrics),RefImageMetrics); savethisone([GroupSet.E2.ImageMetrics.Name 'SSIM vs Average POw']);% Same, just saved in both Metric Files
[GroupSet.E3.PowImageMetrics]=IQ_Standard(newImage3,refImage,(GroupSet.E3.PowImageMetrics),RefImageMetrics); savethisone([GroupSet.E3.ImageMetrics.Name 'SSIM vs Average POw']);% Same, just saved in both Metric Files
