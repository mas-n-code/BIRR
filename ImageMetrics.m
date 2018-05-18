function [averageSig,averageBg,area,vSig,Vbg,ClutNum,SNR]=ImageMetrics(imafin,zm,ths,flip_i)
%imafin=reconstructed image (full size 1202x1202)
%zm=Zoom in parameter, if 20 is used a 40x40 pixels image is used for the
%algorithm so the final size is always 2zm X 2zm
%ths=Threshoold, the threshoold for the image segmentation, if 0 is used
%you get the average and variance of the whole image (2zm X 2zm image)
sizmat=size(imafin);
smalImafin=abs(imafin).^2;
if(zm>0)
X1=round(sizmat(1)/2-zm);X2=round(sizmat(1)/2+zm);Y1=round(sizmat(2)/2-zm);Y2=round(sizmat(2)/2+zm);
smalImafin=abs(imafin(X1:X2,Y1:Y2)).^2;
end
figure;imagesc(abs(smalImafin)); close;
binImaifn = abs(smalImafin);
binImaifn(binImaifn >=ths) = 1;%threshoold of the image is done in the energy value
binImaifn(binImaifn < ths) = 0;
figure;imshow(binImaifn);
%%% graphcarateristics

if (flip_i ~=0)
    imshow(flipud(binImaifn));
end
title( 'ROIs','FontSize', 12);

%
[L, ClutNum] = bwlabel(binImaifn, 8); %label the diferent clutter blobs
average=0;
area=0;
v=0;
allNumbers=[];
for lx=1:ClutNum %search for the different clutter blobs
    blopSize = nnz(L==lx);
    average=average+(sum(abs(smalImafin(L==lx)))/blopSize);
    area=area+blopSize;
    allNumbers=[allNumbers ; smalImafin(L==lx)];
end
averageSig=average/ClutNum;%average energy of the signal
area=area/ClutNum;%Average area of the signal
vSig=var(allNumbers);%Variance of all the values inside the signal blobs


averageBg=(mean(abs(smalImafin(smalImafin>=ths/2 & smalImafin<ths))));
Vbg=var(abs(smalImafin(smalImafin>=ths/2 & smalImafin<ths)));
SNR=20*log10(averageSig/averageBg);

