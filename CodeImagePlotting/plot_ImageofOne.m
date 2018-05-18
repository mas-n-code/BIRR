function plot_ImageofOne(cdata1,scan_properties,s_edgePlot) %elTitle removed
%plot_ImageofThree(cdata1, cdata2, cdata3,scan_properties) 
%  CDATA1:  image array
%  CDATA2:  image array
%  CDATA3:  image array
%  scan_properties-> sProp Axes coordinates
%  Auto-generated by MATLAB on 04-Aug-2017 22:17:22

% Used in:
% -> plot_ImageofThree(ROT_ControlArrays.C_P1_A,ROT_ControlArrays.C_P2_A,ROT_ControlArrays.C_P3_A,imx,imy);
close all;
% Create figure
figure1 = figure;

fSize=11;
fName='Times New Roman';
fLwidth=0.75;
fZoom=[-8 8]; %8 for rS 8.5 for liftstage

% Colorbar initializer

try cmap=colormap(parula(250)); % 
catch
    try cmap = colormap(paruly(250));
    catch
        cmap= colormap(jet(250));
    end
end 


% Set figure size and position
% set(figure1,'Units','centimeters',...
%     'Position', [15 8.5 15 15.5]);

x_label = 'x-axis (cm)';
y_label = 'y-axis (cm)';


edgeColor=cmap(2,:); % Edge of the plot
%-------------------------------------------------------------------------
%Unbundle
imx = scan_properties.imx_t;
imy = scan_properties.imy_t;
location_tumor = scan_properties.location_tumor;
location_fibro = scan_properties.location_fibro;
r_target = scan_properties.radius_target;
CLim = scan_properties.CLim; 
r_phantom = scan_properties.radius_phantom;

% This code is unused 
s_excl='Off';
if ~strcmp(s_excl,'On')
    nanExclusionZone=0;
else
    nanExclusionZone=1;
end


if ~strcmp(s_edgePlot,'On')
    edgePlot=0;
else
    edgePlot=1;
end

%%-----------------------------AXES1----------------------------------------
%{ 
%old style
% Create axes
image(imx,imy,cdata1,'CDataMapping','scaled','AlphaData',~isnan(cdata1));


%axes1 = axes('Parent',figure1,'Units','centimeters',...
axes1 = gca;
set(axes1,...
    'Units','centimeters',...
    'FontName',fName, ...
    'FontSize',fSize, ... %'PlotBoxAspectRatio',[1 1 1],...
    'DataAspectRatioMode', 'auto', ...
    'Layer','top',...
    'TickDir','out',...
    'TickLength',[0.02 0.02],...
    'XTickLabel',{'-15','-10','-5','0','5','10','15'},...
    'XTick',[-15 -10 -5 0 5 10 15],...
    'YTickLabel',{'-15','-10','-5','0','5','10','15'},...
    'YTick',[-15 -10 -5 0 5 10 15]);
box(axes1,'on');
%hold(axes1,'all');
%}


%% New stuff

%--- mask exclusion zone, set it to NAN

if nanExclusionZone
cdata1(scan_properties.Masks.mask_excl_fibro)=NaN;   %<---
cdata1(scan_properties.Masks.mask_excl_tumor)=NaN;   %<---
end;
%--- End of masking


%% Normalizer
cdata1_NORM = cdata1./CLim(2); 
%cdata1_NORM =cdata1;

%% Create image

image(imx,imy,cdata1_NORM,'CDataMapping','scaled','AlphaData',~isnan(cdata1_NORM));

% Create tile and labels
% title(elTitle,'FontWeight','normal','FontName',fName,'FontSize',fSize); % No title necesary, thanks / OR hard code
xlabel(x_label);
ylabel(y_label);
%=== Define axis Stuff




%% Set axes stuff
axes1 = gca;


set(axes1,...
    'FontName',fName, ...
    'FontSize',fSize, ... %'PlotBoxAspectRatio',[1 1 1],...
    'PlotBoxAspectRatio', [1 1 1], ...
    'Layer','top',...
    'TickDir','out',...
    'TickLength',[0.02 0.02],...
    'XTickLabel',{'-15','-10','-5','0','5','10','15'},...
    'XTick',[-15 -10 -5 0 5 10 15],...
    'YTickLabel',{'-15','-10','-5','0','5','10','15'},...
    'YDir','normal',...    
    'YTick',[-15 -10 -5 0 5 10 15]);
box(axes1,'on');

% Uncomment the following line to preserve the X-limits of the axes
xlim(axes1,fZoom);
% Uncomment the following line to preserve the Y-limits of the axes
ylim(axes1,fZoom);

%=== End of axes definition




% Resize the axes in order to prevent it from shrinking.
% set(axes1,'Position',[2 1.5 15 15.5]);

% Set maximum limit
set(axes1,'CLim',[0 1]); %NORMALIZEEDD
% set(axes1,'CLim',CLim); 


hold on
% Plot cirlces for targets
viscircles(location_tumor,r_target,'LineWidth',fLwidth, 'LineStyle','-','EnhanceVisibility',true); %set to false to remove white cirlce
viscircles(location_fibro,r_target,'LineWidth',fLwidth, 'LineStyle','-','EnhanceVisibility',true,'EdgeColor',[0.2 0.8 0.5]);
%viscircles(location_fibro,r_target,'LineWidth',fLwidth,'EdgeColor',[0.2 0.8 0.5]);

%Rounds edge of map with a line
if edgePlot, edgeColorer(r_phantom,edgeColor), end
hold off

% Create colorbar
colorbar('peer',axes1);

% % change width of colorbar
% x1=get(gca,'position');
% x=get(cl,'Position');
% x(3)=0.03;
% set(cl,'Position',x)

% Change figure position
figure1.Units= 'Centimeters';
figure1.Position=[25.5   13.5   14  11];


function edgeColorer(r_phantom,edgeColor)
xc = 0;
yc = 0;
theta = linspace(0,2*pi);
x = r_phantom*cos(theta) + xc;
y = r_phantom*sin(theta) + yc;
plot(x,y,'Color','w','LineWidth',8);

r_phantom=r_phantom+0.4; % Offset to hide  pixels
x = r_phantom*cos(theta) + xc;
y = r_phantom*sin(theta) + yc;
plot(x,y,'Color','w','LineWidth',7);


