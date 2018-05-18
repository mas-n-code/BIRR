

%close all;

%[A1_averageSig,A2_averageBg,A3area,A4vSig,A5Vbg,A6ClutNum,A7SNR]=ImageMetrics(imafin_z,zm,max_value/2);
%tablita=repmat(999,8,8);

zoom_factor=0;
flip_i=1;
window_i=0;
i=1;

%----%
Datea=Mono_AA_Ref_Cal__0cm__Freq_2_9_2015_1105;
Refa=Mono_AB_1Target1oClock__0cm__Freq_2_9_2015_1123;
titulo='';
num_antennas=72;
%----%

[raw_i,imafin_z_1,max_value(i)] = monofun_mario_cm(Refa,Datea,num_antennas,window_i,flip_i,titulo);
[AverageSignal(i),AverageBackground(i),Area,VarianceSignal(i),VarianceBackground(i),ClutterNumber(i),SCR(i)]=ImageMetrics(imafin_z_1,zoom_factor,max_value(i)/2,flip_i);
ScriptTable=table(max_value,AverageSignal,AverageBackground,Area,VarianceSignal,VarianceBackground,ClutterNumber,SCR);


clearvars i Area AverageBackground AverageSignal i ClutterNumber imafin_z_1 max_value raw_i SCR VarianceBackground VarianceSignal zoom_factor;
clearvars flip_i ans window_i Refa num_antennas titulo

ScriptTable

%[raw,imafin_z_2,max_value(2)] = monofun_mario(AA__RefD__Air__1,AD__Vol5__1,36,1,0,0);
%[raw,imafin_z_3,max_value(3)] = monofun_mario(AA__RefD__Air__2,AD__Vol5__2,36,1,0,0);
%[raw,imafin_z_4,max_value(4)] = monofun_mario(AA__RefD__Air__3,AD__Vol5__3,36,1,0,0);




%TablaNames={'averageSig','averageBg','area','vSig','Vbg','ClutNum','SNR'};

%t1='averageSig',t2='averageBg',t3='area',t4='vSig',t5='Vbg',t6='ClutNum',t7='SNR';

% 
% lx=2;
% [tablita(lx,2),tablita(lx,3),tablita(lx,4),tablita(lx,5),tablita(lx,6),tablita(lx,7),tablita(lx,8)]=ImageMetrics(imafin_z_2,zm,max_value(lx)/2);
% tablita(lx,1)=max_value(lx);
% 
% lx=3;
% [tablita(lx,2),tablita(lx,3),tablita(lx,4),tablita(lx,5),tablita(lx,6),tablita(lx,7),tablita(lx,8)]=ImageMetrics(imafin_z_3,zm,max_value(lx)/2);
% tablita(lx,1)=max_value(lx);
% 
% 
% lx=4;
% [tablita(lx,2),tablita(lx,3),tablita(lx,4),tablita(lx,5),tablita(lx,6),tablita(lx,7),tablita(lx,8)]=ImageMetrics(imafin_z_4,zm,max_value(lx)/2);
% tablita(lx,1)=max_value(lx);

