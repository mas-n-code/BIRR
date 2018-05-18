function [FibroArray,FBackArray,FExcArray]=IFibroLocator(ITumor,IComp)
% Detects the location of HV MW elements that are not the tumor

max_raw=max(max(ITumor));
mean_raw=mean(mean(ITumor));
copyT=ITumor;
TumorArray=(ITumor >= max_raw/2); %generate an index of Half Value signals
TBackArray=(ITumor <= mean_raw);
TExcArray= ~xor(TumorArray,TBackArray);

%copyR(TumorArray)=1;
ITumor(~TumorArray)=0;
figure('position', [100, 300, 800, 420]);%hold on;
imagesc(ITumor, [0 5e-9]); 


copyT(TBackArray)=1;
copyT(TExcArray)=3;
copyT(TumorArray)=5;
copyT([1 1])=0;
figure;imagesc(copyT); 

% detect Fibro
copyF=IComp;
IComp(TumorArray)=0;
IComp(TExcArray)=0;
figure;imagesc(IComp, [0 5e-9]); 

max_raw=max(max(IComp));
FibroArray=(IComp >= max_raw/2);

FBackArray=(IComp <= mean_raw);
FExcArray= ~xor(FibroArray,FBackArray);


IComp(~FibroArray)=0;

figure;imagesc(IComp, [0 5e-9]); 
%%
IComp(FBackArray)=1;

IComp(TExcArray)=3;
IComp(FExcArray)=3;

IComp(FibroArray)=4;
IComp(TumorArray)=5;

IComp([1 1])=0;
figure;imagesc(IComp); 


%Project Regions

copyF(TumorArray)=0;
copyF(TExcArray)=0;
figure;imagesc(copyF, [0 5e-9]);
%}