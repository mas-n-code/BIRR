function [Profile1,Profile2]=Profile_extractor(Data,offset)
Size_Data=size(Data);
Profile1=zeros(601,Size_Data(2));
Profile2=zeros(601,Size_Data(2));
for i=1:Size_Data(2)
    Profile1(:,i)=Data(:,i,i);
    j=i+offset;
    if j>Size_Data(2)
        j=j-Size_Data(2);
    end;
    Profile2(:,i)=Data(:,i,j);
    
end