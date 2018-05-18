
%% Rtoary stage A and P errors
% Version 1.0a
%Made by Mario Solis

%----Pending Work
%> Normalize images to noise
% > save images and raws

%% 12_0a.01.a Load Ref and Response sets 
close all; 

%% Load Files
% %{
%@ CAD
%cd('C:\Users\El Mario\Documents\DopboxMyAcount\Dropbox\ResearchMagic\RandomProyects\160110 12 Effects of AR\12_0 Prelude calculate SNR\12_0a\SampletumorData')

%@ Inferno
cd('C:\Users\Mario\Dropbox\ResearchMagic\RandomProyects\160110 12 Effects of AR\12_0 Prelude calculate SNR\12_0a\SampletumorData')

Ref_files = dir('**Mono*[A]***.txt');
TumorFibro_files=dir('*Mono*[C]***.txt');
Tumor_files = dir('**Mono*[B]***.txt');

ref=load(Ref_files(1).name);
data=load(TumorFibro_files(1).name);
setTumor=load(Tumor_files(1).name);
% ref_fold=load(Ref_files(2).name);
% data_fold=load(TumorFibro_files(2).name);

%>> commented to save time<<
%}

%%%% Rec current image
setA=ref;
setB=data;

%% Image Reconstruction Settings
RecSettings.win=1; % Selects wether a window is present or not
RecSettings.w_sup=10; % window at 10
RecSettings.w_inf=15; %window at 15
RecSettings.speed=2.7e8; %diegospeed 2.7e8
RecSettings.radius=0.285; %DiegoRadius 0.285
RecSettings.ver=100; % Reconstruction version of algorithm   %%%%%%
RecSettings.Iclims=[0 5e-9];
RecSettings.counterWise=0;

RecSettings.wflip=0;
if (RecSettings.counterWise==0);
    RecSettings.wflip=1;
end

%% Generate Plus Arrays
setAPlus=[setA,setA];
setBPlus=[setB,setB];

%% Reconstruct original 288L Images
supershort='RSART L288 P1'; 
RecSettings.Arrasize=size(setA,2)/2;

%% SF Sample Fold original dataset into 72

setA_fold72=SampleRaw(4,setA);
setB_fold72=SampleRaw(4,setB);
setTum_fold72=SampleRaw(4,setTumor);

%% Set settings for 72L images
RecSettings.Arrasize=size(setA_fold72,2)/2;

%% Reconstruct Sampled data
supershort='RSART L288 P1 72 Sampled ';

[S11_Raw,S11_Window,S11_Reconstructed]=...
    monofun_mario_cmS(setA_fold72,setB_fold72,RecSettings,supershort);
SF.Com.Name=supershort;
SF.Com.RecSettings=RecSettings;
SF.Com.Raw=S11_Raw;
SF.Com.Win=S11_Window;
SF.Com.Rec=S11_Reconstructed;

%% Reconstruct Tumor Only data

supershort='72 -T- Tumor Only ';

[S11_Raw,S11_Window,S11_Reconstructed]=...
    monofun_mario_cmS(setA_fold72,setTum_fold72,RecSettings,supershort);
SF.Tumor.Name=supershort;
SF.Tumor.RecSettings=RecSettings;
SF.Tumor.Raw=S11_Raw;
SF.Tumor.Win=S11_Window;
SF.Tumor.Rec=S11_Reconstructed;


%% SAE Single Accuracy Error
% A single antenna element is shifted in both  of the scans;
%{
%% SAE Shift position x_p by 5deg
x_p=81; % Error or Antenna position

[SAE.E1.A,SAE.E1.B]=SAcc_Err(1,x_p,setA_fold72,setB_fold72,setA,setB); % 1/2 Step
[SAE.E2.A,SAE.E2.B]=SAcc_Err(2,x_p,setA_fold72,setB_fold72,setA,setB); % 1/2 Step
[SAE.E4.A,SAE.E4.B]=SAcc_Err(4,x_p,setA_fold72,setB_fold72,setA,setB); % 1/2 Step
[SAE.E12.A,SAE.E12.B]=SAcc_Err(12,x_p,setA_fold72,setB_fold72,setA,setB); % 3 Step

supershort='SAE 1.25\circ Shift  ';

[S11_Raw,S11_Window,S11_Reconstructed]=...
    monofun_mario_cmS(SAE.E1.A,SAE.E1.B,RecSettings,supershort);

supershort='SAE 15\circ Shift ';

[S11_Raw,S11_Window,S11_Reconstructed]=...
    monofun_mario_cmS(SAE.E12.A,SAE.E12.B,RecSettings,supershort);

SAE.E12.Raw=S11_Raw;
SAE.E12.Win=S11_Window;
SAE.E12.Rec=S11_Reconstructed;

%} 

