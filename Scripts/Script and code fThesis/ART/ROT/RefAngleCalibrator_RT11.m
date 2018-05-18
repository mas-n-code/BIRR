function [cal_devV,cal_s_devV] = RefAngleCalibrator_RT11(RefAngleArray,devV,calValue,sampleValue)
% Calibrator for angles 
% V 1.0 completed in April 15 2015
% Uses empiric angle calulation based on ref angle. multiplied by sValue

%% RefAngleCalibrator_RT11
%Sub15D
% Sub15B and C Sub15A Track First Ref angle.
% sunday 13 December 
close all
%load('C:\Users\El Mario\Google Drive\13 Circle Oficial ART 30deg\CorrMDist\RT13B.mat')
%load('F:\UserElGuapo\Google Drive\13 Circle Oficial ART 30deg\CorrMDist\RT13B.mat')
%RefAngleArray=RefAngleArray(:,2);

%% Determine sinusoid of Ref angle

RefAngle_Sampled=RefAngleArray(1:sampleValue:end);

t=1:sampleValue:length(RefAngleArray);
s_ref=StarSineFit(t,RefAngle_Sampled'); %commented to speed up

t=1:1:length(RefAngleArray);
RefStar_Sinusoid= s_ref.amplitude*sin(2*pi*(1/(s_ref.period))*(t)-s_ref.phase)+s_ref.offset;
figure(1); hold on
plot(RefAngleArray) 
plot(t,RefStar_Sinusoid,'-r');
legend('Data','Fit')
title('Ref and Ref-Fit')


%% Determine sinusoid of absolute angle

% calculate deviation vector
%posV=[cirMain_E_z0z4_RT13B.absAngle]';
%posV=posV-posV(1);
%targv=(0:theta_step:337.5)';
%targV=repmat(targv,5,1);
%dev_posV=posV-targV;
dev_posV=devV';
figure;plot(dev_posV,'m');
title('deviation per position')


% obtain sinusoidal
t=1:1:length(dev_posV);
s_abs=StarSineFit(t,dev_posV');
%aabs_sinusoid= s_abs.amplitude*sin(2*pi*(1/s_abs.period)*(t)+s_abs.phase) +s_abs.offset; %% for some reason, this sinousoid needs +pi
aabs_sinusoid= s_abs.amplitude*sin(2*pi*(1/s_abs.period)*(t-15)-s_abs.phase) +s_abs.offset; %% for some reason, this sinousoid for this dude it has to sart in -15
figure(2); hold on
plot(dev_posV,'m');
plot(t,aabs_sinusoid,'-b')
legend('Data','Fit')
title('PosV and PosV-fit [abs]')
hold off;


%% calculate phase shift of REf and angle inc, generate ref_sin_shifted

size(aabs_sinusoid)
size(RefStar_Sinusoid)
d_theta=phase_sift_calculator(aabs_sinusoid,RefStar_Sinusoid-25);
%ref_sin_shifted= s_ref.amplitude*sin(2*pi*(1/s_ref.period)*(t+1)-d_theta-pi);
ref_sin_shifted= s_ref.amplitude*sin(2*pi*(1/s_ref.period)*(t+1)+d_theta-s_ref.phase);
size(ref_sin_shifted);

figure(3); hold on
plot(t,RefStar_Sinusoid-25,'b-'); %%its not realy centered on 25
plot(t,aabs_sinusoid,'k-');
plot(t,ref_sin_shifted,'r--d','LineWidth',1)

title('In-phase sinusoids')
legend('Reference Sin','Pos Dev sinusoid','Ref Sin phase shift');


%% calibrate ref with re_sinusoid
% correcting Vector
correctingV=0-ref_sin_shifted;
plot(ref_sin_shifted+correctingV,'m-x')

%% calibrate Pos Angle with ref_sinosoid shifted
cal_sin=aabs_sinusoid+correctingV;
sup_cal_sin=aabs_sinusoid+correctingV*calValue;
plot(t,cal_sin,'c','LineWidth',2);
plot(t,sup_cal_sin,'b','LineWidth',3);
legend('Ref','Angle inc','Ref Shifted','Corrected shift ref',' corrected', 'super corrected')

%%


%% Plot original ref and corrected reference
cal_ref=RefAngleArray-correctingV';
figure(5); hold on;
plot(t,RefAngleArray,'-b');
plot(t,cal_ref,'x-k');
plot(t,ref_sin_shifted+correctingV+25);
legend('Original data','corrected data','corrected sinusoidal')
title('Corrected Reference Data')

%% Plot original angle and corrected angle
cal_devV=dev_posV'+correctingV;
cal_s_devV=dev_posV'+correctingV*calValue;
figure(6); hold on;
plot(t,dev_posV','k-o');
plot(t,cal_devV,'b');
plot(t,cal_s_devV,'r');
plot(aabs_sinusoid);
ylim([-0.5 0.5])
refline([0 0]);
legend('Original','corrected','supercorrected')
title('Corrected Absolute Angle increment Data')

%% Figure histogram and  boxplot figures

figure;
group = [repmat({'Normal'}, length(devV), 1); repmat({'corrected'}, length(devV), 1);repmat({'supercorrected'}, length(devV), 1)];
boxplot([dev_posV';cal_devV;cal_s_devV],group,'Notch','on');

%%
figure(8); 

hold on;


hist(dev_posV',-0.30:0.025:0.30,'Normalization','probability');
%hist(cal_devV,-0.3:0.025:0.3,'Normalizatiodn','probability');
hist(cal_s_devV,-0.3:0.025:0.3,'Normalization','probability');



h = findobj(gca,'Type','patch');
%set(h(3),'FaceColor',[0.0 0.5 0.5],'EdgeColor','w')%,'facealpha',0.65) 
set(h(2),'FaceColor',[0.0 0.5 0.5],'EdgeColor','w')%,'facealpha',0.75) 
set(h(1),'FaceColor','r','EdgeColor','w','facealpha',0.75) 
%set(h(2),'FaceColor',[0.6 0.6 0.6],'EdgeColor','w','facealpha',0.65) 
%set(h(1),'FaceColor',[0.0 0.5 0.05],'EdgeColor','w','facealpha',0.75) 

%set(h(3),'FaceColor',[0 0.5 0.5],'EdgeColor','w','facealpha',0.55) 

legend('normal','calibrated');
%legend('normal','orrected','supercorrected');

%xlim([22.5-.5,22.5+.5]);

disp(mean(dev_posV'))
disp(mean(cal_devV))
disp(mean(cal_s_devV))
disp(std(dev_posV'))
disp(std(cal_devV))
disp(std(cal_s_devV))
end

%  targV=(0:theta_step:337.5)';
%  
%  coverage_factor=2;
%  runs=5;
% art_rot(posV,targV,rims,2)


