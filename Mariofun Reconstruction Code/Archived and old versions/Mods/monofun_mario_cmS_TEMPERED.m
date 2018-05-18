function [SCAN]=monofun_mario_cmS_TEMPERED(ref_parsed,data,RecSettings,graph_title)

%TEMPERED version allows for ref to be a parsed file 


%New:[SCAN]=monofun_mario_cmS(ref,data,RecSettings,graph_title)

%Past: [S11_Raw,S11_Window,S11_Reconstructed]=monofun_mario_cmS...
%--------------------------------------------------
% Version 2.1.7.0
% Created by Mario Solis [M]
% Last modified 06/17/2016
% first version date  05/02/2014
%monofun_mario_cmS Cheerfully process the data using the multi_rec_full
%   ref is the element to be used as reference
%   data is, of course, the data with target information
% RECSETTINGs: Structure file w/
    % RecSettings.win; % Selects wether a window is present or not
    % RecSettings.w_sup; % window at 10
    % RecSettings.w_inf; %window at 15
    % RecSettings.speed; %diegospeed 2.7e8
    % RecSettings.radius; %DiegoRadius 0.285
    % RecSettings.ver; % Reconstruction version of algorithm
    % RecSettings.wflip; % Depending on the direction of the scan the image is flipped
    % RecSettings.Arrasize; % Number of antenna locations
    % RecSettings.Iclims; % Image maximum value to clip rec figures
    % RecSettings.fl_low; % Freq settings for cm conversion Typically fl_low=2e9;
    % RecSettings.fl_high; % Freq settings for cm conversion  Typically fl_high=8e9; 
    % RecSettings.Bdiam; % diameter of the imaginary edge of breast phantom
    % in meters
% g_title, graph title put 0 if default
% 


%--------------------------------------------------
%% Revision changes
%----------------------------------------------- 
%Version 2.1.7 Date:06/17/2016
%- RecSettings is now saved on the SCAN file and in a txt file 
%- 
%- RecSetting also contains the graphtitle name

% >>> future work: 
%RecSetting also contains the name of the passed Ref variable and data
% varaible
%It is necessary to create a function that creates a ref and data
%structures with values and name before passing them to monofun_mario_cmS

%Version 2.1.6.0 Date:05/02/2016
%- savethisone now receives a string value;


%Version 2.1.5.0 Date:04/11/2016
%-Outputs  a SCAN struct 
%Added output variable S11_ReconstructedComplex, which cotains the
% reconstructed image without the abs(imafin).^2 
%- iclims is now unfolded from RecSettings
%- fl_low and fl_high, contained in RecSetttings which will probably modify
%current images and create errors in previous scripts.

% Version 2.1.4.0
% -Reconstruction settings are passed as a structure for improved usability
% -Will return S11_Raw,S11_Window,S11_Reconstructed


%% Work in progress
% >
% > 
% > Improve readability of code


%% A) Unfold RecSettings %%



window=RecSettings.win; % Selects wether a window is present or not
wind_sup=RecSettings.w_sup; % window at 10
wind_inf=RecSettings.w_inf; %window at 15
speed=RecSettings.speed; %diegospeed 2.7e8
radius=RecSettings.radius; %DiegoRadius 0.285
recver=RecSettings.ver; % Reconstruction version of algorithm
%flip_i=RecSettings.wflip; % Depending on the direction of the scan the image is flipped
l_size=RecSettings.Arrasize; % Number of antenna locations
i_clims=RecSettings.Iclims; % Image maximum value to clip rec figures

fl_low=RecSettings.fl_low; % Freq settings for cm conversion Typically fl_low=2e9;
fl_high=RecSettings.fl_high; % Freq settings for cm conversion  Typically fl_high=8e9;

breast_radius=[RecSettings.Bdiam]/2;

if (RecSettings.counterWise==0);
    flip_i=1;
else 
    flip_i=0;
end

% notes on wind_sup and wind_inf:
 % determine the supperior window limit 9 soo 10 to 15  tend to be are the best accoring to 
 % determine the inferior window limit 21
 

%% B) Set additional parameters.
%close all
zz=1; % Zoom to 40 / 40 image
diegoW=1; %(1: Frequency Window, 0: Time Window);
zoomf=20; % determine the zoom factor of the image in cm for the rec image
 %what a speed gotta do, 2.54 for glycerine at 13cm but diego suggest 2.7 now, what a 
 % electrical radius of the antennas, See Diego's thesis 285 for 13 cm, 305 for 15
d_points=1001; % Number of frequency/time points


