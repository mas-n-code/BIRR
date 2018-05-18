function circulo=circleCatcher(I,Crange,circletag)
%% circleCatcher
% 
%provides the coordinates of a single circle with radius cropRange of the
% form [min max]. Interactively requests for a croped region
%
% Struct_circle = circleCatcher(Image,cropRange,circleTag) 

%%
cclip=Crange(2)*8;
if (Crange(2)>50)
    cclip=400;
end

circulo.tag=circletag;
figure(1);
%imshow(I,'InitialMagnification',17); hold on;
h=imrect(gca,[40 40 cclip cclip]);
Irect =ceil(wait(h));
Ic=imcrop(I,(Irect));
[cCord, cRad ,cStrg] = imfindcircles(Ic,Crange,'Sensitivity',0.88,'ObjectPolarity','dark'); %IcO,[10 20],'Sensitivity',0.88)
figure(99); imshow(Ic);hold on; viscircles(cCord,cRad);
circulo.x=cCord(1,1)+Irect(1)-1;
circulo.y=cCord(1,2)+Irect(2)-1;
circulo.rad=cRad(1);
circulo.str=cStrg(1);

viscircles([circulo.x,circulo.y],circulo.rad,'LineStyle',':');
plot(circulo.x,circulo.y,'x','Color','r');
waitforbuttonpress
%close(fgh);
close;