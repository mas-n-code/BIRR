%% Please put sscritp code in here and separete in sections
% 
%  A draft, for great glory of Mario
%  
% 

% %%
%%  close all
% % 
  pdir = dir(['FW_****.jpg']);
% % 
%  image=1;

% I = imread(pdir(image).name);
%%CIRCULITOS COLLECTOR
cRange=[10 20];

circulitosEAST_Unc_FW=photoCircleTracker(pdir,5,xcFromExt,ycFromExt,cRange);
%%

% % 
% 
% %%
%  figure(1); 
% % 
 imshow(I,'InitialMagnification',25); hold on;
% 
% plot([InitialPhoto.x],[InitialPhoto.y],'x');
% 
% for ii=1:length(pdir)
%   image=ii;  
% PNx=InitialPhoto(ii).x;
% PNy=InitialPhoto(ii).y;
% PEx=InitialPhoto(ii).x;
% PEy=InitialPhoto(ii).y;
% PCx=InitialPhoto(ii).x;
% PCy=InitialPhoto(ii).y;
% 
% lsidex=PNx - PCx;
% lsidey=PNy - PCy;
% 
% Ssidex=PEx - PCx;
% Ssidey=PEy - PCy;
% 
% plot([PNx PCx PEx],[PNy PCy PEy]);
% 
% resAngle=angleFinder([PNx PNy],[PEx PEy],[PCx PCy]);
% 
% text(PCx+PCx*(0.015),PCy+PCy*(0.015),['\theta ' num2str(resAngle,6)]);
% Tnew=table(image,resAngle)
% TAutScoreUn=[TAutScoreUn;Tnew]
% %set(gca,'YDir','reverse'); % Only for non images
% end

 %%

% for ii=1:length(pdir)
%   image=ii;  
% PNx=circulitosNorth(ii).x;
% PNy=circulitosNorth(ii).y;
% PEx=circulitosEast(ii).x;
% PEy=circulitosEast(ii).y;
% PCx=circulitosCenter(ii).x;
% PCy=circulitosCenter(ii).y;
% 
% lsidex=PNx - PCx;
% lsidey=PNy - PCy;
%  
% Ssidex=PEx - PCx;
% Ssidey=PEy - PCy;
% 
% plot([PNx PCx PEx],[PNy PCy PEy]);
% 
% resAngle=angleFinder([PNx PNy],[PEx PEy],[PCx PCy]);
% 
% text(PCx+PCx*(0.015),PCy+PCy*(0.015),['\theta ' num2str(resAngle,6)]);
% Tnew=table(image,resAngle);
% TAutScoreCorrD=[TAutScoreCorrD;Tnew]
% % %set(gca,'YDir','reverse'); % Only for non images
% end
%%

TScore_unc_DARK_fw=losanglesFinder(circulitosNORTH_Unc_FW,circulitosEAST_Unc_FW,circulitosCENTER_Unc_FW);

%%
% imshow(I,'InitialMagnification',25); hold on;
% cNorth=circleCatcher(I,cRange,'North');
% angleCatcher(cNorth.x,cNorth.y,xcenter,ycenter)

%%
%circulitosWestCMM=photoCircleTracker(pdir,5,xcenter,ycenter,cRange);
% table([circulitosWestCMM(1).x,circulitosWestCMM(1).y;...
%     circulitosEastCMM(1).x,circulitosEastCMM(1).y;...
%     circulitosNorthCMM(1).x,circulitosNorthCMM(1).y;...
%     circulitosSouthCMM(1).x,circulitosSouthCMM(1).y;...
%     circulitosCenterCM(1).x,circulitosCenterCM(1).y]);


%% MIM ANALYSIS
% 
% cRange=[12 22];
% 
% cirN__RV_CenterBIG_Dark=photoCircleTracker(pdir,-5,xcbig,ycbig, cRange);
% 
% tmpFW=cirN__FW_CenterBIG_Dark;
% tmpRV=cirN__RV_CenterBIG_Dark;
% plot(xcbig,ycbig,'o');
% plot(round(xcbig),round(ycbig),'s');
% figure(); hold on;
% plot(1:1:10,[cirN__FW_CenterBIG_Dark.relativeAngleInc],'-go');
% plot(12:-1:1,[cirN__RV_CenterBIG_Dark.relativeAngleInc]*-1,'-ro');
% %FW_RVdata=[tmpFW(2:end).relativeAngleInc;tmpRV(2:end).relativeAngleInc]
% FWstd=std([tmpFW(2:end).relativeAngleInc]);
% RVstd=std([tmpRV(2:end).relativeAngleInc]);
% FWmean=mean([tmpFW(2:end).relativeAngleInc]);
% RVmean=mean([tmpRV(2:end).relativeAngleInc]);
% MIM_FW=3*FWstd;
% MIM_RV=3*RVstd;
% table_FW_RV=table([FWmean;RVmean],[FWstd;RVstd],[MIM_FW;MIM_RV],'RowNames',{'Forward';'Reverse'},'VariableNames',{'mean','std','MIM'})
% FW_dataT=table([tmpFW.relativeAngleInc]',[tmpFW.absAngle]','VariableNames',{'IncrementalAngle','AbsoluteAngle'});
% RV_dataT=table([tmpRV.relativeAngleInc]',[tmpRV.absAngle]','VariableNames',{'IncrementalAngle','AbsoluteAngle'});