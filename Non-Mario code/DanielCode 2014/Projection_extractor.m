function datasets=Projection_extractor(Data,offsets)

% Projection_extractor.m
%--------------------------------------------------
% Version 1.0.0.0
% Created by Daniel Flores Tapia
% Date 17/02/2014
% This function extracts the projections specified by the angles in offset
% from the simulated multistatic dataset Data
% Input Parameters
% Data: Simulated multistatic dataset
% offsets: Location of the recording sensors(in radians);
%--------------------------------------------------
% Revision changes
%--------------------------------------------------
%
% Please document here any changes

%--------------------------------------------------

%Initial size calculations
%--------------------------------------------------
Size_Data=size(Data);
total_projections=length(offsets);
Profile=zeros(601,Size_Data(2),total_projections);
theta=linspace(0,2*pi,Size_Data(2));
delta_theta=theta(2)-theta(1);
offset_index=round(offsets/delta_theta);
%--------------------------------------------------


%Data extraction
%--------------------------------------------------
for i=1:Size_Data(2)
    for m=1:total_projections
    j=i+offset_index(m);
        if j>Size_Data(2)
            j=j-Size_Data(2);
        end;
    Profile(:,i,m)=Data(:,i,j);
    end
        
end

for m=1:total_projections
    datasets(m).data=Profile(:,:,m);
    datasets(m).offset=offsets(m);
end

%--------------------------------------------------
