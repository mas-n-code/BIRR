%% Sub15B and C Sub15A Track First Ref angle.
% sunday 13 December 
close all
%load('C:\Users\El Mario\Google Drive\13 Circle Oficial ART 30deg\CorrMDist\RT13B.mat')

%% Determine sinusoid of Ref angle

t=1:1:80;
s_ref=StarSineFit(t,RefAngleArray(:,2)'); %commented to speed up

RefStar_Sinusoid= s_ref.amplitude*sin(2*pi*(1/s_ref.period)*(t)-s_ref.phase)+s_ref.offset;
figure(1); hold on
plot(RefAngleArray(:,2)) 
plot(t,RefStar_Sinusoid,'-r');
legend('Data','Fit')
title('Ref and Ref_Fit')
%% Determine sinusoid of angle inc
mainAincAlt=mainAinc;
mainAincAlt(1)=mainAincAlt(16);
s_ainc=StarSineFit(t,mainAincAlt);
ainc_sinusoid= s_ainc.amplitude*sin(2*pi*(1/s_ainc.period)*(t)-s_ainc.phase+pi)+s_ainc.offset; %% for some reason, this sinousoid needs +pi
figure(2); hold on
plot(t,mainAincAlt)
plot(t,ainc_sinusoid,'-r')
legend('Data','Fit')
title('AInc and ainc_fit')
%% calculate phase shift of REf and angle inc, generate ref_sin_shifted
figure(3); hold on
plot(t,RefStar_Sinusoid-25,'-'); %%its not realy centered on 25
plot(t,ainc_sinusoid-22.5,'-');

title('Centered sinusoids')

d_theta=phase_sift_calculator(ainc_sinusoid-22.5,RefStar_Sinusoid-25);

ref_sin_shifted= s_ref.amplitude*sin(2*pi*(1/s_ref.period)*(t-1)-d_theta);

figure(3); hold on
plot(t,ref_sin_shifted,'--','LineWidth',1)

%% calibrate ref with re_sinusoid
% correcting Vector
correctingV=0-ref_sin_shifted;
plot(ref_sin_shifted+correctingV,'-x')
%% calibrate Angle_inc with ref_sinosoid shifted
cal_ainc_sin=ainc_sinusoid+correctingV;
plot(t,cal_ainc_sin-22.5,'LineWidth',2);
legend('Ref','Angle inc','Ref Shifted','Corrected shift ref',' corrected a inc')


%% Plot original ref and corrected reference
cal_ref=RefAngleArray(:,2)-correctingV';
figure(5); hold on;
plot(t,RefAngleArray(:,2));
plot(t,cal_ref);
plot(t,ref_sin_shifted+correctingV+25);
legend('Original','corrected')
title('Corrected Reference Data')

%% Plot original inc and corrected inc
cal_main_ainc=mainAincAlt+correctingV;
figure(6); hold on;
plot(t,mainAincAlt-22.5);
plot(t,cal_main_ainc-22.5);
ylim([-0.5 0.5])
refline([0 0]);
legend('Original','corrected')
title('Corrected Relative Angle increment Data')
figure;
group = [repmat({'Normal'}, 80, 1); repmat({'corrected'}, 80, 1)];
boxplot([mainAincAlt;cal_main_ainc],group,'Notch','on');
figure; hold on;
histogram (mainAincAlt,11,'Normalization','probability')
histogram (cal_main_ainc,11,'Normalization','probability')
xlim([22.5-.5,22.5+.5]);
mean(mainAincAlt)
mean(cal_main_ainc)
std(mainAinc)
std(cal_main_ainc)
% %% correcting vector
% correctingV=25-RefStar_Sinusoid;
% 
% %plot(correctingV+25);
% %% calibration vector applied to fit
% plot(RefStar_Sinusoid+correctingV)
% 
% %% calibration vector applied to ref values
% plot(RefAngleArray(:,2)'+correctingV)
% calib_RefAngle=RefAngleArray(:,2)'+correctingV;
% d_calib_RefAngle=calib_RefAngle-25;
% 
% mainAinc=[cirMain_E_z0z4_RT13B.relativeAngleInc];
% mainAinc=mainAinc(2:end);
% d_mainAinc=
% plot(mainAinc+2.5,'LineWidth',2);
% hold off



% plot(WideRefAngle-WideRefAngleSummary.mean);
% legend('Normal Ref angle','Wide Ref angle');
% mainAinc=[cirMain_E_z0z4_RT13B.relativeAngleInc]-22.5;
% refAinc=[cirRef_E_z0z4_RT13B.relativeAngleInc]-22.5;
% centerAinc=[cirCenter_E_z0z4_RT13B.relativeAngleInc]-22.5;
% %figure(2); hold on;
% plot(mainAinc(2:end),'LineWidth',2),plot(refAinc(2:end),'LineWidth',2);
% % plot(centerAinc(2:end),':');
% plot(t,RefStar_SinusoidW-WideRefAngleSummary.mean,'-r');




