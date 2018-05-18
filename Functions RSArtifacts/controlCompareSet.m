% controlCompareSet(errorSet,exp_label,graph_title)
%
%exp_number=[1 2 3 ... n]
%exp_label ={'Case1','Exp 2','Exp3', ... n}


function controlCompareSet(errorSet,exp_number,exp_label,graph_title)
%% --- Part I Load and plot Control values ---
%Load group summary fill

%% Select computer source %[Guaper, Inf or CAD]
load('F:\UserElGuapo\DBOx\Dropbox\ResearchMagic\RandomProyects\160110 12 Effects of AR\MASTER Dataset\ControlSummaryOFF.mat')
%load('C:\Users\Mario\Dropbox\ResearchMagic\RandomProyects\160110 12 Effects of AR\MASTER Dataset\ControlSummaryOFF.mat')



%% *** Plot MSEB graph with IQM with CO from 3 samples



graph_IQM_error_v=repmat([  ControlSummaryOFF.table3exp.ScR_3exp_CI;...
                            ControlSummaryOFF.table3exp.TfR_3exp_CI;...
                            ControlSummaryOFF.table3exp.CcR_3exp_CI],1,length(exp_number)+2);
                        
graph_IQM_mean_v=repmat([   ControlSummaryOFF.table3exp.ScR_3exp_mean;...
                            ControlSummaryOFF.table3exp.TfR_3exp_mean;...
                            ControlSummaryOFF.table3exp.CcR_3exp_mean],1,length(exp_number)+2);

x1=[0,exp_number,max(exp_number)+1.5]; %x1=[0,2,15];

mulineprops.style=':';
mulineprops.width=1.5;
figure; hold on; mseb(x1,graph_IQM_mean_v,graph_IQM_error_v,mulineprops,1);


%*** plot values to compare

%%{
laline.style='o--';
%laline.width=2.5;
% x1=[1,2,3];



%{

hold on;
%% --- Part II Plot obtained current values and graphs

x2=exp_number; %x2=[1.25,2.5,5,15]; %Error set at 1.25°, 2.5°, 5° and 15°.
ScR_v=errorSet.IQMSummary.ScR_M_cMean;
TfR_v=errorSet.IQMSummary.TfR_M_cMean;
CcR_v=errorSet.IQMSummary.CcR_M_cMean;

% Error bars to be plotted, for this I decided to use 95% CI 
ScR_unc=errorSet.IQMSummary.ScR_M_cCI;
TfR_unc=errorSet.IQMSummary.TfR_M_cCI;
CcR_unc=errorSet.IQMSummary.CcR_M_cCI;
% 

plot(x2,ScR_v,'b--o','LineWidth',2.4,'MarkerSize',9,'MarkerFaceColor',[0.15 1 .63])
plot(x2,TfR_v,'r--^','LineWidth',2.4,'MarkerSize',11,'MarkerFaceColor',[0.35 1 .63])
plot(x2,CcR_v,'k--s','LineWidth',2.4,'MarkerSize',11,'MarkerFaceColor',[0.25 1 .33])


%Vertical error bars old style
 plot([x2; x2], [ScR_v'-ScR_unc'; ScR_v'+ScR_unc'], '-b','LineWidth',2)
 plot([x2; x2], [TfR_v'-TfR_unc'; TfR_v'+TfR_unc'], '-r','LineWidth',2)
 plot([x2; x2], [CcR_v'-CcR_unc'; CcR_v'+CcR_unc'], '-k','LineWidth',2)
 
%Vertical error bars hipster style
% errorbar(x2,ScR_v,ScR_unc,'LineStyle','--','color','b');
% errorbar(x2,TfR_v,TfR_unc,'LineStyle','--','color','r');
% errorbar(x2,CcR_v,CcR_unc,'LineStyle','--','color','k');

%Horizontal error bars old style
he=0.1;
 plot([x2-he; x2+he], [ScR_v'; ScR_v'], '-b','LineWidth',2)
 plot([x2-he; x2+he], [TfR_v'; TfR_v'], '-r','LineWidth',2)
 plot([x2-he; x2+he], [CcR_v'; CcR_v'], '-k','LineWidth',2)

%Horizontal error bars hipster style
% herrorbar(x2,SfR_v,repmat(0.5,1,4),'--b');
% herrorbar(x2,TfR_v,repmat(0.5,1,4),'--r');
% herrorbar(x2,CcR_v,repmat(0.5,1,4),'--k');


%% Plot Accuracy error line

 plot([0.26; 0.26], [0;40], '-g','LineWidth',2)
 plot([0.2; 0.2], [0;40], '-m','LineWidth',2)

%% --- Part III Formating and publishing graphs
title(graph_title)


% Define labels on x axis
ax = gca;
set(ax,'XTick', exp_number); % exp_number=[1 2 3 ... n]
set(ax,'XTickLabel',exp_label); %exp_label ={'Case1','Exp 2','Exp3', ... n}
%
% hide labels and title

xlim([0,max(exp_number)+1.5]);
ylabel('dB');
savethisone(['IQMPLOT-', graph_title]);

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