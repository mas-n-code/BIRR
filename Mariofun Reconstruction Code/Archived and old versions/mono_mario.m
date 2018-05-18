%script para mario 

s11_ref=data_reader(ref);%reference
s11_patch=data_reader(dataset);%data!
s11_patch_ref=s11_patch-s11_ref;
figure;imagesc(abs(s11_patch_ref).^2); %raw data view
colorbar;
d_size= 36;
speed=1.7e8; %what a speed gotta do

[ BSCAN2 ] = data_former( s11_patch_ref,zeros(601,d_size),145/57.3 );
Params.dataset=BSCAN2;
Params.freqvals=linspace(2e6,6e9,601);
Params.radius=0.25 %radius! may need to change in the fute!
Params.angles=linspace(0,2*pi,d_size);
Params.speed=3e8;
imafin=Multi_rec_full(Params);
sizmat=size(imafin);

imx=linspace(-30,30,61).*(speed/(4*(6e9)));%(Mu/(2*(6e9)))=0.0121 where Mu=1.45e8
imy=imx;
X1=round(sizmat(1)/2-15);X2=round(sizmat(1)/2+15);Y1=round(sizmat(2)/2-15);Y2=round(sizmat(2)/2+15);
figure;imagesc(imx,imy,abs(imafin(X1:X2,Y1:Y2)).^2);
colorbar;
