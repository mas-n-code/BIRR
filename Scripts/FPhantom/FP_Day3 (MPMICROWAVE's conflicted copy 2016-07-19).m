%FP Day 3
%% Change Directory
close all; 

cd('F:\UserElGuapo\Google Drive\MarioProject2\160204 FP Day2\DataSets\Experiment Two') %Guaper

%cd('C:\Users\El Mario\Google Drive\MarioProject2\160204 FP Day2\DataSets\Experiment Two')


%% Load Files 
load('M_set_XA_CW.mat')
load('M_set_XO_CW.mat')
%{
O_Mono_files_W = dir('**Mono*O_***aW**.txt');
A_Mono_files_W = dir('**Mono*A_***aW**.txt');
%TumorFibro_files=dir('*Mono*[C]***.txt');
%Tumor_files = dir('**Mono*[B]***.txt');


%{
%
set_AO=load(O_Mono_files_W(1).name); % Chamber + Support
set_CO=load(O_Mono_files_W(2).name); % CS + Fibro + Tumor
set_DO=load(O_Mono_files_W(3).name); % CS + Fibro
set_OO=load(O_Mono_files_W(4).name); %%Chamber
%}

%{
%
set_AA_1=load(A_Mono_files_W(1).name); % Ref no Refill [CS + FAT]
set_AA_2=load(A_Mono_files_W(2).name); % Ref with Refill [CS + FAT]
set_BA=load(A_Mono_files_W(3).name);   % CSF + TUMOR P-1 
set_CA_2=load(A_Mono_files_W(4).name); % CSF + ExT + FibroGlandular % no
actual tumor present
set_CA_1=load(A_Mono_files_W(5).name); % CSF + Tumor + FG
%}



%}
 
%<<<<<



%% Image Reconstruction Settings
%%{ 
RecSettings.win=0; % Selects wether a window is present or not
RecSettings.w_sup=2; % window at 10
RecSettings.w_inf=30; %window at 15
RecSettings.speed=2.5e8; %diegospeed 2.7e8 %%calc at 2.5
RecSettings.radius=0.204; % Radious of antenna to center%DiegoRadius 0.285, 10cm are added %%22calc % 204 according to Mario and Diego
RecSettings.ver=100; % Reconstruction version of algorithm   %%%%%%
RecSettings.Iclims=[0 1.4e-6];
RecSettings.counterWise=0;

RecSettings.wflip=0;
if (RecSettings.counterWise==0);
    RecSettings.wflip=1;
end


%}


%% Reconstruct images OO

% 1) First Reconstruction [Support]
%{
B_ack=set_OO;
T_arget=set_AO;
supershort='Support in Chamber'; 

RecSettings.Arrasize=size(B_ack,2)/2;
[S11_Raw,S11_Window,S11_Reconstructed]=...
    monofun_mario_cmS(B_ack,T_arget,RecSettings,supershort);

%}

% 2) Second Rec [Fibro No Fat]
%{

B_ack=set_AO;
T_arget=set_DO;
supershort='Fibro No Fat'; 

RecSettings.Arrasize=size(B_ack,2)/2;
[S11_Raw,S11_Window,S11_Reconstructed]=...
    monofun_mario_cmS(B_ack,T_arget,RecSettings,supershort);
%}

% 3) Third Rec [Fibro No Fat]
%{

B_ack=set_AO;
T_arget=set_CO;
supershort='Fibro+Tumor No Fat'; 

RecSettings.Arrasize=size(B_ack,2)/2;

[S11_Raw,S11_Window,S11_Reconstructed]=...
    monofun_mario_cmS(B_ack,T_arget,RecSettings,supershort);
%}



%%AA settings

RecSettings.speed=2.5e8; %diegospeed 2.7e8 %%calc at 2.5
RecSettings.radius=0.205; % Radious of antenna to center%DiegoRadius 0.285, 10cm are added %%22calc
RecSettings.Iclims=[0 3.5e-6];


%% A Fibro Only
% 1) CA_1 [CompletePhantom]
%{

B_ack=set_AO;
T_arget=set_AA_2;
supershort='Fatty breast No Tumor'; 

RecSettings.Arrasize=size(B_ack,2)/2;

[S11_Raw,S11_Window,S11_Reconstructed]=...
    monofun_mario_cmS(B_ack,T_arget,RecSettings,supershort);
%}


%% A version Tumor only
% 1) BA [TumorOnly]
%{

B_ack=set_AA_2;
T_arget=set_BA;
supershort='Tumor on fatty breast [Calibrated]'; 

RecSettings.Arrasize=size(B_ack,2)/2;

[S11_Raw,S11_Window,S11_Reconstructed]=...
    monofun_mario_cmS(B_ack,T_arget,RecSettings,supershort);
%}


%{

B_ack=set_AO; 
T_arget=set_BA;
supershort='Tumor on fatty breast [Not Calibrated]'; 

RecSettings.Arrasize=size(B_ack,2)/2;

[S11_Raw,S11_Window,S11_Reconstructed]=...
    monofun_mario_cmS(B_ack,T_arget,RecSettings,supershort);
%}



%% AC version Complete with tumor
% 
%%{

B_ack=set_AA_2;
T_arget=set_CA_1;
supershort='Tumor and Fibro in fatty breast'; 

RecSettings.Arrasize=size(B_ack,2)/2;

[S11_Raw,S11_Window,S11_Reconstructed]=...
    monofun_mario_cmS(B_ack,T_arget,RecSettings,supershort);
%}


%{

B_ack=set_AO; 
T_arget=set_CA_1;
supershort='Tumor and Fibro in fatty breast'; 

RecSettings.Arrasize=size(B_ack,2)/2;

[S11_Raw,S11_Window,S11_Reconstructed]=...
    monofun_mario_cmS(B_ack,T_arget,RecSettings,supershort);
%}

%% AC-EX1 version Complete with EXtumor
% 
%{

B_ack=set_AA_2;
T_arget=set_CA_2;
supershort='EXT+FG in fatty breast [Calibrated]'; 

RecSettings.Arrasize=size(B_ack,2)/2;

[S11_Raw,S11_Window,S11_Reconstructed]=...
    monofun_mario_cmS(B_ack,T_arget,RecSettings,supershort);
%}


%{

B_ack=set_AO; 
T_arget=set_CA_2;
supershort='EXT+FG in fatty breast [Not Calibrated]'; 

RecSettings.Arrasize=size(B_ack,2)/2;

[S11_Raw,S11_Window,S11_Reconstructed]=...
    monofun_mario_cmS(B_ack,T_arget,RecSettings,supershort);
%}

