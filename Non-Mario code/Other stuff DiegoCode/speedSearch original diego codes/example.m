%example file
Raw_data=importdata('D:\Diego\Dropbox\myDcouments\Matlab code\dataset\DiegoTest\sep6\gly\Mono_AA_(0cm)_Freq_9_6_2015_348.txt');
Ref=importdata('D:\Diego\Dropbox\myDcouments\Matlab code\dataset\DiegoTest\sep6\gly\Mono_refAA_(0cm)_Freq_9_6_2015_357.txt');
s11=data_reader(Raw_data)-data_reader(Ref);
[range,res,speed]=find_speed(downSample(fft(s11),72),[],0.24,1.5e8,3e8,100,[1e9 8e9],145,15);
PlotSearchResult(range,res);
