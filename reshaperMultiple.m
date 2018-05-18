locations=71;
laser_dist=303';
d1=Distances_AA_ABSPhantom_Rep__0cm__Freq_8_4_2015_622;
d2=flipud(Distances_AA_ABSPhantom_Rep__1cm__Freq_8_4_2015_627);
d3=Distances_AA_ABSPhantom_Rep__2cm__Freq_8_4_2015_632;
d4=flipud(Distances_AA_ABSPhantom_Rep__3cm__Freq_8_4_2015_637);

distances1=laser_dist - d1';
%distances2= laser_dist - flipud(Distances_11__1cm__Freq_7_17_2015_647)';
distances2= laser_dist - d2';
distances3= laser_dist - d3';
distances4= laser_dist - d4';

t = 0 : .01 : 2 * pi;
P = polar(t, 55 * ones(size(t)));
set(P, 'Visible', 'off')
hold on


angi=(2*pi/locations);
theta = 0:angi:2*pi;

close all;
figure('Color',[1 1 1]);


h1= polar(theta,distances1,'m');
set(h1,'linewidth',2)
hold on
h2= polar(theta,distances2,'k');
set(h2,'linewidth',2)
hold on
h3= polar(theta,distances3,'--g');
set(h3,'linewidth',2)
h4= polar(theta,distances4,'--r');
set(h4,'linewidth',2)

legend('Rep1','Rep2','Rep3','Rep4','Location','southwest');

%myaa('publish');