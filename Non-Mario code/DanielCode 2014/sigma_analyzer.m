function [sigma_vector,sigma]=sigma_analyzer(dataset)
% sigma_analyzer.m
%--------------------------------------------------
% Version 1.0.1.0
% Created by Daniel Flores Tapia
% Date 11/10/2014
% This function calculates the energy of each range profile in a BMR dataset and the energy gradient standard deviation
% datasets
% Input Parameters
% dataset=BMR dataset
%--------------------------------------------------
% Revision changes
%--------------------------------------------------
%
% Please document here any changes

%--------------------------------------------------
sigma_vector=zeros(1,60);

for i=1:60
sigma_vector(:,i)=sum(abs(dataset(:,i)).^2);
end;
sigma=std(abs(diff(sigma_vector)));