%% CAE Collective Accuracy Error 
% All antenna elements are shifted in both  of the scans;
%{
%% CAE Shift all positions by 1.25 deg
%x_p=81;


[CAE.E1.A,CAE.E1.B]=CAcc_Err(1,setA_fold72,setB_fold72,setA,setB); % 1/2 Step
[CAE.E2.A,CAE.E2.B]=CAcc_Err(2,setA_fold72,setB_fold72,setA,setB); % 1/2 Step
[CAE.E4.A,CAE.E4.B]=CAcc_Err(4,setA_fold72,setB_fold72,setA,setB); % 1/2 Step
[CAE.E12.A,CAE.E12.B]=CAcc_Err(12,setA_fold72,setB_fold72,setA,setB); % 3 Step

supershort='CAE 1.25\circ Shift  ';

[S11_Raw,S11_Window,S11_Reconstructed]=...
    monofun_mario_cmS(CAE.E1.A,CAE.E1.B,RecSettings,supershort);

supershort='CAE 15\circ Shift ';

[S11_Raw,S11_Window,S11_Reconstructed]=...
    monofun_mario_cmS(CAE.E12.A,CAE.E12.B,RecSettings,supershort);



%}

%% SPE Single Precision Error
% A single antenna element in the Rotary stage is shifted at one of the
% scans.


% Create data set pairs with SPE error
[SPE.E1.A,SPE.E1.B]=SPre_Err(1,81,setA_fold72,setB_fold72,setA,setB); % 1/2 Step
[SPE.E2.A,SPE.E2.B]=SPre_Err(2,81,setA_fold72,setB_fold72,setA,setB); % 1/2 Step
[SPE.E4.A,SPE.E4.B]=SPre_Err(4,81,setA_fold72,setB_fold72,setA,setB); % 1/2 Step
[SPE.E12.A,SPE.E12.B]=SPre_Err(12,81,setA_fold72,setB_fold72,setA,setB); % 1/2 Step

supershort='SPE  1.25\circ Shift ';

% Reconstruct Images

[S11_Raw,S11_Window,S11_Reconstructed]=...
    monofun_mario_cmS(SPE.E1.A,SPE.E1.B,RecSettings,supershort);
SPE.E1.Raw=S11_Raw;
SPE.E1.Win=S11_Window;
SPE.E1.Rec=S11_Reconstructed;


supershort='SPE  15\circ Shift ';

[S11_Raw,S11_Window,S11_Reconstructed]=...
    monofun_mario_cmS(SPE.E12.A,SPE.E12.B,RecSettings,supershort);

SPE.E12.Raw=S11_Raw;
SPE.E12.Win=S11_Window;
SPE.E12.Rec=S11_Reconstructed;

%}

%% CPE Collective Precision Error
%{

% All antenna elements are shifted in one of the scans; based on CAE

% Create data set pairs with CPE error
[CPE.E1.A,CPE.E1.B]=CPre_Err(1,setA_fold72,setB_fold72,setA,setB); % 1/4 Step
[CPE.E2.A,CPE.E2.B]=CPre_Err(2,setA_fold72,setB_fold72,setA,setB); % 1/2 Step
[CPE.E4.A,CPE.E4.B]=CPre_Err(4,setA_fold72,setB_fold72,setA,setB); % 1 Step
[CPE.E12.A,CPE.E12.B]=CPre_Err(12,setA_fold72,setB_fold72,setA,setB); % 3 Step


% Reconstruct images.

supershort='CPE  1.25\circ Shift ';

[S11_Raw,S11_Window,S11_Reconstructed]=...
    monofun_mario_cmS(CPE.E1.A,CPE.E1.B,RecSettings,supershort);

supershort='CPE  15\circ Shift ';

[S11_Raw,S11_Window,S11_Reconstructed]=...
    monofun_mario_cmS(CPE.E12.A,CPE.E12.B,RecSettings,supershort);

%}

%% Save parameters
%%T
figure;
% imagesc(log10(S11_Reconstructed),[0 100]);