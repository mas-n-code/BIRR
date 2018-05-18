%Signal Boundry detection for Rec Images
% Used to determine the exclusion zone of the structures
%dilIndex -> Determines the dilatation value in pixels {3}
%nBlobs -> Number of adjacent patches
%
function RecEdge=IEdge_Locator(RecImage,open_index,dil_index,nBlobs)
%WAaa = im2bw(RecImage, max(max(RecImage))*.5);
ROI=IFWHM(RecImage,open_index,nBlobs);



se = strel('diamond',dil_index);
afterOpening = imdilate(ROI,se);
RecEdge=logical(afterOpening-ROI);

%Present images after dilate
%{
figure, 
subplot(1,2,1);
imshow(WAaa);
subplot(1,2,2);
imshow(RecEdge);
%}



%{
[B,L] = bwboundaries(BW,'noholes');
figure; 
subplot(2,2,1); imagesc(RecImage);
subplot(2,2,2); imshow(BW);
subplot(2,2,3); imshow(label2rgb(L, @jet, [.5 .5 .5]));
hold on
for k = 1:length(B)
    boundary = B{k};
    plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 2)
end

WAaa=logical(WAaa);
%}