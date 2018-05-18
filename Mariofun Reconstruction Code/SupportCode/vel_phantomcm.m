function [velocity,radious]=vel_phantomcm(phantom_r,antenna_border)
% Made by Mario Solis, Jul-27-2016,
% V 1.2
% vel_phantomcm gives an estimate of the radius and velocity to input for
% the reconstruction algorithm. It works better that Diego's  thesis I
% promise. 
% [velocity,radious]=vel_phantomcm(phantom_r,antenna_border)
% phantom_r = radius of phantom [input must be in cm]
% antenna_border = distance from antenna edge to edge of phantom [input must be in cm]
% --------------------
% Version Updates
% 1.2   - Returns radious as per D. Rodriguez thesis
%       - H_dist is no longer relevant, for horn antennas the waves are
%       propagated from the edge of the antenna. 
phantom_r=phantom_r/100;
antenna_border=antenna_border/100;

v_air=3e8;
Er_Glycerine=7.29;  %[1]
v_gly=v_air/sqrt(Er_Glycerine); %  %v_air/1.473; % refractive index glycerine 1.473
H_dist=.11; % I dont thik the waves propagate from the feed anymore A-Info distance

% air_d= antenna_border; % (antenna_border)+H_dist; Distance the waves propagate in air
air_d=(antenna_border)+H_dist;
tot_d=(air_d+phantom_r); % 

velocity = v_air*(air_d/tot_d)+v_gly*(phantom_r/tot_d);

% x = tot_d;
x = tot_d-H_dist;
r_delay_diegus=0.97*x+0.148; % Based on Diego thesis.Page 31

radious= tot_d + 0.0526; % output for radious is the distance from the center + electric delay based on my experience
disp(['Reconstruction radius should be ', num2str(tot_d*100), 'cm +  5.25 cm dealay I calculated.'])
disp([ 'Alternative= ', num2str(r_delay_diegus*100,3), ' See D. Rodriguez thesis']) 
disp(' ') 
disp(['Vel Phantom is  ',num2str(velocity,3),'m/s']) 
% References:
% [1] Flores-Tapia, D., Maizlish, O., Alabaster, C. and Pistorius, S., 2012, May. Microwave radar imaging of inhomogeneous breast phantoms using circular holography. In Biomedical Imaging (ISBI), 2012 9th IEEE International Symposium on (pp. 86-89). IEEE