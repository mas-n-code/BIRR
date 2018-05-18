
function resAngle=angleFinder(P1, P2, PC)
%% angleFinder
% provides the resulting angle (deg) between 3 Vectors [Ui Uj], PC is the Center Point
% resAngle=angleFinder(P1, P2, PC)
Uvector= P1-PC;
Vvector= P2-PC;

dp=dot(Uvector,Vvector);
lU = sqrt(sum(Uvector.^2));
lV = sqrt(sum(Vvector.^2));

resAngle=acos(dp/(lU*lV))*180/pi();
%figure();
plot([P1(1) PC(1) P2(1)],[P1(2) PC(2) P2(2)]);
%axis equal

%text(PC(1)+PC(1)*(0.015),PC(2)+PC(2)*(0.015),['\theta ' num2str(resAngle,6)]);
%set(gca,'YDir','reverse');

%display(['res angle =' num2str(resAngle,8)]);
%text(10,10,'Press on the image to continue');
%waitforbuttonpress;
%close;