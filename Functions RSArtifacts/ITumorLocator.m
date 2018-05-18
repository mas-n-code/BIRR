function [TumorArray,BackArray,ExcArray]=ITumorLocator(ITumor,~)
% Detects the location of all HV MW elements on the image, will be assigned
% as the Tumor ROI

max_raw=max(max(ITumor));
mean_raw=mean(mean(ITumor));
copyR=ITumor;
TumorArray=(ITumor >= max_raw/2); %generate an index of Half Value signals
BackArray=(ITumor <= mean_raw);
ExcArray= ~xor(TumorArray,BackArray);

%copyR(TumorArray)=1;
ITumor(~TumorArray)=0;
figure('position', [100, 300, 800, 420]);%hold on;
imagesc(ITumor, [0 5e-9]); 

figure;
copyR(BackArray)=1;
copyR(ExcArray)=3;
copyR(TumorArray)=5;
copyR([1 1])=0;
imagesc(copyR); 