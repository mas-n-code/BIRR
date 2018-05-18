

close all;
r_data_0=data_reader_daniel(Mono_1Sweep_From220to180__0cm__Freq_7_21_2015_346);
r_data_1=data_reader_daniel(Mono_1Sweep_From220to180__1cm__Freq_7_21_2015_346);
r_data_2=data_reader_daniel(Mono_1Sweep_From220to180__2cm__Freq_7_21_2015_346);
r_data_3=data_reader_daniel(Mono_1Sweep_From220to180__3cm__Freq_7_21_2015_346);
r_data_4=data_reader_daniel(Mono_1Sweep_From220to180__4cm__Freq_7_21_2015_346);
r_data_5=data_reader_daniel(Mono_1Sweep_From220to180__5cm__Freq_7_21_2015_346);
r_data_6=data_reader_daniel(Mono_1Sweep_From220to180__6cm__Freq_7_21_2015_346);

plot(abs(r_data_0).^2,'--r'); hold on;
plot(abs(r_data_1).^2);
plot(abs(r_data_2).^2,':y');

ARA(:,1)=abs(r_data_0-r_data_1).^2;
ARA(:,2)=(abs(r_data_0-r_data_2).^2);
ARA(:,3)=(abs(r_data_0-r_data_3).^2);
ARA(:,4)=(abs(r_data_0-r_data_4).^2);
ARA(:,5)=(abs(r_data_0-r_data_5).^2);
ARA(:,6)=(abs(r_data_0-r_data_6).^2);


figure;plot(ARA);
