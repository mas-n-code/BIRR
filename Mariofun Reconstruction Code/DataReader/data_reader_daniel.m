function data_time=data_reader_daniel(mat)
% data_reader.m
%--------------------------------------------------
% Version 1.0.0.0
% Created by Daniel Flores Tapia
% Date 26/01/2014
% This function reads a raw dataset in the frequency domain and provides
% its time represetnation
%--------------------------------------------------
% Revision changes
%--------------------------------------------------
%
% Please document here any changes
%--------------------------------------------------

%Input parameters
%mat:Raw data
%-------------------------------------------------

%Output parameters
%data_time:complex formatted data in the time domain
%-------------------------------------------------

sizemat=size(mat);
data_matrix=zeros(sizemat(1),sizemat(2)/2);

for k=1:sizemat(2)/2

    data_matrix(:,k)=(mat(:,2*(k-1)+1)+1i*mat(:,2*k));
end;

data_time=ifft(data_matrix);

