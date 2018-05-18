function [xc,yc,theta]=thetagen(R,Npoints)
% theta=linspace(0,2*pi,Npoints);
theta=linspace(0,2*pi,Npoints);
xc=cos(theta).*R;
yc=sin(theta).*R;




