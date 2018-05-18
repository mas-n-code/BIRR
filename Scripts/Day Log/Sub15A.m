
%% Saturday December 12, Sub15A Track Second or wide Reference angle.
close all
% load('F:\UserElGuapo\Google Drive\13 Circle Oficial ART 30deg\CorrMDist\CirculitosC_Dxo.mat')
% load('C:\Users\El Mario\Google Drive\13 Circle Oficial ART 30deg\CorrMDist\CirculitosC_Dxo.mat')
load('C:\Users\El Mario\Google Drive\13 Circle Oficial ART 30deg\CorrMDist\RT13B.mat')

%create a circ structure to use with losangles finders
Circenter4Ref=circ_creator(xc_RT13B_East2,ycenter,10,'RT13B_CorrectMDist',80);

[WideRefAngleT,WideRefAngleSummary]=losanglesFinder(cirMain_E_z0z4_RT13B,cirRef_E_z0z4_RT13B,Circenter4Ref);
title('Wide Reference Angle');
WideRefAngle=WideRefAngleSummary.array;
%plot sinusoid
 t = 1:1:80;
 A = WideRefAngleSummary.range/2; % Range of WideREfAngle
 f =1/16;
 p_shift=3*pi/4; %% Eye calculation

 
%  ReFSinusoid = A*sin(2*pi*f*t)+WideRefAngleSummary.mean; Original
%  plot(t(1:80),ReFSinusoid(1:80),'--','Color',[.2 .1 .7]);
 
 RefSinusoidW = A*sin(2*pi*f*t-p_shift)+WideRefAngleSummary.mean;
 plot(t,RefSinusoidW,':','Color',[.2 .7 .7]);
 
%% Caculated calibrated ref
calibratedRefW= WideRefAngle-RefSinusoidW';
plot(calibratedRefW+WideRefAngleSummary.mean,'-x','Color',[.7 .7 .7]);


%% StarFit
s_fit=StarSineFit(t,WideRefAngle');

RefStar_SinusoidW = s_fit.amplitude*sin(2*pi*(1/s_fit.period)*(t-1)-s_fit.phase)+s_fit.offset;

figure(2); hold on;
plot(t,RefStar_SinusoidW,'-r');

%% Star calibrated %% SB15B
s_calibratedRefW= WideRefAngle-RefStar_SinusoidW';
plot(s_calibratedRefW+WideRefAngleSummary.mean,'-','Color',[.2 .8 .7]);

legend('Wide Ref Angle','Calculated sinusoid','Corrected Ref','Star sinusoid','Star Corrected Ref')
refline([0 WideRefAngleSummary.mean]);


