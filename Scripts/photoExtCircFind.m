%% photoExCircFind
% 
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

%% Loads file names
function loscircles= photoCircleTracker(pdir,thetaStep,xcenter,ycenter, cRange);
close all;
sizdir=length(pdir);

I = imread(pdir(1).name);
Ig=rgb2gray(I);%converta to grayscale


figure(1);
imshow(I,'InitialMagnification',25); hold on;
GuideCircle=circleCatcher(I,[cRange],'Guide');


sizCrop=cRange(2)*8;
if (cRange(2)>50)
    sizCrop=400;
end

initialCx=GuideCircle.x;      %2387; %2483.64848660633
initialCy=GuideCircle.y;      %316;  %415.323858292785

rectangle('Position', [initialCx-sizCrop/2,initialCy-sizCrop/2,sizCrop,sizCrop])
adS=initialCy-ycenter; %y
opS=initialCx-xcenter; %x
cropTheta=atan(adS/opS)*180/pi(); %Sah cota, this inverts the x and y axis
cropR2=hypot(adS,opS);




for i=1:sizdir
    deltax=floor(cropR2*cos(cropTheta*pi()/180));
    deltay=floor(cropR2*sin(cropTheta*pi()/180));
    currx=ceil(xcenter+deltax);
    curry=ceil(ycenter+deltay);
    cropPos= [currx-sizCrop/2,curry-sizCrop/2,sizCrop,sizCrop];
    I = imread(pdir(i).name);
    figure(1)
    rectangle('Position', cropPos)
    figure(i+1);
    IcO= imcrop(I,cropPos);
    imshow(IcO,'InitialMagnification',100); hold all; 
    [centersDark, radiiDark ,circleStrength] = imfindcircles(IcO,[cRange],'Sensitivity',0.88); %IcO,[10 20],'Sensitivity',0.88)
    viscircles([centersDark],radiiDark,'LineStyle',':');
    loscircles(i).x=centersDark(1)+cropPos(1)-1;
    loscircles(i).y=centersDark(2)+cropPos(2)-1;
    loscircles(i).rad=radiiDark;
    loscircles(i).str=circleStrength;
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
imshow(I,'InitialMagnification',25); hold on;
rectangle('Position', cropPos);
plot([loscircles.x],[loscircles.y],'o');
viscircles([loscircles(end).x,loscircles(end).y],loscircles(end).rad,'LineStyle',':');

figure(1); hold on;
plot([loscircles.x],[loscircles.y],'o');
plot(GuideCircle.x,GuideCircle.y,'x');
