%% ART_RotaryStage_RT11
% targV= targeted positions in 1 cycle
% Creates or loads the circle.Complex (Vector size 864) with a lot of circle positions 
%
%Complete Arc with full DataSet RT11 <- fthesis material
%%
%Original Script version  Wednesday 16 December
close all


set(0,'defaultAxesFontSize', 14) 

clc
tic
%% Define angle step
theta_step=5; %72 locations per cycle
runs=12; %in case there was something off
targV=(0:theta_step:360-theta_step);
n_pos=runs*(360/theta_step);

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
            
        
%% Save circCmplx
%        circCmplx.RefAngle=RefAngle.array;
%        circCmplx.IncAngle=IncAngleArray;
%        save('circCmplx_RT11_dataset2')
 

%% Load the circCmplx information, which has the actual measured values of the position
cd('F:\UserElGuapo\DBOx\Dropbox\ResearchMagic\RandomProyects\2015 HF2\151116 RotAngleAnalysis\FINAL DATASETS\ART Dataset fThesis');

load circCmplx_RT11_dataset circCmplx
load circCmplx_RT11_dataset IncAngleArray
load circCmplx_RT11_dataset RefAngleArray

%%Reduce to 5?
reducer=0;

%% Generates deviation files
temp_main=[circCmplx.circMain.absAngle];
temp_ref=[circCmplx.circRef.absAngle];
temp_center=[circCmplx.circCenter.absAngle];

 devV_main=temp_main(1:end-reducer)-repmat(0:theta_step:360-theta_step,1,runs)-circCmplx.circMain(1).absAngle;
 devV_ref=temp_ref(1:end-reducer)-repmat(0:theta_step:360-theta_step,1,runs)-circCmplx.circRef(1).absAngle;
 devV_center=temp_center(1:end-reducer)-repmat(0:theta_step:360-theta_step,1,runs)-circCmplx.circCenter(1).absAngle;
 
 %% Reduce to 5 cycles
%RefAngleArray=RefAngleArray(1:end-reducer);
 
 %% Calibrate abs angle based on ref
[devCal,devSuperCal]=RefAngleCalibrator_RT11(RefAngleArray,devV_main,2,4);
devV_main_cal=devSuperCal;
 
%% Re=Sphape array for conversion to excel ART calculator

posV=[circCmplx.circMain.absAngle]-circCmplx.circMain(1).absAngle;
nPos=length(targV);
posM=reshape(posV,[nPos,runs]);


% Separate Forward and Reverse arrays
posFW=posM(:,1:2:end);
posRV=posM(:,2:2:end);

%reshapel calibrated deviation matrix (positions lost sorry)
devM_cal=reshape(devV_main_cal,[nPos,runs]);

% Save arrays

save MeasRotPos_RT_11fThesis posM
save MeasRotDev_RT_11fThesis devM_cal


%% Plot the distribution of positional deviations
figure;
hist(devV_main,-0.30:0.025:0.30);
h = findobj(gca,'Type','patch');
set(h,'FaceColor',[0 .5 .5],'EdgeColor','w');
title({'Histogram of measured positional deviations ( \circ)',['for the rotary stage. n=' num2str(n_pos)]});
savefig fig_Histogram_PosDev_RT11


%% Plot the incremental angle, reference angel and posititional deviation of main circle for two cycles
%%{
        figure;
        sposition=[ 0.16 0.76 0.7675 0.15];
        subplot(3,1,1,'Position',sposition);
        plot(IncAngleArray(1:144),'-or','MarkerSize',5,'linewidth',1);
        ylim([theta_step-0.25 theta_step+0.25]);
        title('Measured relative angle increment per photo for two cycles');
        xlabel('Photo');
        ylabel('Angle ( \circ)','rot',0)
        refline([0 theta_step])
        
        subplot(3,1,2);
        plot(RefAngleArray(1:144),'-o','MarkerSize',5,'linewidth',1); hold on
        xlabel('Photo');
        ylabel('Angle ( \circ)','rot',0)
        ylim([25-0.25 25+0.25]);
        title('Measured reference angle per photo for two cycles');
        refline([0 25])
        
        subplot(3,1,3);
        plot(devV_main(1:144),'-go','MarkerSize',5,'linewidth',1); hold on
        xlabel('Photo');
        ylabel('Angle ( \circ)','rot',0)
        %ylim([25-0.25 25+0.25]);
        title('Measured positional deviation per photo for two cycles for two cycle');
        refline([0 0])
savefig fig_Position_RT11

        figure('Position', [100, 50, 1200, 600]); hold on;
        plot(devV_main,'k');
        plot(devV_ref,'g');
        plot(devV_center,'r');
        legend('Main','Reference','Center')
        ylim([-0.5 0.5])
        

%}

%% Save values?? circCmplx_New is never used
%{
save('RT11_circles_all','circCmplx_NEW')
 IncAngleArray=circCmplx.IncAngle;
 RefAngleArray=circCmplx.RefAngle;
%}

%% Run comparison
%ART30Deg_RT13_CompareRefandInc;

%% Run ART cal
[artISO_Absolute_cal,artNP_Absolute_cal]=art_rot(devV_main_cal,targV,runs,2,'Yes');

title('Deviation curve for rotary stage')
save('Art_results_cal','artISO_Absolute_cal','artNP_Absolute_cal')

savefig('Deviatio_curve_cal');

%% Run ART not cal

[artISO_Absolute_uncal,artNP_Absolute_uncal]=art_rot(devV_main,targV,runs,2,'Yes');
title('Deviation curve for rotary stage (not calibrated) ')
save('ART_results_uncal','artISO_Absolute_uncal','artNP_Absolute_cal')

savefig('Deviation_curve_Uncal');

%devV_Inc=IncAngleArray;
%devV_Inc(2:end)=devV_Inc(2:end)-theta_step;
%[artISO_Inc,artNP_Inc]=art_rot(devV_Inc,targV,runs,2,'Yes');

%title('Deviation curve for rotary stage using Incremental angle')


toc