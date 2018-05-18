function[GroupSet]=Group_RegionSegmenter_Rotary(GroupSet,Regions,IM_Clim,IP_Clim) 
%%{

% [GroupSet]=Group_RegionSegmenter_Rotary(GroupSet,Regions,IM_Clim,IP_Clim,SetName) 
% Segments regions, calculate standard regions values, evaluates 

GroupSetName=GroupSet.GName;

GroupSet.E1.ImageMetrics.Name=[GroupSetName, ' E1 '];
% GroupSet.E2.ImageMetrics.Name=[GroupSetName, ' E2 '];
% GroupSet.E4.ImageMetrics.Name=[GroupSetName, ' E4 '];
% GroupSet.E12.ImageMetrics.Name=[GroupSetName, ' E12 '];

GroupSet.E1.PowImageMetrics.Name=[GroupSetName, ' E1 Pow'];
% GroupSet.E2.PowImageMetrics.Name=[GroupSetName, ' E2 Pow'];
% GroupSet.E4.PowImageMetrics.Name=[GroupSetName, ' E4 Pow'];
% GroupSet.E12.PowImageMetrics.Name=[GroupSetName, ' E12 Pow'];


%%  Calculate Standard Metrics for Regions 


%IM_clim= 7e-5; % this value might be overrided
[GroupSet.E1.ImageMetrics]=I_RegionStandard(abs(GroupSet.E1.SCAN.S11_c_RecZoomFlip),Regions,GroupSet.E1.ImageMetrics,IM_Clim); savethisone([GroupSet.E1.ImageMetrics.Name 'magnitude structure mean']);
% [GroupSet.E2.ImageMetrics]=I_RegionStandard(abs(GroupSet.E2.SCAN.S11_c_RecZoomFlip),Regions,GroupSet.E2.ImageMetrics,IM_Clim); savethisone([GroupSet.E2.ImageMetrics.Name 'magnitude structure mean']);
% [GroupSet.E4.ImageMetrics]=I_RegionStandard(abs(GroupSet.E4.SCAN.S11_c_RecZoomFlip),Regions,GroupSet.E4.ImageMetrics,IM_Clim); savethisone([GroupSet.E4.ImageMetrics.Name 'magnitude structure mean']);
% [GroupSet.E12.ImageMetrics]=I_RegionStandard(abs(GroupSet.E12.SCAN.S11_c_RecZoomFlip),Regions,GroupSet.E12.ImageMetrics,IM_Clim); savethisone([GroupSet.E12.ImageMetrics.Name 'magnitude structure mean']);


%% Plot mean values per scan with +- sd 
%{
cmap=colormap(paruly);
figure; hold on
tresh_magnitude= IM_Clim; % this value might be overrided
title({GroupSetName,'Mean value at PD'})

ylim([0 tresh_magnitude])
xlim([0.5 4.5])


ax = gca;
set(ax,'XTick',[1 2 3 4])
set(ax,'XTickLabel',{'1.25°' '3.00°' '5.00°' '15.00°'})

pos = get(gcf, 'Position');
set(gcf, 'Position', [pos(1) pos(2) pos(3), pos(4)*1.10]); %<- Set size

tplot=plot([GroupSet.E1.ImageMetrics.Tumor.Mean...
            %,GroupSet.E2.ImageMetrics.Tumor.Mean,...
            %GroupSet.E4.ImageMetrics.Tumor.Mean,...
            %GroupSet.E12.ImageMetrics.Tumor.Mean...
            ],'--s');

set(tplot,'color',cmap(50,:));
set(tplot,'LineWidth',3);

%Plot maxiumum tumor , not fixed
%{
%Shows the
maxtplot=plot([GroupSet.E1.ImageMetrics.Tumor.Max,GroupSet.E2.ImageMetrics.Tumor.Max,GroupSet.E4.ImageMetrics.Tumor.Max]);
maxtplot.MarkerSize=8;
maxtplot.MarkerEdgeColor='k';
maxtplot.MarkerFaceColor=cmap(50,:)+0.05;
maxtplot.LineStyle='none';
maxtplot.Marker='o';
%} 


fplot=plot([GroupSet.E1.ImageMetrics.Fibro.Mean...
            %,GroupSet.E2.ImageMetrics.Fibro.Mean,...
            %GroupSet.E4.ImageMetrics.Fibro.Mean,...
            %GroupSet.E12.ImageMetrics.Fibro.Mean,...
            ],'--o');
set(fplot,'color',cmap(35,:));
set(fplot,'LineWidth',3);


%{
maxfplot=plot([GroupSet.E1.ImageMetrics.Fibro.Max,GroupSet.E2.ImageMetrics.Fibro.Max,GroupSet.E4.ImageMetrics.Fibro.Max]);
maxfplot.MarkerSize=8;
maxfplot.MarkerEdgeColor='k';
maxfplot.MarkerFaceColor=cmap(35,:)-0.05;
maxfplot.LineStyle='none';
maxfplot.Marker='o';
%}

bplot=plot([GroupSet.E1.ImageMetrics.Back.Mean...
            %,GroupSet.E2.ImageMetrics.Back.Mean,...
            %GroupSet.E4.ImageMetrics.Back.Mean,...
            %GroupSet.E12.ImageMetrics.Back.Mean,...
            ],'--d');
set(bplot,'color',cmap(10,:));
set(bplot,'LineWidth',3);

%Tumor errorbars
errorbar([1,2,3,4],...
        [GroupSet.E1.ImageMetrics.Tumor.Mean...
         %,GroupSet.E2.ImageMetrics.Tumor.Mean,...
         %GroupSet.E4.ImageMetrics.Tumor.Mean...
         %GroupSet.E12.ImageMetrics.Tumor.Mean],...
        [GroupSet.E1.ImageMetrics.Tumor.Std...
         %,GroupSet.E2.ImageMetrics.Tumor.Std,...
         %GroupSet.E4.ImageMetrics.Tumor.Std...
         %GroupSet.E12.ImageMetrics.Tumor.Std],...
        'Color', cmap(50,:)-0.2,'MarkerSize',4,'LineWidth',2.5,'LineWidth',2.5 ),hold on;
    
%Fibro errorbars 
errorbar([1,2,3,4],...
        [GroupSet.E1.ImageMetrics.Fibro.Mean...
         %,GroupSet.E2.ImageMetrics.Fibro.Mean,...
         %GroupSet.E4.ImageMetrics.Fibro.Mean,...
         %GroupSet.E12.ImageMetrics.Fibro.Mean],...
        [GroupSet.E1.ImageMetrics.Fibro.Std...
         %,GroupSet.E2.ImageMetrics.Fibro.Std,...
         %GroupSet.E4.ImageMetrics.Fibro.Std,...
         %GroupSet.E12.ImageMetrics.Fibro.Std],...
        'Color', cmap(35,:)-0.2,'MarkerSize',4,'LineWidth',2.5,'LineWidth',2.5 ),hold on;


%Back errorbars 
errorbar([1,2,3,4],...
        [GroupSet.E1.ImageMetrics.Back.Mean,...
         GroupSet.E2.ImageMetrics.Back.Mean,...
         GroupSet.E4.ImageMetrics.Back.Mean,...
         GroupSet.E12.ImageMetrics.Back.Mean],...
        [GroupSet.E1.ImageMetrics.Back.Std,...
         GroupSet.E2.ImageMetrics.Back.Std,...
         GroupSet.E4.ImageMetrics.Back.Std...
         GroupSet.E12.ImageMetrics.Back.Std],...
        'Color', cmap(10,:),'MarkerSize',4,'LineWidth',2.5,'LineWidth',2.5 ),hold on;

le1=legend([tplot,fplot,bplot],'Tumor','Fibro-glandular','Background');
set (le1,'Position',[0.53,0.18,0.21,0.20]);
    
% This other legend includes maximum values
%legend([tplot,maxtplot,fplot,maxfplot,bplot],'Mean tumor','Max tumor','Mean fibro','Max fibro','Mean background')


savethisone([GroupSetName, ' Mean value at PD MAG'])

%}


%% Calculate Standard Metrics for POWER Regions
close all;

tresh_power= IP_Clim; % this value might be overrided
[GroupSet.E1.PowImageMetrics]=I_RegionStandard(abs(GroupSet.E1.SCAN.S11_c_RecZoomFlip).^2,Regions,GroupSet.E1.PowImageMetrics,tresh_power); savethisone([GroupSet.E1.ImageMetrics.Name 'pow structures mean']);
% [GroupSet.E2.PowImageMetrics]=I_RegionStandard(abs(GroupSet.E2.SCAN.S11_c_RecZoomFlip).^2,Regions,GroupSet.E2.PowImageMetrics,tresh_power); savethisone([GroupSet.E2.ImageMetrics.Name 'pow structures mean']);
% [GroupSet.E4.PowImageMetrics]=I_RegionStandard(abs(GroupSet.E4.SCAN.S11_c_RecZoomFlip).^2,Regions,GroupSet.E4.PowImageMetrics,tresh_power); savethisone([GroupSet.E4.ImageMetrics.Name 'pow structures mean']);
% [GroupSet.E12.PowImageMetrics]=I_RegionStandard(abs(GroupSet.E12.SCAN.S11_c_RecZoomFlip).^2,Regions,GroupSet.E12.PowImageMetrics,tresh_power); savethisone([GroupSet.E12.ImageMetrics.Name 'pow structures mean']);



%%
%% Plot mean values per scan with +- sd 
%{
cmap=colormap(paruly);
figure; hold on
tresh_magnitude= IP_Clim; % this value might be overrided
title({GroupSetName,'Mean value at PD'})

ylim([0 tresh_magnitude])
xlim([0.5 4.5])


ax = gca;
set(ax,'XTick',[1 2 3 4])
set(ax,'XTickLabel',{'1.25°' '3.00°' '5.00°' '15.00°'})

pos = get(gcf, 'Position');
set(gcf, 'Position', [pos(1) pos(2) pos(3), pos(4)*1.10]); %<- Set size

tplot=plot([GroupSet.E1.PowImageMetrics.Tumor.Mean,...
            GroupSet.E2.PowImageMetrics.Tumor.Mean,...
            GroupSet.E4.PowImageMetrics.Tumor.Mean,...
            GroupSet.E12.PowImageMetrics.Tumor.Mean...
            ],'--s');

set(tplot,'color',cmap(50,:));
set(tplot,'LineWidth',3);

%Plot maxiumum tumor , not fixed
%{
%Shows the
maxtplot=plot([GroupSet.E1.PowImageMetrics.Tumor.Max,GroupSet.E2.PowImageMetrics.Tumor.Max,GroupSet.E4.PowImageMetrics.Tumor.Max]);
maxtplot.MarkerSize=8;
maxtplot.MarkerEdgeColor='k';
maxtplot.MarkerFaceColor=cmap(50,:)+0.05;
maxtplot.LineStyle='none';
maxtplot.Marker='o';
%} 


fplot=plot([GroupSet.E1.PowImageMetrics.Fibro.Mean,...
            GroupSet.E2.PowImageMetrics.Fibro.Mean,...
            GroupSet.E4.PowImageMetrics.Fibro.Mean,...
            GroupSet.E12.PowImageMetrics.Fibro.Mean,...
            ],'--o');
set(fplot,'color',cmap(35,:));
set(fplot,'LineWidth',3);


%{
maxfplot=plot([GroupSet.E1.PowImageMetrics.Fibro.Max,GroupSet.E2.PowImageMetrics.Fibro.Max,GroupSet.E4.PowImageMetrics.Fibro.Max]);
maxfplot.MarkerSize=8;
maxfplot.MarkerEdgeColor='k';
maxfplot.MarkerFaceColor=cmap(35,:)-0.05;
maxfplot.LineStyle='none';
maxfplot.Marker='o';
%}

bplot=plot([GroupSet.E1.PowImageMetrics.Back.Mean,...
            GroupSet.E2.PowImageMetrics.Back.Mean,...
            GroupSet.E4.PowImageMetrics.Back.Mean,...
            GroupSet.E12.PowImageMetrics.Back.Mean,...
            ],'--d');
set(bplot,'color',cmap(10,:));
set(bplot,'LineWidth',4);

%Tumor errorbars
errorbar([1,2,3,4],...
        [GroupSet.E1.PowImageMetrics.Tumor.Mean,...
         GroupSet.E2.PowImageMetrics.Tumor.Mean,...
         GroupSet.E4.PowImageMetrics.Tumor.Mean...
         GroupSet.E12.PowImageMetrics.Tumor.Mean],...
        [GroupSet.E1.PowImageMetrics.Tumor.Std,...
         GroupSet.E2.PowImageMetrics.Tumor.Std,...
         GroupSet.E4.PowImageMetrics.Tumor.Std...
         GroupSet.E12.PowImageMetrics.Tumor.Std],...
        'Color', cmap(50,:)-0.2,'MarkerSize',4,'LineWidth',2.5 ),hold on;
    
%Fibro errorbars 
errorbar([1,2,3,4],...
        [GroupSet.E1.PowImageMetrics.Fibro.Mean,...
         GroupSet.E2.PowImageMetrics.Fibro.Mean,...
         GroupSet.E4.PowImageMetrics.Fibro.Mean,...
         GroupSet.E12.PowImageMetrics.Fibro.Mean],...
        [GroupSet.E1.PowImageMetrics.Fibro.Std,...
         GroupSet.E2.PowImageMetrics.Fibro.Std,...
         GroupSet.E4.PowImageMetrics.Fibro.Std,...
         GroupSet.E12.PowImageMetrics.Fibro.Std],...
        'Color', cmap(35,:)-0.2,'MarkerSize',4,'LineWidth',2.5 ),hold on;


%Back errorbars 
errorbar([1,2,3,4],...
        [GroupSet.E1.PowImageMetrics.Back.Mean,...
         GroupSet.E2.PowImageMetrics.Back.Mean,...
         GroupSet.E4.PowImageMetrics.Back.Mean,...
         GroupSet.E12.PowImageMetrics.Back.Mean],...
        [GroupSet.E1.PowImageMetrics.Back.Std,...
         GroupSet.E2.PowImageMetrics.Back.Std,...
         GroupSet.E4.PowImageMetrics.Back.Std...
         GroupSet.E12.PowImageMetrics.Back.Std],...
        'Color', cmap(10,:),'MarkerSize',4,'LineWidth',2.5 ),hold on;

le1=legend([tplot,fplot,bplot],'Tumor','Fibro-glandular','Background');
set (le1,'Position',[0.53,0.65,0.21,0.20]);
    
% This other legend includes maximum values
%legend([tplot,maxtplot,fplot,maxfplot,bplot],'Mean tumor','Max tumor','Mean fibro','Max fibro','Mean background')


savethisone([GroupSetName, ' Mean value at PD POW'])



%}

%% %% Boxplot region values  

[GroupSet.E1.ImageMetrics]=I_RegionBoxplot(abs(GroupSet.E1.SCAN.S11_c_RecZoomFlip),Regions,GroupSet.E1.ImageMetrics); title([GroupSet.E1.ImageMetrics.Name]); savethisone([GroupSet.E1.ImageMetrics.Name 'boxplot per region MAG']);
% [GroupSet.E2.ImageMetrics]=I_RegionBoxplot(abs(GroupSet.E2.SCAN.S11_c_RecZoomFlip),Regions,GroupSet.E2.ImageMetrics); title([GroupSet.E2.ImageMetrics.Name]); savethisone([GroupSet.E2.ImageMetrics.Name 'boxplot per region MAG']);
% [GroupSet.E4.ImageMetrics]=I_RegionBoxplot(abs(GroupSet.E4.SCAN.S11_c_RecZoomFlip),Regions,GroupSet.E4.ImageMetrics); title([GroupSet.E4.ImageMetrics.Name]); savethisone([GroupSet.E4.ImageMetrics.Name 'boxplot per region MAG']);
% [GroupSet.E12.ImageMetrics]=I_RegionBoxplot(abs(GroupSet.E12.SCAN.S11_c_RecZoomFlip),Regions,GroupSet.E12.ImageMetrics); title([GroupSet.E12.ImageMetrics.Name]); savethisone([GroupSet.E12.ImageMetrics.Name 'boxplot per region MAG']);



%% %% Boxplot region values  power
[GroupSet.E1.PowImageMetrics]=I_RegionBoxplot(abs(GroupSet.E1.SCAN.S11_c_RecZoomFlip).^2,Regions,GroupSet.E1.PowImageMetrics); title([GroupSet.E1.PowImageMetrics.Name]); savethisone([GroupSet.E1.PowImageMetrics.Name 'boxplot per region POW']);
% [GroupSet.E2.PowImageMetrics]=I_RegionBoxplot(abs(GroupSet.E2.SCAN.S11_c_RecZoomFlip).^2,Regions,GroupSet.E2.PowImageMetrics); title([GroupSet.E2.PowImageMetrics.Name]); savethisone([GroupSet.E2.PowImageMetrics.Name 'boxplot per region POW']);
% [GroupSet.E4.PowImageMetrics]=I_RegionBoxplot(abs(GroupSet.E4.SCAN.S11_c_RecZoomFlip).^2,Regions,GroupSet.E4.PowImageMetrics); title([GroupSet.E4.PowImageMetrics.Name]); savethisone([GroupSet.E4.PowImageMetrics.Name 'boxplot per region POW']);
% [GroupSet.E12.PowImageMetrics]=I_RegionBoxplot(abs(GroupSet.E12.SCAN.S11_c_RecZoomFlip).^2,Regions,GroupSet.E12.PowImageMetrics); title([GroupSet.E12.PowImageMetrics.Name]); savethisone([GroupSet.E12.PowImageMetrics.Name 'boxplot per region POW']);

%}
disp('All done Thanks!')