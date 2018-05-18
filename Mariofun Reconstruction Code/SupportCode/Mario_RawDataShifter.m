
function [ShiftedRawData]= Mario_RawDataShifter(RawData,Dis)
% Shifts the Raw data columns (Antenna locations) by a given amount of
% spaces, The angle can be calculated as (180/(antenna locations))*Dis. Note
% that the angle can only by modified in increments of  (180/(antenna location)
% Dis must be a positive integer between 0 and (antenna locations)
% ---
%[M] Aug 4-2017
% V 1.0
[FreqPoints,aLocations] = size(RawData);

% Generate an array with double the data
RawD_Plus=[RawData,RawData]; 

% Initialize the array with zeros
ShiftedRawData=zeros(size(RawData));

% Raw data has Real and imaginary parts, so columns have to be 'cut' in
% pairs.
for ii=1:2:aLocations
    ShiftedRawData(:,ii)=RawD_Plus(:,ii+Dis*2);
    ShiftedRawData(:,ii+1)=RawD_Plus(:,(ii)+1+Dis*2);
end
disp('Get Schwifty!')

% Tester code
% test_A(1:2:144)=[0:71]
% test_A(2:2:144)=[0:71]
% Shift_test=Mario

