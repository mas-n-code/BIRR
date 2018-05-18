%cd(f_rawData)
%% default settings

sf1=0; % Set to 1 if we want to save figures!

set(0,'defaultAxesFontName', 'Times New Roman')
set(0,'DefaultAxesFontSize',12)

% Set defualtu coloramp Parula, or paruly or Jet but with 250 intervals.
try cmap=colormap(parula(250)); % 
catch
    try cmap = colormap(paruly(250));
    catch
        cmap= colormap(jet(250));
    end
end 
set(0,'DefaultFigureColormap',cmap) %Paruly disabled when working on LabCADws  

%% standard Rec settings
RecSettings.win=1; % Selects wether a window is present or not
RecSettings.w_sup=8; % window at 10
RecSettings.w_inf=15; %window at 14 make elements look very round
RecSettings.speed=2.6e8;   %2.35e8; %diegospeed 2.7e8 2.7
RecSettings.radius= .2498;%(21.5+5.25)/100;  %0.2313 +0.01; %DiegoRadius 0.285 in meters
RecSettings.ver=100;  % Reconstruction version of algorithm   %%%%%%
RecSettings.Iclims=[0 6e-9]; % LS limit is 5.5    RS limit was 5e-9!
RecSettings.counterCWise=0;   %% Reverse=1, clockwise=0
RecSettings.fl_low=1e9; 
RecSettings.fl_high=8e9;
RecSettings.Bdiam=.1416; %diameter of the breast <------
RecSettings.wflip=0;

if (RecSettings.counterCWise==0);
    RecSettings.wflip=1;
end


% Set settings for 72L images
RecSettings.Arrasize=72;
RecSettings.f_points=1001;
% Set settings for 72L images


%% Request reference
close all;
FilterSpec= {'**Mono**aW*.txt', 'Mono-Static'; ...
            '*Multi*aW*.txt','Multi-Static';...
            '*Mono*CW.txt*','CC_MonoStatic';...
            '*Multi*CW.txt*','CC_MultiStatic';...
            '*.*',  'All Files (*.*)'};
    
    
% ;*.fig;*.mat;*.slx;*.mdl',... %'**Multi**aW*.txt';
%  'MATLAB Files (*.m,*.fig,*.mat,*.slx,*.mdl)';
%    '*.m',  'Code files (*.m)'; ...
%    '*.fig','Figures (*.fig)'; ...
%    '*.mat','MAT-files (*.mat)'; ...
%    '*.mdl;*.slx','Models (*.slx, *.mdl)'; ...
%    '*.*',  'All Files (*.*)'};



[ref_filename,path_filename] = uigetfile(FilterSpec,'REFERENCE FILE');
RecSettings.File_ref=ref_filename;
cd(path_filename);
a_Reference=load(ref_filename);


% Request target

FilterSpec='****aW*.txt';
[target_filename,path_filename] = uigetfile(FilterSpec,'TARGET FILE');
cd(path_filename);
RecSettings.File_target=target_filename;
a_Target=load(target_filename);

% Rotate if necesary  for An=72  Dis=1 -> 5deg  Dis=54->270deg 
Dis=52;
 a_Target = Mario_RawDataShifter(a_Target,Dis);
 a_Reference = Mario_RawDataShifter(a_Reference,Dis);

%%
% Request name
supershort = inputdlg('Enter name of experiment:',...
             'Sample', [1 50],{'TeSt'});
         
% Change saving folder
cd(path_filename)

%% Process data
RecSettings.Arrasize=size(a_Reference,2)/2;

[TestScan]=...
    monofun_mario_cmS(a_Reference,a_Target,RecSettings,supershort{1});
%% Plot other stuff
% plot location of target
hold on; viscircles([2.25,-2.25], 2);

if sf1
    
    savethisone11(supershort{1}); close; 
end


%  Save First Fig scaled

if sf1
    hold on; viscircles([2.25+3.5,-2.25-3.5], 2);
    savethisone11([supershort{1},' scaled']);
end

