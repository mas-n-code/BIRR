function [TArray,TBackArray,TExcArray]=IRegionLocatorTumor(ITumor,radiusBack,tBlobs)

% function [FGArray,ICompBack,FGExcArray,TArray,TBackArray,TExcArray]=IRegionLocator(ITumor,IComp,radiusBack,nBlobs)
% Detects the location of HV MW elements that are not the tumor
% Exclusion zone is a 2 pixel disc dilation characterized by edge_index
% The ITumor and IComp(lete) variables are: abs(S11_c_RecZoomFlip) of each
% file 
%
%radiusBack is the diameter of the breast phantom region that will be accepted as part of background in pixels usually //12
%
%tBlobs is the number of tumor blobs




%% Crop Circle out of Background



[rr,cc] = meshgrid(1:size(ITumor,1));
CircExcl = sqrt((rr-21).^2+(cc-21).^2)<=radiusBack;
%add circle to background



%%


copyT=ITumor;
edge_index=3;
close_index=1;





%% Detect Tumor ROI using FWHM and penumbra size criteria
figure('name','Tumor Response');
TArray=IFWHM(ITumor,close_index,tBlobs);
TExcArray= IEdge_Locator(ITumor,close_index,edge_index,tBlobs);
TBackArray=~(TArray+TExcArray);



%% Detect Fibroglandular  ROI using FWHM and penumbra size criteria
%{
 % Remove tumor response to isolate FG
copyFG=IComp;
copyFG(~TBackArray)=0;

figure('name',' FG only');
imagesc(copyFG);

% IComp(TArray)=0;
% IComp(TExcArray)=0;
% figure;imagesc(IComp, [0 5e-9]); 
% 
% max_raw=max(max(IComp));


figure('name','FG Response');
FGArray=IFWHM(copyFG,close_index,nBlobs);
FGExcArray=  IEdge_Locator(copyFG,close_index,edge_index,nBlobs);
FGBackArray=~(FGExcArray+FGArray);

ICompBack=logical(FGBackArray.*TBackArray);


copyFG=zeros(size(IComp));
copyFG(FGExcArray)=1;
copyFG(TExcArray)=1;
figure;imshow(copyFG);

%}
%%
%FGBackArray=and(FGBackArray,CircExcl);
%ICompBack=and(ICompBack,CircExcl);
%FGExcArray=and(FGExcArray,CircExcl);
TArray=and(TArray,CircExcl);
TBackArray=and(TBackArray,CircExcl);
TExcArray=and(TExcArray,CircExcl);

%{

%% Graph stuff Tumor

%copyR(TumorArray)=1;
ITumor(~TArray)=0;
%figure('position', [150, 300, 800, 420]);%hold on;
imagesc(ITumor, [0 5e-9]); 


copyT(TBackArray)=1;
copyT(TExcArray)=3;
copyT(TArray)=5;
copyT([1 1])=0;
figure;imagesc(copyT); 

%% Graph stuff Fibroglandular
IComp(~FGArray)=0;

figure;imagesc(IComp, [0 5e-9]); 
%%
IComp(FGBackArray)=1;

IComp(TExcArray)=3;
IComp(FGExcArray)=3;

IComp(FGArray)=4;
IComp(TArray)=5;

IComp([1 1])=0;
figure;imagesc(IComp); 


%Project Regions

copyFG(TArray)=0;
copyFG(TExcArray)=0;
figure;imagesc(copyFG, [0 5e-9]);
legend('ba','ff','exc')
%}