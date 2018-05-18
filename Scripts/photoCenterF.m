%% photoCenterF
% 
%--------------------------------------------------
% Version 1.0.0
% Created by Mario Solis N [M]
% Date =Today()
% Looks for the Circle cennter in all images, creates a list and plots the result in image 1
% The purpose of this script is to find the rotary of stage center

%--------------------------------------------------
% Revision changes
%--------------------------------------------------

%% Loads file names
close all;
pdir = dir(['*Captured**0**.jpg']);
sizdir=length(pdir);
figure(1);
imshow(IcO,'InitialMagnification',100); hold all; %(190:250,200:260)
zoom(4.5);
%viscircles(lastC, lastR,'LineStyle','--');%Draw circles
viscircles([xCenter,yCenter],rCenter,'LineStyle',':');
colorE = hot(length(pdir));
ccount=0;
cArray=zeros(sizdir,2);
rArray=zeros(sizdir,1);
for i=1:sizdir
    
    I = imread(pdir(i).name);
    cropPos= [1900 1200 500 500];
    Ic= imcrop(I,cropPos);
    Ig=rgb2gray(Ic);%converta to grayscale
    [centersDark, radiiDark ,circleStrength] = imfindcircles(Ig,[60 140]);
    if (isempty(centersDark)==0)
        ccount=ccount+1;
        cArray(i,:)=centersDark;
        rArray(i)=radiiDark;
        imshow(Ic,'InitialMagnification',100); hold all; %(190:250,200:260)
        viscircles([xCenter,yCenter],rCenter,'LineStyle',':');
        plot(xCenter,yCenter,'+','color',colorE(i,:));
        plot(xc,yc,'x','color',colorE(i,:));
        plot(centersDark(1),centersDark(2),'o','color',colorE(i,:)); % Plot a marker o in the center of the cirlce
        drawnow
    end
end 
if (ccount==length(pdir))
    display(['Ya se armo ' num2str(length(pdir))]);
else
    display(['Nope']);
    display([num2str(length(pdir))  ' archivos']);
    display([num2str(ccount)  ' circulos']);
end
IcO=Ic;
lastC=centersDark;
lastR=radiiDark;
plot(centersDark(1),centersDark(2),'+','color',colorE(i,:));
%figure(1); hold on;

%imshow(IcO(190:250,200:260)); hold all; %


