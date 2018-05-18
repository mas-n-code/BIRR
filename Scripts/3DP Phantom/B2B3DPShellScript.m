% Mario new script
%% Change Directory
close all; 

% cd('X:\Shared Folders\Tyson -- Mario\Imaging\0720 Back2Basics') %Guaper

f_root='C:\Users\Mario\Google Drive\MarioProject2\TEMPFOLDER\B2B\3DPShell';
cd(f_root);
%% Load Files 

cd([f_root,'\03 Glycerine Cover']) %Guaper
A_Mono_files_W = dir('**Mono*[A]***aW**.txt');
set_A1=load(A_Mono_files_W(1).name);
%
cd([f_root,'\05 MetalRod2cm']) %Guaper
M_Mono_files_W = dir('**Mono*[M]***aW**.txt');
set_M1=load(M_Mono_files_W(1).name); % 

%
cd([f_root,'\06 Tumor B']) %Guaper
B_Mono_files_W = dir('**Mono*[B]***aW**.txt');
set_B1=load(B_Mono_files_W(1).name); % 
set_B2=load(B_Mono_files_W(2).name); % 

%
cd([f_root,'\07 tumorPatch']) %Guaper
C_Mono_files_W = dir('**Mono*[C]***aW**.txt');
set_C1=load(C_Mono_files_W(1).name); % 
set_C2=load(C_Mono_files_W(2).name); % 


%{
O_Mono_files_W = dir('**Mono*[O]***aW**.txt');

C_Mono_files_W = dir('**Mono*[C]***aW**.txt');

B_Mono_files_W = dir('**Mono*[B]***aW**.txt');
D_Mono_files_W = dir('**Mono*[D]***aW**.txt');

set(0,'defaultAxesFontName', 'Times New Roman')
set(0,'DefaultAxesFontSize',16)
set(0,'DefaultFigureColormap',paruly)
%
%}

%%
cmap=colormap(paruly);
colores.Tumor=cmap(50,:);
colores.Fibro=cmap(35,:);
colores.Back=cmap(10,:);
set(0,'defaultAxesFontName', 'Times New Roman')
set(0,'DefaultAxesFontSize',14)
close all

%% Reconstruct image Tumor in glyerine old basic one
cd('X:\Shared Folders\Tyson -- Mario\Imaging\0720 Back2Basics') %Guaper


%{

set_A1=load(A_Mono_files_W(2).name); % Chamber + Support
set_A0=load(A_Mono_files_W(1).name); % Chamber + Support
set_CO=load(C_Mono_files_W(1).name); % CS + Fibro + Tumor

set_A1=load(A_Mono_files_W(1).name); % Chamber + Support
set_M1=load(M_Mono_files_W(1).name); % 

set_BO=load(B_Mono_files_W(1).name); % 
set_D1=load(D_Mono_files_W(1).name); % simple fibro
set_D2=load(D_Mono_files_W(2).name); % complex fibro
%set_DO=load(O_Mono_files_W(3).name); % CS + Fibro
%set_OO=load(O_Mono_files_W(4).name); %%Chamber

%}

%% Image Reconstruction Settings
%%{ 

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

%{
RecSettings.speed=2.5e8; %diegospeed 2.7e8 %%calc at 2.5
RecSettings.radius=0.205; % Radious of antenna to center%DiegoRadius 0.285, 10cm are added %%22calc
%RecSettings.Iclims=[0 3.5e-6];
%}

%{
RecSettings.w_sup=9; % window at 10 file at 2
RecSettings.w_inf=13; %window at 15 file at 30
RecSettings.speed=2.65e8; %diegospeed 2.7e8 %%calc at 2.5 fiel at 2.5
RecSettings.radius=0.245; % R
%}

%%
%%% Reconstruct image Tumor
%%{
close all;
B_ack=set_A1;
T_arget=set_B2;
supershort='B1 Test'; 


RecSettings.win=1; 
RecSettings.w_sup=8; % window at 10 file at 2
RecSettings.w_inf=14; %window at 15 file at 30
RecSettings.speed=2.75e8; %diegospeed 2.7e8 %%calc at 2.5 fiel at 2.5
RecSettings.radius=0.245; % R

monofun_mario_cmS(B_ack,T_arget,RecSettings,supershort);

close all;
B_ack=set_A1;
T_arget=set_B2;
supershort='B2 Test'; 


RecSettings.win=1; 
RecSettings.w_sup=8; % window at 10 file at 2
RecSettings.w_inf=14; %window at 15 file at 30
RecSettings.speed=2.75e8; %diegospeed 2.7e8 %%calc at 2.5 fiel at 2.5
RecSettings.radius=0.245; % R

monofun_mario_cmS(B_ack,T_arget,RecSettings,supershort);



%% Reconstruct image C
close all;
B_ack=set_A1;
T_arget=set_C1;
supershort='C1 Test'; 


RecSettings.win=1; 
RecSettings.w_sup=8; % window at 10 file at 2
RecSettings.w_inf=14; %window at 15 file at 30
RecSettings.speed=2.75e8; %diegospeed 2.7e8 %%calc at 2.5 fiel at 2.5
RecSettings.radius=0.245; % R

monofun_mario_cmS(B_ack,T_arget,RecSettings,supershort);

%% Reconstruct image C2
close all;
B_ack=set_A1;
T_arget=set_C2;
supershort='C1 Test'; 


RecSettings.win=1; 
RecSettings.w_sup=8; % window at 10 file at 2
RecSettings.w_inf=14; %window at 15 file at 30
RecSettings.speed=2.75e8; %diegospeed 2.7e8 %%calc at 2.5 fiel at 2.5
RecSettings.radius=0.245; % R

monofun_mario_cmS(B_ack,T_arget,RecSettings,supershort);


%% Reconstruct image Rod
close all;
B_ack=set_A1;
T_arget=set_M1;
supershort='M1 Test'; 


RecSettings.win=1; 
RecSettings.w_sup=9; % window at 10 file at 2
RecSettings.w_inf=14; %window at 15 file at 30
RecSettings.speed=2.75e8; %diegospeed 2.7e8 %%calc at 2.5 fiel at 2.5
RecSettings.radius=0.245; % R

monofun_mario_cmS(B_ack,T_arget,RecSettings,supershort);

%% Functions to get speed, win and radious

%% {
close all;
B_ack=set_A1;
T_arget=set_M1;
supershort='ROD2CM S240 R245'; 
s=0;


for v_speeds=2.49e8:0.01e8:2.54e8
     supershort=['ROD2CM S', num2str(v_speeds/1e6,4),' R245 w5-17 ']; 
    disp(supershort)  
     RecSettings.speed=v_speeds;
 
    [SCAN_tumorthere]=...
    monofun_mario_cmS(B_ack,T_arget,RecSettings,supershort);
    close(1,2,s+4)
    s=s+1;
    
      
end
toc

%% {
close all;
B_ack=set_A1;
T_arget=set_M1;
supershort='ROD2CM S240 R245'; 
s=0;


for wininf=10:1:15
     supershort=['ROD2CM S245 R245 w5-',num2str(wininf)]; 
   
     RecSettings.w_inf=wininf;
 
    [SCAN_tumorthere]=...
    monofun_mario_cmS(B_ack,T_arget,RecSettings,supershort);
    close(1,2,s+4)
    s=s+1;
    
      
end
toc



%}