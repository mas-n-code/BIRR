function tyson_HistogramAnalysis(image, percentCutoff)
%--------------------------------------------------------------------------
% This function creates a box plot for a given image and a given percent
% cutoff, in the method described by el Mario Solis on July 27 2017. The
% image is separated into two components - pixels with intensities in the
% top 'percentCutoff' of intensity values, and the pixels with intensities
% not in this top 'percentCutoff' of intensity values.
%--------------------------------------------------------------------------
% Input Variables
%
% image := The image you want to analyze (array)
%
% percentCutoff := The percent cut off you'd like to use, in decimal form
% (e.g. 0.05 represents 5%) (value)
%
%--------------------------------------------------------------------------
% Output Variables
%
% N/A := this function only forms a histogram. Output variables could be
% added in the future for further analysis.
%
%--------------------------------------------------------------------------
% Version 1.0
% Created by Tyson Reimer
% Date: July 27 2917
%--------------------------------------------------------------------------
% Revision Changes
%
%
%--------------------------------------------------------------------------
% Notes for Future Work
%
% July 27 2017: Add output variables for further analysis. 
%
%--------------------------------------------------------------------------

sizeImg = size(image);%Finds the size of image.

[~, sortedIndices] = sort(image(:), 'descend');%finds the indices of the 
                        %pixels, sorted in descending intensity
indicesOfInterest = sortedIndices(1 : percentCutoff * numel(image));
                        %Finds the indices of the top percentCutoff percent

pixelsOfInterest = image(indicesOfInterest);%Obtains the pixels
                        %of interest from the image

separationMatrix = ones(sizeImg);%Initialize matrix to find pixels outside
                        %region of interest
separationMatrix(indicesOfInterest) = 0;
separationMatrix = logical(separationMatrix);

restOfImg = image(separationMatrix);%Finds the pixels outside the region of
                        %interest, as defined by pixelsOfInterest

dataForPlot = [pixelsOfInterest; restOfImg];%Gets the data for boxplot

groupingForBoxPlot = [repmat({'Pixels of Interest'},length(...
    pixelsOfInterest),1);repmat({'Rest of Image'}, length(restOfImg),1)];
        %Makes grouping for boxplot, so that we can plot all pretty like

figure;boxplot( dataForPlot, groupingForBoxPlot);title(...
    ['Box plot of image with ', num2str(percentCutoff), ' as the cutoff']);
        %Plots the bad boys, booyah
