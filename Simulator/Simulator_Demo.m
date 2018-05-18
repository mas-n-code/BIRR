%Dataset at 6cm
[BSCAN,f,dd,Mu,dR,theta]=cylscan2Dmulti(0,6,601,1,1,.175,73,.06,0,50);
[Profile1,Profile2]=Profile_extractor(BSCAN,63);
[ BSCAN2 ] = data_former( zeros(601,73), Profile2,2*pi-0.6025);

df=6e9/601;
f2=df:df:df*601;
Params6.dataset=BSCAN2;
Params6.freqvals=f2;
Params6.speed=3e8;
Params6.angles=theta;
Params6.radius=.175;

%Dataset at 5cm
[BSCAN,f,dd,Mu,dR,theta]=cylscan2Dmulti(0,6,601,1,1,.175,73,.05,0,50);
[Profile1,Profile2]=Profile_extractor(BSCAN,63);
[ BSCAN2 ] = data_former( zeros(601,73), Profile2,2*pi-0.6025);

Params5.dataset=BSCAN2;
Params5.freqvals=f2;
Params5.speed=3e8;
Params5.angles=theta;
Params5.radius=.175;

%Dataset at 4cm
[BSCAN,f,dd,Mu,dR,theta]=cylscan2Dmulti(0,6,601,1,1,.175,73,.04,0,50);
[Profile1,Profile2]=Profile_extractor(BSCAN,63);
[ BSCAN2 ] = data_former( zeros(601,73), Profile2,2*pi-0.6025);

Params4.dataset=BSCAN2;
Params4.freqvals=f2;
Params4.speed=3e8;
Params4.angles=theta;
Params4.radius=.175;

%Dataset at 2.5cm
[BSCAN,f,dd,Mu,dR,theta]=cylscan2Dmulti(0,6,601,1,1,.175,73,.025,0,50);
[Profile1,Profile2]=Profile_extractor(BSCAN,63);
[ BSCAN2 ] = data_former( zeros(601,73), Profile2,2*pi-0.6025);

Params25.dataset=BSCAN2;
Params25.freqvals=f2;
Params25.speed=3e8;
Params25.angles=theta;
Params25.radius=.175;

