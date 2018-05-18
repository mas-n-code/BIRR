[DataPair]SAE_Function=[,PD_Location,SL72_S,L288_Pn]
% SAE Single Accuracy Error
% A single antenna element is shifted by PD in both  of the scans;
% 
% %{
%
PD_Location=81; % Error or antenna location 
SAE.Name='Single Aaccuracy Errors';

[SAE.E1.A,SAE.E1.B]=SAcc_Err(1,PD_Location,setA_fold72,setB_fold72,L288_Pn.set_data,L288_Pn.set_ref); % 1/4 Step
[SAE.E2.A,SAE.E2.B]=SAcc_Err(2,PD_Location,setA_fold72,setB_fold72,setA,setB); % 1/2 Step
[SAE.E4.A,SAE.E4.B]=SAcc_Err(4,PD_Location,setA_fold72,setB_fold72,setA,setB); % 1 Step
[SAE.E12.A,SAE.E12.B]=SAcc_Err(12,PD_Location,setA_fold72,setB_fold72,setA,setB); % 3 Step

supershort='SAE 1.25\circ Shift  ';

[S11_Raw,S11_Window,S11_Reconstructed]=...
    monofun_mario_cmS(SAE.E1.A,SAE.E1.B,RecSettings,supershort);

supershort='SAE 15\circ Shift ';

[S11_Raw,S11_Window,S11_Reconstructed]=...
    monofun_mario_cmS(SAE.E12.A,SAE.E12.B,RecSettings,supershort);

SAE.E12.Raw=S11_Raw;
SAE.E12.Win=S11_Window;
SAE.E12.Rec=S11_Reconstructed;


DataPair.SAE=SAE;
%SL72_P1.set_data
%SL72_P1.set_ref
%SL72_P1.set_tumor
P1.set_data
P2.set_ref