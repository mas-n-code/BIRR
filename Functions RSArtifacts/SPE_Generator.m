function [SPE]=SPE_Generator(L288_FullSet,SL72_SampledSet,x_p)
% SPE_Generator(x_p,L288_FullSet,SL72_SampledSet) for Rotary Stage errors
%: 
%L288_FullSet: 
%SL72_SampledSet:

% Generate XXErrors for refernce and data files as pairs. Depending on the
% type of error, the ref file might be an untouched copy of the sampled ref
% file. While ineficient to generete so many copies of ref files, this
% allows for self-dependency of the reconstructed files. 
% Worst position must be 49,50,51


setA_fold72=SL72_SampledSet.set_ref;
setB_fold72=SL72_SampledSet.set_data;
setA=L288_FullSet.set_ref;
setB=L288_FullSet.set_data;

[SPE.E1.ref,SPE.E1.data]=SPre_Err(1,x_p,setA_fold72,setB_fold72,setA,setB); % 1/4 Step
[SPE.E2.ref,SPE.E2.data]=SPre_Err(2,x_p,setA_fold72,setB_fold72,setA,setB); % 1/2 Step
[SPE.E4.ref,SPE.E4.data]=SPre_Err(4,x_p,setA_fold72,setB_fold72,setA,setB); % 1 Step
[SPE.E12.ref,SPE.E12.data]=SPre_Err(12,x_p,setA_fold72,setB_fold72,setA,setB); % 3 Step