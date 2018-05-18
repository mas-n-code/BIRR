function [ScanSet]=eSummaryMaker(ScanSet)
%[ScanSet]=eSummaryMaker(ScanSet)
%Require ScanSet with ImageMetrics
% July update
%- Added XY position of tumor and fibro and back

%% Saves values in a singlle struct to be saved in excel proly Mario©®  
% April 28

%%Sumary field
ScanSet.ImageMetrics.eSummary.Name=ScanSet.ImageMetrics.Name;

ScanSet.ImageMetrics.eSummary.TumorMean=ScanSet.ImageMetrics.Tumor.Mean;
ScanSet.ImageMetrics.eSummary.FibroMean=ScanSet.ImageMetrics.Fibro.Mean;
ScanSet.ImageMetrics.eSummary.BackMean=ScanSet.ImageMetrics.Back.Mean;

ScanSet.ImageMetrics.eSummary.TumorStd=ScanSet.ImageMetrics.Tumor.Std;
ScanSet.ImageMetrics.eSummary.FibroStd=ScanSet.ImageMetrics.Fibro.Std;
ScanSet.ImageMetrics.eSummary.BackStd=ScanSet.ImageMetrics.Back.Std;

ScanSet.ImageMetrics.eSummary.ScR_M=ScanSet.ImageMetrics.q0all.ScR_M;
ScanSet.ImageMetrics.eSummary.TfR_M=ScanSet.ImageMetrics.q0all.TfR_M;
ScanSet.ImageMetrics.eSummary.CcR_M=ScanSet.ImageMetrics.q0all.CcR_M;

%PowerValues
ScanSet.ImageMetrics.eSummary.TumorMeanPOW=ScanSet.PowImageMetrics.Tumor.Mean;
ScanSet.ImageMetrics.eSummary.FibroMeanPOW=ScanSet.PowImageMetrics.Fibro.Mean;
ScanSet.ImageMetrics.eSummary.BackMeanPOW=ScanSet.PowImageMetrics.Back.Mean;

ScanSet.ImageMetrics.eSummary.TumorStdPOW=ScanSet.PowImageMetrics.Tumor.Std;
ScanSet.ImageMetrics.eSummary.FibroStdPOW=ScanSet.PowImageMetrics.Fibro.Std;
ScanSet.ImageMetrics.eSummary.BackStdPOW=ScanSet.PowImageMetrics.Back.Std;

%Position
ScanSet.ImageMetrics.eSummary.TumorXYMax=ScanSet.ImageMetrics.Tumor.XYMax;
ScanSet.ImageMetrics.eSummary.FibroXYMax=ScanSet.ImageMetrics.Fibro.XYMax;
ScanSet.ImageMetrics.eSummary.BackXYMax=ScanSet.ImageMetrics.Back.XYMax;


