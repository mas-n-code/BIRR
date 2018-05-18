% Beautifully saves the figure and png file using the figure as is
% also saves the figure in full and half widht mode
% function savethisoneAsIs(supershort_savetitle)
function savethisoneAsIs(PPath,DTag,supershort_savetitle)
tic
%%{
supershort_savetitle=[DTag,supershort_savetitle];
parent_dir=[PPath,DTag,'B_Images and Figures'];
path_tile=[parent_dir,'\',supershort_savetitle,'\'];
mkdir(parent_dir,supershort_savetitle)

%{
fig=gcf;
fig.PaperUnits='centimeters';
fig.PaperSize=[9 6];
fig.Units='centimeters';
fig.Position=[1 13 13 10];
%}

%%
set(gcf,'PaperPositionMode', 'manual');

disp(supershort_savetitle);
disp(['in ',path_tile]);

savefig([path_tile,supershort_savetitle]);
saveas(gcf,[path_tile,supershort_savetitle,' Original.png'])
export_fig('-dpng','-transparent','-nocrop','-m2',[path_tile,supershort_savetitle,'_openGL'],'-openGL');

set(gcf,'InvertHardcopy','on');
set(gcf,'PaperUnits', 'inches');

%{

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
%}


