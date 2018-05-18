clc;
clear;
close all;
siz=400;%size of the croped image, 350 generates a 701x701 pixels image
pdir = dir(['*cricles**.jpg']);
A = imread(pdir(1).name);
AG=rgb2gray(A);%convert to grayscale
[centersDark, radiiDark ,circleStrength] = imfindcircles(AG,[60 140]);%find circles in the image, radious between 25 to 40 (at 22 there is a circle from a bolt)
display(['The circle Stregth is ' num2str(circleStrength)]);

figure;imshow(AG); hold on;
viscircles(centersDark, radiiDark,'LineStyle','--');%Draw circles
plot(centersDark(1),centersDark(2),'o','Color','r'); % Plot a marker o in the center of the cirlce



AGsm=AG(floor(centersDark(2)-siz):floor(centersDark(2)+siz),floor(centersDark(1)-siz):floor(centersDark(1)+siz));%cropp image using the circle as center and siz as half size of the image
AGsmEd=edge(AGsm,'canny',0.03);%edge detection using Canny
cropSize=size(AGsm); %
offsetX=floor(centersDark(1)-siz);
offsetY=floor(centersDark(2)-siz);

szBB=70; % size of the area to be deleted at the center of the image (should be above 55 to cut all concentric circles in the center
siz=size(AGsmEd);
AGsmEd(siz(2)/2-szBB:siz(2)/2+szBB,siz(1)/2-szBB:siz(1)/2+szBB)=0;%delete circle in the middle of the image to avoid false detections
%%%%%%%Hough stuff
se = strel('disk',5);%disk for closing image, this makes the lines ticker and joins them together
AGsmEdC = imclose(AGsmEd,se);%closing of the image
se = strel('disk',1);%disk for eroding image, this makes the lines tinner, if bigger than 1 some lines may disapear
AGsmEdC = imerode(AGsmEdC,se);
%[H,theta,rho] = hough(AGsmEd,'ThetaResolution',0.01);
[H,theta,rho] = hough(AGsmEdC);
peaks = houghpeaks(H,10,'Threshold',1);
%peaks = houghpeaks(H,10);

lines = houghlines(AGsmEdC,theta,rho,peaks,'FillGap',10,'MinLength',100); %detect lines, fills gaps is how close a line has to be before being joint with an other line
                                                                          %MinLength tells you the size of the lines, this helps avoid duplicate lines
figure, imshow(AGsmEdC), hold on
max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

   % Determine the endpoints of the longest line segment
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
   end
end
plot(centersDark(1)-offsetX,centersDark(2)-offsetY,'o','Color','r');