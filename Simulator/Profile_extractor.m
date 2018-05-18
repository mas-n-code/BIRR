function [Profile1,Profile2]=Profile_Extractor(Data,offset)
sizedata=size(Data);
Profile1=zeros(601,sizedata(2));
Profile2=zeros(601,sizedata(2));
for i=1:sizedata(2)
    Profile1(:,i)=Data(:,i,i);
    j=i+offset;
    if j>sizedata(2)
        j=j-sizedata(2);
    end;
    Profile2(:,i)=Data(:,j,i);
    
end