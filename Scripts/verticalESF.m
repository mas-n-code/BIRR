%                  Default      Paper	Presentation
% Width             5.6         varies      varies
% Height            4.2         varies      varies
% AxesLineWidth     0.5         0.75        1
% FontSize          10          8           14
% LineWidth         0.5         1.5         2
% MarkerSize        6           8           12
close all






for ii = 1:length(ResultSet)
eVX(ii).position=[num2str((ii-1)*5) 'mm'];
eVX(ii).data=ResultSet(ii).raw(1:40,:);
eVX(ii).max=max(eVX(ii).data);
Nashi(ii,:)=ResultSet(ii).raw(1:40,:);
end
x_mm=0:5:((length(ResultSet)-1)*5);
x_line=linspace(0,130,27);

figure(1);
plot(x_mm,[eVX.max],'marker','o');
%--------------------------------------------------

% Create Nice Graphs
%--------------------------------------------------
%plot(dmn,f(dmn),'b-',dmn,g(dmn),'r--',xeq,f(xeq),'g*');

legend('Max Energy at location');
xlabel('Vertical decent (mm)');
ylabel('Energy');
title('Improved Energy curve');

%print('example', '-dpng', '-r600'); %<-Save as PNG with 300 DPI




% Defaults for this blog post
width = 5;     % Width in inches
height = 4;    % Height in inches
alw = 1;    % AxesLineWidth
fsz = 14;      % Fontsize
lw = 1.75;      % LineWidth
msz = 4;       % MarkerSize

figure(2);

pos = get(gcf, 'Position');
set(gcf, 'Position', [pos(1)+100 pos(2) width*100, height*100]); %<- Set size
set(gca, 'FontSize', fsz, 'LineWidth', alw); %<- Set properties

plot(x_mm,[eVX.max],'LineWidth',lw,'MarkerSize',msz,'marker','o'); %<- Specify plot properites

legend('Max Energy at location');
xlabel('Vertical decent (mm)');
ylabel('Energy');
title('Improved Energy curve');
%marker('o')

% Set Tick Marks
set(gca,'XTick',0:10:130);
%set(gca,'YTick',0:10);

% Here we preserve the size of the image when we save it.
set(gcf,'InvertHardcopy','on');
set(gcf,'PaperUnits', 'inches');
papersize = get(gcf, 'PaperSize');
left = (papersize(1)- width)/2;
bottom = (papersize(2)- height)/2;
myfiguresize = [left, bottom, width, height];
set(gcf,'PaperPosition', myfiguresize);

% Save the file as PNG
print('EdgeCurve2','-dpng','-r600');



clearvars ii



