function [dd,phi]=distcyl2D(Num,x,y,xc,yc,theta)
%measures distance and angle from antenna to target: for data compiling
%only
k=length(theta); K=1:k;
dd=zeros(Num,k);
%magnitude_xy=zeros(1,k);
phi=zeros(Num,k);
rad=sqrt(xc(1).^2+yc(1).^2);


    for i=1:Num;
        
        dd(i,K)=sqrt((x(i)-xc(K)).^2+(y(i)-yc(K)).^2);
        
        x_difference_vector=-(x(i)-xc(K));
        y_difference_vector=-(y(i)-yc(K));
        magnitude_xy=sqrt((x(i)-xc(K)).^2+(y(i)-yc(K)).^2);
        
        abs_angle=acos((x_difference_vector.*xc(K)+y_difference_vector.*yc(K))./(magnitude_xy.*rad));
        phi(i,K)=abs_angle.*sign(x_difference_vector).*sign(y_difference_vector);
        
      
        
    end

