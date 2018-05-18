function [masked_img,R_Values]=mario_segmenter_FromTargetMask_LS(img_array,Masks)
% [masked_img R_Values]=mario_segmenter_FromTargetMask(img_array,Masks)
% Removes values otside of the phantom diameter
% Segment, meant to return values from pre-define control masks (known location of targets)


%Unwrap masks from Masks structure
c_mask=Masks.cMask; 
% mask_tumor=Masks.mask_tumorHand;  %Now requiers one of the hand formables
% mask_fibro=Masks.mask_fibroHand; %Now requiers one of the hand formables

mask_tumor=Masks.mask_tumorHandBig;  %Comment if not using Big!!!
mask_fibro=Masks.mask_fibroHandBig;  %Comment if not using BIG


mask_targets=or(mask_tumor,mask_fibro);

%mask_excl_tumor=Masks.mask_excl_tumor;
%mask_excl_fibro=Masks.mask_excl_fibro;
%mask_exclusion=or(mask_excl_tumor,mask_excl_fibro);

% masks outer ring
masked_img=img_array;
masked_img(~c_mask)=NaN;

% Extracts values from masked regions
R_Values.tumor=img_array(mask_tumor);
R_Values.fibro=img_array(mask_fibro);

R_Values.rest=img_array(~mask_targets);
ind = ~isnan(R_Values.rest); %Removes NaN values out of the rest of the pixels
R_Values.rest=R_Values.rest(ind);





