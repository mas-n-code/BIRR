%http://dgleich.github.io/hq-matlab-figs/


%                  Default      Paper	Presentation
% Width             5.6         varies      varies
% Height            4.2         varies      varies
% AxesLineWidth     0.5         0.75        1
% FontSize          10          8           14
% LineWidth         0.5         1.5         2
% MarkerSize        6           8           12

% Defaults for this blog post
width = 6;     % Width in inches
height = 5;    % Height in inches
alw = 1;    % AxesLineWidth
fsz = 14;      % Fontsize
lw = 1.75;      % LineWidth
msz = 4;       % MarkerSize


%--------------------------------------------------

% Create Nice Graphs
%--------------------------------------------------
%plot(dmn,f(dmn),'b-',dmn,g(dmn),'r--',xeq,f(xeq),'g*');

close all;

figure;
ColorSet = varycolor(50);
hold all;
set(gca, 'ColorOrder', ColorSet);

hold all;
for m = 1:50
  plot([0 51-m], [0 m]);
end
color(ColorSet)

plot(Xx,EnergiaB)
% %Set Tick Marks
set(gca,'XTick',0:10:130);
set(gca,'YTick',0:10);


% % Here we preserve the size of the image when we save it.
set(gcf,'InvertHardcopy','on');
set(gcf,'PaperUnits', 'inches');
papersize = get(gcf, 'PaperSize');
left = (papersize(1)- width)/2;
bottom = (papersize(2)- height)/2;
myfiguresize = [left, bottom, width, height];
set(gcf,'PaperPosition', myfiguresize);






% 
% legend;
% xlabel('Time');
% ylabel('Energy');
% title('Energy curve 15mm decrements');
% %marker('o')
% %print('EnergyCurve', '-dpng', '-r600'); %<-Save as PNG with 300 DPI
% 
figure;
plot(x_mm,[SetPlate.max],'LineWidth',lw,'MarkerSize',msz,'marker','o'); %<- Specify plot properites

legend('Max Energy at location');
xlabel('Vertical decent (mm)');
ylabel('Energy');
title('Improved Energy curve');
marker('o')
% 
% % Set Tick Marks
% set(gca,'XTick',0:10:130);
% %set(gca,'YTick',0:10);
% 

% 
% % Save the file as PNG
% %print('EdgeCurve2','-dpng','-r600');

x_mm=0:5:130;
figure;
plot(x_mm,[SetPlate.max],'LineWidth',lw,'MarkerSize',msz,'marker','o'); %<- Specify plot properites

legend('Max Energy at location');
xlabel('Vertical decent (mm)');
ylabel('Energy');
title('Improved Energy curve');
%marker('o')
for ii=1:(22)
y(ii)=SetPlate(ii+4).max;

end

xs=x_mm(5:22);
ys=y(1:18);
figure; plot(xs,ys,'LineWidth',lw,'MarkerSize',msz,'marker','o');
figure;
dy=diff(y)./diff(x_mm);
plot(x_mm(1:end-1),dy);






