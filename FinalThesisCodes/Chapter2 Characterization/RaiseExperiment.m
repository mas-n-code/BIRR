%% I.1 Default settings
set(0,'defaultAxesFontName', 'Times New Roman')
set(0,'DefaultAxesFontSize',16)
set(0,'DefaultFigureColormap',paruly)
cmap=colormap(paruly);
col_Tumor=cmap(50,:);
col_Fibro=cmap(35,:);
col_Back=cmap(10,:);

close all

%% TumorRaisedExp

cd('F:\UserElGuapo\Google Drive\MarioProject2\150922 Effects of Vertical Error\1020 36FullTest\[xy] oficial\RaiseTumorExp');

%% Load the ref file
Ref_files = dir('**Mono*[A]***.txt');
RSE_CW.set_ref=load(Ref_files(1).name);


%% Load the data B files 
Tumor_files = dir('**Mono*[B]*aw**.txt');
RSE_CW.P00mm=load(Tumor_files(5).name);
RSE_CW.P05mm=load(Tumor_files(6).name);
RSE_CW.P10mm=load(Tumor_files(1).name);
RSE_CW.P20mm=load(Tumor_files(2).name);
RSE_CW.P40mm=load(Tumor_files(3).name);
RSE_CW.P60mm=load(Tumor_files(4).name);


%% Load RecSettings
RecSettings.win=1; % Selects wether a window is present or not
RecSettings.w_sup=10; % window at 10
RecSettings.w_inf=18; %window at 15
RecSettings.speed=2.9e8; %diegospeed 2.7e8
RecSettings.radius=0.285; %DiegoRadius 0.285 in meters
RecSettings.ver=100; % Reconstruction version of algorithm   %%%%%%
RecSettings.Iclims=[0 35e-9];
RecSettings.counterWise=1;   %% this might be wrong, dont know. for this experiment lest leave it like this
RecSettings.fl_low=1e9;
RecSettings.fl_high=8e9;
RecSettings.Bdiam=.175; %diameter of the breast <------ particular f this exp in meters
RecSettings.wflip=0;

if (RecSettings.counterWise==0);
    RecSettings.wflip=1;
end


% Set settings for 72L images
RecSettings.Arrasize=size(RSE_CW.set_ref,2)/2;
%%
save_folder='F:\UserElGuapo\DBOx\Dropbox\ResearchMagic\RandomProyects\160110 12 Effects of AR\LiftTumorExperiment\Reconstructed images';
amin_folder='F:\UserElGuapo\DBOx\Dropbox\ResearchMagic\RandomProyects\160110 12 Effects of AR\LiftTumorExperiment\';
cd(save_folder)

%% Reconstruct control scan.
cd([save_folder,'/Control'])
close all;
RecSettings.File_ref=Ref_files(1).name;
RecSettings.File_target=Tumor_files(5).name;
supershort='Control T-Raise Experiment ';

a_Reference=RSE_CW.set_ref;
b_Target=RSE_CW.P00mm;
[RSE_CW.SCANS.Control]=...
    monofun_mario_cmS(a_Reference,b_Target,RecSettings,supershort);

%% Reconstruct Raised Tumors
%-P05-% 

cd([save_folder,'/P05'])
close all;
RecSettings.File_ref=Ref_files(1).name;
RecSettings.File_target=Tumor_files(6).name;
supershort='P05 T-Raise Experiment ';

a_Reference=RSE_CW.set_ref;
b_Target=RSE_CW.P05mm;
[RSE_CW.SCANS.P05]=...
    monofun_mario_cmS(a_Reference,b_Target,RecSettings,supershort);


%-P10-%

cd([save_folder,'/P10'])
close all;
RecSettings.File_ref=Ref_files(1).name;
RecSettings.File_target=Tumor_files(1).name;
supershort='P10 T-Raise Experiment ';

a_Reference=RSE_CW.set_ref;
b_Target=RSE_CW.P10mm;
[RSE_CW.SCANS.P10]=...
    monofun_mario_cmS(a_Reference,b_Target,RecSettings,supershort);


%-P20-%

cd([save_folder,'/P20'])
close all;
RecSettings.File_ref=Ref_files(1).name;
RecSettings.File_target=Tumor_files(2).name;
supershort='P20 T-Raise Experiment ';

a_Reference=RSE_CW.set_ref;
b_Target=RSE_CW.P20mm;
[RSE_CW.SCANS.P20]=...
    monofun_mario_cmS(a_Reference,b_Target,RecSettings,supershort);


%-P40-%

cd([save_folder,'/P40'])
close all;
RecSettings.File_ref=Ref_files(1).name;
RecSettings.File_target=Tumor_files(3).name;
supershort='P40 T-Raise Experiment ';

a_Reference=RSE_CW.set_ref;
b_Target=RSE_CW.P40mm;
[RSE_CW.SCANS.P40]=...
    monofun_mario_cmS(a_Reference,b_Target,RecSettings,supershort);


%-P60-%

cd([save_folder,'/P60'])
close all;
RecSettings.File_ref=Ref_files(1).name;
RecSettings.File_target=Tumor_files(4).name;
supershort='P60 T-Raise Experiment ';

a_Reference=RSE_CW.set_ref;
b_Target=RSE_CW.P60mm;
[RSE_CW.SCANS.P60]=...
    monofun_mario_cmS(a_Reference,b_Target,RecSettings,supershort);

%% Obtain regions with control value
cd(main_folder)
ITumor=abs(RSE_CW.SCANS.Control.S11_c_RecZoomFlip);
IP_Clim=RecSettings.Iclims(2);
[Regions.Tumor,Regions.ITumorBack,Regions.TExcl]=IRegionLocatorTumor(ITumor,15,1); close all
regions_showSingle(ITumor.^2,Regions,'Tumor Single',IP_Clim);

%% Reconstruct and quantify each file independently


%% Plot the Scr, tcr and CcR as the tumor is raised
save 
