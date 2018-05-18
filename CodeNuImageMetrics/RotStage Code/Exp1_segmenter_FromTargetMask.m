function [ProcessedExperiments]=Exp1_segmenter_FromTargetMask(ExpSetIMG1,ExpSetIMG2,ExpSetIMG3,sProp)
% fUNCTION FOR one exp ONLY
% note that the ExpSet requires to have three figures of the form
% ExpSet.PD_P1.E1.SCAN.Fig_c_RecZoomFlip_abs
%
%To make things easier for me, I saved the control experiments on a E1
%structure
%
% Function that initializies the PE structure with R values and A Masked
% arrays. The structure goes from Type of Error -> Deg of error ->
% Case1.2.3
%
% Based on experiment_segmenter_FromTargetMask(ErrorScans,sProp)

[ProcessedExperiments.E1.P_P1.A_masked,ProcessedExperiments.E1.P_P1.R_Values] = mario_segmenter_FromTargetMask(ExpSetIMG1,sProp.Masks);
[ProcessedExperiments.E1.P_P2.A_masked,ProcessedExperiments.E1.P_P2.R_Values] = mario_segmenter_FromTargetMask(ExpSetIMG2,sProp.Masks);
[ProcessedExperiments.E1.P_P3.A_masked,ProcessedExperiments.E1.P_P3.R_Values] = mario_segmenter_FromTargetMask(ExpSetIMG3,sProp.Masks);