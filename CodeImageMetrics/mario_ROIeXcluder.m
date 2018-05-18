function ROI_ExclusionEdge=mario_ROIeXcluder(ROI,dil_index)
% Dilates the ROI to generate an exclusion zone, removes penumbra region

se = strel('diamond',dil_index);
afterOpening = imdilate(ROI,se);
ROI_ExclusionEdge=logical(afterOpening-ROI);