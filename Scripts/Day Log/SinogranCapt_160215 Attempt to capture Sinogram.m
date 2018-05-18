
%Capturing Sinogram in Raw data
%------
%
%
close all
noiseB=5.933E-6;
signalB=9.75E-4+noiseB;

figure;
imagesc(S11_Raw(1:30,:));


MS11_emptyraw=repmat(noiseB,size(S11_Raw));
figure;imagesc(MS11_emptyraw(1:30,:), [0 max(max(S11_Raw))]);
figure;
 t = [1:1:72];
 A = 3;
 f =1/72;
 y = round(A*sin(2*pi*f*t+1));
 plot(t(1:72),y(1:72))
 ylim([-15 15])
 
 MS11_Sin=MS11_emptyraw;
 for ii=1:size(S11_Raw,2)
     y = round(A*sin(2*pi*f*ii+(pi*7/6)))+11;
     MS11_Sin(y,ii)=signalB;
 end
 figure;
imagesc(MS11_Sin(1:30,:));


RecSettings.win=1; % Selects wether a window is present or not
RecSettings.w_sup=2; % window at 10
RecSettings.w_inf=30; %window at 15
RecSettings.speed=2.99e8; %diegospeed 2.7e8
RecSettings.radius=0.20; % Radious of antenna to center%DiegoRadius 0.285, 2cm are added? 
RecSettings.ver=100; % Reconstruction version of algorithm   %%%%%%
RecSettings.Iclims=[0 6.5e-5];
RecSettings.clockwise=0;

RecSettings.wflip=0;
if (RecSettings.counterWise==1);
    RecSettings.wflip=1;
end

% 2) Third Reconstruction [D3]
%%{
B_ack=MS11_emptyraw;
T_arget=MS11_Sin;
supershort='Simulated'; 

RecSettings.Arrasize=size(B_ack,2)/2;
[MRAW,MWINDOW,MREC]=...
    monofun_mario_cmS(B_ack,T_arget,RecSettings,supershort);

%}