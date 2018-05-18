function [Profile1,Profile2]=Profile_Extractor(Data,offset)
Profile1=zeros(601,144);
Profile2=zeros(601,144);
for i=1:144
    Profile1(:,i)=Data(:,i,i);
    j=i+offset;
    if j>144
        j=j-144;
    end;
    Profile2(:,i)=Data(:,j,i);
    
end