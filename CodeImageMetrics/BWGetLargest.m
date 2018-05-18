%Function get the largest connected element
function BW2= BWGetLargest(BW)
%
%Find connected components
CC = bwconncomp(BW); %

numPixels = cellfun(@numel,CC.PixelIdxList);

[biggestSize,idx] = max(numPixels);
%disp([num2str(biggestSize) ' Total pixels connected'])
     
BW2 = false(size(BW));
BW2(CC.PixelIdxList{idx}) = true;