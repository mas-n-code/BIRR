%% Subtask  SB17 B Complete Arc with full DataSet RT11
% Wednesday 16 December
close all

clc
tic
%% Define angle step
theta_step=5;
runs=12;
targV=(0:theta_step:360-theta_step);

%% Load image directory and display fist image
% pdir = dir('**mPhoto**.jpg');
% display(['Total of ' num2str(length(pdir)) ' files'])
% I = imread(pdir(1).name);
% figure(1); 
% imshow(I,'InitialMagnification',13); hold on;
% 
% %% Aquires the three guide for the circles
% 
% guideMain=circleCatcher(I,[18 28],'GuideMain');
% guideRef=circleCatcher(I,[18 28],'GuideRef');
% guideCenter=circleCatcher(I,[39 49],'GuideCenter');
% 
% %% Track the Easter circle position for X' amount of periods to feed the circle center fit 
% 
% csIni_E=photoCircleTracker(pdir(1:216),theta_step,2709,1867,[15 40],[guideRef.x,guideRef.y]);
% 
% %% Determine center of images 
% % Based on Csini, uses circfit(R) to calculate a circle and its x,y cordinates.
% [xc_RT11_East,yc_RT11_East]=circfit([csIni_E.x],[csIni_E.y]);
% 
% %% Assign center of images
% % 
% xcenter=xc_RT11_East;
% ycenter=yc_RT11_East;
% % 
% plot(xcenter,ycenter,'dr');
% save('Center_RT11_.mat','xc_RT11_East','yc_RT11_East');

%% Track circle Comples 
%[circCmplx]=photoCircleTrackerCMPLX(pdir,theta_step,xcenter,ycenter,guideMain,guideRef,guideCenter);

 %% If the previoius one doesnt work try this:
    %Detecting circles
%     circMain=photoCircleTracker(pdir,theta_step,xcenter,ycenter,[18 28],[guideMain.x,guideMain.y]);
%     display('Main Circle collected');
%     circRef=photoCircleTracker(pdir,theta_step,xcenter,ycenter,[18 28],[guideRef.x,guideRef.y]);
%     display('Ref Circle collected');
%       circCenter=photoCircleTracker(pdir,theta_step,xcenter,ycenter,[39 51],[guideCenter.x,guideCenter.y]);
%       display('Center Circle collected');
%         circCmplx.circMain=circMain;
%         circCmplx.circRef=circRef;
%         circCmplx.circCenter=circCenter;
%         save('circCmplx')
        
        %%Create Ref Angle Element
%        [RefAngleT,RefAngle]=losanglesFinder(circMain,circRef,circCenter);

        %% Create Inc Angle Element
%        IncAngleArray=[circMain.relativeAngleInc];
%        IncAngleT=table(mean(IncAngleArray(2:end)),range(IncAngleArray(2:end)),std(IncAngleArray(2:end)),'VariableNames',{'Mean','Range','Std'});
            
        
        %%Save circCmplx
%        circCmplx.RefAngle=RefAngle.array;
%        circCmplx.IncAngle=IncAngleArray;
%        save('circCmplx')
        
 devV_main=[circCmplx.circMain.absAngle]-repmat([0:5:355],1,runs)-circCmplx.circMain(1).absAngle;
 devV_ref=[circCmplx.circRef.absAngle]-repmat([0:5:355],1,runs)-circCmplx.circRef(1).absAngle;
 devV_center=[circCmplx.circCenter.absAngle]-repmat([0:5:355],1,runs)-circCmplx.circCenter(1).absAngle;

        %% Plot the incremental angle of main circle
%         figure('Position', [100, 100, 1800, 500]);
%         subplot(3,1,1);
%         plot(IncAngleArray,'-or','MarkerSize',5,'linewidth',1);
%         ylim([theta_step-0.25 theta_step+0.25]);
%         title('Relative angle increment per photo ');
%         xlabel('Photo');
%         ylabel('Increment angle(\circ)')
%         refline([0 theta_step])
%         
%         subplot(3,1,2);
%         plot(RefAngleArray,'-o','MarkerSize',5,'linewidth',1); hold on
%         xlabel('Photo');
%         ylabel('Reference angle (\circ)')
%         ylim([25-0.25 25+0.25]);
%         title('Reference angle');
%         refline([0 25])
%         
%         subplot(3,1,3);
%         plot(devV_main,'-go','MarkerSize',5,'linewidth',1); hold on
%         xlabel('Photo');
%         ylabel('Absolute Angle Deviation (\circ)')
%         %ylim([25-0.25 25+0.25]);
%         title('Absolute Angle');
%         %refline([0 25])
%         
%         figure('Position', [100, 50, 1800, 800]); hold on;
%         plot(devV_main);
%         plot(devV_ref);
%         plot(devV_center);
%         legend('Main','Reference','Center')
%         ylim([-0.5 0.5])
%% Save values
% save('RT11_circles_all','circCmplx_NEW')
% IncAngleArray=circCmplx.IncAngle;
% RefAngleArray=circCmplx.RefAngle;

%%Run comparison
% ART30Deg_RT13_CompareRefandInc;

%% Run ART 
[artISO_Absolute,artNP_Absolute]=art_rot(devV_main,targV,runs,2,'Yes');

title('Deviation curve for rotary stage using Absolute angle')

devV_Inc=IncAngleArray;
devV_Inc(2:end)=devV_Inc(2:end)-theta_step;
[artISO_Inc,artNP_Inc]=art_rot(devV_Inc,targV,runs,2,'Yes');

title('Deviation curve for rotary stage using Incremental angle')


toc