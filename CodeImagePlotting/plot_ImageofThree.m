function plot_ImageofThree(cdata1, cdata2, cdata3,scan_properties,s_edgePlot)
%plot_ImageofThree(cdata1, cdata2, cdata3,scan_properties) 
%  CDATA1:  image array
%  CDATA2:  image array
%  CDATA3:  image array
%  scan_properties-> sProp Axes coordinates
%  Auto-generated by MATLAB on 04-Aug-2017 22:17:22

% Used in:
% -> plot_ImageofThree(ROT_ControlArrays.C_P1_A,ROT_ControlArrays.C_P2_A,ROT_ControlArrays.C_P3_A,imx,imy);

% Create figure
figure1 = figure;

% Colorbar initializer

try cmap=colormap(parula(250)); % 
catch
    try cmap = colormap(paruly(250));
    catch
        cmap= colormap(jet(250));
    end
end 

set(0,...
    'DefaultFigureColormap',cmap,...
    'defaultAxesFontName', 'Times New Roman',...
    'DefaultAxesFontSize',14);

% Set figure size and position
set(figure1,'Units','centimeters',...
    'Position', [15 8.5 45 15.5]);

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

% Create axes
axes1 = axes('Parent',figure1,'Units','centimeters',...
    'Position',[2 1.5 10 13.5],...
    'PlotBoxAspectRatio',[1 1 1],...
    'Layer','top',...
    'TickDir','out',...
    'TickLength',[0.02 0.02],...
    'XTickLabel',{'-15','-10','-5','0','5','10','15'},...
    'XTick',[-15 -10 -5 0 5 10 15],...
    'YTickLabel',{'-15','-10','-5','0','5','10','15'},...
    'YTick',[-15 -10 -5 0 5 10 15]);
box(axes1,'on');
hold(axes1,'all');

% Uncomment the following line to preserve the X-limits of the axes
xlim(axes1,[-12.5 12.5]);
% Uncomment the following line to preserve the Y-limits of the axes
ylim(axes1,[-12.5 12.5]);


%---
%--- mask exclusion zone, set it to NAN
%---
if nanExclusionZone
cdata1(scan_properties.Masks.mask_excl_fibro)=NaN;   %<---
cdata1(scan_properties.Masks.mask_excl_tumor)=NaN;   %<---
end;
% disable for future not probmens

% Create image
image(imx,imy,cdata1,'Parent',axes1,'CDataMapping','scaled','AlphaData',~isnan(cdata1));

% Create title and labels
% title('Phantom scan 1'); N
xlabel(x_label);
ylabel(y_label);


% Create colorbar
colorbar('peer',axes1);

% Resize the axes in order to prevent it from shrinking.
set(axes1,'Position',[2 1.5 10 13.5]);

% Set maximum limit
set(axes1,'CLim',CLim);

% Plot cirlces for targets
viscircles(location_tumor,r_target);
viscircles(location_fibro,r_target,'EdgeColor',[0.2 0.8 0.5]);

%Rounds edge of map with a line
if edgePlot, edgeColorer(r_phantom,edgeColor), end



%%-----------------------------AXES2----------------------------------------
% Create axes
axes2 = axes('Parent',figure1,'Units','centimeters',...
    'Position',[17 1.5 10 13.5],...
    'PlotBoxAspectRatio',[1 1 1],...
    'Layer','top',...
    'TickDir','out',...
    'TickLength',[0.02 0.02],...
    'XTickLabel',{'-15','-10','-5','0','5','10','15'},...
    'XTick',[-15 -10 -5 0 5 10 15],...
    'YTickLabel',{'-15','-10','-5','0','5','10','15'},...
    'YTick',[-15 -10 -5 0 5 10 15]);
box(axes2,'on');
hold(axes2,'all');

% Uncomment the following line to preserve the X-limits of the axes
 xlim(axes2,[-12.5 12.5]);
% Uncomment the following line to preserve the Y-limits of the axes
 ylim(axes2,[-12.5 12.5]);

%---
%--- mask exclusion zone, set it to NAN
%---
if nanExclusionZone
cdata2(scan_properties.Masks.mask_excl_fibro)=NaN;   %<---
cdata2(scan_properties.Masks.mask_excl_tumor)=NaN;   %<---
end;
% disable for future not probmens

% Create image
image(imx,imy,cdata2,'Parent',axes2,'CDataMapping','scaled','AlphaData',~isnan(cdata2));

% Create title
title('Phantom scan 2');
xlabel(x_label);
ylabel(y_label);


% Create colorbar
colorbar('peer',axes2);
% Resize the axes in order to prevent it from shrinking.
set(axes2,'Position',[17 1.5 10 13.5]);

% Set maximum limit
set(axes2,'CLim',CLim);

% Plot cirlces for targets
viscircles(location_tumor,r_target);
viscircles(location_fibro,r_target,'EdgeColor',[0.2 0.8 0.5]);

%Rounds edge of map with a line
if edgePlot, edgeColorer(r_phantom,edgeColor), end

%% -----------------------------AXES3----------------------------------------

% Create axes
axes3 = axes('Parent',figure1,'Units','centimeters',... %'Position',[30 1.5 10 13.5],...
    'PlotBoxAspectRatio',[1 1 1],...
    'Layer','top',...
    'TickDir','out',...
    'TickLength',[0.02 0.02],...
    'XTickLabel',{'-15','-10','-5','0','5','10','15'},...
    'XTick',[-15 -10 -5 0 5 10 15],...
    'YTickLabel',{'-15','-10','-5','0','5','10','15'},...
    'YTick',[-15 -10 -5 0 5 10 15]);
box(axes3,'on');
hold(axes3,'all');

% Uncomment the following line to preserve the X-limits of the axes
xlim(axes3,[-12.5 12.5]);
% Uncomment the following line to preserve the Y-limits of the axes
ylim(axes3,[-12.5 12.5]);

%---
%--- mask exclusion zone, set it to NAN
%---
if nanExclusionZone
cdata3(scan_properties.Masks.mask_excl_fibro)=NaN;   %<---
cdata3(scan_properties.Masks.mask_excl_tumor)=NaN;   %<---
end;
% disable for future not probmens


% Create image
image(imx,imy,cdata3,'Parent',axes3,'CDataMapping','scaled','AlphaData',~isnan(cdata3));

% Create title and axes label
title('Phantom scan 3');
xlabel(x_label);
ylabel(y_label);

% Create colorbar
colorbar('peer',axes3);

% Resize the axes in order to prevent it from shrinking.
set(axes3,'Position',[32 1.5 10 13.5]);

% Set maximum limit
set(axes3,'CLim',CLim);

% Plot cirlces for targets
viscircles(location_tumor,r_target);
viscircles(location_fibro,r_target,'EdgeColor',[0.2 0.8 0.5]);

%plot using circular patches 
% works but affects the gradient colorbar
% plot_patch_target(location_tumor,r_target,[0.5 0 0],0.3);
% plot_patch_target(location_fibro,r_target,[0.2 0.8 0.5],0.3);
% 

%Rounds edge of map with a line
if edgePlot, edgeColorer(r_phantom,edgeColor), end




function edgeColorer(r_phantom,edgeColor)
xc = 0;
yc = 0;
theta = linspace(0,2*pi);
x = r_phantom*cos(theta) + xc;
y = r_phantom*sin(theta) + yc;
plot(x,y,'Color',edgeColor,'LineWidth',8);

r_phantom=r_phantom+0.3; % Offset to hide  pixels
x = r_phantom*cos(theta) + xc;
y = r_phantom*sin(theta) + yc;
plot(x,y,'Color',edgeColor,'LineWidth',8);


