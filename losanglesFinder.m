function [Tscore,Tscore2]=losanglesFinder(cir1,cir2,cirC)
% *Tscore=losanglesFinder(cir1,cir2,cirC)*
%Determines the angles between three circulito structures given by 
% _photoCircleTracker_


image=[];
resAngle=[];
Tscore=table(image,resAngle);
ColorSet = varycolor(30);
set(gca, 'ColorOrder', ColorSet); hold all;

for ii=1:length(cir1)
image=ii;  
PNx=cir1(ii).x;
PNy=cir1(ii).y;
PEx=cir2(ii).x;
PEy=cir2(ii).y;
PCx=cirC(ii).x;
PCy=cirC(ii).y;

lsidex=PNx - PCx;
lsidey=PNy - PCy;
 
Ssidex=PEx - PCx;
Ssidey=PEy - PCy;

plot([PNx PCx PEx],[PNy PCy PEy]);

resAngle=angleFinder([PNx PNy],[PEx PEy],[PCx PCy]);

text(PCx+PCx*(0.015)+ii,PCy+PCy*(0.015)+ii,['\theta ' num2str(resAngle,6)]);
Tscore=[Tscore;table(image,resAngle)];
%TAutScoreCorrD=[TAutScoreCorrD;Tnew]
% %set(gca,'YDir','reverse'); % Only for non images

end
Tarray=table2array(Tscore);
figure;plot(Tarray(:,1),Tarray(:,2),'-o'); hold on
title('Reference angle')
ylabel('Degrees \circ')
xlabel('Photo')
%refline([0 25])

Tscore2.mean=mean(Tarray(:,2));
Tscore2.std=std(Tarray(:,2));
Tscore2.range=max(Tarray(:,2))-min(Tarray(:,2));
Tscore2.array=Tarray(:,2);
%Tscore2=struct(meanValue,rangeValue,stdValue);
