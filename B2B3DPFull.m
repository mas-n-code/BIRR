%% Change Directory
close all; 

% cd('X:\Shared Folders\Tyson -- Mario\Imaging\0720 Back2Basics') %Guaper

%f_root='C:\Users\Mario\Google Drive\MarioProject2\TEMPFOLDER\B2B\3DP Full';
f_root='F:\UserElGuapo\Google Drive\MarioProject2\TEMPFOLDER\B2B\3DP Full';


cd(f_root);

cd([f_root,'\DataFiles']);

A_Mono_files_W = dir('**Mono*[A]***aW**.txt');
C_Mono_files_W = dir('**Mono*[C]***aW**.txt');

D_Mono_files_W = dir('**Mono*[D]***aW**.txt');
M_Mono_files_W = dir('**Mono*[M]***aW**.txt');
B_Mono_files_W = dir('**Mono*[B]***aW**.txt');

set(0,'defaultAxesFontName', 'Times New Roman')
set(0,'DefaultAxesFontSize',16)
set(0,'DefaultFigureColormap',paruly)
colores.Tumor=cmap(50,:);
colores.Fibro=cmap(35,:);
colores.Back=cmap(10,:);
set(0,'defaultAxesFontName', 'Times New Roman')
set(0,'DefaultAxesFontSize',14)
close all



set_A1=load(A_Mono_files_W(1).name); % First reference
set_A2=load(A_Mono_files_W(2).name); % first reference repeat
set_A3=load(A_Mono_files_W(3).name); % Useful - Reference at 2mm low
set_A4=load(A_Mono_files_W(4).name); % Fibro Refill 
set_A5=load(A_Mono_files_W(5).name); % Fibro Refill Repeat
set_A6=load(A_Mono_files_W(6).name); % Fibro Refill Repeat No MoveLid 2.5 hours later


set_C1=load(C_Mono_files_W(1).name); % CS + Fibro + Tumor

set_M1=load(M_Mono_files_W(1).name); % 

set_D1=load(D_Mono_files_W(1).name); % Fibro


set_B1=load(B_Mono_files_W(1).name); %  Tumor on glycerine with FibroGlyFill
set_B2=load(B_Mono_files_W(2).name); %  Tumor on glycerine with FibroGlyFill Repeat
set_B3=load(B_Mono_files_W(3).name); %   Tumor at second height on glycerine with FibroGlyFill

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
RecSettings.w_sup=8; % window at 10 file at 2
RecSettings.w_inf=14; %window at 15 file at 30
RecSettings.speed=2.75e8; %diegospeed 2.7e8 %%calc at 2.5 fiel at 2.5
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


%% NEW EXP %%
% 1   A3 with A2 – Difference between references moved 2mm
% 
% 2.  A3 with C – Fibro and tumor at 3pm
%     A3 with D  - Fibro only
% 
% 3   A3 with A4- Reference with fibro refill reference. 
% 
% 4-  A4/A5 with C – Fibro and tumor at 3pm with GlyRefill in fibro
%     A4/A5  with D – Fibro with GlyRefill in fibro
% 
% 5.- A4/A5 with B1/B2 – Tumor on fat, no fibro should be present
% 
%     A6 with B1/B3 – Tumor on fat, no fibro should be present, tumor Up

f_root2='F:\UserElGuapo\Google Drive\MarioProject2\TEMPFOLDER\B2B\3DP Full\ImagesNewExpOrder';

%% Exp No1 Differennce Between 2mm references

cd([f_root2,'\Exp 1']);

close all;
B_ack=set_A2;
T_arget=set_A3;
supershort='E1 Difference between 2mm Referenes'; 


RecSettings.Arrasize=size(B_ack,2)/2;
RecSettings.win=1; 
RecSettings.w_sup=8; % window at 10 file at 2
RecSettings.w_inf=14; %window at 15 file at 30
RecSettings.speed=2.45e8; %diegospeed 2.7e8 %%calc at 2.5 fiel at 2.5
RecSettings.radius=0.245; % R

monofun_mario_cmS(B_ack,T_arget,RecSettings,supershort);

%% Exp No1 Differennce Between 2mm references

cd([f_root2,'\Exp 1']);

close all;
B_ack=set_A2;
T_arget=set_A3;
supershort='E1 Difference between 2mm Referenes'; 


