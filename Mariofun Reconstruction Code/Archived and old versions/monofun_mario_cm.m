function [max_value,max_value_raw,max_valueRAWRAW,s11_minus_ref_RAW,imafin_z]=monofun_mario_cm(ref,data,l_size,window,flip_i,graph_title,w_sup,w_inf,s,r,ver)

% monofun_mario_cm.m
%--------------------------------------------------
% Version 2.0.4.0
% Created by Mario Solis [M]
% Date 05/02/2014
%monofun_mario Hapilly process the data using the multi_rec_full
%   ref is the element to be used as reference
%   data is, of course, the data
%  l_size is the number of locations
% p is a bolean selctor for window
% flip is used to invert y axis
% g_title, graph title put 0 if default
%--------------------------------------------------
% Revision changes
%--------------------------------------------------



%close all
zz=1;
diegoW=1; %(1: Frequency Window, 0: Time Window);
zoomf=20; % determine the zoom factor of the image in cm for the rec image
speed=s; %what a speed gotta do, 2.54 for glycerine at 13cm but diego suggest 2.7 now, what a 
radius=r; % electrical radius of the antennas, See Diego's thesis 285 for 13 cm, 305 for 15
d_points=1001;
fl_low=1e9;
fl_high=8e9;
wind_sup=w_sup; % determine the supperior window limit 9 soo 10 to 15  tend to be are the best accoring to 
wind_inf=w_inf; % determine the inferior window limit 21
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
r_m = 9; % radius of the breast or mold

%---------------------------------------------
Ver_Multi_rec_full='Full v1.0.1';

disp('Antenna_position= 13cm to border');
%-----------------------------------------

%---Graph Title------
if (graph_title==0)
title_plot=[' Data: ',inputname(2),' Ref: ',inputname(1)];
else
    title_plot=graph_title;
end
%---Step 1: Substract Ref-----
s11_ref=data_reader_daniel(ref);%reference
s11_data=data_reader_daniel(data);%data!
s11_minus_ref=s11_data-s11_ref;

%RAWRAW Figure
%max_value_raw_NoWindow = raw_max(ref,data);

figure('name','Raw no Window','position', [100, 200, 800, 420]);
s11_minus_ref_RAW=s11_data-s11_ref;
raw_fig_RAW= abs(s11_minus_ref_RAW).^2;

imagesc(raw_fig_RAW(1:30,:)); %raw raw data view
max_valueRAWRAW=max(max(raw_fig_RAW));
disp(['Max Value with no Window = ',num2str(max_valueRAWRAW)]);
annot_string=['Max=',num2str(max_valueRAWRAW,3)];
annotation('textbox', [0.01,0,0.1,0.1],'string',annot_string,'Color',[.2,.2,0.3])
h=colorbar;

%----Step 2: Substra Apply WINDOW------
if (window==1)
disp('Window Signal');
    if (diegoW==1)
    disp('Frequency Window');
    s11_minus_ref= ApplyWindow(s11_minus_ref,wind_sup,wind_inf);   
        
    else 
    disp('Time Window');
    resulting= s11_minus_ref(1:30,:);
    figure('name','Raw data minus background','Position',[200, 200, 800, 420]);imagesc(abs(resulting).^2); % 

%Here i put the piece of code to time shift that signal from copper
%mountain when it didnt had delay

%z_2(8:20,:)=resulting(120:132,:); %moving values to the 16 bin in z_2

%s11_patch_ref(8:20,:)=s11_patch_ref(120:132,:);
%figure('name','Resulting moved');imagesc(abs(s11_patch_ref).^2); % 


    s11_minus_ref(1:wind_sup,:)=0;
    s11_minus_ref(wind_inf:end,:)=1e-20;
 %windowed data
    end

else % No Window
    s11_minus_ref=s11_data-s11_ref;
end

%Max data

raw_fig= abs(s11_minus_ref).^2;
max_value_raw=max(max(raw_fig));
display(['Maximum value =' num2str(max_value_raw)]);
db_raw= 10*log10(max_value_raw/.0039811); %VNa emits 3.911mw according to Daniel;


 %------------Step 4: Zoom data ----------


