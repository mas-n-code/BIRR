%% %Sub12_0A
%subs 12_0a Caclulate sensitivity snr and tumor to fibroglandular ratio in RAW image
% .a Load Ref and Response sets 
% .b Generate Raw image (A1 B1 and A2 B2)
% .c Calculate sensitivity (A1 to A2 in DB) and Max noise value (milly watts??)
% .d Calculate SCR (A1-B1) (ROI is half width to non half width ) (btween 3.19dB to 7dB)
% .e Calculate STR (signal to tumor ratio)

% Work pending
%> Make it a function given a ref and a dataset (sensitivity also a function)
%> Set an erosion/neighbor algorithm so that the signal is clean and free from
%artifacats


tic;close all; 
%% 12_0a.01.a Load Ref and Response sets 

% Ref_files = dir('**Mono*[A]***.txt');
% Tumor_files=dir('*Mono*[B]***.txt');
%
% 
% ref=load(Ref_files(1).name);
% data=load(Tumor_files(1).name);
% 
% ref2=load(Ref_files(2).name);
% data2=load(Tumor_files(2).name);

%>> commented to save time<<

%% 12_0a.01.b Generate Raw image

%  From monofun_mario_cm
%---Step 1: Substract Ref-----
s11_ref=data_reader_daniel(ref);%reference in time
s11_data=data_reader_daniel(data);%data in time
s11_minus_ref=s11_data-s11_ref; % s11 in time 
s11_minus_ref_freq=fft(s11_minus_ref);
abs_s11= abs(s11_minus_ref);
square_abs_s11=abs_s11.^2; %square the abs, dun no why -<<<<

raw_data_set1=square_abs_s11;


figure('name','Raw Image no Window TD','position', [100, 500, 800, 420]); 
imagesc(square_abs_s11(1:40,:)); %Crop image to fist 40 ns?
title('Raw Image no Window TD');
xlabel('Antenna Position (1 to 288)');
ylabel('Time segment (0 to 1000)');

figure('name','Raw Image no Window FD','position', [100, 500, 800, 420]); 
imagesc(abs(s11_minus_ref_freq).^2)
title('Raw Image no Window FD');
xlabel('Antenna Position (1 to 288)');
ylabel('Freq segment (0 to 1000)');

%% 12_0a.01.c Calculate sensitivity
% sensitivity antenna with movement
% an alternative aproach to what I did here would be to use stationary
% scans using a known load

s11_ref2=data_reader_daniel(ref2);%reference in time
s11_data2=data_reader_daniel(data2);%data in time

ref2_12=s11_ref2(:,12); ref_12=s11_ref(:,12); % obtain a single scan in time 
figure; hold on;
plot(abs(ref2_12))
plot(abs(ref_12))
ylabel('Amplitude');
xlabel('Time');

figure;
ref_subs_12=ref2_12-ref_12; % s11 in time 
ref_subs_12=fft(ref_subs_12); % transfor to Freq Domain

ref_subs=s11_ref2-s11_ref;
ref_subs=fft(ref_subs);

%v_s11_sensiv=abs(s11_sensiv); %%all the freq, on the 12th pos 
%v_s11_sensiv=10*log10(v_s11_sensiv);
plot(20*log10(abs(ref_subs_12)));
title(['Sensitivity calculated using two scans after physical movement of' char(10) 'the prototype  (12th Position) ']);
xlabel('Frequency Segments (1GHz - 8 Ghz)');
ylabel('Sensitivity level (dB)');
xlim([0,1000]);
ylim([-120,-40]);

figure;
plot(20*log10(abs(ref_subs)));
title(['Sensitivity calculated using two full scans after physical movement of' char(10) 'the prototype ']);
xlabel('Frequency Segments (1GHz - 8 Ghz)');
ylabel('Sensitivity level (dB)');
xlim([0,1000]);
ylim([-120,-40]);

%%RMSE
RMSE = sqrt(mean(mean(abs(ref_subs).^2)));

%% 12_0a.01.d Calculate SCR 

%Detect half maximum value in signal
max_raw=max(max(raw_data_set1));
copyR=zeros(size(raw_data_set1));
idxHV=(raw_data_set1 >= max_raw/2); %generate an index of Half Value signals