%---------For Rec Full Com-----
Loss1= 1.4; %Loss factor of Glycerine 1.4
Surbin= 6; %Location of the surface (bin)
diameter=2; %Diameter of phantom?
%-------------------------------

% add patch 
%Phantom configuration
breastplot=1; % Activates, or deactivates the contour of the breast
p_xc = 2.25; % location of the patch, x direction
p_yc = -3.25;  %location of the patch, y direction
patch_r = 0; % radius of the patch
r_cm = breast_radius*100; % radius of the breast or mold
%r_cm = 9; % 9 era?
%---------------------------------------------
% Ver_Multi_rec_full='Full v1.0.1'; unused

disp('Antenna_position= 13cm to border'); % border of what?
%-----------------------------------------


%---Graph Title------
if (graph_title==0)
title_plot=[' Data: ',inputname(2),' Ref: ',inputname(1)];
else
    title_plot=graph_title;
end

%% ---TEMPERED STUFF -----
s11_ref=ref_parsed;%reference
s11_data=data_reader_daniel(data);%data!
s11_calibrated=s11_data-s11_ref;

%{
% ORIGINAL SUTFF
% ---Step 1: Substract Ref-----
s11_ref=data_reader_daniel(ref_parsed);%reference
s11_data=data_reader_daniel(data);%data!
s11_calibrated=s11_data-s11_ref;
%}


%% FIGURE= Raw Figure
%RAWRAW Figure
%max_value_raw_NoWindow = raw_max(ref,data);

figure('name','Raw no Window','position', [100, 200, 800, 420]);
S11_AbsRAW30= (abs(s11_calibrated)).^2;
S11_AbsRAW30=S11_AbsRAW30(1:30,:);
imagesc(S11_AbsRAW30); %raw raw data view                %%%%%%%%%%%%%%%%%%%<RV>

%Beauty parameters
set(gca, ...
  'Box'         , 'off'     , ...
  'TickDir'     , 'out'     , ...
  'TickLength'  , [.02 .02]);
title([title_plot 'raw']);
xlabel('Antenna location');
ylabel('Time segment');

colorbar;
%%set(gca,'fontsize',14)


max_valueRAWRAW=max(max(S11_AbsRAW30));
disp(['Max Value with no Window = ',num2str(max_valueRAWRAW)]);
annot_string=['Max=',num2str(max_valueRAWRAW,3)];
annotation('textbox', [0.01,0,0.1,0.1],'string',annot_string,'Color',[.2,.2,0.3])



savethisone([graph_title 'Raw'])

%% ----Step 2:  Apply WINDOW------
if (window==1)
    if (diegoW==1)
    disp('Window: Frequency  Window D');
    s11_win= ApplyWindow(s11_calibrated,wind_sup,wind_inf);   
        
    else 
    disp('Window: Time Window');
    s11_win=s11_calibrated;
    s11_win(1:wind_sup,:)=0;
    s11_win(wind_inf:end,:)=1e-20;
    figure('name','Raw data Time window','Position',[200, 200, 800, 420]);imagesc(abs(s11_win).^2); % 
    
    

% Here i put the piece of code to time shift that signal from copper
%mountain when it didnt had delay

%z_2(8:20,:)=resulting(120:132,:); %moving values to the 16 bin in z_2

%s11_patch_ref(8:20,:)=s11_patch_ref(120:132,:);
%figure('name','Resulting moved');imagesc(abs(s11_patch_ref).^2); % 

    
 %windowed data
    end

else % No Window
    disp('Window: No Window');
    s11_win=s11_data-s11_ref;
    
end

%Max data

raw_fig_Win= abs(s11_win).^2;
max_value_raw=max(max(raw_fig_Win));
display(['Maximum value =' num2str(max_value_raw)]);
db_raw= 10*log10(max_value_raw/.0039811); %VNa emits 3.911mw according to Daniel;


%% ------------Step 4: Zoom data ----------


%raw_fig= abs(resulting).^2;

figure('name','Zoomed raw data with window','position', [300, 200, 800, 420]);
imagesc(raw_fig_Win(1:30,:)); %raw data view                               %%%%%%%%%%%%%%%%%%<RV>

%Beauty parameters
set(gca, ...
  'Box'         , 'off'     , ...
  'TickDir'     , 'out'     , ...
  'TickLength'  , [.02 .02]);
title( title_plot);
xlabel('Antenna location');
ylabel('Time segment');
colorbar;
%%set(gca,'fontsize',14)
%ylabel(h, 'Watts')

