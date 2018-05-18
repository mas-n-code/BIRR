close all;
pdir = dir(['*Cricles**.jpg']);
originalP = imread(pdir(1).name);

%Step 2: Extract the Region of Interest
figure, imshow(originalP,'InitialMagnification',25);
cropBorders = imrect(gca, [10 10 1500 1500]);
position = wait(cropBorders); % Double click to select ROI
close;

%position= [1900 750 1000 1000];
cropP= imcrop(originalP,position);
figure(1), imshow(cropP,'InitialMagnification',50);

%Step 2: Extract the Region of Interest

%Step 3: Convert to BW, 
figure(2); hold on;
I = rgb2gray(cropP); %converts to grayscale

%threshold = graythresh(I)-.05; %+ offset to make it darkerish;
threshold=0.875;
bwP = im2bw(I,threshold);
bwP = ~bwP;  % complement the image (objects of interest must be white)
%imshow(bwP,'InitialMagnification',50);
%dimP = size(bwP);

%%
%Use of filter
BWcanny = edge(I,'Canny');
BWcanny = bwareaopen(BWcanny, 100);
%%
bwP=BWcanny;
bwP = bwareaopen(bwP, 100);

imshow(bwP,'InitialMagnification',60);


hold on;
[centers,radiiis,cStrength] = imfindcircles(I,[9 45],'ObjectPolarity','bright', 'Sensitivity',0.75);
[centerbig,radiiisbig,cStrengthbig] = imfindcircles(I,[40 185],'ObjectPolarity','dark', 'Sensitivity',0.95);
viscircles(centers,radiiis,'LineStyle','--');
viscircles(centerbig,radiiisbig,'LineStyle',':');
plot(centers(1),centers(2),'yx','LineWidth',4);
display(['the strength of circle is ', num2str(cStrength(1))]);
%Step 4: Extract lines of intersection
%Line 1
rowl1s=[];

while (isempty(rowl1s))
hline1 = imrect;
pl1 = wait(hline1);
region1=imcrop(bwP,pl1);

rowl1s = find(region1(:,round(end/2)), 3);   %y
end

rowl1=rowl1s(1);
coll1s= find(region1(rowl1,:),3,'last');            %x
coll1of=coll1s(end)-coll1s(1);  
coll1=coll1s(1);

figure(3);
imshow(region1);hold on;
plot(coll1,rowl1,'x');

reg1offx=round(pl1(1))-1;
ref1offy=round(pl1(2))-1;

coll1=coll1 + reg1offx;                %offest
rowl1=rowl1 + ref1offy;   




figure(2);hold on;
%---Plot a point on the calculated center of the line----%%%
% xc = coll1;
% yc = rowl1;
% r_m=3;
% theta = linspace(0,2*pi);
% x = r_m*cos(theta) + xc;
% y = r_m*sin(theta) + yc;
% 
% plot(x,y,'Color',[1 0.600000023841858 1])
plot(coll1,rowl1,'x','Color','y');
plot(coll1+coll1of,rowl1,'x','Color','r');
% Line2
rowl2s=[];
while (isempty(rowl2s))
hline2 = imrect;
pl2 = wait(hline2);
region2=imcrop(bwP,pl2);
rowl2s = find(region2(:,round(end/2)),3);   %y
end
rowl2=rowl2s(1);
coll2s= find(region2(rowl2,:),3,'last');    
coll2=coll2s(1);  %x
coll2of=coll2s(end)-coll2;  

rowl2s=find(region2(:,coll2),3);
rowl2=rowl2s(1);
rowl2of=rowl2s(end)-rowl2s(1); 


figure(4);
imshow(region2);hold on;
plot(coll2,rowl2,'x');

reg2offx=round(pl2(1))-1;
ref2offy=round(pl2(2))-1;


%Apply offest to recover coordinates to original image
coll2=coll2 + reg2offx;                
rowl2=rowl2 + ref2offy;   
%---Plot a point on the calculated start of the line----%%%
figure(2);hold on;