RecSettings.Arrasize=size(B_ack,2)/2;
RecSettings.win=1; 
RecSettings.w_sup=8; % window at 10 file at 2
RecSettings.w_inf=14; %window at 15 file at 30
RecSettings.speed=2.45e8; %diegospeed 2.7e8 %%calc at 2.5 fiel at 2.5
RecSettings.radius=0.245; % R

monofun_mario_cmS(B_ack,T_arget,RecSettings,supershort);
cmap=colormap(paruly);


%% Exp No2 Fibro and Tumor, Standard Reference

cd([f_root2,'\Exp 2']);

RecSettings.Arrasize=size(B_ack,2)/2;
RecSettings.win=1; 
RecSettings.w_sup=8; % window at 10 file at 2
RecSettings.w_inf=14; %window at 15 file at 30
RecSettings.speed=2.75e8; %diegospeed 2.7e8 %%calc at 2.5 fiel at 2.5
RecSettings.radius=0.245; % R


close all;
B_ack=set_A3;
T_arget=set_C1;
supershort='E2 C) Fibro and Tumor3pm NormalRef'; 

monofun_mario_cmS(B_ack,T_arget,RecSettings,supershort);

% With Tumor 
close all;
B_ack=set_A3;
T_arget=set_D1;
supershort='E2 D) Fibro NormalRef '; 


monofun_mario_cmS(B_ack,T_arget,RecSettings,supershort);

%% Exp No2.5 Tumor response from a D and C files
cd([f_root2,'\Exp 2-5']);
close all;
B_ack=set_D1;
T_arget=set_C1;
supershort='E2-5 Tumor response from D reference'; 

monofun_mario_cmS(B_ack,T_arget,RecSettings,supershort);

%% Exp No3 FibroRefill Reference vs normal reference
cd([f_root2,'\Exp 3']);
close all;
B_ack=set_A3;
T_arget=set_A4;
supershort='E3 FibroGlyRefill vs Normal reference'; 

monofun_mario_cmS(B_ack,T_arget,RecSettings,supershort);

close all;
B_ack=set_A3;
T_arget=set_A5;
supershort='E3 FibroGlyRefill A5 vs Normal reference'; 

monofun_mario_cmS(B_ack,T_arget,RecSettings,supershort);


%% Exp No4a Tumor amd Fibro on  FibroRefil Reference
cd([f_root2,'\Exp 4']);
close all;
B_ack=set_C1;
T_arget=set_A4;
supershort='E4a TumorAndFibro refA4'; 

monofun_mario_cmS(B_ack,T_arget,RecSettings,supershort);

close all;
B_ack=set_C1;
T_arget=set_A5;
supershort='E4a TumorAndFibro refA5'; 

monofun_mario_cmS(B_ack,T_arget,RecSettings,supershort);



%% Exp No5a Tumor only and Refill reference
cd([f_root2,'\Exp 5']);
close all;
B_ack=set_A5;
T_arget=set_B1;
supershort='E5a Tumor refA5'; 

monofun_mario_cmS(B_ack,T_arget,RecSettings,supershort);


B_ack=set_A5;
T_arget=set_B2;
supershort='E5a Tumor Repeat refA5'; 

monofun_mario_cmS(B_ack,T_arget,RecSettings,supershort);

close all
B_ack=set_A5;
T_arget=set_B3;
supershort='E5b High Tumor refA5'; 

monofun_mario_cmS(B_ack,T_arget,RecSettings,supershort);


B_ack=set_A6;
T_arget=set_B3;
supershort='E5a High Tumor LastReference'; 

monofun_mario_cmS(B_ack,T_arget,RecSettings,supershort);




%% ------------------Experiments out of order*------------------

%%{
cd([f_root2,'\TEST']);
RecSettings.Arrasize=size(B_ack,2)/2;
RecSettings.win=1; 
RecSettings.w_sup=8; % window at 10 file at 2
RecSettings.w_inf=14; %window at 15 file at 30
RecSettings.speed=2.75e8; %diegospeed 2.7e8 %%calc at 2.5 fiel at 2.5
RecSettings.radius=0.245; % R

close all;
B_ack=set_A6;
T_arget=set_B2;
supershort='TEST tumor with last reference'; 

monofun_mario_cmS(B_ack,T_arget,RecSettings,supershort);


close all;
B_ack=set_A6;
T_arget=set_C1;
supershort='TEST Fibro tumor with last reference'; 


monofun_mario_cmS(B_ack,T_arget,RecSettings,supershort);
%}