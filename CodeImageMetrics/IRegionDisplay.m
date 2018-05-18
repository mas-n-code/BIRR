function IRegionDisplay(ICanvasO,disp_limits,Regions)
%disp_limits  vector of form[ll lh] where ll is limit low [0.5e-5]
%and lh is limit high [5e-6]
%ICanvasO is an image to be display into regions
%IRegions is a Region structure file

sR=1;
sC=4;
sii=1;

%% Display regions localization

cleanlow=disp_limits(1);%0.5e-5;
IClim= disp_limits(2);%5e-6;

figure('name','Regions in IRef Image','Position',[403 106 860 560]);
%Complete image
subplot(sR,sC,sii);
sii=sii+1;

targets=or(Regions.Fibro,Regions.Tumor);
imagesc(ICanvasO,[0 IClim]);
title('Original Image')
axis square


%Background
subplot(sR,sC,sii);
sii=sii+1;

Icanvas=ICanvasO;
%Icanvas(~Regions.IRefBack)=cleanlow;
Icanvas(~Regions.IRefBack)=1;
imagesc(Icanvas,[0 IClim]);
title('background (blue)')
axis square


%Exclusion
subplot(sR,sC,sii);
sii=sii+1;
Icanvas=ICanvasO;
Icanvas(~(Regions.TExcl+Regions.FExcl))=cleanlow;
imagesc(Icanvas,[0 IClim]);
title('exclusion zone')
axis square

%Targets only
subplot(sR,sC,sii);
sii=sii+1;
Icanvas=ICanvasO;
Icanvas(~targets)=cleanlow;
imagesc(Icanvas,[0 IClim]);
title('tumor and fibro')
axis square