function [dd,phi]=distcyl3d(Num,zsteps,x,y,z,xc,yc,zc,theta,zdis);
%measures distance and angle from antenna to target: for data compiling
%only

k=length(theta); K=1:k;Z=1:zsteps;
dd=zeros(Num,k,zsteps);
phi=zeros(Num,k,zsteps);

for j=1:zsteps;
    for i=1:Num;
        dd(i,K,j)=sqrt((x(i)-xc(K)).^2+(y(i)-yc(K)).^2+(z(i)-zc(j)).^2);
            if x(i)==0
                phi(i,K,j)=pi/2-theta(K);
            else
                phi(i,K,j)=atan(y(i)/x(i))-theta(K);
            end
    end
end