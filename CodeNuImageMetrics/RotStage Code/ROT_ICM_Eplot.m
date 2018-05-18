% controlCompareSet(errorSet,exp_label,graph_title)
%
%exp_number=[1 2 3 ... n]
%exp_label ={'Case1','Exp 2','Exp3', ... n}


function ROT_ICM_Eplot(combined_summary,exp_values,xTickValues,xTicksLabels)


%% Select computer source %[Guaper, Inf or CAD]
%load('F:\UserElGuapo\DBOx\Dropbox\ResearchMagic\RandomProyects\160110 12 Effects of AR\MASTER Dataset\ControlSummaryOFF.mat')
%load('C:\Users\Mario\Dropbox\ResearchMagic\RandomProyects\160110 12 Effects of AR\MASTER Dataset\ControlSummaryOFF.mat')


%% Prepare paper for graphing
close all;
h=figure; hold on; 
h.Units='inches';
h.Position(1)=0.5;
h.Position(2)=2.5;
h.Position(3)=6.5;
h.Position(4)=5;

%Define Colors
cmap=parula(25);
cS=cmap(1,:); %[1 0 0];
cT=cmap(9,:);%[0 0 1];
cC=cmap(11,:); %[0 0.5 0];
cG=[0.2 0.2 0.2];

% Define font settings
fName='Times New Roman';
fSize=11;
% 'FontName',fName,'FontSize',fSize

%% *** Plot MSEB graph with IQM with CO from 3 samples



graph_IQM_error_v=repmat([  combined_summary(1).gScR_CI;...
                            combined_summary(1).gTfR_CI;...
                            combined_summary(1).gCcR_CI],1,length(exp_values)+2);
                        
graph_IQM_mean_v=repmat([   combined_summary(1).gScR;...
                            combined_summary(1).gTfR;...
                            combined_summary(1).gCcR],1,length(exp_values)+2);

x1=[0,exp_values,max(exp_values)+1.5]; %x1=[0,2,15];
mulineprops.col{1} = cS; 
mulineprops.col{2} = cT; 
mulineprops.col{3} = cC;
mulineprops.style=':';
mulineprops.width=1;


%
mseb(x1,graph_IQM_mean_v,graph_IQM_error_v,mulineprops,1);
%Plot labels at the right of the axes
text(16,combined_summary(1).gScR,'SCR','FontName',fName,'FontSize',fSize)
text(16,combined_summary(1).gTfR,'TFR','FontName',fName,'FontSize',fSize)
text(16,combined_summary(1).gCcR,'CCR','FontName',fName,'FontSize',fSize)

xlim([0 16]);

%*** plot values to compare


