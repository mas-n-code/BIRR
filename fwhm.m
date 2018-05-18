function width = fwhm(x,y)

% function width = fwhm(x,y)
%
% Full-Width at Half-Maximum (FWHM) of the waveform y(x)
% and its polarity.
% The FWHM result in 'width' will be in units of 'x'
%
%
% Rev 1.2, April 2006 (Patrick Egan)
close all;
figure(2);
y = y / max(y);
plot(x,y,'LineWidth',2,'MarkerSize',1.75,'marker','o','LineStyle',':');
N = length(y);
lev50 = 0.5;
if y(1) < lev50                  % find index of center (max or min) of pulse
    [garbage,centerindex]=max(y);
    Pol = +1;
    disp('Pulse Polarity = Positive')
else
    [garbage,centerindex]=min(y);
    Pol = -1;
    disp('Pulse Polarity = Negative')
end
i = 2;
while sign(y(i)-lev50) == sign(y(i-1)-lev50)
    i = i+1;
end                                   %first crossing is between v(i-1) & v(i)
interp = (lev50-y(i-1)) / (y(i)-y(i-1));
tlead = x(i-1) + interp*(x(i)-x(i-1));
i = centerindex+1;                    %start search for next crossing at center
while ((sign(y(i)-lev50) == sign(y(i-1)-lev50)) & (i <= N-1))
    i = i+1;
end
if i ~= N
    Ptype = 1;  
    disp('Pulse is Impulse or Rectangular with 2 edges')
    interp = (lev50-y(i-1)) / (y(i)-y(i-1));
    ttrail = x(i-1) + interp*(x(i)-x(i-1));
    width = ttrail - tlead;
else
    Ptype = 2; 
    disp('Step-Like Pulse, no second edge')
    ttrail = NaN;
    width = NaN;
end

display(['ttrail:  ' num2str(ttrail)])
display(['tlead:  ' num2str(tlead)])
hold all;
plot(linspace(ttrail,tlead,N),repmat(0.5,N),'LineWidth',2,'MarkerSize',1.75,'marker','o');
title(['Full Width Half Maximum: ' num2str(width,4)], 'fontweight','Bold','FontSize',20);
xlabel('x axis(mm)','fontweight','bold','FontSize',20);
ylabel('f(y)','fontweight','bold','FontSize',20);

