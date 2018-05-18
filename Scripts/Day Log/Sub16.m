%% Sub16 Genereate ART using corrected values;
%% original values
close all;
clc;
theta_step=22.5;
targv=(0:theta_step:337.5)';
posV=[cirMain_E_z0z4_RT13B.absAngle]';
c_f=2;
runs=5;
[Iso230,NewPort]=art_rot(posV,targv,runs,c_f,'No');
%% corrected (cal_main_ainc_c)
load('C:\Users\El Mario\Google Drive\13 Circle Oficial ART 30deg\CorrMDist\calibrated_increments')
posV_cal=cal_main_ainc_C';

[Iso230_cal,NewPort_cal]=art_rot(posV_cal,targv,runs,c_f,'Yes');


