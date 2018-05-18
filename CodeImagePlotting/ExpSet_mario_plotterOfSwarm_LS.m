function ExpSet_mario_plotterOfSwarm_LS(ErrorSet,sProp)
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

e1=ErrorSet.E1;
e2=ErrorSet.E2;
e3=ErrorSet.E3;


i=0.25; x_width=1;

xlim([0 9*x_width]); ylim(sProp.CLim); 
%plot tumor
 plot(rand(length(e1.CALL.call_tumor),1)*(x_width/2) +i,e1.CALL.call_tumor,'ko','MarkerFaceColor',[0.8 0.2 0.2].^(1)); i=i+x_width; plotVL(i)
 plot(rand(length(e2.CALL.call_tumor),1)*(x_width/2) +i,e2.CALL.call_tumor,'ko','MarkerFaceColor',[0.8 0.2 0.2].^(.5)); i=i+x_width; plotVL(i)
 plot(rand(length(e3.CALL.call_tumor),1)*(x_width/2) +i,e3.CALL.call_tumor,'ko','MarkerFaceColor',[0.8 0.2 0.2].^(0.25)); i=i+x_width; plotVL(i)


%plot fibro
 plot(rand(length(e1.CALL.call_fibro),1)*(x_width/2) +i,e1.CALL.call_fibro,'ko','MarkerFaceColor',[0.1 0.8 0.2].^(1)); i=i+x_width; plotVL(i)
 plot(rand(length(e2.CALL.call_fibro),1)*(x_width/2) +i,e2.CALL.call_fibro,'ko','MarkerFaceColor',[0.1 0.8 0.2].^(.5)); i=i+x_width; plotVL(i)
 plot(rand(length(e3.CALL.call_fibro),1)*(x_width/2) +i,e3.CALL.call_fibro,'ko','MarkerFaceColor',[0.1 0.8 0.2].^(0.25)); i=i+x_width; plotVL(i)


%plot clutter
plot(rand(length(e1.CALL.call_clutter),1)*(x_width/2) +i,e1.CALL.call_clutter,'ko','MarkerFaceColor',[0.15 0.15 0.8].^(1)); i=i+x_width; plotVL(i)
plot(rand(length(e2.CALL.call_clutter),1)*(x_width/2) +i,e2.CALL.call_clutter,'ko','MarkerFaceColor',[0.15 0.15 0.8].^(.5)); i=i+x_width; plotVL(i)
plot(rand(length(e3.CALL.call_clutter),1)*(x_width/2) +i,e3.CALL.call_clutter,'ko','MarkerFaceColor',[0.15 0.15 0.8].^(0.25)); i=i+x_width; plotVL(i)

% 
% plot([2.25 2.25],[0 6e-9],'k');
% plot([3.25 3.25],[0 6e-9],'k');
% plot([4.25 4.25],[0 6e-9],'k');
% plot([5.25 5.25],[0 6e-9],'k');
% plot([6.25 6.25],[0 6e-9],'k');
% plot([7.25 7.25],[0 6e-9],'k');

set(gca,'XTick', 0.5:0.5+(1*8),...
    'XTickLabel',...
    {'TE1' 'TE2' 'TE3' ...
    'FE1' 'FE2' 'FE3' ...
    'CE1' 'CE2' 'CE3' });

P = get(gcf,'Position');
set(gcf,'position',[P(1) P(2) P(3)*1.5 P(4)]);

% T = get(gca,'tightinset')
% set(gca,'position',[T(1) T(2) 1-T(1)-T(3) 1-T(2)-T(4)]);

G = get(gca,'Position');
% set(gca,'position',[G(1) G(2) G(3) G(4)]);
set(gca,'position',[G(1)*0.5 G(2) G(3)*1.19 G(4)]);

function plotVL(i)
fi=i-0.25;
plot([fi fi],[0 3e-8],':','Color',[0.2 0.2 0.2]);

