%%Script ART30Deg_RT13_Th103 C
% Last Version: November 2015
% 3 FW periods, 2 RV periods
% 22.5 deg increments
% 16 Images per period
% 80 images
 tic

%% Section 1, Read directory, open 1st image 
% 
% close all;
% 
% % %%pdir = dir('**z_0**.jpg');
% %
% pdir = [dir('**z_0**.jpg');dir('**z_1*.jpg*')];
% 
% 
% display(['Total of ' num2str(length(pdir)) ' files'])
% 
% theta_step=22.5;
% 
% 
% I = imread(pdir(1).name);
% 
% figure(1); 
% 
% imshow(I,'InitialMagnification',13); hold on;

%% Adquires the three circles for the east complex

%guideMain=circleCatcher(I,[18 28],'GuideMain');
%guideRef=circleCatcher(I,[18 28],'GuideRef');
%guideCenter=circleCatcher(I,[39 49],'GuideCenter');

%% Track the Easter circle position for one period
% uses an aproximate center of image and a bigger circle radius to account
% for variation

%csIni_E=photoCircleTracker(pdir,theta_step,2709,1867,[15 40],[guideMain.x,guideMain.y]);

%% Determine center of images 
% Based on Csini, uses circfit(R) to calculate a circle and its x,y cordinates.
%[xc_RT13C_East2,yc_RT13C_East2]=circfit([csIni_E.x],[csIni_E.y]);

%% Assign center of images
% 
% xcenter=xc_RT13C_East2;
% ycenter=yc_RT13C_East2;
% 
% plot(xcenter,ycenter,'dr');
% save('CenterC_Dxo.mat','xc_RT13C_East2','yc_RT13C_East2');


%% Opens all files in folder
close all;
% 
pdir = dir(['**z_**.jpg']);
% 
display(['Total of ' num2str(length(pdir)) ' files'])
% 
theta_step=22.5;
% 
I = imread(pdir(1).name);
% 
figure(1); 
% 
imshow(I,'InitialMagnification',17); hold on;


%[circCmplx_NEW]=photoCircleTrackerCMPLX(pdir,theta_step,xcenter,ycenter,guideMain,guideRef,guideCenter);
% 
% %% Tracks circleComplex_East
% %tracks three east circles, provides the metrics for "reference deviation"
% %and the angle of the most external circle, 
% 
%  circMain=photoCircleTracker(pdir,theta_step,xcenter,ycenter,[18 28],[guideMain.x,guideMain.y]);
%  display('Main Circle collected');
%  circRef=photoCircleTracker(pdir,theta_step,xcenter,ycenter,[18 28],[guideRef.x,guideRef.y]);
%  display('Ref Circle collected');
%  circCenter=photoCircleTracker(pdir,theta_step,xcenter,ycenter,[39 51],[guideCenter.x,guideCenter.y]);
%  display('Center Circle collected');
% 
% 
%  %% Calculate the uncertanty or angle variation among the collected circles
%  
% [RefAngleT,SummaryRefAngleT]=losanglesFinder(circMain,circRef,circCenter);
% RefAngleArray=table2array(RefAngleT);
% 
% %% Calculate relative angle increment metrics
% IncAngleArray=[circMain.relativeAngleInc];
% IncAngleT=table(mean(IncAngleArray(2:end)),range(IncAngleArray(2:end)),std(IncAngleArray(2:end)), ...
%     'VariableNames',{'Mean','Range','Std'});
% 
% %% Plot the incremental angle of main circle
% figure;
% subplot(2,1,1);
% plot(IncAngleArray,'-ro');
% ylim([theta_step-0.25 theta_step+0.25]);
% title('Relative angle increment per photo ');
% xlabel('Photo');
% ylabel('Increment angle(\circ)')
% refline([0 22.5])
% 
% subplot(2,1,2);
% plot(RefAngleArray(:,1),RefAngleArray(:,2),'-o'); hold on
% xlabel('Photo');
% ylabel('Reference angle (\circ)')
% ylim([25-0.25 25+0.25]);
% title('Reference angle');
% refline([0 25])

% figure;
% %[hAx,hLine1,hLine2] =plotyy(RefAngleArray(:,1),[cirMain_E_z0z4.relativeAngleInc],RefAngleArray(:,1),RefAngleArray(:,2),'plot','plot');
% ylabel(hAx(1),'Relative angle increment') % left y-axis
% ylabel(hAx(2),'Reference angle') % right y-axis
% hAx(1).YLim=[23  28];
% hAx(1).YTick=[1:0.1:25];
% Line1.Marker='d';
% hLine2.Marker='o';

%% Caclulate the 

%%


%% create 

% RefAngleArray_New=RefAngleArray;
% circRef_New=circRef;
% circMain_New=circMain;
% circCenter_New=circCenter;
% IncAngleNew=IncAngleArray;
% RefAngleNew=RefAngleArray;
% IncAngleT
toc
IncAngleNew=circCmplx_NEW.IncAngle;
RefAngleNew=circCmplx_NEW.RefAngle;
ART30Deg_RT13_CompareRefandInc;
save('CirculitosC_Dxo.mat','circMain','circRef','circCenter');

%%
%% Caculate ART

 
theta_step=22.5;
targV=(0:theta_step:337.5)';
posV=[cirMain_E_z0z4_RT13B.absAngle]';
c_f=2;
runs=5;
[I,NP]=art_rot(posV,targV,runs,c_f);
