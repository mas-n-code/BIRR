function [ImageMetrics]=I_RegionStandard(IRec,Region,ImageMetrics,tresh_magnitude)
%[ImageMetrics]=I_RegionStandard(IRec,Region,ImageMetrics,tresh_magnitude)
%Calculates the region standard values:
% 1- Sample standard deviation s
% 2- Sample variance
% 3- mean (Average)
% 4- median
% 5- min
% 6- max
% -----V1.1------ May/12/2015
% Editor: Mario

%Update 1.1
% Also saves the tumor array for its use in SCR, not sure if other values
% are needed, but it is likely they will.

cmap = colormap;
plotlimit_mean=tresh_magnitude;


ImageMetrics.Tumor.RegName='Tumor region';
ImageMetrics.Fibro.RegName='Fibro-glandular region';
ImageMetrics.Back.RegName='Background region';

%Regions
ImageMetrics.Tumor.TumorArray=IRec(Region.Tumor);
ImageMetrics.Fibro.FibroArray=IRec(Region.Fibro);
ImageMetrics.Back.BackArray=IRec(Region.IRefBack);

% 1- Sample standard deviation s
ImageMetrics.Tumor.Std=std(IRec(Region.Tumor));
ImageMetrics.Fibro.Std=std(IRec(Region.Fibro));
ImageMetrics.Back.Std=std(IRec(Region.IRefBack));

% 2- Sample variance
ImageMetrics.Tumor.Var=var(IRec(Region.Tumor));
ImageMetrics.Fibro.Var=var(IRec(Region.Fibro));
ImageMetrics.Back.Var=var(IRec(Region.IRefBack));


% 3- mean (Average)
ImageMetrics.Tumor.Mean=mean(IRec(Region.Tumor));
ImageMetrics.Fibro.Mean=mean(IRec(Region.Fibro));
ImageMetrics.Back.Mean=mean(IRec(Region.IRefBack));

% 4- median
ImageMetrics.Tumor.Median=median(IRec(Region.Tumor));
ImageMetrics.Fibro.Median=median(IRec(Region.Fibro));
ImageMetrics.Back.Median=median(IRec(Region.IRefBack));

% 5- min
ImageMetrics.Tumor.Min=min(IRec(Region.Tumor));
ImageMetrics.Fibro.Min=min(IRec(Region.Fibro));
ImageMetrics.Back.Min=min(IRec(Region.IRefBack));

% 6- max
ImageMetrics.Tumor.Max=max(IRec(Region.Tumor));
ImageMetrics.Fibro.Max=max(IRec(Region.Fibro));
ImageMetrics.Back.Max=max(IRec(Region.IRefBack));


%--- Plot mean in bars----



figure; bar(1,ImageMetrics.Tumor.Mean, 'facecolor', cmap(50,:)),hold on;
title({ImageMetrics.Name,' Mean value region \pm 1 SD'})
bar(2,ImageMetrics.Fibro.Mean, 'facecolor', cmap(35,:)),hold on;
bar(3,ImageMetrics.Back.Mean, 'facecolor', cmap(10,:)),hold on;
ylim([0 plotlimit_mean]);
Labels = {'Tumor', 'Fibro-glandular', 'Background'};
set(gca, 'XTick', 1:3, 'XTickLabel', Labels);


x1=0.5*rand(size(IRec(Region.Tumor)))+0.75;
x2=0.5*rand(size(IRec(Region.Fibro)))+1.75;
x3=0.5*rand(size(IRec(Region.IRefBack)))+2.75;

scatter(x1,IRec(Region.Tumor),'filled','k'),hold on;
scatter(x2,IRec(Region.Fibro),'filled','k'),hold on;
scatter(x3,IRec(Region.IRefBack),'filled','k'),hold on;

errorbar(1,ImageMetrics.Tumor.Mean,ImageMetrics.Tumor.Std,'rx','LineWidth',2),hold on;
errorbar(2,ImageMetrics.Fibro.Mean,ImageMetrics.Fibro.Std,'rx','LineWidth',2),hold on;
errorbar(3,ImageMetrics.Back.Mean,ImageMetrics.Back.Std,'rx','LineWidth',2),hold on;

% 
% scatter(1*ones(1,length(IRec(Region.Tumor))),IRec(Region.Tumor),'filled',),hold on;
% scatter(2*ones(1,length(IRec(Region.Fibro))),IRec(Region.Fibro),'filled'),hold on;
% scatter(3*ones(1,length(IRec(Region.IRefBack))),IRec(Region.IRefBack),'filled'),hold on;

%%Sumary field
ImageMetrics.eSummary.TumorMean=mean(IRec(Region.Tumor));
ImageMetrics.eSummary.FibroMean=mean(IRec(Region.Fibro));
ImageMetrics.eSummary.BackMean=mean(IRec(Region.IRefBack));

ImageMetrics.eSummary.TumorStd=ImageMetrics.Tumor.Std;
ImageMetrics.eSummary.FibroStd=ImageMetrics.Fibro.Std;
ImageMetrics.eSummary.BackStd=ImageMetrics.Back.Std;



