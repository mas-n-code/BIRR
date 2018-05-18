function [masked_img,c_mask]=mario_cMasker(img_array,cutoff_radius)
% c_mask=mario_cMasker(img_array,cutoff_radius);
%   img_array: Array where mask will be used
%   cutoff_radius: Pixel radius of the circle in the mask
% -Returns:-
%   c_mask:
%   masked_img:
% Generates a square array with a cirlce mask on the center for the image_array of size cutOff_radius
% cutOff_radious must be given in pixels!
% Can be used to make NaN values transparent.
% [M] August 8th

%% Generates the c_maks
[iy,ix] = size(img_array);
r= cutoff_radius;

cx=ceil(iy/2);cy=ceil(ix/2);   % Circle Center x, Circle Center Y, Circle radius 

[x,y]=meshgrid(-(cx-1):(ix-cx),-(cy-1):(iy-cy)); 
c_mask=((x.^2+y.^2)<=r^2);

%% Applies mask (NaN value) to the image array
masked_img=img_array;
masked_img(~c_mask)=NaN;