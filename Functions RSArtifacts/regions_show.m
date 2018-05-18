function regions_show(Image1,Image2,Regions,codeName1,codeName2,IClim)

%function regions_show(Image1,Image2,Regions,codeName1,codeName2,IClim)
% display two images segmented into regions.  
% each image has its own codeName


IP1=Image1;
IP2=Image2;

%IClim=5e-5;
cleanlow=0.5e-5;
figure('name','Regions in IRef Image','Position',[403 106 860 560]);
%Complete image
subplot(2,4,1);

targets=or(Regions.Fibro,Regions.Tumor);
imagesc(IP1,[0 IClim]);
h=gca; set(h,'xTickLabel','','yTickLabel','','xTick',[],'yTick',[]);
title(codeName1);
axis square


%Background
subplot(2,4,2);
Icanvas=IP1;
%Icanvas(~Regions.IRefBack)=cleanlow;
Icanvas(~Regions.IRefBack)=1;
imagesc(Icanvas,[0 IClim]);
h=gca; set(h,'xTickLabel','','yTickLabel','','xTick',[],'yTick',[]);
title('background (blue)')
axis square


%Exclusion
subplot(2,4,3);
Icanvas=IP1;
Icanvas(~(Regions.TExcl+Regions.FExcl))=cleanlow;
imagesc(Icanvas,[0 IClim]);
h=gca; set(h,'xTickLabel','','yTickLabel','','xTick',[],'yTick',[]);
title('exclusion zone')
axis square

%Targets only
subplot(2,4,4);
Icanvas=IP1;
Icanvas(~targets)=cleanlow;
imagesc(Icanvas,[0 IClim]);
h=gca; set(h,'xTickLabel','','yTickLabel','','xTick',[],'yTick',[]);
title('tumor and fibro')
axis square

% new image
subplot(2,4,5);
imagesc(IP2,[0 IClim]);
h=gca; set(h,'xTickLabel','','yTickLabel','','xTick',[],'yTick',[]);
title(codeName2);
axis square

%Background and artifacts
subplot(2,4,6);
Icanvas=IP2;
Icanvas(~Regions.IRefBack)=cleanlow;
Icanvas(~Regions.IRefBack)=1;
imagesc(Icanvas,[0 IClim]);
h=gca; set(h,'xTickLabel','','yTickLabel','','xTick',[],'yTick',[]);
title('background (blue)')
axis square

%Exclusion
subplot(2,4,7);
Icanvas=IP2;
Icanvas(~(Regions.TExcl+Regions.FExcl))=cleanlow;
imagesc(Icanvas,[0 IClim]);
h=gca; set(h,'xTickLabel','','yTickLabel','','xTick',[],'yTick',[]);
title('exclusion zone')
axis square

%Targets only
subplot(2,4,8);
Icanvas=IP2;
Icanvas(~targets)=cleanlow;
imagesc(Icanvas,[0 IClim]);
title('tumor and fibro')
h=gca; set(h,'xTickLabel','','yTickLabel','','xTick',[],'yTick',[]);
axis square