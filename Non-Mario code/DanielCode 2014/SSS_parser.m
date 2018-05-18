function [SSS_data,f]=SSS_parser(data,BG,B)

compl=abs(data(:,2)).*exp(-1i.*data(:,3)./180.*pi);

A=reshape(compl,length(compl)/73,73);%4Ghz
%A=reshape(compl,301,73);

 
 compl_BG=abs(BG(:,2)).*exp(-1i.*BG(:,3)./180.*pi);
 hann_win=hanning(601);
for i=1:73
A(:,i)=(A(:,i)-compl_BG);
end;    

df=B/(length(compl)/73);
f=df:df:df*(length(compl)/73);
SSS_data=A;
