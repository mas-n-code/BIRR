function [ImageMetrics]=I_RegionBoxplot(IRec,Region,ImageMetrics)
ATumor=(IRec(Region.Tumor))';
AFibro=(IRec(Region.Fibro))';
ARefBack=(IRec(Region.IRefBack))';

figure;

set(0,'defaultAxesFontName', 'Times New Roman')
set(0,'DefaultAxesFontSize',16)
set(0,'DefaultFigureColormap',paruly)

title([ImageMetrics.Name ' Boxplot per region'])
boxX=[ATumor AFibro ARefBack];
grp = [zeros(1,length(ATumor)),ones(1,length(AFibro)),ones(1,length(ARefBack))*2];

bh=boxplot(boxX,grp,'Notch','off','Labels',{'Tumor','FibroGlandular', 'Background'});

set(bh(:,:),'linewidth',3);
set(findobj(gca,'Type','text'),'FontSize',16, 'FontName', 'Times New Roman')

txt = findobj(gca,'Type','text');
set(txt(2:end),'VerticalAlignment', 'Middle');

%Example of a group boxplot 
%{
c_1=rand(1,20);
c_2=rand(1,100);
C = [c_1 c_2];
grp = [zeros(1,20),ones(1,100)];
boxplot(C,grp)
%}