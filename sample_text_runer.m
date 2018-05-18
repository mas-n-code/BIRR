% sample_text_runer.m
%--------------------------------------------------
% Version 2.0.0
% Created by Mario Solis N [M]
% Date =Today()
% This script reconstructs up to 4 datasets and stores common values on 

%--------------------------------------------------
% Revision changes
%--------------------------------------------------


close all;
clearvars Tnew;
tic;
n=1; %wher do we start in the table
start=n;

cuantos=2;

write=0;
filename =['','.xlsx'];

w_sup=11;
w_inf=15;
speed=2.7e8; %diegospeed
radius=0.285; %DiegoRadius
ver=101;
%--------------------------------------------------

% 1st Element [{Typically CW}
%--------------------------------------------------

structMT(n,1).graphname='Pos X Wind(Tumor) CW 8 No Flip';


structMT(n,1).Ref='Mono__WTB__REF_HalfPos2__cWz0_a2090k_l72__10_25_2015_638';     %<-REF A0w(0)
 References(n,1).R=Mono__WTB__REF_HalfPos2__cWz0_a2090k_l72__10_25_2015_638;
 
structMT(n,1).Data='Mono__WTB_TumorPos_X___cWz0_a2090k_l72__10_25_2015_1114';       %<-DATA B0w(0)
       Datas(n,1).D=Mono__WTB_TumorPos_X___cWz0_a2090k_l72__10_25_2015_1114;

structMT(n,1).window=1;
structMT(n,1).locations=72;
structMT(n,1).flip=0;       

%--------------------------------------------------

% 2th Element {Typically CC}
%--------------------------------------------------

if (cuantos>=2)
n=n+1;

structMT(n,1).graphname='Pos  X (Tumor) CW No Flip FullRef';

structMT(n,1).Ref='Mono__WTB_Full_Ref___cWz0_a2090k_l72__10_25_2015_1025';     %<-REF A0w(0)
 References(n,1).R=Mono__WTB_Full_Ref___cWz0_a2090k_l72__10_25_2015_1025;
 
structMT(n,1).Data='Mono__WTB_TumorPos_X___cWz0_a2090k_l72__10_25_2015_1114';       %<-DATA B0w(0)
       Datas(n,1).D=Mono__WTB_TumorPos_X___cWz0_a2090k_l72__10_25_2015_1114;


structMT(n,1).window=1;
structMT(n,1).locations=72;
structMT(n,1).flip=0;

end
%--------------------------------------------------

% 3th Element
%--------------------------------------------------
if (cuantos>=3)
n=n+1;

structMT(n,1).graphname='Pos T2 (Tumor) CW';

structMT(n,1).Ref='Mono__WTB__REF_HalfPos2__cWz0_a2090k_l72__10_25_2015_638';     %<-REF A0w(0)
 References(n,1).R=Mono__WTB__REF_HalfPos2__cWz0_a2090k_l72__10_25_2015_638;
 
structMT(n,1).Data='Mono__WTB_TPos2__cWz0_a2090k_l72__10_25_2015_606';       %<-DATA B0w(0)
       Datas(n,1).D=Mono__WTB_TPos2__cWz0_a2090k_l72__10_25_2015_606;

structMT(n,1).window=1;
structMT(n,1).locations=72;
structMT(n,1).flip=0;
 

end
%--------------------------------------------------

% 4th Element
%--------------------------------------------------
if (cuantos>=4)
n=n+1;

structMT(n,1).graphname='Pos T2 (Tumor) CC';

structMT(n,1).Ref='Mono__WTB__REF_HalfPos2__cCz1_a2090k_l72__10_25_2015_642';     %<-REF A0w(0)
 References(n,1).R=Mono__WTB__REF_HalfPos2__cCz1_a2090k_l72__10_25_2015_642;
 
structMT(n,1).Data='Mono__WTB_TPos2__cCz1_a2090k_l72__10_25_2015_610';       %<-DATA B0w(0)
       Datas(n,1).D=Mono__WTB_TPos2__cCz1_a2090k_l72__10_25_2015_610;
       

structMT(n,1).locations=72;
structMT(n,1).flip=0;
structMT(n,1).window=1; 
       
end
%--------------------------------------------------

% Evaluation Tool
%--------------------------------------------------

for i=start:(start+cuantos-1)
structMT(i,1).w_sup=w_sup;
structMT(i,1).w_inf=w_inf;
structMT(i,1).ver=ver;
structMT(i,1).speed=speed;
structMT(i,1).radius=radius;
[structMT(i,1).MaxRec,structMT(i,1).MaxRaw] =monofun_mario_cm(References(i,1).R,Datas(i,1).D,structMT(i,1).locations,structMT(i,1).window,structMT(i,1).flip,structMT(i,1).graphname,w_sup,w_inf,speed,radius,ver);




end

Tnew = [struct2table(structMT)];
aaTlog=[aaTlog;Tnew];

if (write==1) 
    writetable(Tnew,filename,'Sheet',1,'Range','A1')
end


toc;
clearvars  write filename start cuantos cauntospares i Datas References structMT;
clearvars w_inf w_sup n speed radius;


% 
% 
% 
% Ref2.name='Mono_REF_TargetsUP_144_72_144__Z_0___10_24_2015_147';
% Ref2.value=Mono_REF_TargetsUP_144_72_144__Z_0___10_24_2015_147;
% 
% Data2.name='Mono_REF_TargetsUP_144_72_144__Z_0___10_24_2015_147';
% Data2.value=Mono_REF_TargetsUP_144_72_144__Z_0___10_24_2015_147;
% 
% graphname1='A0 vs Bo';
% i2max=monofun_mario_cm(,,144,1,0,'L_1_0 Tumor B_0 P1 A_0P_2 CC|Gly|');
% i2max=monofun_mario_cm(,,144,1,0,'L_1_0 Tumor B_0 P1 A_0P_2 CC|Gly|');
% structMT(2,1). = 'A';
% structMT(2,1).Data = 'B';
% structMT(2,1).MAx = 45;
% % 
% Tnew = [struct2table(structMT)];
% size(Tnew)
% 
% filename = 'evaluate144v72.xlsx';
% writetable(Tnew,filename,'Sheet',1,'Range','A1')



%monofun_mario_cm(Mono_AC_72L_Ref_Air__2cm__Freq_9_22_2015_325,Mono_AD_72L_HRod_Data_Air__2cm__Freq_9_22_2015_402,72,0,1,'H-Rod - Z-2cm |Air|AC/AD');
%monofun_mario_cm(,,72,0,1,'Move VNA CC | E2E/E2D');
%monofun_mario_cm(,,72,0,1,'Move VNA CW | E2E/E2D');
%monofun_mario_cm(,,72,0,0,'Move VNA CC | E2E/E2D');
