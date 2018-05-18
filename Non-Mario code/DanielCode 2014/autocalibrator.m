function clean_scan=autocalibrator(dataset)
% Autocalibrator.m
%--------------------------------------------------
% Version 1.0.1.0
% Created by Daniel Flores Tapia
% Date 11/10/2014
% This function correlates and eliminates the background responses in a BMR
% datasets
% Input Parameters
% dataset=BMR dataset
%--------------------------------------------------
% Revision changes
%--------------------------------------------------
%
% Please document here any changes

%--------------------------------------------------
vec_original=1:2:59;
vec_ref=2:2:60;
clean_scan=zeros(601,30);
[sigma_vector,sigma]=sigma_analyzer(dataset);
ref=1;
for i=1:30
    energy_difference=sum(abs(dataset(:,vec_original(i))).^2)-sum(abs(dataset(:,vec_ref(ref))).^2);
    if (abs(energy_difference))<sigma
        clean_scan(:,i)=dataset(:,vec_original(i))-dataset(:,vec_ref(ref));
        ref=i+1;
    else
        clean_scan(:,i)=dataset(:,vec_original(i))-dataset(:,vec_ref(ref));
    end
    
end

    