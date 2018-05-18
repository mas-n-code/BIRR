
%SCR
clc
clearvars;

Bmean=25.906; 
Bsd=0.364;



cSCRmean =27.5893; 
cSCRsd=0.3153;
N = 3;
v = 2*N-2;
tval = (cSCRmean-Bmean) / sqrt((cSCRsd^2+Bsd^2)/N);       % Calculate T-Statistic
tdist2T = @(t,v) (1-betainc(v/(v+t^2),v/2,0.5));    % 2-tailed t-distribution
tdist1T = @(t,v) 1-(1-tdist2T(t,v))/2;              % 1-tailed t-distribution
tprob = 1-[tdist2T(tval,v)  tdist1T(tval,v)];

pwr2 = sampsizepwr('t2',[Bmean cSCRmean],max(Bsd,cSCRsd),[],N,'Ratio',1);
pwr1 = sampsizepwr('t2',[Bmean cSCRmean],max(Bsd,cSCRsd),[],N,'Ratio',1,'tail','right');
tprob
disp(['1 tail p-value= ',num2str(tprob(2),4),' pwer= ',num2str(pwr1,4)]);
disp(['2 tail p-value= ',num2str(tprob(1),4),' pwer= ',num2str(pwr2,4)]);


%cCR
clearvars; clc;
Bmean=22.1653;
Bsd=0.5848;

cCCRmean =24.0057; 
cCCRsd=0.4449;
N = 3;
v = 2*N-2;
tval = (cCCRmean-Bmean) / sqrt((cCCRsd^2+Bsd^2)/N);       % Calculate T-Statistic
tdist2T = @(t,v) (1-betainc(v/(v+t^2),v/2,0.5));    % 2-tailed t-distribution
tdist1T = @(t,v) 1-(1-tdist2T(t,v))/2;              % 1-tailed t-distribution
tprob = 1-[tdist2T(tval,v)  tdist1T(tval,v)];

pwr2 = sampsizepwr('t2',[Bmean cCCRmean],max(Bsd,cCCRsd),[],N,'Ratio',1);
pwr1 = sampsizepwr('t2',[Bmean cCCRmean],max(Bsd,cCCRsd),[],N,'Ratio',1,'tail','right');

disp(['1 tail p-value= ',num2str(tprob(2),4),' pwer= ',num2str(pwr1,4)]);
disp(['2 tail p-value= ',num2str(tprob(1),4),' pwer= ',num2str(pwr2,4)]);

%TFR 
clearvars;
Bmean=
Bsd=

cTFRmean =2.5425; 
cTFRsd=0.4607;
N = 3;
v = 2*N-2;
tval = (cTFRmean-Bmean) / sqrt((cTFRsd^2+Bsd^2)/N);       % Calculate T-Statistic
tdist2T = @(t,v) (1-betainc(v/(v+t^2),v/2,0.5));    % 2-tailed t-distribution
tdist1T = @(t,v) 1-(1-tdist2T(t,v))/2;              % 1-tailed t-distribution
tprob = 1-[tdist2T(tval,v)  tdist1T(tval,v)]


