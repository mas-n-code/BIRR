% Com communication Sensor
% Will comuncate witht the wenglor sensor and detect version and measure
% one distance and perhaps blind diego a bit more
% Mario Solis V0.1 April 21

% Functional test: April 21
% +V: White; -V: Black 
% Feed using 25V power supply\
% 
% Range: Error or contaminatioun output 0-5cm \\ and 35cm to inf = 5cm - 35cm
% c 

%% 
instrfind


%% Define port and communication 
s = serial('COM1');
s.Baudrate=38400;
s.StopBits=1;
%s.Terminator='.'; %This might be wrong
s.Parity='none';
s.FlowControl='none';

%% Open the port
fopen(s)
s.Status

%Read adata continously 
%s.ReadAsyncMode='continuous';

%% Request version
fprintf(s, '/000V49.');
pause(0.5);
 
s.BytesAvailable

%% Request version
 

fprintf(s,'*IDN?.')
out = fscanf(s);

%%close it
fclose(s);
delete(s);
clear s