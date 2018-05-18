% Beautifully saves the figure and png file using Times 11
% also saves the figure in full and half widht mode
% savethisone11(supershort_savetitle)
function savethisone11(DTag,supershort_savetitle)

tic
%%{
supershort_savetitle=[DTag,supershort_savetitle];
parent_dir=[DTag,'B_Images and Figures'];
path_tile=[parent_dir,'\',supershort_savetitle,'\'];
mkdir(parent_dir,supershort_savetitle)
%fig=gcf;
%fig.PaperUnits='centimeters';
%fig.PaperSize=[9 6];

set(gcf,'InvertHardcopy','on');
set(gcf,'PaperUnits', 'inches');

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
    'FontSize',12,...
    'FontName','Times New Roman');






%--->Temporary disabled<-----
%colorbar('peer',axes1,'FontSize',16,'FontName','Times New Roman');


h=get(gca,'xlabel');
set(h, 'FontSize', 12) 
set(h,'FontName','Times New Roman') %time new roman

h=get(gca,'ylabel');
set(h, 'FontSize', 12) 
set(h,'FontName','Times New Roman') %time new roman

h=get(gca,'title');
set(h, 'FontSize', 12) 
set(h,'FontName','Times New Roman') %time new roman

%print(supershort_savetitle, '-dpng', '-r300')
% export_fig('-dpng','-transparent','-nocrop','-m2',supershort_savetitle)
%print(supershort_savetitle, '-depsc2') 
 
%%
disp(supershort_savetitle);
disp(['in ',path_tile]);

savefig([path_tile,supershort_savetitle]);
export_fig('-dpng','-transparent','-nocrop','-m1',[path_tile,supershort_savetitle,'']);

% set(gcf,'InvertHardcopy','on');
% set(gcf,'PaperUnits', 'inches');

%% export full width
paper_width=16.51/2.54; 

origPos=get(gcf,'Position');
exp_ratio=(paper_width*100)/origPos(3);
set(gcf,'Position', [origPos(1) origPos(2) origPos(3)*exp_ratio origPos(4)*exp_ratio]);

export_fig('-png','-transparent','-nocrop','-m2',[path_tile,supershort_savetitle,'FullWidthx2']);
%% export half width
paper_width=16.51/2.54/2; 

origPos=get(gcf,'Position');
exp_ratio=(paper_width*100)/origPos(3);
set(gcf,'Position', [origPos(1) origPos(2) origPos(3)*exp_ratio origPos(4)*exp_ratio]);

export_fig('-png','-transparent','-nocrop','-m2',[path_tile,supershort_savetitle,'HalfWidthx2']); % Leave it at M2
%}



% writetable(T,[supershort '.xlsx'])
% 
% clearvars width height bottom left papersize myfiguresize



% fig_width = 16.51/2.54;     % Width in inches
% fig_height = 6; 
% 
% defpos = get(gcf,'Position');
% set(gcf,'Position', [defpos(1) defpos(2) fig_width*100, fig_height*100]);



