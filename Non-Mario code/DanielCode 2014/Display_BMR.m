function   Display_BMR( BMR )
% Display_BMR.m
%--------------------------------------------------
% Version 1.0.1.0
% Created by Daniel Flores Tapia
% Date 11/10/2014
% This function displays a radar image 
% Input Parameters
% BMR=Data structure containing the reconstruction parameters
% BMR.ima=BMR image
% BMR.vectors=Spatial representation vectors.
%--------------------------------------------------
% Revision changes
%--------------------------------------------------
%
% Please document here any changes

%--------------------------------------------------
figure
imagesc(BMR.vector,BMR.vector,abs(BMR.ima).^2)
colorbar
axis xy

end

