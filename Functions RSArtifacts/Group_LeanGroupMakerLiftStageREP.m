function [LeanGroup]=Group_LeanGroupMakerLiftStageREP(HeavyGroup)
% Tries to generate lighter memmory files with only the image metrics associated
% with the scans

LeanGroup.GName=HeavyGroup.GName;
LeanGroup.GeSummary=HeavyGroup.GeSummary;


removeFields={'set_ref','set_data','set_tumor','SCAN'};
LeanGroup.E1=rmfield(HeavyGroup.E1,removeFields);
LeanGroup.E2=rmfield(HeavyGroup.E2,removeFields);
%LeanGroup.E3=rmfield(HeavyGroup.E3,removeFields);

