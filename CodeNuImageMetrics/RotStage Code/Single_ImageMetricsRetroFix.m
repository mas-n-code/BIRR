function [ImageMetrics] = Single_ImageMetricsRetroFix(PhantomSet)
% function [TesT_PD_P1] = Group_ImageMetricsRetroFix(PD_P1); 
% Based on I_RegionStandard(IRec,Region,ImageMetrics,tresh_magnitude)
% Returns the ImageMetric for each region, 
% note that the image metrics are
% calculated in [magnitude] not power


tumor=sqrt(PhantomSet.R_tValues.tumor);
fibro=sqrt(PhantomSet.R_tValues.fibro);
clutter=sqrt(PhantomSet.R_tValues.clutter);
back=sqrt(PhantomSet.R_Values.rest);


ImageMetrics.Tumor.RegName='Tumor region';
ImageMetrics.Fibro.RegName='Fibro-glandular region';
ImageMetrics.Back.RegName='Background region';
ImageMetrics.Clutter.RegName='Clutter region';

%Regions
ImageMetrics.Tumor.TumorArray=tumor;
ImageMetrics.Fibro.FibroArray=fibro;
ImageMetrics.Back.BackArray=back;
ImageMetrics.Clutter.ClutterArray=clutter;

% 1- Sample standard deviation s
ImageMetrics.Tumor.Std=std(tumor);
ImageMetrics.Fibro.Std=std(fibro);
ImageMetrics.Back.Std=std(back);
ImageMetrics.Clutter.Std=std(clutter);

% 2- Sample variance
ImageMetrics.Tumor.Var=var(tumor);
ImageMetrics.Fibro.Var=var(fibro);
ImageMetrics.Back.Var=var(back);
ImageMetrics.Clutter.Var=var(clutter);

% 3- mean (Average)
ImageMetrics.Tumor.Mean=mean(tumor);
ImageMetrics.Fibro.Mean=mean(fibro);
ImageMetrics.Back.Mean=mean(back);
ImageMetrics.Clutter.Mean=mean(clutter);

% 4- median
ImageMetrics.Tumor.Median=median(tumor);
ImageMetrics.Fibro.Median=median(fibro);
ImageMetrics.Back.Median=median(back);
ImageMetrics.Clutter.Median=median(clutter);

% 5- min
ImageMetrics.Tumor.Min=min(tumor);
ImageMetrics.Fibro.Min=min(fibro);
ImageMetrics.Back.Min=min(back);
ImageMetrics.Clutter.Min=min(clutter);

% 6- max
ImageMetrics.Tumor.Max=max(tumor);
ImageMetrics.Fibro.Max=max(fibro);
ImageMetrics.Back.Max=max(back);
ImageMetrics.Clutter.Max=max(clutter);

% 7 count
ImageMetrics.Tumor.n=length(tumor);
ImageMetrics.Fibro.n=length(fibro);
ImageMetrics.Back.n=length(back);
ImageMetrics.Clutter.n=length(clutter);



%% Sumary field
ImageMetrics.eSummary.TumorMean=mean(tumor);
ImageMetrics.eSummary.FibroMean=mean(fibro);
ImageMetrics.eSummary.BackMean=mean(back);
ImageMetrics.eSummary.ClutterMean=mean(clutter);

ImageMetrics.eSummary.TumorStd=ImageMetrics.Tumor.Std;
ImageMetrics.eSummary.FibroStd=ImageMetrics.Fibro.Std;
ImageMetrics.eSummary.BackStd=ImageMetrics.Back.Std;
ImageMetrics.eSummary.ClutterStd=ImageMetrics.Clutter.Std;

% --- Expanded eSummary
ImageMetrics.eSummary.dTPresent=PhantomSet.tDiagnosis.tX;
if PhantomSet.tDiagnosis.tX
    ImageMetrics.eSummary.dTL_x=PhantomSet.tDiagnosis.center(1);
    ImageMetrics.eSummary.dTL_y=PhantomSet.tDiagnosis.center(2);
else
    ImageMetrics.eSummary.dTL_x=NaN;
    ImageMetrics.eSummary.dTL_y=NaN;
end

ImageMetrics.eSummary.dTOnRegion=PhantomSet.tDiagnosis.OnRegion;
ImageMetrics.eSummary.dTOutcome=PhantomSet.tDiagnosis.Outcome;
