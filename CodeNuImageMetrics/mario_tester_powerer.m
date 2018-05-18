mu=11; %control mean
alpha=0.05;
sd=2.3;
ZetaCrit=1.645;
nn=100;
NuMu=11.5; %new mean

se=(sd/(nn)^0.5);

b=mu+ZetaCrit*se; %-> B is actual the control mean and to this you add the 95 ci


z=(b-NuMu)/se;

Power=zscore(z);

tinv(z,nn);