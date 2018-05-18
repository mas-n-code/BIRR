function loscircles= photoCircleTracker(pdir,thetaStep,xcenter,ycenter,cRange,varargin)
%% photoCircleTracker
% photoCircleTracker(pdir,thetaStep,xcenter,ycenter,cRange,varargin)
%--------------------------------------------------
% Version 1.3.0
% Created by Mario Solis N [M]
% Date =Today()
% Looks for one of the Exter Circle cennter in all images, creates a list and plots the result in image 1
% The purpose of this script is to locate the cordinates of all cirlces
% rotating in the images. A ordered directory of images must be given along
% with the expected thetha incrmenet thetaStep
% xc and yc are pictures coordinate of the center of rotation. 


%--------------------------------------------------
% Revision changes
%--------------------------------------------------
%1.3 varargin 
%% Loads file names

%close all;
sizdir=length(pdir);

I = imread(pdir(1).name);
%Ig=rgb2gray(I);%convert to grayscale


figure(1); 
imshow(I,'InitialMagnification',17); hold on;
sizCrop=cRange(2)*8;
if (cRange(2)>50)
    sizCrop=400;
end

switch nargin
    case 5
        GuideCircle=circleCatcher(I,[cRange],'Guide');
        initialCx=GuideCircle.x;      %2387; %2483.64848660633
        initialCy=GuideCircle.y;      %316;  %415.323858292785
    case 6
        tmpvar=varargin{1};
        initialCx=tmpvar(1);
        initialCy=tmpvar(2);
    otherwise
        display('No, something went wrong');
end
rectangle('Position', [initialCx-sizCrop/2,initialCy-sizCrop/2,sizCrop,sizCrop],'EdgeColor','y');


% % % % adS=initialCy-ycenter; %y
% % % % opS=initialCx-xcenter; %x
% % % % cropTheta=atan(adS/opS)*180/pi(); %Sah cota, this inverts the x and y axis
% % % % cropR2=hypot(adS,opS);

[cropTheta,cropR2]=angleCatcher(initialCx,initialCy,xcenter,ycenter);


for i=1:sizdir
    I = imread(pdir(i).name);
    Ig=rgb2gray(I);
    
    deltax=floor(cropR2*cos(cropTheta*pi()/180));
    deltay=floor(cropR2*sin(cropTheta*pi()/180));
    cropx=ceil(xcenter+deltax);
    cropy=ceil(ycenter+deltay);
    cropPos= [cropx-sizCrop/2,cropy-sizCrop/2,sizCrop,sizCrop];
    
    
    figure(1); hold on;
    rectangle('Position', cropPos)
    
    IcO= imcrop(I,cropPos);
    %tmpf=figure(i+1);
    %imshow(IcO,'InitialMagnification',100); hold on; 
    
    
    [centersDark, radiiDark ,circleStrength] = imfindcircles(IcO,cRange,'Sensitivity',0.85,'ObjectPolarity','dark'); %IcO,[10 20],'Sensitivity',0.88)
    
    loscircles(i).x=centersDark(1)+cropPos(1)-1;
    loscircles(i).y=centersDark(2)+cropPos(2)-1;
    loscircles(i).rad=radiiDark;
    loscircles(i).str=circleStrength;
    loscircles(i).centerValue=Ig(round(xcenter),round(ycenter));
    loscircles(i).absAngle=angleCatcher(loscircles(i).x,loscircles(i).y,xcenter,ycenter);
    figure(1); hold on;
    viscircles([loscircles(i).x, loscircles(i).y],loscircles(i).rad,'LineStyle',':');
    loscircles(i).relativeAngle=angleFinder([loscircles(i).x,loscircles(i).y],[loscircles(1).x,loscircles(1).y],[xcenter,ycenter]);
    if i==1;
        loscircles(i).relativeAngleInc=0;
        else
        loscircles(i).relativeAngleInc=angleFinder([loscircles(i).x,loscircles(i).y],[loscircles(i-1).x,loscircles(i-1).y],[xcenter,ycenter]);
    end
    loscircles(i).image=pdir(i).name;
    %pause(.1)
    %close(tmpf);
    drawnow;
    cropTheta=cropTheta+thetaStep;
end

%display(['range rad ' num2str(range([loscircles.rad],2))]);
%display(['Mean rad ' num2str(mean([loscircles.rad]))]);
%ccount=0;
%viscircles([loscircles(end).x,loscircles(end).y],loscircles(end).rad,'LineStyle',':');
% 
% colorE = hot(length(pdir));
% excArray=zeros(sizdir,2);
% exrArray=zeros(sizdir,1);


figure(i+2);
imshow(I,'InitialMagnification',17); hold on;
rectangle('Position', cropPos);
plot([loscircles.x],[loscircles.y],'o');
viscircles([loscircles(end).x,loscircles(end).y],loscircles(end).rad,'LineStyle',':');

figure(1); hold on;
plot([loscircles.x],[loscircles.y],'o');
plot(initialCx,initialCy,'x');
