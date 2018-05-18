function circulitoConstructor    

    deltax=floor(cropR2*cos(cropTheta*pi()/180));
    deltay=floor(cropR2*sin(cropTheta*pi()/180));
    cropx=ceil(xcenter+deltax);
    cropy=ceil(ycenter+deltay);
    cropPos= [cropx-sizCrop/2,cropy-sizCrop/2,sizCrop,sizCrop];
    figure(1)
    rectangle('Position', cropPos)
    %figure(i+1);
    IcO= imcrop(I,cropPos);
    
    imshow(IcO,'InitialMagnification',100); hold all; 
    [centersDark, radiiDark ,circleStrength] = imfindcircles(IcO,cRange,'Sensitivity',0.88,'ObjectPolarity','dark'); %IcO,[10 20],'Sensitivity',0.88)
    viscircles([centersDark],radiiDark,'LineStyle',':');
    loscircles(i).x=centersDark(1)+cropPos(1)-1;
    loscircles(i).y=centersDark(2)+cropPos(2)-1;
    loscircles(i).rad=radiiDark;
    loscircles(i).str=circleStrength;
    
    
    loscircles(i).centerValue=Ig(round(xcenter),round(ycenter));
    loscircles(i).absAngle=angleCatcher(loscircles(i).x,loscircles(i).y,xcenter,ycenter);
    loscircles(i).relativeAngle=angleFinder([loscircles(i).x,loscircles(i).y],[loscircles(1).x,loscircles(1).y],[xcenter,ycenter]);
    if i==1;
        loscircles(i).relativeAngleInc=0;
        else
        loscircles(i).relativeAngleInc=angleFinder([loscircles(i).x,loscircles(i).y],[loscircles(i-1).x,loscircles(i-1).y],[xcenter,ycenter]);
    end
    loscircles(i).image=pdir(i).name;
    %pause(.3)
    %close;
    