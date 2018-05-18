%Signal Full Width Half Maximum detection for Rec Images (or raw data)
% Made by mario solis
%
%
function FWHM=IFWHM(RecImage,close_Index,nBlobs)
max_value=max(max(RecImage));
FWHM_seg =(RecImage >= max_value/2);



se = strel('disk',close_Index);
% Perform a morphological close operation on the image.


subplot(1,2,1);
imshow(FWHM_seg)
title('FWHM')

FWHM = imclose(FWHM_seg,se);
%FWHM= BWGetLargest(FWHM);
disp(nBlobs);
FWHM = bwareafilt2(FWHM,[],nBlobs,'largest');

subplot(1,2,2);
imshow(FWHM)
title('FWHM+Close')
