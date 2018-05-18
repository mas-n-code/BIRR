function [CAE]=CAE_Generator(L288_FullSet,SL72_SampledSet)
% CAE_Generator(x_p,L288_FullSet,SL72_SampledSet) for Rotary Stage errors
%: 
%L288_FullSet: 
%SL72_SampledSet:

% Generate XXErrors for refernce and data files as pairs. Depending on the
% type of error, the ref file might be an untouched copy of the sampled ref
% file. While ineficient to generete so many copies of ref files, this
% allows for self-dependency of the reconstructed files. 

setA_fold72=SL72_SampledSet.set_ref;
setB_fold72=SL72_SampledSet.set_data;
setA=L288_FullSet.set_ref;
setB=L288_FullSet.set_data;

[CAE.E1.ref,CAE.E1.data]=CAcc_Err(1,setA_fold72,setB_fold72,setA,setB); % 1/4 Step
[CAE.E2.ref,CAE.E2.data]=CAcc_Err(2,setA_fold72,setB_fold72,setA,setB); % 1/2 Step
[CAE.E4.ref,CAE.E4.data]=CAcc_Err(4,setA_fold72,setB_fold72,setA,setB); % 1 Step
[CAE.E12.ref,CAE.E12.data]=CAcc_Err(12,setA_fold72,setB_fold72,setA,setB); % 3 Step