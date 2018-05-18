%script para mario 
r=0.29;
speed=3e8;
shift=-0.03;
f=linspace(2e6,6e9,601);
s11_ref=data_reader(Mono_MoldAirReferenceR0x2Daa_0x280cm0x29_Freq_9_16_2014_1215);%reference s11
s11_patch=data_reader(Mono_moldAirPatchestumorR0x2Daa_0x280cm0x29_Freq_9_16_2014_113);%data! s11
s11_patch_ref=s11_patch-s11_ref;

s21_ref=data_reader(Multi_MoldAirReferenceR0x2Daa_0x280cm0x29_Freq_9_16_2014_1215);%reference s21
s21_patch=data_reader(Multi_moldAirPatchestumorR0x2Daa_0x280cm0x29_Freq_9_16_2014_113);%data! s21
s21_patch_ref=s21_patch-s21_ref;

figure;imagesc(abs(s11_patch_ref).^2); %raw data view
figure;imagesc(abs(s21_patch_ref).^2); %raw data view


shift_mat=repmat(exp(-1i*2*pi*f*(shift)*2/3e8).',1,144);
s21_patch_ref=ifft(fft(s21_patch_ref).*shift_mat);
figure;imagesc(abs(s21_patch_ref).^2); %shifted raw data view

[ BSCAN2 ] = data_former( s11_patch_ref,s21_patch_ref,135/180*pi); %zeros(size(s11_patch_ref))
Params.dataset=BSCAN2;
Params.freqvals=f;
Params.radius=r; %radius! may need to change in the fute!
Params.angles=linspace(0,2*pi,144);
Params.speed=speed;
imafin=Multi_rec_full(Params);
sizmat=size(imafin);
imx=linspace(-30,30,61).*(speed/(4*(6e9)));%(Mu/(2*(6e9)))=0.0121 where Mu=1.45e8
imy=imx;
X1=round(sizmat(1)/2-15);X2=round(sizmat(1)/2+15);Y1=round(sizmat(2)/2-15);Y2=round(sizmat(2)/2+15);
figure;imagesc(imx,imy,abs(imafin(X1:X2,Y1:Y2)).^2);