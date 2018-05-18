function ROC_MetaPlotter(Control_ROC,PE,C_Style)
% will be a function that will be passed a PC and PE erroSet structres and
% a folder, where the variables will be saved and a DTag and a FIGName,
% which is the name of the figure(CAE errors)

%First, plot the control value
close all;
%C_Style='Strong';
% C_Style='Soft';
fSize=11;
fName='Times New Roman';


xCON=Control_ROC.xroc;
yCON=Control_ROC.yroc;

    H=figure;
    set(H,'Position',[30 400 460 400])
    hold on
    
    
    
    ylabel('True positive rate (Sensitivity)')
    xlabel('False positive rate (1-Specificity)')
    xlim([0 1])
    ylim([0 1])
    axis square
    
if strcmp(C_Style,'Strong')
    cmap=colormap(hot(25));
else
    cmap=colormap(parula(25));
    cmap(:,4)=0.7;
end

% Plot control
ROCcurves.CON=plot(xCON,yCON,'K','LineWidth',3,'MarkerSize',6);

% Plot Errors
  ROCcurves.E1=plot(PE.E1.ROC.Roc_TumorVsFC.xroc,PE.E1.ROC.Roc_TumorVsFC.yroc,'Color',cmap(2,:),'LineWidth',3,'MarkerSize',1);
  ROCcurves.E2=plot(PE.E2.ROC.Roc_TumorVsFC.xroc,PE.E2.ROC.Roc_TumorVsFC.yroc,'Color',cmap(4,:),'LineWidth',3,'MarkerSize',1);
  ROCcurves.E4=plot(PE.E4.ROC.Roc_TumorVsFC.xroc,PE.E4.ROC.Roc_TumorVsFC.yroc,'Color',cmap(8,:),'LineWidth',3,'MarkerSize',1);
ROCcurves.E12=plot(PE.E12.ROC.Roc_TumorVsFC.xroc,PE.E12.ROC.Roc_TumorVsFC.yroc,'Color',cmap(11,:),'LineWidth',3,'MarkerSize',1);

% Plot 0.5
plot([0 1],[0 1],'--','LineWidth',1,'Color',[0.1 0.1 0.1]);

    %Curve properties and adjustments
    set(gca, ...
      'Box'         , 'on'      , ...
      'TickDir'     , 'out'     , ...
      'TickLength'  , [.02 .02] , ...
      'XMinorTick'  , 'off'      , ...
      'YMinorTick'  , 'off'      , ...
      'YGrid'       , 'off'      , ...
      'XGrid'       , 'off'      , ...
      'XColor'      , [.1 .1 .1], ...
      'YColor'      , [.1 .1 .1], ...
      'XTick'       , 0:0.2:1   , ...
      'YTick'       , 0:0.2:1   , ...
      'FontSize'    , fSize     , ...
      'FontName'    , fName     , ...
      'LineWidth'   , 1         );
  
    ax=gca;
    ax.GridColor = [0.3, 0.3, 0.3];  % [R, G, B]
    ax.XTickMode = 'Manual';
    ax.YTickMode = 'Manual';
    %set(gca,'Color',[0.95 0.95 0.95]);
    set(gca,'LooseInset',get(gca,'TightInset'))
    
    % generate legend elements
    Le(1).Name='Control';
    Le(2).Name='1.25°';
    Le(3).Name='2.5°  ';
    Le(4).Name='5°     ';
    Le(5).Name='15°   ';
    
    Le(1).Auc=num2str(Control_ROC.AUC,'%10.3f');
    Le(2).Auc=num2str(PE.E1.ROC.Roc_TumorVsFC.AUC,'%10.3f');
    Le(3).Auc=num2str(PE.E2.ROC.Roc_TumorVsFC.AUC,'%10.3f');
    Le(4).Auc=num2str(PE.E4.ROC.Roc_TumorVsFC.AUC,'%10.3f');
    Le(5).Auc=num2str(PE.E12.ROC.Roc_TumorVsFC.AUC,'%10.3f');


    for i= 1:5 
    Le(i).Tag=[Le(i).Name,' (AUC = ',Le(i).Auc,')'];
    end
    
    %{
    %comented legend?
    % Legend
    l=legend([ROCcurves.CON,...
        ROCcurves.E1    ,       ...
        ROCcurves.E2    ,       ...
        ROCcurves.E4    ,       ...
        ROCcurves.E12]  ,       ...
        Le(1).Tag       ,       ...
        Le(2).Tag       ,       ...
        Le(3).Tag       ,       ...
        Le(4).Tag       ,       ...
        Le(5).Tag'      ,       ...
        'Location'      , 'SouthEast'   ,   ...
        'EdgeColor'     , 'white'      ); 
    l.FontSize=fSize;
    l.FontName=fName;
    
    %}
    
    