%%{
laline.style='o--';
%laline.width=2.5;
% x1=[1,2,3];

hold on;
%% --- Part II Plot obtained current values and graphs

x_values=exp_values; %x2=[1.25,2.5,5,15]; %Error set at 1.25°, 2.5°, 5° and 15°.
ScR_v=[combined_summary(2:end).gScR];
TfR_v=[combined_summary(2:end).gTfR];
CcR_v=[combined_summary(2:end).gCcR];

% Error bars to be plotted, for this I decided to use 95% CI 
ScR_unc=[combined_summary(2:end).gScR_CI];
TfR_unc=[combined_summary(2:end).gCcR_CI];
CcR_unc=[combined_summary(2:end).gCcR_CI];
% 


errorbar(x_values-.02,ScR_v,ScR_unc,'LineStyle','--','color',cG,'LineWidth',1.5);
errorbar(x_values-.02,TfR_v,TfR_unc,'LineStyle','--','color',cT,'LineWidth',1.5);
errorbar(x_values-.02,CcR_v,CcR_unc,'LineStyle','--','color',cC,'LineWidth',1.5);

%Vertical error bars old style
%  plot([x_values; x_values], [ScR_v-ScR_unc; ScR_v+ScR_unc], '-b','LineWidth',1.5,'Color',cS+.1)
%  plot([x_values; x_values], [TfR_v-TfR_unc; TfR_v+TfR_unc], '-r','LineWidth',1.5,'Color',cT+.1)
%  plot([x_values; x_values], [CcR_v-CcR_unc; CcR_v+CcR_unc], '-k','LineWidth',1.5,'Color',cC+.1)

%  
 plot(x_values,ScR_v,'--o','Color',cS,'LineWidth',2,'MarkerSize',6,'MarkerFaceColor',cS.*.9,'MarkerEdgeColor',cG)
plot(x_values,TfR_v,'--d','Color',cT,'LineWidth',2,'MarkerSize',6,'MarkerFaceColor',cT.*.9,'MarkerEdgeColor',cT)
plot(x_values,CcR_v,'--s','Color',cC,'LineWidth',2,'MarkerSize',8,'MarkerFaceColor',cC.*.9,'MarkerEdgeColor',cC)

%Vertical error bars hipster style


%Horizontal error bars old style
% Horizonal error bars are to small to be added to the table

% he=0.1;
%  plot([x_values-he; x_values+he], [ScR_v; ScR_v], '-b','LineWidth',2)
%  plot([x_values-he; x_values+he], [TfR_v; TfR_v], '-r','LineWidth',2)
%  plot([x_values-he; x_values+he], [CcR_v; CcR_v], '-k','LineWidth',2)

%Horizontal error bars hipster style
% herrorbar(x2,SfR_v,repmat(0.5,1,4),'--b');
% herrorbar(x2,TfR_v,repmat(0.5,1,4),'--r');
% herrorbar(x2,CcR_v,repmat(0.5,1,4),'--k');


%% Plot Accuracy error line



%% --- Part III Formating and publishing graphs
% 
% % Define labels on x axis
% ax = gca;
% set(ax,'XTick', exp_values); % exp_number=[1 2 3 ... n]
% set(ax,'XTickLabel',exp_label); %exp_label ={'Case1','Exp 2','Exp3', ... n}
% %
% % hide labels and title
% 
% xlim([0,max(exp_values)+1.5]);



%%--- Part IV Plot in Log format (Idea was droped because mseb does not applies trasnparencis in semilog format)
%{
figure; hold on;
mseb(log2(x1),graph_IQM_mean_v,graph_IQM_error_v,mulineprops,0);
plot(log2(x2),ScR_v,'b--o')
plot(log2(x2),TfR_v,'r--o')
plot(log2(x2),CcR_v,'k--o')
ax = gca;
set(ax,'XTick', log2(0:16)); % exp_number=[1 2 3 ... n]
set(ax,'XTickLabel',{'0°','','2°','3°','','5°','','','8°','','','','12°','','','','16°'}); %exp_label ={'Case1','Exp 2','Exp3', ... n}
set(ax,'XGrid','on')


%}
% %{
  %Curve properties and adjustments
    set(gca, ...
      'Box'         , 'off'      , ...
      'TickDir'     , 'in'     , ...
      'TickLength'  , [.02 .02] , ...
      'XMinorTick'  , 'on'      , ...
      'YMinorTick'  , 'off'      , ...
      'YGrid'       , 'off'      , ...
      'XGrid'       , 'off'      , ...
      'XColor'      , [.1 .1 .1], ...
      'YColor'      , [.1 .1 .1], ...
      'YTick'       , 0:5:30   , ...
      'XTick'       , xTickValues, ...
      'XTickLabel'  , xTicksLabels, ...
      'FontSize'    , fSize        , ...
      'FontName'    , fName, ...
      'LineWidth'   , 1         );

ylabel('dB');
xlabel('Induced positioning error (± 0.01°)')

%% Plot extra lines
plot([0,16],[5,5],':k','LineWidth',1.5); text(8,6,'Rose criterion','FontName',fName,'FontSize',fSize)

%}