function animg_mario(fotoFile,col1,col2)
%Nueva imaginalona
FOTO = imread(fotoFile);  
%imshow(FOTO); %displays Foto
close all;


%Step 2: Extract the Region of Interest
start_row = 1000;
start_col = 1600;

cropFOTO = FOTO(start_row:1400, start_col:2000, :);
imshow(cropFOTO);
offsetX = start_col-1;
offsetY = start_row-1;



%Threshold
I = rgb2gray(cropFOTO); %converts to grayscale
threshold = graythresh(I)-.02 %+ offset to make it darkerish;
BW = im2bw(I,threshold);
BW = ~BW;  % complement the image (objects of interest must be white)
imshow(BW)
figure;
%Line de horizonte
% BW(1:3,1:40)=1;
% figure;imshow(BW)
% figure;


%---DetermineStuff
%fnd Initial Point on Each Boundary

dim = size(BW);

% beam1 
%col 1 must be infered
row1 = find(BW(:,col1), 1);

% beam 2
%col 2 col2 = 390; %must be infered
row2 = find(BW(:,col2), 1);

% trace boundries
boundary1 = bwtraceboundary(BW, [row1, col1], 'NW', 8, 200);

% set the search direction to counterclockwise, in order to trace downward.
boundary2 = bwtraceboundary(BW, [row2, col2], 'E', 8, 200,'counter');

imshow(FOTO); hold on;

% apply offsets in order to draw in the original image
plot(offsetX+boundary1(:,2),offsetY+boundary1(:,1),'g','LineWidth',2);
plot(offsetX+boundary2(:,2),offsetY+boundary2(:,1),'g','LineWidth',2);

%----Fit lines to the original boundries
ab1 = polyfit(boundary1(:,2), boundary1(:,1), 1);
ab2 = polyfit(boundary2(:,2), boundary2(:,1), 1);


f = polyval(ab1,boundary1(:,2));
plot(offsetX+boundary1(:,2),offsetY+f,'o');

%----Step 7: Find the Angle of Intersection
%Use the dot product to find the angle.

vect1 = [1 ab1(1)]; % create a vector based on the line equation
vect2 = [1 ab2(1)];
dp = dot(vect1, vect2);

% compute vector lengths
length1 = sqrt(sum(vect1.^2));
length2 = sqrt(sum(vect2.^2));

% obtain the larger angle of intersection in degrees
angle = 180-acos(dp/(length1*length2))*180/pi

% Find the intersection
intersection = [1 ,-ab1(1); 1, -ab2(1)] \ [ab1(2); ab2(2)];
% apply offsets in order to compute the location in the original,
% i.e. not cropped, image.
intersection = intersection + [offsetY; offsetX]


% Plot results
inter_x = intersection(2);
inter_y = intersection(1);

% draw an "X" at the point of intersection
plot(inter_x,inter_y,'yx','LineWidth',2);

text(inter_x-60, inter_y-30, [sprintf('%1.3f',angle),'{\circ}'],...
     'Color','y','FontSize',14,'FontWeight','bold');

interString = sprintf('(%2.1f,%2.1f)', inter_x, inter_y);

text(inter_x-10, inter_y+20, interString,...
     'Color','y','FontSize',14,'FontWeight','bold');