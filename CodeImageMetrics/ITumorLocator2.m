function [TumorArray,BackArray,ExcArray]=ITumorLocator2(ITumor,~)
% Detects the location of all HV MW elements on the image, will be assigned
% as the Tumor ROI

edge_index=2;

Tum_FWHM=IFWHM(ITumor);
Tum_Edge=IEdge_Locator(ITumor,edge_index);
Tum_Back=~(Tum_FWHM+Tum_Edge);

max_raw=max(max(ITumor));
%mean_raw=mean(mean(ITumor));
copyR=ITumor;
TumorArray=Tum_FWHM;
BackArray=Tum_Back;
ExcArray= Tum_Edge;

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