function [SAE]=SAE_Generator(x_p,FullSet,SampledSet)
setA_fold72=SampledSet.set_ref;
setB_fold72=SampledSet.set_data;
setA=FullSet.set_ref;
setB=FullSet.set_data;


[SAE.E1.ref,SAE.E1.data]=SAcc_Err(1,x_p,setA_fold72,setB_fold72,setA,setB); % 1/4 Step
[SAE.E2.ref,SAE.E2.data]=SAcc_Err(2,x_p,setA_fold72,setB_fold72,setA,setB); % 1/2 Step
[SAE.E4.ref,SAE.E4.data]=SAcc_Err(4,x_p,setA_fold72,setB_fold72,setA,setB); % 1 Step
[SAE.E12.ref,SAE.E12.data]=SAcc_Err(12,x_p,setA_fold72,setB_fold72,setA,setB); % 3 Step