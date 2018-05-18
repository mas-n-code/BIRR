function [Profile1,Profile2,Profile3]=Profile_extractor2(Data,offset,offset2)
Size_Data=size(Data);
Profile1=zeros(601,Size_Data(2));
Profile2=zeros(601,Size_Data(2));
for i=1:Size_Data(2)
    Profile1(:,i)=Data(:,i,i);
    j=i+offset;
    k=i+offset2;
    if j>Size_Data(2)
        j=j-Size_Data(2);
    end;
    Profile2(:,i)=Data(:,i,j);
    
    if k>Size_Data(2)
        k=k-Size_Data(2);
    end;
    Profile3(:,i)=Data(:,i,k);
    
end