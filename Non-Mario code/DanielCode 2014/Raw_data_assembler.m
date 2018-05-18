function [ Raw_data ] = Raw_data_assembler( datasets )
% Raw_data_assembler.m
%--------------------------------------------------
% Version 1.0.0.0
% Created by Daniel Flores Tapia
% Date 17/02/2014
% This function forms the raw dataset for multistatic reconstruction
% Input Parameters
% datasets: An array projections that will be used to form the image, need to be
% in the following format
% Structure data
% dataset.data: The reflections in the time domain(S11 or S21)
% offset: The angular location of the sensor in radians
%--------------------------------------------------
% Revision changes
%--------------------------------------------------
%
% Please document here any changes

%--------------------------------------------------

%Initial size calculations
%--------------------------------------------------


size_data=size(datasets(1).data);
Raw_data=zeros(size_data(1),size_data(2),size_data(2));
theta=linspace(0,2*pi,size_data(2));
number_data=length(datasets);
offset_index=zeros(1,number_data);

%--------------------------------------------------


%Raw data structure formation
%--------------------------------------------------
for m=1:number_data

    offset_index(m)=round(datasets(m).offset/(theta(2)-theta(1)));

end



for i=1:size_data(2)
    
    for m=1:number_data
        
        j=i+offset_index(m);
    
            if j>size_data(2)
                j=j-size_data(2);
            end
    
        Raw_data(:,i,j)=datasets(m).data(:,i);
    end

end

