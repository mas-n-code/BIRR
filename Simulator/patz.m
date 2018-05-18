%Antenna field pattern
function [field]=patz(W);
% field=100*cos(W+pi/4).^2;
field=10*cos(W);
% field=1;
% field=1;
% field=abs(sinc(W));
