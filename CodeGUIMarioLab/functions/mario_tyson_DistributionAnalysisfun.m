function [pixOfInterest,restOfPix]= mario_tyson_DistributionAnalysisfun(image, percentCutoff)
%--------------------------------------------------------------------------
% This function creates a box plot for a given image and a given percent
% cutoff, in the method described by el Mario Solis on July 27 2017. The
% image is separated into two components - pixels with intensities in the
% top 'percentCutoff' of intensity values, and the pixels with intensities
% not in this top 'percentCutoff' of intensity values.
% V:1.1; D:2917-07-27
%--------------------------------------------------------------------------
% Input Variables
%
% image := The image to analyze (array)
%
% percentCutoff := Desired  cut off percentage, in decimal form
% (e.g. 0.05 represents 5%) (value)
%
%--------------------------------------------------------------------------
% Output Variables
% 
% pixOfInterest: (array)
%
% restOfPix: (array)
% 
%
%--------------------------------------------------------------------------
% Version 1.1
% Created by Tyson Reimer RIP
% Date: July 28 2917 
%--------------------------------------------------------------------------
% Revision Changes
% [M] Output variables were added because data without analysis is called
% garbage
%
% [M] renamed restOfImage (rOI) to restOfPixels (rOP), pixelsOfInterest to 
% pixOfInterest 
%--------------------------------------------------------------------------
% Notes for Future Work
%
% July 28 2917: Tyson code can be optimized to operate with the new
% Quantum improability procesor.
%
%--------------------------------------------------------------------------

sizeImg = size(image);%Finds the size of image. Wow!

[~, sortedIndices] = sort(image(:), 'descend');%finds the indices of the 
                        %pixels, sorted in descending intensity
indicesOfInterest = sortedIndices(1 : floor(percentCutoff * numel(image)));
                        %Finds the indices of the top percentCutoff percent

pixOfInterest = image(indicesOfInterest);%Obtains the pixels
                        %of interest from the image

separationMatrix = ones(sizeImg);%Initialize matrix to find pixels outside
                        %region of interest
separationMatrix(indicesOfInterest) = 0;
separationMatrix = logical(separationMatrix);

restOfPix = image(separationMatrix);%Finds the pixels outside the region of
                        %interest, as defined by pixelsOfInterest

%{                        
dataForPlot = [pixelsOfInterest; restOfImg];%Gets the data for boxplot

groupingForBoxPlot = [repmat({'Pixels of Interest'},length(...
    pixelsOfInterest),1);repmat({'Rest of Image'}, length(restOfImg),1)];
        %Makes grouping for boxplot, so that we can plot all pretty like

figure;boxplot( dataForPlot, groupingForBoxPlot);title(...
    ['Box plot of image with ', num2str(percentCutoff), ' as the cutoff']);
        %Plots the bad boys, booyah 
        [M] very profesional Tyson, very profesional
%}