annot_string=['Max=',num2str(max_value_raw,3), '| ', num2str(db_raw,3),'dB'];
annotation('textbox', [0,0,0.1,0.1],'string',annot_string,'Color',[.2,.2,0.3])

supershort_savetitle=[graph_title 'Raw_win'];
savethisone(supershort_savetitle);

%% -----------Step 5: Reconstruct ---------


%[ BSCAN2 ] = data_former( s11_data,zeros(d_points,l_size),145/57.3 ); %temporar wrong
%
[ BSCAN2 ] = data_former( s11_win,zeros(d_points,l_size),145/57.3 ); 
% %offset: angle offset between the radiating and the receiving locations in
%the bistatic dataset {In this case, i use only monostatic, thus offset value is irrelevant}
%GOOOd one
%
Params.dataset=BSCAN2;
Params.freqvals=linspace(fl_low,fl_high,d_points);
Params.angles=linspace(0,2*pi,l_size);
Params.radius=radius; %radius! may need to change in the fute!
Params.speed=speed;
Params.L1= Loss1;%Loss factor in breast medium
Params.surbin= Surbin;%
Params.diameter=diameter;
%---- Decide wich rec you want-----%
%New vs old MultiRec
%------Supported Versions
%Multi_rec_full100m.m
%Multi_rec_full101 UNSUPORTED
%Multi_rec_full101m.m this is the same as 100
%Multi_rec_full_comp201.m
%Multi_rec_full_comp202 UNSUPORTED
disp(recver)
switch recver
    case 201
        BMR=Multi_rec_full_comp201(Params);
        Ver_Multi_rec_full='Comp v2.0.1';
        
    case 211 
        BMR = BMR_SVD( data,[3 20],Params );
        Ver_Multi_rec_full='Comp v2.1.1 wSVD';
        
    case 101
        BMR=Multi_rec_full101(Params); 
        Ver_Multi_rec_full='Full v1.0.1';
        
    otherwise %ver100
        BMR=Multi_rec_full100m(Params);
        Ver_Multi_rec_full='Full v1.0.0';
end
%{        
if (ver==201)
    
else
    BMR=Multi_rec_full101(Params);
    Ver_Multi_rec_full='Full v1.0.0';
end
%}
% BMR=Multi_rec_full(Params); %old section used for reconstruciton


size_ofmat=size(BMR.ima);
%disp(['Size of mat = ',num2str(size_ofmat)]);

% Apply zoom and project image
if(zz==1)&&(recver==100)
    BMR.ima(1,1)
    
    imx=linspace(-zoomf,zoomf,(zoomf*2+1)).*(speed*100/(4*(fl_high)));%(Mu/(2*(6e9)))=0.0121 where Mu=1.45e8
    imy=imx*-1;
    
    X1=round(size_ofmat(1)/2-zoomf);X2=round(size_ofmat(1)/2+zoomf);Y1=round(size_ofmat(2)/2-zoomf);Y2=round(size_ofmat(2)/2+zoomf);
    
    imafin_z=BMR.ima(X1:X2,Y1:Y2);
    
   imafin_abs=abs(imafin_z).^2;
    else
        imafin_abs=abs(BMR.ima).^2;
end

if (flip_i ~=0)
    imafin_z=flipud(imafin_z);
    imafin_abs=flipud(imafin_abs);
    %imafin_abs=fliplr(imafin_abs);
end








%% ----------- Step 6: Plot reconstructed images ---------
figure('name','Reconstruction');

ColorSet = varycolor(50);
set(gca, 'ColorOrder', ColorSet);


if (zz==1)&&(recver==100)
imagesc(imx,imy,imafin_abs); % creates the graph we know and love (x,y,image,clims)
else
   %imagesc(BMR.vector,BMR.vector*-1,imafin_abs);
    imagesc(imafin_abs);
end

set(gca,'YDir','normal');% This will reverse both the y-axis and the image.

title(title_plot);
xlabel('x axis (cm)');
ylabel('y axis (cm)');

% option 2 set(get(gca,'YLabel'),'Rotation',0)
%colormap(parula(120));
colorbar;
%%set(gca,'fontsize',14)
hold on
set(gca, ...
  'Box'         , 'off'     , ...
     'XTickLabel',{'-15','-10','-5','0','5','10','15'},...
    'XTick',[-15 -10 -5 0 5 10 15],...
    'YTickLabel',{'-15','-10','-5','0','5','10','15'},...
    'YTick',[-15 -10 -5 0 5 10 15],...
  'TickDir'     , 'out'     , ...
  'TickLength'  , [.02 .02]);

