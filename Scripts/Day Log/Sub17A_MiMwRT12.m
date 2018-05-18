%%SB17A Mim with RT12 MiM with full dataset. 0.5 angle inc
% Update on April 15 2016
Saved all files to a 

%% Section 1, Read directory of photoset, open 1st image 

close all;

%directory is probably in 
%GoogleDrive/T10 Rotary Stage fThesis datasets/T 12 MIM Photoset

% %%pdir = dir('**z_0**.jpg');
%
% pdir = [dir('**z_0**.jpg');dir('**z_1*.jpg*')];
% 
% 
% display(['Total of ' num2str(length(pdir)) ' files'])
% 

%% Theta increement
theta_step=0.5;
% 
% 
%% Display the first image
% I = imread(pdir(1).name);
% 
% figure(1); 
% 
% imshow(I,'InitialMagnification',13); hold on;
% 
% %% Adquires the three circles for the east complex
% 
% guideMain=circleCatcher(I,[18 28],'GuideMain');
% guideRef=circleCatcher(I,[18 28],'GuideRef');
% guideCenter=circleCatcher(I,[39 49],'GuideCenter');


% Track the Easter circle position for one period
% uses an aproximate center of image and a bigger circle radius to account
% for variation

%csIni_2=photoCircleTracker(pdir_2,theta_step,2709,1867,[15 40],[guideMain.x,guideMain.y]);

%csIni_1=photoCircleTracker(pdir_1,theta_step,2709,1867,[15 40],[guideMain.x,guideMain.y]);


% %% Determine center of images 
% Based on Csini, uses circfit(R) to calculate a circle and its x,y cordinates.

%[xc_RT12_West,yc_RT12_West]=circfit([[csIni_1.x];[csIni_2.x]],[[csIni_1.y];[csIni_2.y]]);

% % Assign center of images
% % 
% xcenter=xc_RT12_West;
% ycenter=yc_RT12_West;
% 
% plot(xcenter,ycenter,'dr');
% 
% 
% %x_n = inputdlg('Enter label for the datafile [no spaces]:',...
% %             'Save name window', [1 50]);
% % 
% 
% nameS=strcat(x_n,'.mat');
% save('Center','xc_RT12_West','yc_RT12_West');
% 
%% 
%[circCmplx_NEW_FW]=photoCircleTrackerCMPLX(pdir_1,theta_step,xcenter,ycenter,guideMain);
%[circCmplx_NEW_RV]=photoCircleTrackerCMPLX(pdir_2,theta_step,xcenter,ycenter,guideMain);

angPosVFW=[circCmplx_NEW_FW.circMain.absAngle];
absPosVFW=angPosVFW-angPosVFW(1);

angPosVRV=[circCmplx_NEW_RV.circMain.absAngle];
absPosVRV=angPosVRV-angPosVFW(1);


targPosV=[0:0.5:29.5];
figure; hold on
% plot(absPosVFW);
% plot(targPosV,'--r');

figure; hold on
plot(1:60,angPosVFW)
plot(60:-1:1,fliplr(angPosVRV),'r');

figure; hold on
plot(1:60,absPosVFW)
plot(119:-1:60,absPosVRV,'r');

%%deviations

%%FW Dev
FW_dev=absPosVFW-[0,absPosVFW(1:end-1)];
flipRVV=fliplr(absPosVRV);
RV_dev_F=flipRVV-[absPosVFW(end),flipRVV(1:end-1)];

%% STd dev
FW_std=std(FW_dev(2:end));
RV_std=std(RV_dev_F(2:end));

MiM=5*max(FW_std,RV_std);
figure; hold on
plot(1:60,FW_dev)
plot(60:-1:1,RV_dev_F,'r');
title('Minimal incremental motion of Rotary Stage based on 0.5\circ steps')

dim = [.2 .5 .3 .3];
str = ['MiM: ' num2str(MiM,3) '\circ'];
annotation('textbox',dim,'String',str,'FitBoxToText','on');
legend('Forward direction','Reverse direction')
xlabel('Absolute position ( \circ)')
ylabel('Measured increment ( \circ)')