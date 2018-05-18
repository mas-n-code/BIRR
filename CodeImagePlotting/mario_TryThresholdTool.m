function [ExpSet]= mario_TryThresholdTool(thres_val,ExpSet)
% function [C_P1,C_P2,C_P3]= mario_TryThresholdTool(thres_val,C_P1,C_P2,C_P3,sProp) 
% TryThresholdTool does a lot of things at once!
% {Note that it requires the full Scan structure}
% 01 Generates an Array-Mask pair given a low background threshold

% 03 Scans the R_Values parent and generates R_tValues parent with only
% values above desired threshold.

% 01 Apply threshold and generated mask and masked arrays
[ExpSet.P_P1.A_tmasked,ExpSet.P_P1.Masks.mask_thresh]=mario_tMasker(ExpSet.P_P1.A_masked,thres_val);
[ExpSet.P_P2.A_tmasked,ExpSet.P_P2.Masks.mask_thresh]=mario_tMasker(ExpSet.P_P2.A_masked,thres_val);
[ExpSet.P_P3.A_tmasked,ExpSet.P_P3.Masks.mask_thresh]=mario_tMasker(ExpSet.P_P3.A_masked,thres_val);
              
% 03 Generate arrays  above background threshold
ExpSet.P_P1.R_tValues = R_aboveTValues(ExpSet.P_P1.R_Values,thres_val);
ExpSet.P_P2.R_tValues = R_aboveTValues(ExpSet.P_P2.R_Values,thres_val);
ExpSet.P_P3.R_tValues = R_aboveTValues(ExpSet.P_P3.R_Values,thres_val);

% Generate a 'clutter' region above threshold'
function [R_tValues] = R_aboveTValues(ScanRValues,threshold)

R_tValues.tumor=ScanRValues.tumor(ScanRValues.tumor>threshold);
R_tValues.fibro=ScanRValues.fibro(ScanRValues.fibro>threshold);     
R_tValues.clutter=ScanRValues.rest(ScanRValues.rest>threshold); %Generate a 'clutter' region above threshold'
disp(['->Filtered ',num2str(length(ScanRValues.rest)-length(R_tValues.clutter)),' pixels out as background']);
