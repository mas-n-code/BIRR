%--------------------------------------------------------------------------
%---------------------mario_ROT_Scan_EXTRACTOR-----------------------------
%--------------------------------------------------------------------------
% August 14 Doesnt work as a function
% Extracts -Scan- Structures  out of previously reconstructed datasets for
% new processing
function ROT_Scan_Extractor(ExperimentGroup,name)

ExperimentGroup_ScansOnly.PD_P1.E1.SCAN=rmfield(ExperimentGroup.PD_P1.E1.SCAN,'S11_c_Rec');
ExperimentGroup_ScansOnly.PD_P1.E2.SCAN=rmfield(ExperimentGroup.PD_P1.E2.SCAN,'S11_c_Rec');
ExperimentGroup_ScansOnly.PD_P1.E4.SCAN=rmfield(ExperimentGroup.PD_P1.E4.SCAN,'S11_c_Rec');
ExperimentGroup_ScansOnly.PD_P1.E12.SCAN=rmfield(ExperimentGroup.PD_P1.E12.SCAN,'S11_c_Rec');
ExperimentGroup_ScansOnly.PD_P1.GName=ExperimentGroup.PD_P1.GName;

ExperimentGroup_ScansOnly.PD_P2.E1.SCAN=rmfield(ExperimentGroup.PD_P2.E1.SCAN,'S11_c_Rec');
ExperimentGroup_ScansOnly.PD_P2.E2.SCAN=rmfield(ExperimentGroup.PD_P2.E2.SCAN,'S11_c_Rec');
ExperimentGroup_ScansOnly.PD_P2.E4.SCAN=rmfield(ExperimentGroup.PD_P2.E4.SCAN,'S11_c_Rec');
ExperimentGroup_ScansOnly.PD_P2.E12.SCAN=rmfield(ExperimentGroup.PD_P2.E12.SCAN,'S11_c_Rec');
ExperimentGroup_ScansOnly.PD_P2.GName=ExperimentGroup.PD_P2.GName;

ExperimentGroup_ScansOnly.PD_P3.E1.SCAN=rmfield(ExperimentGroup.PD_P3.E1.SCAN,'S11_c_Rec');
ExperimentGroup_ScansOnly.PD_P3.E2.SCAN=rmfield(ExperimentGroup.PD_P3.E2.SCAN,'S11_c_Rec');
ExperimentGroup_ScansOnly.PD_P3.E4.SCAN=rmfield(ExperimentGroup.PD_P3.E4.SCAN,'S11_c_Rec');
ExperimentGroup_ScansOnly.PD_P3.E12.SCAN=rmfield(ExperimentGroup.PD_P3.E12.SCAN,'S11_c_Rec');
ExperimentGroup_ScansOnly.PD_P3.GName=ExperimentGroup.PD_P3.GName;

save(name,'ExperimentGroup_ScansOnly')


