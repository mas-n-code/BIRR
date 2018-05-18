%% Change Directory
close all; 

% cd('X:\Shared Folders\Tyson -- Mario\Imaging\0720 Back2Basics') %Guaper

f_root='C:\Users\Mario\Google Drive\MarioProject2\TEMPFOLDER\B2B\3DP Full';
cd(f_root);

cd([f_root,'\DataFiles']);

A_Mono_files_W = dir('**Mono*[A]***aW**.txt');
C_Mono_files_W = dir('**Mono*[C]***aW**.txt');

D_Mono_files_W = dir('**Mono*[D]***aW**.txt');
M_Mono_files_W = dir('**Mono*[M]***aW**.txt');

cmap=colormap(paruly);
colores.Tumor=cmap(50,:);
colores.Fibro=cmap(35,:);
colores.Back=cmap(10,:);
set(0,'defaultAxesFontName', 'Times New Roman')
set(0,'DefaultAxesFontSize',14)
close all

set_A4=load(A_Mono_files_W(3).name); % Chamber + Reffill
set_A3=load(A_Mono_files_W(3).name); % Chamber + Support
set_A2=load(A_Mono_files_W(2).name); % Chamber + Support
set_A1=load(A_Mono_files_W(1).name); % Chamber + Support
set_C1=load(C_Mono_files_W(1).name); % CS + Fibro + Tumor
set_M1=load(M_Mono_files_W(1).name); % 
%set_BO=load(B_Mono_files_W(1).name); % 
set_D1=load(D_Mono_files_W(1).name); % simple fibro
%set_D2=load(D_Mono_files_W(2).name); % complex fibro

%% Rec Settings

RecSettings.ver=100; % Reconstruction version of algorithm   %%%%%%

RecSettings.counterWise=0;

RecSettings.wflip=0;
if (RecSettings.counterWise==0);
    RecSettings.wflip=1;
end

RecSettings.fl_low=1e9; % Freq settings for cm conversion Typically fl_low=2e9;
RecSettings.fl_high=8e9; % Freq settings for cm conversion  Typically fl_high=8e9; 



% Important ones
RecSettings.win=1; % Selects wether a window is present or not
RecSettings.w_sup=5; % window at 10 file at 2
RecSettings.w_inf=15; %window at 15 file at 30
RecSettings.speed=2.55e8; %diegospeed 2.7e8 %%calc at 2.5 fiel at 2.5
RecSettings.radius=0.245; % Radious of antenna to center%DiegoRadius 0.285, 10cm are added %%22calc % 204 according to Mario and Diego file at 204
RecSettings.Bdiam=14;
RecSettings.Iclims=[0 13e-9];
%}
RecSettings.colores=colores;

%% Reconstruct TUMOR AND FIBOR
cd([f_root,'\Images\01 C TumorFat']);

close all;
B_ack=set_A3;
T_arget=set_C1;
supershort='C1 FibroAndTumor'; 

RecSettings.Arrasize=size(B_ack,2)/2;
RecSettings.win=1; 
RecSettings.w_sup=8; % window at 10 file at 2
RecSettings.w_inf=16; %window at 15 file at 30
RecSettings.speed=2.55e8; %diegospeed 2.7e8 %%calc at 2.5 fiel at 2.5
RecSettings.radius=0.245; % R

monofun_mario_cmS(B_ack,T_arget,RecSettings,supershort);


%% Reconstruct FIBRO
cd([f_root,'\Images\02 D FIBRO']);

close all;
B_ack=set_A3;
T_arget=set_D1;
supershort='D1 FibroOnly'; 

RecSettings.Arrasize=size(B_ack,2)/2;
RecSettings.win=1; 
RecSettings.w_sup=8; % window at 10 file at 2
RecSettings.w_inf=14; %window at 15 file at 30
RecSettings.speed=2.75e8; %diegospeed 2.7e8 %%calc at 2.5 fiel at 2.5
RecSettings.radius=0.245; % R

monofun_mario_cmS(B_ack,T_arget,RecSettings,supershort);

%% Reconstruct MROD
cd([f_root,'\Images\03 M MetalRod']);

close all;
B_ack=set_A4;
T_arget=set_A1;
supershort='TEST Rod with Ref'; 


RecSettings.Arrasize=size(B_ack,2)/2;
RecSettings.win=1; 
RecSettings.w_sup=8; % window at 10 file at 2
RecSettings.w_inf=14; %window at 15 file at 30
RecSettings.speed=2.75e8; %diegospeed 2.7e8 %%calc at 2.5 fiel at 2.5
RecSettings.radius=0.245; % R

monofun_mario_cmS(B_ack,T_arget,RecSettings,supershort);
