function [masked_img,c_mask]=mario_cMaskerAdvanced(img_array,cutoff_radius,cCenter,imx_t,imy_t)
% c_mask=mario_cMaskerAdvanced(img_array,cutoff_radius,cCenter,imx_t,imy_t)
% 
%   img_array: Array where mask will be used
%   cutoff_radius: radius of the circle in the mask (cm)
% -Returns:-
%   c_mask:
%   masked_img:
% Generates a square array with a cirlce mask on the center for the image_array of size cutOff_radius
% cutOff_radious must be given in pixels!
% Can be used to make NaN values transparent.
% [M] August 8th

%% Generates the c_maks
[iy,ix] = size(img_array);
d_res = imx_t(2)-imx_t(1);
r= ceil(cutoff_radius/d_res); %ceil?

% Finds the closest value to the center of 
cx_cm = cCenter(1);
cy_cm = cCenter(2);


[c,index] = min(abs(imx_t-cx_cm));
cx = index; % Finds first one only!

[c,index] = min(abs(imy_t-cy_cm));
cy = index; % Finds first one only!


% generates the mask based on a grid
[x,y]=meshgrid(-(cx-1):(ix-cx),-(cy-1):(iy-cy)); 
c_mask=((x.^2+y.^2)<=r^2);

masked_img=img_array;
masked_img(c_mask)=5e-9;


figure; imagesc(imx_t,imy_t, masked_img); set(gca,'YDir','normal'); axis equal; hold on;
viscircles([cx_cm,cy_cm],cutoff_radius);

