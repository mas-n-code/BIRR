%Distance Cal
% Distance Cal was an experiment where a 0.5mm rod was place at
% controlled distances 11,33 and 55 radial millimeters from the center.
%It is mm, do not believe filenames
% Distance cal can be used to determine positional accuracy of the
% algorithm and other stuff
% data might have been recorded at 2Ghz
% Current version 1.1
%
% version 1.0 created on February 8

%verision changes
%V 1.1
% added fl_low and fl_high settings as per new monofun_mario_cmS V1.1.5

%% Change Directory
close all; 



%Guaper
%cd('F:\UserElGuapo\Google Drive\\MarioProject2\160208 DistanceCal') %Guaper

%Cad
cd('C:\Users\El Mario\Google Drive\MarioProject2\160208 DistanceCal')


%% Load Files 
%load('M_set_XA_CW.mat')
%load('M_set_XO_CW.mat')

%%{
D_Mono_files_W = dir('**Mono*_D***aW**.txt');
A_Mono_files_W = dir('**Mono*A_***aW**.txt');



%%{
%
set_se_D1=load(D_Mono_files_W(1).name); % Chamber + Support
set_se_D2=load(D_Mono_files_W(2).name); % CS + Fibro + Tumor
set_se_D3=load(D_Mono_files_W(3).name); % CS + Fibro
%}

%%{
%
set_AA_Ref=load(A_Mono_files_W(1).name); % Ref no Refill [CS + FAT]

%}



%}
 
%<<<<<



%% Image Reconstruction Settings
%%{ 
RecSettings.win=1; % Selects wether a window is present or not
RecSettings.w_sup=2; % window at 10
RecSettings.w_inf=30; %window at 15
RecSettings.speed=2.9e8; %diegospeed 2.7e8
RecSettings.radius=0.20; % Radious of antenna to center of rotation DiegoRadius 0.285, 2cm are added? 
RecSettings.ver=100; % Reconstruction version of algorithm   %%%%%%
RecSettings.Iclims=[0 6.5e-5];
RecSettings.clockwise=1;
RecSettings.fl_low=1e9;
RecSettings.fl_high=8e9;

RecSettings.wflip=0;
if (RecSettings.clockwise==1);
    RecSettings.wflip=1;
end


%}


%% Reconstruct images OO

% 1) First Reconstruction [D1]
 %%{
B_ack=set_AA_Ref;
T_arget=set_se_D1;
supershort='D1 11'; 

RecSettings.Arrasize=size(B_ack,2)/2;
[S11_Raw,S11_Window,S11_Reconstructed]=...
    monofun_mario_cmS(B_ack,T_arget,RecSettings,supershort);
save ([supershort  ' RecImage.mat'], 'S11_Reconstructed')
save ([supershort  ' RawWin.mat'], 'S11_Window')
%}

% 2) Second Reconstruction [D2]
 % %{
B_ack=set_AA_Ref;
T_arget=set_se_D2;
supershort='D2 33'; 

RecSettings.Arrasize=size(B_ack,2)/2;
[S11_Raw,S11_Window,S11_Reconstructed]=...
    monofun_mario_cmS(B_ack,T_arget,RecSettings,supershort);

%}

% 2) Third Reconstruction [D3]
%%{
B_ack=set_AA_Ref;
T_arget=set_se_D3;
supershort='D3 53'; 

RecSettings.Arrasize=size(B_ack,2)/2;
[S11_Raw,S11_Window,S11_Reconstructed]=...
    monofun_mario_cmS(B_ack,T_arget,RecSettings,supershort);

save ([supershort  ' RecImage.mat'], 'S11_Reconstructed')
save ([supershort  ' RawWin.mat'], 'S11_Window')

%}
save DistanceCal_RecSettings RecSettings;
 