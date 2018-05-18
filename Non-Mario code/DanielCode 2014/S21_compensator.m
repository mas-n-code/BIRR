function  data_compS21  = S21_compensator( Params )

% S21_compensator.m
%--------------------------------------------------
% Version 1.0.0.0
% Created by Daniel Flores Tapia
% Date 26/01/2014
% This function reconstructs a radar image based on a multistatic dataset
% Input Parameters
% Params=Data structure containing the reconstruction parameters
% Params.S21data=S21 Dataset to be processed
% Paramas.compfactor=Vector of frequency values
%--------------------------------------------------
% Revision changes
%--------------------------------------------------
%
% Please document here any changes
%--------------------------------------------------

%Input structure parsing
%--------------------------------------------------
Params.S21data=data;
Params.compfactor=compfactor;
%--------------------------------------------------

%Signal compensation
%--------------------------------------------------
vec=exp(-1i*2*pi*f*(compfactor)*2/3e8);
matc=repmat(vec',1,144);
data_compS21=ifft(fft(data).*matc);
%--------------------------------------------------


end