copyR(idxHV)=1;
copyR(~idxHV)=3;
figure('position', [100, 300, 800, 420]);
imagesc(copyR(1:40,:));

%Average of Half Maximum 
smeanHV=mean(mean(raw_data_set1(idxHV)));

%Std of non half maximum
sigBack=std2(raw_data_set1(~idxHV));

%ScR 
ScR=20*log10(smeanHV/sigBack);
hold on


%% 12_0a.01.e Calculate TtF

%Load C
%TumorandF_files=dir('*Mono*[C]***.txt');
%Cdata=load(TumorandF_files(1).name);
%Cdata2=load(TumorandF_files(2).name);
s11_Cdata=data_reader_daniel(Cdata);%data in time
s11_C_minus_ref=s11_Cdata-s11_ref; % s11C in time 

abs_C_s11= abs(s11_C_minus_ref);
square_C_abs_s11=abs_C_s11.^2; %square the abs, dun no why -<<<<

raw_data_C_set1=square_C_abs_s11;

tempos=square_C_abs_s11-square_abs_s11;
tempos(tempos<0)=0;

figure('name','Raw Image C no Window TD','position', [100, 200, 800, 420]); 
imagesc(square_C_abs_s11(1:40,:)); %Crop image to fist 40 ns?
title('Raw Image C no Window TD');
xlabel('Antenna Position (1 to 288)');
ylabel('Time segment (0 to 1000)');

c_max=max(max(tempos));
tempos(1:10,:)= 1.2e-9;
c_idxHV=tempos >=c_max/2;

figure('name','Raw Image C no Window TD','position', [150, 200, 800, 420]); 
imagesc((c_idxHV(1:40,:))); %Crop image to fist 40 ns?
title('Tempos');
xlabel('Antenna Position (1 to 288)');
ylabel('Time segment (0 to 1000)');

%Average of C Half Maximum
c_t_meanHV=mean(mean(square_C_abs_s11(idxHV)));
c_f_meanHV=mean(mean(square_C_abs_s11(c_idxHV)));

%C Std of non half maximum
c_sigBack=std2(square_C_abs_s11(~(idxHV+c_idxHV)));
c_meanBack=mean(mean(square_C_abs_s11(~(idxHV+c_idxHV))));

%TfR 
TfR=20*log10((c_t_meanHV/c_f_meanHV));

%CnR
CnR=10*log10(((c_t_meanHV^2)-(c_f_meanHV^2))/(c_sigBack)^2);

% Othervalues 
c_t_Max=max(max(square_C_abs_s11(idxHV)));
c_f_Max=max(max(square_C_abs_s11(c_idxHV)));
c_n_Max=max(max(square_C_abs_s11(~(idxHV+c_idxHV))));

%% Generate table 
%Based on C config
Raw_Results.TumorMax=c_t_Max;
Raw_Results.TumorMean=c_t_meanHV;
Raw_Results.NoiseStdDev=c_sigBack;
Raw_Results.NoiseMean=c_meanBack;
Raw_Results.NoiseMax=c_n_Max;
Raw_Results.FibroMax=c_f_Max;
Raw_Results.FibroMean=c_f_meanHV;
Raw_Results.ScR=ScR;
Raw_Results.TfR=TfR;
Raw_Results.CnR=CnR;

%From Daniel db_raw= 10*log10(max_value_raw/.0039811); %VNa emits 3.911mw according to Daniel or 6dB;
figure; h1=axes;hold on;
%set(h1, 'Ydir', 'reverse')


bar(1,10*log10(c_meanBack/.0039811),0.8,'b')
bar(1,10*log10(c_f_meanHV/.0039811),0.7,'c');
bar(1,10*log10(c_t_meanHV/.0039811),0.6,'r');
legend('Background Noise','Fibro-Glandular','Tumor');
toc



%% Garbage deletable 
figure;
raka=(square_C_abs_s11);
raka(~(idxHV+c_idxHV))=1.29e-9;
%raka(idxHV)=1.29e-9;
%raka(c_idxHV)=1.29e-9;
imagesc(raka(1:40,:));
title('Garbagio');


% square_abs_s11(~idxHV)=0;
% figure;
% imagesc(square_abs_s11(1:40,:));
% 
% square_C_abs_s11(~c_idxHV)=0;
% figure;
% imagesc(square_C_abs_s11(1:40,:));
% 
