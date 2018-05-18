% Beautifully saves the figure and png file
% savethisone(supershort_savetitle)
function savethisone(supershort_savetitle)
tic
%{
width = 7.2;     % Width in inches
height = 6; 

set(gcf,'InvertHardcopy','on');
set(gcf,'PaperUnits', 'inches');
papersize = get(gcf, 'PaperSize');
left = (papersize(1)- width)/2;
bottom = (papersize(2)- height)/2;
myfiguresize = [left, bottom, width, height];

%}



set(gcf,'PaperPositionMode', 'manual');
%fig=gcf;
%fig.PaperUnits='centimeters';
%fig.PaperSize=[9 6];



%% Change tick labels
%{
ax = gca;
set(ax,'XTick', [1 2 3]);
set(ax,'XTickLabel',{'CS 1' 'CS 2' 'CS 3'});
%}

%% the rest
set(gca,...
    'TickDir','out',...
    'TickLength',[0.02 0.02],... 
    'Layer','top',...
    'FontSize',16,...
    'FontName','Times New Roman');






%--->Temporary disabled<-----
%colorbar('peer',axes1,'FontSize',16,'FontName','Times New Roman');


h=get(gca,'xlabel');
set(h, 'FontSize', 16) 
set(h,'FontName','Times New Roman') %time new roman

h=get(gca,'ylabel');
set(h, 'FontSize', 16) 
set(h,'FontName','Times New Roman') %time new roman

h=get(gca,'title');
set(h, 'FontSize', 16) 
set(h,'FontName','Times New Roman') %time new roman

%print(supershort_savetitle, '-dpng', '-r300')

% 
%print(supershort_savetitle, '-depsc2') 
disp(supershort_savetitle);
savefig(supershort_savetitle);

% export fig, title
export_fig('-dpng','-transparent','-nocrop','-m2','-opengl',supershort_savetitle)

% export fig, 'no title'
%title('')
%export_fig('-dpng','-transparent','-nocrop','-m2',[supershort_savetitle,'_noTitle']);


% writetable(T,[supershort '.xlsx'])
% 
% clearvars width height bottom left papersize myfiguresize






