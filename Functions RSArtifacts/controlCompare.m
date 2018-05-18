% controlCompare (ScR_v,TfR_v,CcR_v,exp_number,exp_label,graph_title)
%
%exp_number=[1 2 3 ... n]
%exp_label ={'Case1','Exp 2','Exp3', ... n}


function controlCompare (ScR_v,TfR_v,CcR_v,exp_number,exp_label,graph_title)

%Load group summary fill
load('F:\UserElGuapo\DBOx\Dropbox\ResearchMagic\RandomProyects\160110 12 Effects of AR\MASTER Dataset\ControlSummaryOFF.mat')


%% Plot MSEB graph with IQM with CO from 3 samples



graph_IQM_error_v=repmat([  ControlSummaryOFF.table3exp.ScR_3exp_CI;...
                            ControlSummaryOFF.table3exp.TfR_3exp_CI;...
                            ControlSummaryOFF.table3exp.CcR_3exp_CI],1,3);
                        
graph_IQM_mean_v=repmat([   ControlSummaryOFF.table3exp.ScR_3exp_mean;...
                            ControlSummaryOFF.table3exp.TfR_3exp_mean;...
                            ControlSummaryOFF.table3exp.CcR_3exp_mean],1,3);

x1=[0,2,4];
mulineprops.style=':';
mulineprops.width=1;
figure; hold on; mseb(x1,graph_IQM_mean_v,graph_IQM_error_v,mulineprops,1);


% plot values to compare

%%{
laline.style='o--';
% x1=[1,2,3];
size(exp_number)
size([ScR_v;TfR_v;CcR_v])

hold on;
plot(1,ScR_v,'k--o')
plot(1,TfR_v,'g--o')
plot(1,CcR_v,'b--o')

%{
h=mseb(x1,[ScR_v;TfR_v;CcR_v],zeros(3,max(exp_number)),laline,1);
l1=legend([h.mainLine],'ScR','TfR','CcR','Location','Best');
set(l1,...
    'Position',[0.40 0.25 0.25 0.15]); %
%}

title('IQM Invidiual experiments values over average and CI')



% Define labels on x axis
ax = gca;
set(ax,'XTick', exp_number); % exp_number=[1 2 3 ... n]
set(ax,'XTickLabel',exp_label); %exp_label ={'Case1','Exp 2','Exp3', ... n}
%
% hide labels and title
%
xlim([0.5,max(exp_number)+1.5])
ylabel('dB')
title('')

%savethisone([graph_title, 'over Control mu+CI']);