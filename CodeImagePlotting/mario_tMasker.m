function [masked_img,t_mask]=mario_tMasker(img_array,cutoff_threshold)
%[masked_img,t_mask]=mario_tMasker(img_array,cutoff_threshold)
%   img_array: Array where mask will be used
%   cutoff_threshold: Pixels bellow this value will be asigned a NaN value
% -Returns:-
%   t_mask:
%   masked_img:
% Can be used to make NaN values transparent.
% [M] August 8th


%% Applies mask (NaN value) to the image array
t_mask=find(img_array<=cutoff_threshold);

masked_img=img_array;
masked_img(t_mask)=NaN;