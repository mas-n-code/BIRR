function [ BSCAN ] = data_former( data_monostatic, data_bistatic,offset )

%data_former.m
%Forms the 3D dataset for multistatic reconstruction(uses only one dataset
%with an offset)
%Input parameters
%data_monostatic: Monostatic dataset in the time domain
%data_bistatic: Bistatic dataset in the time domain
%offset: angle offset between the radiating and the receiving locations in
%the bistatic dataset

%Output parameters
%BSCAN: 3D dataset
size_data=size(data_bistatic);
wins1 = tukeywin(size_data(1),1);
wind=repmat(wins1,1,size_data(2));

if(sum(sum(data_bistatic))==0)
    data_bistatic=data_bistatic+1e-20;
    data_bistatic=ifft(fft(data_bistatic).*wind);
end


BSCAN=zeros(size_data(1),size_data(2),size_data(2))+1e-20;
for i=1:size_data(2)
    BSCAN(:,:,i)=ifft(fft(BSCAN(:,:,i)).*wind);
end
theta=linspace(0,2*pi,size_data(2));
offset_index=round(offset/(theta(2)-theta(1)));

for i=1:size_data(2)
    j=i+offset_index;
    
    if j>size_data(2)
        j=j-size_data(2);
    end
    
    BSCAN(:,i,j)=data_bistatic(:,i);
    BSCAN(:,i,i)=data_monostatic(:,i);
    
end