%raw_fig= abs(resulting).^2;





figure('name','Zoomed raw data with window','position', [300, 200, 800, 420]);
imagesc(raw_fig(1:30,:)); %raw data view 





colorbar;
title( title_plot,'FontSize', 20);
xlabel('Antenna Location');
ylabel('Time in Segment');
h=colorbar;
set(gca,'fontsize',16)
%ylabel(h, 'Watts')

annot_string=['Max=',num2str(max_value_raw,3), '| ', num2str(db_raw,3),'dB'];
annotation('textbox', [0,0,0.1,0.1],'string',annot_string,'Color',[.2,.2,0.3])


%[ BSCAN2 ] = data_former( s11_data,zeros(d_points,l_size),145/57.3 ); %temporar wrong
%
[ BSCAN2 ] = data_former( s11_minus_ref,zeros(d_points,l_size),145/57.3 );
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
if (ver==201)
BMR=Multi_rec_full_comp201(Params);
Ver_Multi_rec_full='Comp v2.0.1';
else
    BMR=Multi_rec_full101(Params);
    Ver_Multi_rec_full='Full v1.0.0';
end
% BMR=Multi_rec_full(Params); %old section used for reconstruciton


size_ofmat=size(BMR.ima);
%disp(['Size of mat = ',num2str(size_ofmat)]);

% Apply zoom and project image
if(zz==1) 
   
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
    
    imafin_abs=flipud(imafin_abs);
    %imafin_abs=fliplr(imafin_abs);
end
  

%clims=[0 1.8882e-06];

figure('name','Reconstruction');

ColorSet = varycolor(50);
set(gca, 'ColorOrder', ColorSet);


if (zz==1)
imagesc(imx,imy,imafin_abs); % creates the graph we know and love (x,y,image,clims)
else
   %imagesc(BMR.vector,BMR.vector*-1,imafin_abs);
    imagesc(imafin_abs);
end

set(gca,'YDir','normal');% This will reverse both the y-axis and the image.


title(title_plot,'FontSize', 20);
xlabel('x axis(cm)','fontweight','bold','FontSize',20);
ylabel('y axis(cm)','fontweight','bold','FontSize',20);

% option 2 set(get(gca,'YLabel'),'Rotation',0)

h=colorbar;
set(gca,'fontsize',20)
hold on

%%%%%%%%%%%%%%%%%%%%%%%%%

% add circle arround the breast

xc = 0;
yc = 0;

theta = linspace(0,2*pi);
x = r_m*cos(theta) + xc;
y = r_m*sin(theta) + yc;
if(breastplot==1)
plot(x,y,'LineStyle','--','Color',[1 0.600000023841858 0.7843137383461])
end
%%%%%%%%%%%%%%%%%%%%%%%%%

% add patch 



theta = linspace(0,2*pi);
x = patch_r*cos(theta) + p_xc;
y = patch_r*sin(theta) + p_yc;
if(breastplot==1)
    plot(x,y,'LineStyle',':','Color','cyan')
end
max_value=max(max(imafin_abs));


annot_string=['Max=',num2str(max_value,3)];
%annotation('textbox', [0.01,0,0.1,0.1],'string',annot_string,'Color',[.2,.2,0.3])


param_string=['S=',num2str(speed,3),'| r =',num2str(radius,3)];
%annotation('textbox', [0.7,0,0.1,0.1],'string',param_string,'Color',[.2,.2,0.3])


%annotation('textbox', [0.0,.05,0.1,0.1],'string',Ver_Multi_rec_full,'Color',[.8,.8,.9], 'LineStyle', 'none')

% h = annotation('rectangle',[0 0 4 4]);
% s = h.FontSize;
% h.FontSize = 12;
% xlabel(['Speed: ' num2str(speed) 'ms'])



disp(['Max Value in Image = ',num2str(max_value)]);

%--------------------------------------------------
% Rotation changes
%--------------------------------------------------
% figure; rotito= imrotate(imafin_abs,20);
% imagesc(imx,imy,rotito);
end

