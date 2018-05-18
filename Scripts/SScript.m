%% Please put sscritp code in here and separete in sections
% 
%  A draft, for great glory of Mario
%  
% 

% %%
%%  close all
% % 
  pdir = dir(['****.jpg']);
% % 
 image=1;
% % 
I = imread(pdir(image).name);
% cRange=[10 20];
% % 
% circulitosEastCM=photoCircleTracker(pdir,5,xcFromExt,ycFromExt,cRange);
% %% 
% % 
% % InitialPhoto(1)=circleCatcher(I,[10 20],'North');
% % 
% % InitialPhoto(2)=circleCatcher(I,[10 20],'East');
% % 
% % InitialPhoto(3)=circleCatcher(I,[110 140],'CenterCircle');
% % 
% 
% %%
%  figure(1); 
% % 
% imshow(I,'InitialMagnification',25); hold on;
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

%%TScoreINVWandS=losanglesFinder(circulitosWestCMM,circulitosSouthCMM,circulitosCenterCM);

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

cRange=[10 20];
cirN_CenterCorr_Dark=photoCircleTracker(pdir,5,xcCorrected,ycCorrected, cRange);
plot(xcbig,ycbig,'o');
plot(round(xcbig),round(ycbig),'s');