function [LeanGroup]=Group_LeanGroupMaker(HeavyGroup)
% Tries to generate lighter memmory files with only the image metrics associated
% with the scans

LeanGroup.GName=HeavyGroup.GName;
LeanGroup.GeSummary=HeavyGroup.GeSummary;


removeFields={'ref','data','SCAN'};
LeanGroup.E1=rmfield(HeavyGroup.E1,removeFields);
% LeanGroup.E2=rmfield(HeavyGroup.E2,removeFields);
% LeanGroup.E4=rmfield(HeavyGroup.E4,removeFields);
% LeanGroup.E12=rmfield(HeavyGroup.E12,removeFields);
