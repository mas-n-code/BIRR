function bh=mario_boxploterOfThree(s)
close all;
ROItumor=s.tumor;
ROIfibro=s.fibro;
ROIrest=s.rest;
dataForPlot = [ROItumor;ROIfibro;ROIrest]; %Gets the data for boxplot

groupingForBoxPlot =  [repmat({'Pixels of Tumor'},length(ROItumor),1);
                       repmat({'Pixels of Fibro'}, length(ROIfibro),1);
                       repmat({'Rest of Pixels'}, length(ROIrest),1)
                       ];
     %Makes grouping for boxplot, so that we can plot all pretty like 
     % - [M] like What?
figure;
bh=boxplot(dataForPlot, groupingForBoxPlot,'Symbol','r+','OutlierSize',1.5,'jitter',0.5,'outliersize',5);    
%  h = findobj(gca,'Tag','Box');
%  for j=1:length(h)
%     patch(get(h(j),'XData'),get(h(j),'YData'),'y','FaceAlpha',.3);
%  end

txt = findobj(gca,'Type','text');
set(txt,'FontName','Times New Roman','FontSize',12)
set(txt(1:end),'VerticalAlignment', 'Middle');

set(bh(:,:),'linewidth',2);


 hold on
  plot(1,mean(ROItumor), 'bd','MarkerSize',4,'LineWidth',4);
   plot(2,mean(ROIfibro), 'bd','MarkerSize',4,'LineWidth',4);
     plot(3,mean(ROIrest), 'bd','MarkerSize',4,'LineWidth',4);

     
