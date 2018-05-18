
function [circCmplx]=photoCircleTrackerCMPLX(pdir,theta_step,xcenter,ycenter,varargin)
%% Tracks circleComplex_East
%tracks three east circles, provides the metrics for "reference deviation"
%and the angle of the most external circle, 

nVarargs = length(varargin);

if (nVarargs>=1)
 guideMain=varargin{1};
 circMain=photoCircleTracker(pdir,theta_step,xcenter,ycenter,[18 28],[guideMain.x,guideMain.y]);
 display('Main Circle collected');
end
if (nVarargs>=2)
    guideRef=varargin{2};
 circRef=photoCircleTracker(pdir,theta_step,xcenter,ycenter,[18 28],[guideRef.x,guideRef.y]);
 display('Ref Circle collected');
end
if (nVarargs>=3)
    guideCenter=varargin{3};
 circCenter=photoCircleTracker(pdir,theta_step,xcenter,ycenter,[39 51],[guideCenter.x,guideCenter.y]);
 display('Center Circle collected');


 %% Calculate the uncertanty or angle variation among the collected circles
 
[circCmplx.RefAngleT,circCmplx.SummaryRefAngleT]=losanglesFinder(circMain,circRef,circCenter);
RefAngleArray=table2array(circCmplx.RefAngleT);
end

%% Calculate relative angle increment metrics
IncAngleArray=[circMain.relativeAngleInc];
circCmplx.IncAngleT=table(mean(IncAngleArray(2:end)),range(IncAngleArray(2:end)),std(IncAngleArray(2:end)), ...
    'VariableNames',{'Mean','Range','Std'});

%% Plot the incremental angle of main circle
figure;
subplot(2,1,1);
plot(IncAngleArray,'-ro');
ylim([theta_step-0.25 theta_step+0.25]);
title('Relative angle increment per photo ');
xlabel('Photo');
ylabel('Increment angle(\circ)')
refline([0 22.5])
if (nVarargs>=3)
subplot(2,1,2);
plot(RefAngleArray(:,1),RefAngleArray(:,2),'-o'); hold on
xlabel('Photo');
ylabel('Reference angle (\circ)')
ylim([25-0.25 25+0.25]);
title('Reference angle');
refline([0 25])
end
%% Save to strucutre result
circCmplx.circMain=circMain;
if (nVarargs>=2)
circCmplx.circRef=circRef;
end
if (nVarargs>=3)
circCmplx.circCenter=circCenter;
circCmplx.RefAngle=RefAngleArray;
end
circCmplx.IncAngle=IncAngleArray;


