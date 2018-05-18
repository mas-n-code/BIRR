close all;
clear all;

pdir = dir(['*Img2**.jpg']);
originalP = imread(pdir(1).name);
figure(1);
%set(gcf,'Position',[50 50 2000 800])
a=2;
b=2;
c=1;

position= [2100 930 400 400];
cropP= imcrop(originalP,position);

subplot(a,b,c);
imshow(cropP,'InitialMagnification',50);
title('Initial Image')
c=c+1;

I = rgb2gray(cropP);
subplot(a,b,c);
imshow(I,'InitialMagnification',50);
title('Grayscale')
c=c+1;

%threshold = graythresh(I)-.05; %+ offset to make it darkerish;
threshold=0.85;
bwP = im2bw(I,threshold);
bwP = ~bwP;  % complement the image (objects of interest must be white)
%imshow(bwP,'InitialMagnification',50);
dimP = size(bwP);
hdimP=round(dimP(1)/2);
bwP = bwareaopen(bwP, 100);

subplot(a,b,c);
c=c+1;
imshow(bwP,'InitialMagnification',50);
title('Black and White clean')





BWPrewitt = edge(I,'Prewitt');
subplot(a,b,c);
c=c+1;
imshow(BWPrewitt,'InitialMagnification',60)
title('Prewitt')

figure(2);
b=3;
c=1;

subplot(a,b,c);
c=c+1;
BWPrewitt = bwareaopen(BWPrewitt, 100);
imshow(BWPrewitt(300:400,70:170),'InitialMagnification',60);
title('Prewitt Clean')

subplot(a,b,c);
c=c+1;
BWcanny = edge(I,'Canny');
BWcanny = bwareaopen(BWcanny, 100);
imshow(BWcanny(300:400,70:170),'InitialMagnification',60);
title('Canny clean')

subplot(a,b,c);
c=c+1;
BWlog = edge(I,'log');
%BWlog = bwareaopen(BWlog, 100);
imshow(BWlog(300:400,70:170),'InitialMagnification',60);
title('log clean')

subplot(a,b,c);
c=c+1;
BWfilt = edge(I,'Roberts');
%BWfilt = bwareaopen(BWfilt, 100);
imshow(BWfilt(300:400,70:170),'InitialMagnification',60);
title('Roberts clean')

subplot(a,b,c);
c=c+1;
BWfilt = edge(I,'Sobel');
%BWfilt = bwareaopen(BWfilt, 100);
imshow(BWfilt(300:400,70:170),'InitialMagnification',60);
title('Sobel clean')

subplot(a,b,c);
c=c+1;
BWfilt = edge(I,'zerocross');
%BWfilt = bwareaopen(BWfilt, 100);
imshow(BWfilt(300:400,70:170),'InitialMagnification',60);
title('zerocross clean')


