%Tester SVD
close all; 
clearvars BMR_SVD Params
 %{
cd('C:\Users\El Mario\Documents\DopboxMyAcount\Dropbox\ResearchMagic\RandomProyects\160110 12 Effects of AR\12_0 Prelude calculate SNR\12_0a\SampletumorData')
Ref_files = dir('**Mono*[A]***.txt');
TumorFibro_files=dir('*Mono*[C]***.txt');
Tumor_files = dir('**Mono*[B]***.txt');


ref=load(Ref_files(1).name);
data=load(TumorFibro_files(1).name);
setTumor=load(Tumor_files(1).name);

setB_fold72=SampleRaw(4,setB);
%}


dataset=data_reader_daniel(setB_fold72);

l_size=72;

d_points=1001; % Number of frequency/time points
fl_low=1e9;
fl_high=8e9;
 % determine the supperior window limit 9 soo 10 to 15  tend to be are the best accoring to 
 % determine the inferior window limit 21
%---------For Rec Full Com-----
Loss1= 1.4; %Loss factor of Glycerine 1.4
Surbin= 6; %Location of the surface (bin)
diameter=2; %Diameter of phantom?


speed=2.7e8; %diegospeed 2.7e8
radius=0.285; %DiegoRadius 0.285


Params.freqvals=linspace(fl_low,fl_high,d_points);
Params.angles=linspace(0,2*pi,l_size);
Params.radius=radius; %radius! may need to change in the fute!
Params.speed=speed;
Params.L1= Loss1;%Loss factor in breast medium
Params.surbin= Surbin;%
Params.diameter=diameter;

BMR_SVD = BMR_SVD(dataset,[3 20],Params);
imafin_abs=abs(BMR_SVD.ima).^2;


figure('name','Reconstruction');

ColorSet = varycolor(50);
set(gca, 'ColorOrder', ColorSet);


imagesc(BMR_SVD.vector,BMR_SVD.vector,imafin_abs); % creates the graph we know and love (x,y,image,clims)
axis([-0.8 0.8 -0.8 0.8])