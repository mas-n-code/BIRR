clc;
clear;
close all;
siz=350;%size of the croped image, 350 generates a 701x701 pixels image
A = imread('MIMTest_1o25deg_mPhoto_z_0_Rot001777_faW_Img2.JPG');%read file
AG=rgb2gray(A);%convert to grayscale
[centersDark, radiiDark] = imfindcircles(AG,[25 40]);%find circles in the image, radious between 25 to 40 (at 22 there is a circle from a bolt)

figure;imshow(AG);
viscircles(centersDark, radiiDark,'LineStyle','--');%Draw circles
AGsm=AG(floor(centersDark(2)-siz):floor(centersDark(2)+siz),floor(centersDark(1)-siz):floor(centersDark(1)+siz));%cropp image using the circle as center and siz as half size of the image
AGsmEd=edge(AGsm,'canny',0.03);%edge detection using Canny

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