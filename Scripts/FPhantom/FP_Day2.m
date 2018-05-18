%FP Day 2
%% 12_0a.01.a Load Ref and Response sets 
close all; 

%%{

cd('C:\Users\El Mario\Google Drive\MarioProject2\160204 FP Day2\DataSets\Experiment One')
O_Mono_files_W = dir('**Mono*O_*aW**.txt');
A_Mono_files_W = dir('**Mono*A_*aW**.txt');
%TumorFibro_files=dir('*Mono*[C]***.txt');
%Tumor_files = dir('**Mono*[B]***.txt');


%{
%
set_BA=load(A_Mono_files_W(3).name);
set_AA_2=load(A_Mono_files_W(2).name);

%}






%%{  
%<<<<<

%%%% Rec current image


%% Image Reconstruction Settings
RecSettings.win=1; % Selects wether a window is present or not
RecSettings.w_sup=9; % window at 10
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



%% Reconstruct images
supershort='BA with AA.2 Tumor On Fat'; 
RecSettings.Arrasize=size(set_AA_2,2)/2;

[S11_Raw,S11_Window,S11_Reconstructed]=...
    monofun_mario_cmS(set_AA_2,set_BA,RecSettings,supershort);

%}
