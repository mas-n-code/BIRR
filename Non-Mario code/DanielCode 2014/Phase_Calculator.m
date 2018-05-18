function Phase_Values=Phase_Calculator(Params)
% Phase_Calculator.m
%--------------------------------------------------
% Version 1.0.0.0
% Created by Daniel Flores Tapia
% Date 26/01/2014
% This function calculates the phase delay between an original and a
% reflected wave
% Input Parameters
% Params=Data structure containing the function input parameters
% Paramas.freqvals=Vector of frequency values
% Params.speed= Propagation speed in the medium
% Params.distance=Signal travel time
%--------------------------------------------------
% Revision changes
%--------------------------------------------------
%
% Please document here any changes
%
%--------------------------------------------------

%Input structure parsing
%--------------------------------------------------

f=Params.freqvals;
Nu=Params.speed;
D=Params.distance;

%--------------------------------------------------

Delay_Factor=D./Nu;
Half_Period=1./f;
Comp_Delay=Delay_Factor./Half_Period;
Adjusted_Delay=floor(Comp_Delay)-Comp_Delay;
Phase_Values=Adjusted_Delay*2*pi;

for i=1:length(f) 
    if (Phase_Values(i)<-pi)
        Phase_Values(i)=(Phase_Values(i)+2*pi);
    end;
end;