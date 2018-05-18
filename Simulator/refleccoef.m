function reflec=refleccoef(En,Er);
reflec=zeros(1,length(En));
for i=1:length(En)
    reflec(i)=abs((En(i)-Er)/(En(i)+Er));
end 