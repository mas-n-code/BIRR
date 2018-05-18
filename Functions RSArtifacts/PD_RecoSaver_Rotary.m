function [errorSet]=PD_RecoSaver_Rotary(errorSet,SetName,RecSettings)
%P1-SAE 
supershort=[SetName,' 1-25deg '];

[errorSet.E1.SCAN]=...
    monofun_mario_cmS(errorSet.E1.ref,errorSet.E1.data,RecSettings,supershort);

%{
supershort=[SetName,' 3deg '];

[errorSet.E2.SCAN]=...
    monofun_mario_cmS(errorSet.E2.ref,errorSet.E2.data,RecSettings,supershort);

supershort=[SetName,' 5deg '];

[errorSet.E4.SCAN]=...
    monofun_mario_cmS(errorSet.E4.ref,errorSet.E4.data,RecSettings,supershort);

supershort=[SetName,' 15deg '];

[errorSet.E12.SCAN]=...
    monofun_mario_cmS(errorSet.E12.ref,errorSet.E12.data,RecSettings,supershort);

%}