plstart1=[rowl1, coll1];
plstart1c=[rowl1, coll1+coll1of];
plstart2=[rowl2, coll2];
plstart2c=[rowl2+rowl2of, coll2];

plot(coll1,rowl1,'o','LineWidth',2,'Color','g')
plot(coll1+coll1of,rowl1,'o','LineWidth',2,'Color','r')

plot(coll2,rowl2,'o','LineWidth',2,'Color','g')
plot(coll2,rowl2+rowl2of,'o','LineWidth',2,'Color','r')

% trace boundries
boundary1 = bwtraceboundary(bwP, plstart1, 'W', 8, 350);
boundary1c = bwtraceboundary(bwP, plstart1c, 'E', 8, 350,'counterclockwise');
boundary2 = bwtraceboundary(bwP, plstart2, 'NE', 8, 250,'counterclockwise');
boundary2c = bwtraceboundary(bwP, plstart2c, 'SW', 8, 250);
 

plot(boundary1(:,2),boundary1(:,1),'g','LineWidth',2);
plot(boundary2(:,2),boundary2(:,1),'g','LineWidth',2);
plot(boundary1c(:,2),boundary1c(:,1),'r','LineWidth',2);
plot(boundary2c(:,2),boundary2c(:,1),'r','LineWidth',2);
hold off;

% Draw boundaries in the croped image
figure(1),hold on;
plot(boundary1(:,2),boundary1(:,1),'g','LineWidth',2);
plot(boundary2(:,2),boundary2(:,1),'g','LineWidth',2);

%Combine boundaries
bigboundary1=[boundary1;boundary1c];
bigboundary2=[boundary2;boundary2c];



%----Fit lines to the original boundries
[ab1,Sab1] = polyfit(bigboundary1(:,2), bigboundary1(:,1), 1);
[ab2,Sab2] = polyfit(bigboundary2(:,2), bigboundary2(:,1), 1);


[fit1,errorDelta1] = polyval(ab1,bigboundary1(:,2),Sab1);
plot(bigboundary1(:,2),fit1,'d');

[fit2,errorDelta2] = polyval(ab2,bigboundary2(:,2),Sab2);
plot(bigboundary2(:,2),fit2,'d');

%----Step 7: Find the Angle of Intersection
%Use the dot product to find the angle.

vect1 = [1 ab1(1)]; % create a vector based on the line equation
vect2 = [1 ab2(1)];
dp = dot(vect1, vect2);

% compute vector lengths
length1 = sqrt(sum(vect1.^2));
length2 = sqrt(sum(vect2.^2));

% obtain the larger angle of intersection in degrees
angle = 180-acos(dp/(length1*length2))*180/pi;

% Find the intersection
intersection = [1 ,-ab1(1); 1, -ab2(1)] \ [ab1(2); ab2(2)];

% i.e. not cropped, image.



% Plot results
inter_x = intersection(2);
inter_y = intersection(1);

% draw an "X" at the point of intersection
plot(inter_x,inter_y,'yx','LineWidth',2);

text(inter_x-70, inter_y-40, [sprintf('%1.3f',angle),'{\circ}'],...
     'Color','r','FontSize',14,'FontWeight','bold');

interString = sprintf('(%2.1f,%2.1f)', inter_x, inter_y);

text(inter_x-10, inter_y+20, interString,...
     'Color','y','FontSize',14,'FontWeight','bold');
 
 display(angle);
 
 %plot(inter_x,)
 
 figure(2); hold on;
 plot(inter_x,inter_y,'yx','LineWidth',4);
 
 
masx=inter_x:max(bigboundary1(:,2));
masy=inter_x:coll2+1;
originl1= polyval(ab1,masx);
plot(masx,originl1,'c','LineWidth',1.5);

originl2= polyval(ab2,masy);
plot(masy,originl2,'c','LineWidth',1.5);
 