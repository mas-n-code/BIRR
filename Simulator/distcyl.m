function [dd,phi,phi2,phi3]=distcyl(Num,x,z,y,xc,zc,yc,theta);
%measures distance and angle from antenna to target: for data compiling
%only
k=length(theta); K=1:k;
dd=zeros(Num,k);
phi=zeros(Num,k);
i=1:Num;
for n=1:length(yc)
    for i=1:Num;
        dd(n,i,K)=sqrt((x(i)-xc(K)).^2+(z(i)-zc(K)).^2+(y(i)-yc(n)).^2);
            if x(i)==0
                phi(n,i,K)=pi/2-theta(K);
            else
             phi(n,i,K)=atan2(z(i),x(i))-theta(K);
             end
           if (y(i)-yc(n))==0
                phi2(n,i,K)=0;
            else
             phi2(n,i,K)=atan(sqrt((x(i)-xc(K)).^2+(z(i)-zc(K)).^2)/(y(i)-yc(n)));
           end
            phi3(n,i,K)=asin((y(i)-yc(n))./dd(n,i,K));
    end
end