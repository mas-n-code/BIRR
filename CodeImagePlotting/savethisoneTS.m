% savethisoneTS(TPath,supershort_savetitle,fheight,fwidth,cScripto)
% Beautifully saves the figure and png file using the figure as is
% also saves the figure in full and half widht mode
% function savethisoneAsIs(supershort_savetitle)
function savethisoneTS(TPath,supershort_savetitle,fwidth,fheight,cStringo,tStringo)

%% Setup
set(gcf,'PaperPositionMode', 'manual');
set(gcf,'PaperUnits', 'centimeters');
set(gcf,'InvertHardcopy','on');

%% Set size of figure

fig=gcf;
fig.PaperUnits='centimeters';
fig.PaperSize=[9 6];
fig.Units='centimeters';
% if strcmp(fheight,'equal')
    
fig.Position=[1 13 fwidth fheight];

%% change fonts
set(gca,...
    'FontSize',11,...
    'FontName','Times New Roman');

    %,...
    %'PlotBoxAspectRatio', [1 1 1]);

h=get(gca,'xlabel');
set(h, 'FontSize', 11) 
set(h,'FontName','Times New Roman') %time new roman

h=get(gca,'ylabel');
set(h, 'FontSize', 11) 
set(h,'FontName','Times New Roman') %time new roman

h=get(gca,'title');
set(h, 'FontSize', 11) 
set(h,'FontName','Times New Roman') %time new roman

% -Thicks
set(gca, ... 
'box', 'on', ...
'TickDir'     , 'in'     , ...
'TickLength'  , [.01 .02]);

%set(gca,'XTick', [0 90 180 270 360]);
%

ax=gca;
ax.XColor = 'k'; % black
ax.YColor = 'k'; % black
if strcmp(cStringo,'c'); 
c = colorbar;
c.Color= 'k';
end

if strcmp(tStringo,'siTrans'); 
figRen = '-openGL';
    else
    figRen= '-painters';
end



%% Export
disp(supershort_savetitle); disp(['in ',TPath]);

% export_fig('-dpng','-transparent','-nocrop','-m2','-openGL',[TPath,supershort_savetitle,]);
export_fig('-png','-nocrop','-transparent','-m4',figRen,[TPath,supershort_savetitle,]);

%% Previous sections
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


