function [R_Values,Masks]=mario_imageSegmenter2 (img_array,sProp)
% Scan segmentation based on known location of tumor and fibro target;

[~,mask_tumor] = mario_cMaskerAdvanced(img_array,[sProp.radius_target],sProp.location_tumor,sProp.imx_t,sProp.imy_t); %<=- v increased radius

[~,mask_fibro] = mario_cMaskerAdvanced(img_array,sProp.radius_target,sProp.location_fibro,sProp.imx_t,sProp.imy_t);

% Generates masks
mask_excl_tumor=mario_ROIeXcluder(mask_tumor,1);
mask_excl_fibro=mario_ROIeXcluder(mask_fibro,1);
mask_exclusions=or(mask_excl_tumor,mask_excl_fibro);
mask_targets=or(mask_tumor,mask_fibro);

% Extracts values from masked regions
R_Values.tumor=img_array(mask_tumor);
R_Values.fibro=img_array(mask_fibro);

R_Values.rest=img_array(~or(mask_targets,mask_exclusions));
ind = ~isnan(R_Values.rest);
R_Values.rest=R_Values.rest(ind);

% save the rest of mask
Masks.mask_tumor=mask_tumor;
Masks.mask_fibro=mask_fibro;
Masks.mask_excl_tumor=mask_excl_tumor;
Masks.mask_excl_fibro=mask_excl_fibro;



showexcl=img_array;
%showexcl(or(mask_targets,mask_exclusions))=NaN;

showexcl((mask_exclusions))=NaN;
%showexcl((mask_targets))=5e9;
figure;image(showexcl,'CDataMapping','scaled','AlphaData',~isnan(showexcl));
axis equal;
set(gca,'CLim',[0 5e-9 ]); hold on;
