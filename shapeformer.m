function shapeformer(locations,distances)
close all;
distances=distances';
angi=(2*pi/locations);
theta = 0:angi:2*pi;
%rho = sin(2*angi).*cos(2*angi);

%polar(theta,rho,'--r')
%hold
figure('Color',[1 1 1]);
%set(gca,'Color',[0.8 0.8 0.8]);
polar(theta,distances,'r');
myaa('publish');
