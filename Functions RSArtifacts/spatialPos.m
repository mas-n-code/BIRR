function [dataSet] = spatialPos(dataSet,RecImageMagnitude)
% [dataSet] = spatialPos(dataSet,RecImage_Magnitudeformat)
% Added the RecImage Magnitude variable to extend use of function, its the
% actual image to be used 

% Reads the corresponding, windowed array for each structure provides the
% current maximum coordinates.

 

I=RecImageMagnitude;% if no I is given
figure;    imagesc(I); axis square; hold on;

A=dataSet.ImageMetrics.Tumor.TumorArray;
[num] = max(A(:));
[y,x] = ind2sub(size(I),find(I==num));
dataSet.ImageMetrics.Tumor.XYMax= [x,y];
viscircles([x,y],2,'LineStyle','--','EdgeColor','K');

A=dataSet.ImageMetrics.Fibro.FibroArray;
[num] = max(A(:));
[y,x] = ind2sub(size(I),find(I==num));
dataSet.ImageMetrics.Fibro.XYMax= [x y];
viscircles([x,y],2,'LineStyle','--','EdgeColor','K');


A=dataSet.ImageMetrics.Back.BackArray;
[num] = max(A(:));
[y,x] = ind2sub(size(I),find(I==num));
dataSet.ImageMetrics.Back.XYMax= [x,y];
viscircles([x,y],4,'LineStyle','--','EdgeColor','K','LineWidth',1);

savethisone([dataSet.ImageMetrics.Name,'Positions'])