function [fullQangle,cRadius]=angleCatcher(initialCx,initialCy,xcenter,ycenter);


adS=initialCy-ycenter;
opS=initialCx-xcenter;
fullQangle=atan2d(adS,opS);
cRadius=hypot(adS,opS);

% 
% cropTheta=atan(adS/opS)*180/pi(); %Sah cota, this inverts the x and y axis
% cropR2=hypot(adS,opS); %%under test
% 
% deltax=floor(cropR2*cos(cropTheta*pi()/180));
%     
% deltay=floor(cropR2*sin(cropTheta*pi()/180));
%     
% % currx=ceil(xcenter+deltax);
% % curry=ceil(ycenter+deltay);
% % cropPos= [currx-sizCrop/2,curry-sizCrop/2,sizCrop,sizCrop];
% % rectangle('Position', cropPos)
% % angleOnI=cropTheta;
% % hold on
% % plot(xcenter,ycenter,'x');
% % plot([xcenter xcenter+deltax],[ycenter ycenter+deltay]);
% % axis equal;
% % 
% % figure(); hold on;
% % plot(xcenter,ycenter,'x');
% % plot([xcenter xcenter+deltax],[ycenter ycenter+deltay]);
% % plot(initialCx,initialCy,'+');
% % set(gca,'YDir','reverse');
% % axis equal;
% % rectangle('Position', cropPos)
% close all;
% figure(); hold on;
% plot(0,0,'x');
% plot([0 0+deltax],[0 0+deltay]);
% axis equal;
% xlim([-1000 1000]);
% ylim([-1000 1000]);
% text(0+100,0,['\theta ' num2str(cropTheta)]);
% %set(gca,'YDir','reverse');
% 
% 
% fullQangle=atan2d(adS,opS);
% plot(opS,adS,'o');
% 
% cropR2=hypot(adS,opS); %%under test
% 
% deltaQx=floor(cropR2*cos(fullQangle*pi()/180));
%     
% deltaQy=floor(cropR2*sin(fullQangle*pi()/180));
% plot([0 0+deltaQx],[0 0+deltaQy],'-.','LineWidth',1.2);
% 
% text(0-200,0-200,['\theta Q ' num2str(fullQangle)]);
% 
% currx=ceil(0+deltaQx);
% curry=ceil(0+deltaQy);
% cropPos= [currx-sizCrop/2,curry-sizCrop/2,sizCrop,sizCrop];
% rectangle('Position', cropPos)
