function group_mario_plotterOfSwarm_LS(ExpSet,sProp)
%PLOTFIGURE
close all; figure(1); hold on
% 
% %max +3std
% base=fibro3maxmean; height=3*fibro3std+base;   %<- play with base  and height
% patch([0 0 7 7],[base, height, height,  base],[0.4 0.5 0.6], 'FaceAlpha',0.5 );
% 
% %max +2std
% height=2*fibro3std+base;
% patch([0 0 7 7],[base, height, height,  base],[0.4 0.5 0.6], 'FaceAlpha',0.5 );
% 
% %max +1std
% height=1*fibro3std+base;
% patch([0 0 7 7],[base, height, height,  base],[0.4 0.5 0.6], 'FaceAlpha',0.5 );

s1=ExpSet.P_P1;
s2=ExpSet.P_P2;


xlim([0 6]); ylim(sProp.CLim); 
i=0.25; 

%plot tumor
plot(rand(length(s1.R_tValues.tumor),1)/2 +i,s1.R_tValues.tumor,'ko','MarkerFaceColor',[0.8 0.2 0.2].^(1)); i=i+1; plotVL(i)
plot(rand(length(s2.R_tValues.tumor),1)/2 +i,s2.R_tValues.tumor,'ko','MarkerFaceColor',[0.8 0.2 0.2].^(.5)); i=i+1; plotVL(i)


%plot fibro
plot(rand(length(s1.R_tValues.fibro),1)/2 +i,s1.R_tValues.fibro,'ko','MarkerFaceColor',[0.1 0.8 0.2].^(1)); i=i+1; plotVL(i)
plot(rand(length(s2.R_tValues.fibro),1)/2 +i,s2.R_tValues.fibro,'ko','MarkerFaceColor',[0.1 0.8 0.2].^(.5)); i=i+1; plotVL(i)


%plot clutter
plot(rand(length(s1.R_tValues.clutter),1)/2 +i,s1.R_tValues.clutter,'ko','MarkerFaceColor',[0.15 0.15 0.8].^(1)); i=i+1; plotVL(i)
plot(rand(length(s2.R_tValues.clutter),1)/2 +i,s2.R_tValues.clutter,'ko','MarkerFaceColor',[0.15 0.15 0.8].^(.5)); i=i+1; plotVL(i)




% 
% plot([2.25 2.25],[0 6e-9],'k');
% plot([3.25 3.25],[0 6e-9],'k');
% plot([4.25 4.25],[0 6e-9],'k');
% plot([5.25 5.25],[0 6e-9],'k');
% plot([6.25 6.25],[0 6e-9],'k');
% plot([7.25 7.25],[0 6e-9],'k');

set(gca,'XTick', [0.5,1.5,2.5,3.5,4.5,5.5],...
    'XTickLabel',{'T1','T2','F1','F2','C1','C2'});

function plotVL(i)
fi=i-0.25;
plot([fi fi],[0 1e-3],':','Color',[0.2 0.2 0.2]);