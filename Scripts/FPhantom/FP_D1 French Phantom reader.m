%% FP Script Day 1
close all; clear all;

Ref_files  = dir('**Mono*[A]***.txt');
Tumor_files=dir('*Mono*[B]***.txt');
Complete_files=dir('*Mono*[C]***.txt');
Fibro_files=dir('*Mono*[D]***.txt');

setA=load(Ref_files(3).name);
setB=load(Tumor_files(1).name);
%setB=load(Complete_files(1).name);
%setB=load(Fibro_files(1).name);

w_sup=10; % window at 10
w_inf=15; %window at 15
speed=2.7e8; %diegospeed 2.7e8
radius=0.285; %DiegoRadius 0.285
ver=101;
Arrasize=size(setA,2)/2;
win=1;
counterWise=0;

supershort='B-A Tumor and Fat  Ref 2';

wflip=0;
if (counterWise==0);
    wflip=1;
end

 
[max_rec,maxRaw_Win,maxRaw,raw_fig]=monofun_mario_cm(setA,setB,Arrasize,win,wflip,supershort,w_sup,w_inf,speed,radius,ver);

%T=table({supershort},max_rec,maxRaw_Win,maxRaw,{bname},{aname},win,w_sup,w_inf,speed,radius,ver,Arrasize);