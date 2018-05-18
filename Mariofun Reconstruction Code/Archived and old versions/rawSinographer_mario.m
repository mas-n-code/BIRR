function [Theta_deg,time_response,Dq,UDq]=rawSinographer_mario(q_xy,phantom_r_cm,antenna_border_cm,positions_antenna,vel_medium)
% Made by Mario Solis, Jul-27-2016,
% V 1.0
% rawSinographer_mario returns a sinogram for a target 'q' position 'q_xy'
% Note that the Sinogram plots in "reverse" pi direction since the stage
% moves from 2pi to 

r_q=rssq(q_xy);
ang_q=atan2(q_xy(2),q_xy(1));
Theta=0:(2*pi/positions_antenna):2*pi; % I probably have to change to 2*p1 - 1 or something 
Theta=fliplr(Theta); % Flip the array because the antenna GOES IN REVERSE for CW rotation
R=(phantom_r_cm+antenna_border_cm);


Dq= sqrt(R^2 + r_q^2 - 2*(R*r_q)*cos(Theta-ang_q));


time_response=2*(Dq/100)/vel_medium;

UDq=(time_response)*(vel_medium/(7E9*2))*100; % resolution of the sistem;
Theta_deg=fliplr(Theta*360/(2*pi()));
% --------------------
% Version Updates

% References:
% [1] %[1] D. Rodriguez Herrera, “Antenna Characterisation and Optimal Sampling Constraints for Breast Microwave Imaging Systems with a Novel Wave Speed Propagation Algorithm"
% ,” Univesity of Manitoba, 2016.


% 