%% Sub15D
%% Sub15B and C Sub15A Track First Ref angle.
% sunday 13 December 
close all
%load('C:\Users\El Mario\Google Drive\13 Circle Oficial ART 30deg\CorrMDist\RT13B.mat')
load('F:\UserElGuapo\Google Drive\13 Circle Oficial ART 30deg\CorrMDist\RT13B.mat')
%% Determine sinusoid of Ref angle

t=1:1:80;
s_ref=StarSineFit(t,RefAngleArray(:,2)'); %commented to speed up

RefStar_Sinusoid= s_ref.amplitude*sin(2*pi*(1/s_ref.period)*(t)-s_ref.phase)+s_ref.offset;
figure(1); hold on
plot(RefAngleArray(:,2)) 
plot(t,RefStar_Sinusoid,'-r');
legend('Data','Fit')
title('Ref and Ref-Fit')
%% Determine sinusoid of absolute angle

% calculate deviation vector
posV=[cirMain_E_z0z4_RT13B.absAngle]';
posV=posV-posV(1);
targv=(0:theta_step:337.5)';
targV=repmat(targv,5,1);
dev_posV=posV-targV;
figure;plot(dev_posV);
title('deviation per position')


% obtain 
s_abs=StarSineFit(t,dev_posV');
ainc_sinusoid= s_abs.amplitude*sin(2*pi*(1/s_abs.period)*(t+2)-s_abs.phase) +s_abs.offset; %% for some reason, this sinousoid needs +pi
figure(2); hold on
plot(t,dev_posV')
plot(t,ainc_sinusoid,'-r')
legend('Data','Fit')
title('AInc and ainc-fit [abs]')

%% calculate phase shift of REf and angle inc, generate ref_sin_shifted


d_theta=phase_sift_calculator(ainc_sinusoid,RefStar_Sinusoid-25);
ref_sin_shifted= s_ref.amplitude*sin(2*pi*(1/s_ref.period)*(t+1)-d_theta-pi);

figure(3); hold on
plot(t,RefStar_Sinusoid-25,'b-'); %%its not realy centered on 25
plot(t,ainc_sinusoid,'k-');
plot(t,ref_sin_shifted,'r--d','LineWidth',1)

title('In-phase sinusoids')
legend('Reference Sin','Pos Dev sinusoid','Ref Sin phase shift');

%% calibrate ref with re_sinusoid
% correcting Vector
correctingV=0-ref_sin_shifted;
plot(ref_sin_shifted+correctingV,'-x')
%% calibrate Angle_inc with ref_sinosoid shifted
cal_POSDEv_sin=ainc_sinusoid+correctingV*2;
plot(t,cal_POSDEv_sin,'LineWidth',2);
legend('Ref','Angle inc','Ref Shifted','Corrected shift ref',' corrected a inc')

%%


%% Plot original ref and corrected reference
cal_ref=RefAngleArray(:,2)-correctingV';
figure(5); hold on;
plot(t,RefAngleArray(:,2));
plot(t,cal_ref);
plot(t,ref_sin_shifted+correctingV+25);
legend('Original','corrected')
title('Corrected Reference Data')

%% Plot original inc and corrected inc
cal_main_ainc=dev_posV'+correctingV;
cal2_main_ainc=dev_posV'+correctingV*2;
figure(6); hold on;
plot(t,dev_posV','k-o');
plot(t,cal_main_ainc,'b');
plot(t,cal2_main_ainc,'r');
plot(ainc_sinusoid);
ylim([-0.5 0.5])
refline([0 0]);
legend('Original','corrected','supercorrected')
title('Corrected Absolute Angle increment Data')

%% Figure histogram and  boxplot figures
figure;
group = [repmat({'Normal'}, 80, 1); repmat({'corrected'}, 80, 1);repmat({'supercorrected'}, 80, 1)];
boxplot([dev_posV';cal_main_ainc;cal2_main_ainc],group,'Notch','on');
figure; 
[n1, xout1] = hist(dev_posV'+22.5,11,'Normalization','probability');
bar(xout1,n1,'r'); hold

[n2, xout2] =hist(cal_main_ainc+22.5,11,'Normalization','probability');
bar(xout2,n2,'g');

[n3, xout3] =hist(cal2_main_ainc+22.5,11,'Normalization','probability');
bar(xout3,n3,'b');

legend('normal','corrected','supercorrected');

xlim([22.5-.5,22.5+.5]);

disp(mean(dev_posV'))
disp(mean(cal_main_ainc))
disp(mean(cal2_main_ainc))
disp(std(dev_posV'))
disp(std(cal_main_ainc))
disp(std(cal2_main_ainc))


%  targV=(0:theta_step:337.5)';
%  
%  coverage_factor=2;
%  runs=5;
% art_rot(posV,targV,rims,2)


