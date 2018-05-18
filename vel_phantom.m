function [velocity]=vel_phantom(phantom_r,antenna_border)

v_air=3e8;
v_gly=1e8;
H_dist=.095;

air_d=(antenna_border/100)+H_dist;
tot_d=(air_d+phantom_r);

velocity = v_air*(air_d/tot_d)+v_gly*(phantom_r/tot_d);