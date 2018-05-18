function [ProcessedExperiments]=experiment_segmenter_FromTargetMask_LS(ErrorScans,sProp)
% Function that initializies the PE structure with R values and A Masked
% arrays. The structure goes from Type of Error -> Deg of error ->
% Case1.2.3

[ProcessedExperiments.E1.P_P1.A_masked,ProcessedExperiments.E1.P_P1.R_Values] = mario_segmenter_FromTargetMask_LS(ErrorScans.PD_P1.E1.SCAN.Fig_c_RecZoomFlip_abs,sProp.Masks);
[ProcessedExperiments.E1.P_P2.A_masked,ProcessedExperiments.E1.P_P2.R_Values] = mario_segmenter_FromTargetMask_LS(ErrorScans.PD_P2.E1.SCAN.Fig_c_RecZoomFlip_abs,sProp.Masks);

[ProcessedExperiments.E2.P_P1.A_masked,ProcessedExperiments.E2.P_P1.R_Values] = mario_segmenter_FromTargetMask_LS(ErrorScans.PD_P1.E2.SCAN.Fig_c_RecZoomFlip_abs,sProp.Masks);
[ProcessedExperiments.E2.P_P2.A_masked,ProcessedExperiments.E2.P_P2.R_Values] = mario_segmenter_FromTargetMask_LS(ErrorScans.PD_P2.E2.SCAN.Fig_c_RecZoomFlip_abs,sProp.Masks);
try
[ProcessedExperiments.E3.P_P1.A_masked,ProcessedExperiments.E3.P_P1.R_Values] = mario_segmenter_FromTargetMask_LS(ErrorScans.PD_P1.E3.SCAN.Fig_c_RecZoomFlip_abs,sProp.Masks);
[ProcessedExperiments.E3.P_P2.A_masked,ProcessedExperiments.E3.P_P2.R_Values] = mario_segmenter_FromTargetMask_LS(ErrorScans.PD_P2.E3.SCAN.Fig_c_RecZoomFlip_abs,sProp.Masks);
catch 
    disp('E1-E2 only')
end
