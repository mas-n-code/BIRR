%%Function RawSample(SSize,OriginalData)
% Samples the original raw data with sample size SSize
%> Hardcoded for 4 samples

function [Sampled_Data] = SampleRaw(SSize,Original_Data)
%self test
% SSize=4;
% Original_Data=setA;

setsize=size(Original_Data,2);
Sampled_Data=zeros(size(Original_Data,1),setsize/SSize);

for ii=1:2:setsize/SSize
    Sampled_Data(:,ii)=Original_Data(:,(ii*SSize)-3);
    Sampled_Data(:,ii+1)=Original_Data(:,(ii*SSize)+1-3);
end