% option 2 set(get(gca,'YLabel'),'Rotation',0)

%%%%%%%%%%%%%%%%%%%%%%%%%

% add circle arround the breast

xc = 0;
yc = 0;

theta = linspace(0,2*pi);
x = r_cm*cos(theta) + xc;
y = r_cm*sin(theta) + yc;
if(breastplot==1)
plot(x,y,'LineStyle','--','Color',[1 0.600000023841858 0.7843137383461])
end
%%%%%%%%%%%%%%%%%%%%%%%%%

% add patch -> to be performed after rec
% theta = linspace(0,2*pi);
% x = patch_r*cos(theta) + p_xc;
% y = patch_r*sin(theta) + p_yc;
% if(breastplot==1)
%     plot(x,y,'LineStyle',':','Color','cyan')
% end


max_value=max(max(imafin_abs));

%-> Annotations in reconstructed images
%annot_string=['Max=',num2str(max_value,3)];
%annotation('textbox', [0.01,0,0.1,0.1],'string',annot_string,'Color',[.2,.2,0.3])

%param_string=['S=',num2str(speed,3),'| r =',num2str(radius,3)];
%annotation('textbox', [0.7,0,0.1,0.1],'string',param_string,'Color',[.2,.2,0.3])

%annotation('textbox', [0.0,.05,0.1,0.1],'string',Ver_Multi_rec_full,'Color',[.8,.8,.9], 'LineStyle', 'none')

% h = annotation('rectangle',[0 0 4 4]);
% s = h.FontSize;
% h.FontSize = 12;
% xlabel(['Speed: ' num2str(speed) 'ms'])

axis square
disp(['Max Value in Image = ',num2str(max_value)]);

supershort_savetitle=[graph_title 'Rec'];
savethisone(supershort_savetitle);


%--------------------------------------------------
% Rotation changes
%--------------------------------------------------
% figure; rotito= imrotate(imafin_abs,20);
% imagesc(imx,imy,rotito);

%% Step 6.6: Image with CLims
% clims=[0 1.8882e-06];
figure('name',['Reconstruction with Clim ' num2str(i_clims(2),'%10.2e')]);

imagesc(imx,imy,imafin_abs,i_clims);
title(title_plot);
hold on;

set(gca,'YDir','normal');% This will reverse both the y-axis and the image.

%Beauty parameters
title(title_plot);
xlabel('x axis (cm)');
ylabel('y axis (cm)');
set(gca, ...
  'Box'         , 'off'     , ...
     'XTickLabel',{'-15','-10','-5','0','5','10','15'},...
    'XTick',[-15 -10 -5 0 5 10 15],...
    'YTickLabel',{'-15','-10','-5','0','5','10','15'},...
    'YTick',[-15 -10 -5 0 5 10 15],...
  'TickDir'     , 'out'     , ...
  'TickLength'  , [.02 .02]);

colorbar;
%colormap(parula(120));
%%%set(gca,'fontsize',14)
hold on
% option 2 set(get(gca,'YLabel'),'Rotation',0)


xc = 0;
yc = 0;
theta = linspace(0,2*pi);
x = r_cm*cos(theta) + xc;
y = r_cm*sin(theta) + yc;
if(breastplot==1)
plot(x,y,'LineStyle','--','Color',[1 0.600000023841858 0.7843137383461])
end
axis square
supershort_savetitle=[graph_title 'Rec_clim'];
savethisone(supershort_savetitle);

%% ----------- Step 7: Return Values ---------------
SCAN.S11_a_Calibrated=s11_calibrated;
SCAN.S11_b_WinRaw=s11_win;
SCAN.S11_c_Rec=BMR.ima;
SCAN.S11_c_RecZoomFlip=imafin_z;

SCAN.Fig_a_CalAbsRaw30=S11_AbsRAW30;
SCAN.Fig_b_AbsWinRaw30=raw_fig_Win(1:30,:);
SCAN.Fig_c_RecZoomFlip_abs=imafin_abs;

SCAN.Fig_c_imx=imx;
SCAN.Fig_c_imy=imy;
SCAN.Fig_c_imgClims=i_clims;

disp(Ver_Multi_rec_full);

%% ----------- Step 8: save RecSettings ---------------
RecSettings.Name=graph_title;
writetable(struct2table(rot90(RecSettings)),[graph_title 'RecSettings'])
RecSettings.refFile = inputname(1);
RecSettings.dataFile = inputname(2);
SCAN.RecSettings = RecSettings; 

