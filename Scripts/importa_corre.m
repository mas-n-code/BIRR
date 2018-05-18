%% Importa_corre
% INTRODUCTORY TEXT



%% Importa_names
% DESCRIPTIVE TEXT

% clearvars supershort
% ctrlchar=10;
% close all;
% tic
% Ref = dir('**[A]***aW****942*.txt');
% Data= dir('**[C]***aW*1202*.txt');
% 
% 
% setA =load(Ref(1).name);
% setB=load(Data(1).name);
% 
% bname=Data(1).name;
% bname=bname(1:(end-5));
% 
% aname=Ref(1).name;
% aname=aname(1:(end-5));
% 
% supershort=([aname(1:ctrlchar) ' with ' bname(1:ctrlchar) ' CW']);
% display(supershort);
%%
%atant=T;

w_sup=10; % window at 10
w_inf=15; %window at 15
speed=2.7e8; %diegospeed 2.7e8
radius=0.285; %DiegoRadius 0.285
ver=101;
Arrasize=size(setA,2)/2;
win=1;


wflip=0;
if (counterWise==0);
    wflip=1;
end

 
[max_rec,maxRaw_Win,maxRaw,raw_fig]=monofun_mario_cm(setA,setB,Arrasize,win,wflip,supershort,w_sup,w_inf,speed,radius,ver);

T=table({supershort},max_rec,maxRaw_Win,maxRaw,{bname},{aname},win,w_sup,w_inf,speed,radius,ver,Arrasize);

T.Properties.VariableNames{1} = 'shortName';
T.Properties.VariableNames{5} = 'DataName';
T.Properties.VariableNames{6} = 'RefName';

save([supershort '_raw'],'raw_fig');

writetable(T,['Table_' supershort '.txt'])

toc
clearvars Ref Data   Arrasize w_sup w_inf speed radius ver window win   
clearvars max_rec maxRaw_Win maxRaw raw_fig wflip
savethisone;