%% Aditional find _speed algorithm
% Define settings 
s11=TestScan.S11_a_Calibrated;  % Calibrated S11? or Win S11 [input]
s21=[];                 %Only used if multistatic, leave empty if mono []
rad=RecSettings.radius; %Radious of antenna position [0.24]
spdini=1.5e8;           %Initial speed of loop [1.5e8]
spdfin=3e8;             %Final speed of loop [3e8]
sppoints=100;           %Number of individual speed to iterate [100]
freq=[1e9 8e9];         %Frequency Range, for planar 804 is [1e9 8e9]
angle=145;              %Angle of separation for multistatic arrengment [145]
zm=15;                  %Zoom window for reconstruction. [15]

% Speed find
disp('We have initieated speed search, please wait');
[FS_range,FS_res,FS_speed]=find_speed(s11,s21,rad,spdini,spdfin,sppoints,freq,angle,zm);
PlotSearchResult(FS_range,FS_res);

%Display image using speed.
RecSettings.speed = FS_speed;
[TestScan_Speed]=...
    monofun_mario_cmS(a_Reference,a_Target,RecSettings,[supershort{1},'s= ',num2str(round(FS_speed*1e-4),'%d \n')]);

%%
%{
ForcedReference=TestScan.S11_a_Calibrated;

[TestScanForced]=...
    monofun_mario_cmS_TEMPERED(ForcedReference,a_Target,RecSettings,'ExperimentoForcedReference');

%%
ForcedReferenceDouble=TestScanForced.S11_a_Calibrated;


[TestScanForcedDouble]=...
    monofun_mario_cmS_TEMPERED(ForcedReferenceDouble,a_Target,RecSettings,'ExperimentoForcedReferenceDouble');
%}

%%

%{
close all;
figure; imagesc((fig_Raw));

figure; imagesc((fig_Raw.*(1/exp(100))));

figure; imagesc(100*log10(fig_Raw));

figure; imagesc(log10(fig_Raw.^(1/2)*10005));
%}

%% Generate log of reconstructed image
%{
%fig_rec=abs(TestScan.Fig_c_RecZoomFlip_abs);

%figure; imagesc((fig_rec)); colormap(bone);

%figure; imagesc((fig_rec).^(1/2)); colormap(bone);
fig_Raw=TestScan.S11_b_WinRaw;
fig_Raw=abs(fig_Raw(1:30,:));
imXcord=TestScan.Fig_c_imx;
imYcord=TestScan.Fig_c_imy;
fig_rec=abs(TestScan.Fig_c_RecZoomFlip_abs);

figure; imagesc(imXcord,imYcord,log10(fig_rec)); axis('square'); colormap(bone);
%}

%% Present reconstructed image with their raw and log counterparts
%{
figure;
%colormap(bone)
%set(gcf,'un','n','pos',[0,0,1,1]);figure(gcf);

subplot(2,2,1)
imagesc((fig_Raw.^(2)));
axis('square')
title('Raw image (Relative power)')
colorbar;


subplot(2,2,2)
imagesc(log10(fig_Raw.^(2)));
title('Raw image (Log of relative power)')
axis('square')
colorbar;


subplot(2,2,3)
imagesc(fig_rec);
title('Rec image (Relative power)')
axis('square')
colorbar;


subplot(2,2,4)
%subimage(imagesc(log10(fig_rec)))
imagesc(log10(fig_rec));
title('Rec image (Log of relative power)')
axis('square')
colorbar;

%savethisone('Comparison of Log for Rec image');
%}

%% Present reconstructed images in a subplot comapring power, amplitude and log 
%{
figure; 
subplot(1,3,1)
imagesc(fig_rec.^(1/2));
axis('square')
title('Rec image (Relative amplitude)')
colorbar;


subplot(1,3,2)
imagesc(fig_rec);
title('Rec image (Relative power)')
axis('square')
colorbar;


subplot(1,3,3)
imagesc(log10(fig_rec));
title('Rec image (Log of relative power)')
axis('square')
colorbar;

savethisone('Comparison of Rec image presentation');
%}

