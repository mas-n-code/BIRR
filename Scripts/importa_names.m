clearvars supershort
ctrlchar=14;
ctrlchar2=14;

counterWise=1; %<-----------

close all;
tic

if (counterWise)
    dire='aW';
else
    dire='oC';
end

%Ref = dir(['*ml0p1[A]**' '****l72*.txt']);
%Data= dir(['*ml0p1[B]**' '****l72*.txt']);

Ref = dir(['M***P1*[A]***' dire '*****.txt']);
Data= dir(['M***P1*[C]***' dire '*****.txt']);


setA =load(Ref(1).name);
setB=load(Data(1).name);

bname=Data(1).name;
bname=bname(6:(end-5));

aname=Ref(1).name;
aname=aname(6:(end-5));

supershort=([aname(1:ctrlchar) ' with ' bname(1:ctrlchar2) ' C' dire(2)]);
display(supershort);

clearvars Ref Data  Arrasize w_sup w_inf speed radius ver window win ctrlchar dire