function bh=mario_boxploterOfTwo(X1,X2,tag1,tag2)
% X is a n-by-2 array, 
% name is a two elemento vector with the 

% tag1={names(1)};
% tag2={names(2)};

firstBox=X1;
secondBox=X2;

dataForPlot = [firstBox;secondBox;]; %Gets the data for boxplot

groupingForBoxPlot =  [repmat({tag1},length(firstBox),1);
                       repmat({tag2}, length(secondBox),1);
                       ];
     %Makes grouping for boxplot, so that we can plot all pretty like 
     % - [M] like What?
     
figure; ylim([0 5e-9])
bh=boxplot(dataForPlot, groupingForBoxPlot,'Symbol','r+','OutlierSize',4,'jitter',0.5,'outliersize',5);    
%  h = findobj(gca,'Tag','Box');
%  for j=1:length(h)
%     patch(get(h(j),'XData'),get(h(j),'YData'),'y','FaceAlpha',.3);
%  end

txt = findobj(gca,'Type','text');
set(txt,'FontName','Times New Roman','FontSize',12)
set(txt(1:end),'VerticalAlignment', 'Middle');

set(bh(:,:),'linewidth',2);

 hold on
  plot(1,mean(firstBox), 'bd','MarkerSize',4,'LineWidth',4);
   plot(2,mean(secondBox), 'bd','MarkerSize',4,'LineWidth',4);

   set(findobj(gca,'Type','text'),'FontSize',12,'FontName','Times New Roman')
  