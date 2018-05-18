function [RAE_Set]=RAE_Generator(L288_FullSet,SL72_SampledSet)
% [RAE_Set]=RAE_Generator(L288_FullSet,SL72_SampledSet) for Rotary Stage errors
%: 
%L288_FullSet: 
%SL72_SampledSet:

% Generate XXErrors for refernce and data files as pairs. Depending on the
% type of error, the ref file might be an untouched copy of the sampled ref
% file. While ineficient to generete so many copies of ref files, this
% allows for self-dependency of the reconstructed files. 

setA_fold72=SL72_SampledSet.set_ref;


set_Ref_Full=L288_FullSet.set_ref;
set_Data_Full=L288_FullSet.set_data;


cd('F:\UserElGuapo\DBOx\Dropbox\ResearchMagic\RandomProyects\160110 12 Effects of AR\MASTER Dataset\AllErrors\RE Base\Uniform Errors')

load uRa_E1.mat
load uRa_E2.mat
load uRa_E4.mat
load uRa_E12.mat


[RAE_Set.E1.ref,RAE_Set.E1.data,RAE_Set.E1.errorArray]=RAcc_Err(uRa_E1,set_Ref_Full,set_Data_Full); % 1/4 Step
[RAE_Set.E2.ref,RAE_Set.E2.data,RAE_Set.E2.errorArray]=RAcc_Err(uRa_E2,set_Ref_Full,set_Data_Full); % 1/2 Step
[RAE_Set.E4.ref,RAE_Set.E4.data,RAE_Set.E4.errorArray]=RAcc_Err(uRa_E4,set_Ref_Full,set_Data_Full); % 1 Step
[RAE_Set.E12.ref,RAE_Set.E12.data,RAE_Set.E12.errorArray,ref_norm]=RAcc_Err(uRa_E12,set_Ref_Full,set_Data_Full); % 3 Step

size(ref_norm)
size(setA_fold72)

max(max(ref_norm-setA_fold72)) % compares values of ref_norm and the folded one to see if they are different.