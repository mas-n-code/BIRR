%% HOW TO CALCULATE CONFIDENCE INTERVALS WITHOUT CALLING FOR INV T SCORE, RATHER CLEVER!
Area+[-1 1].*(realsqrt(2)*erfcinv(alpha)*Serror);

%% PERFCURVE FOR ROC  AUGUST 21

% Using perfcurve
%NBoot - peforms a boot strap calculation to x,y and T? Bias corrected percentile method
% =Output=
% Xroc_perf: false positive rate(first column) and lower(:,2) and  upper(:,3) bounds of pointwise confidence bounds
% Yroc_perf: true positive rate(first column) and lower(:,2) and upper(:,3) bounds of pointwise confidence bounds
% T_perf: is the vector of threshold values used, since im not using
% vertical 
%[xroc_perf,yroc_perf,T_perf,Area_perf] = perfcurve(roc_flag,roc_data,1,'NBoot',500,'Alpha',0.05);



figure;
errorbar(xroc_perf(:,1),yroc_perf(:,1),yroc_perf(:,1)-yroc_perf(:,2),yroc_perf(:,3)-yroc_perf(:,1));
xlim([-0.02,1.02]); ylim([-0.02,1.02]);
xlabel('False positive rate')
ylabel('True positive rate')
title('ROC Curve with Pointwise Confidence Bounds')
hold on;
%figure; hold on
% herrorbar(xroc_perf(:,1),yroc_perf(:,1),yroc_perf(:,1)-yroc_perf(:,2),yroc_perf(:,3)-yroc_perf(:,1));
h1= plot(xroc_perf(:,1),yroc_perf(:,1),'k','LineWidth',2);
% 
% h2H= plot(xroc_perf(:,1),yroc_perf(:,2),'--g','LineWidth',2);
% h2L= plot(xroc_perf(:,1),yroc_perf(:,3),'--r','LineWidth',2);


h2H= plot(xroc_perf(:,2),yroc_perf(:,3),':b','LineWidth',2);
h2L= plot(xroc_perf(:,3),yroc_perf(:,2),':b','LineWidth',2);
axis square
xlim([0 1.01])
ylim([0 1.01])
plot((0:1),())
alpha=0.05;
realsqrt(2)*erfcinv(0.01)

%% CODE I USED TO CORRECT MASK OF THE TUMOR AND FIBRO 
off_tumor=xor(sProp.Masks.mask_fibroHandBig,sProp.Masks.mask_fibroHand);
imshow(off_tumor)

off_fibro=xor(sProp.Masks.mask_tumorHandBig,sProp.Masks.mask_tumorHand);
imshow(off_fibro)

imshow(sProp.Masks.mask_tumorHandBig)
% correct for the tumor Hand thing
mask_correcttumorHandBig=or(sProp.Masks.mask_tumorHand,off_tumor);
imshow(mask_correcttumorHandBig)

% correct for the fibro Hand thing
mask_correctfibroHandBig=or(sProp.Masks.mask_fibroHand,off_fibro);
imshow(mask_correctfibroHandBig)

%correct in sProp
sProp.Masks.mask_fibroHandBig=mask_correctfibroHandBig;
imshow(sProp.Masks.mask_fibroHandBig) % validate

sProp.Masks.mask_tumorHandBig=mask_correcttumorHandBig;
imshow(sProp.Masks.mask_tumorHandBig) % validate


%% NaN plot Example
I=PE.E1.P_P1.A_masked;
I_TargetsOnly=I;
I_TargetsOnly(and(~sProp.Masks.mask_fibroHandBig,~sProp.Masks.mask_tumorHandBig))=NaN;
figure; figImage=I_TargetsOnly;
image(figImage,'CDataMapping','scaled','AlphaData',~isnan(figImage));

