
function imafin=Multi_rec_full(Params)

% Multi_rec_full.m
%--------------------------------------------------
% Version 1.0.0.0
% Created by Daniel Flores Tapia
% Date 05/02/2014
% This function reconstructs a radar image based on a multistatic dataset
% Input Parameters
% Params=Data structure containing the reconstruction parameters
% Params.dataset=Dataset to be processed
% Paramas.freqvals=Vector of frequency values
% Params.speed= Propagation speed in the medium
% Params.radius= Center of rotation of the scan geometry
% Params.angles= Angular locations of the scan locations
%--------------------------------------------------
% Revision changes
%--------------------------------------------------
%
% Please document here any changes
% 31/01/2014 Added general mapping functionality, corrected zero coordinate
% location
%--------------------------------------------------

%Input structure parsing
%--------------------------------------------------
BSCAN=Params.dataset;
f=Params.freqvals;
Nu=Params.speed;
R=Params.radius;
theta=Params.angles;
%--------------------------------------------------

% Wavenumber calculation
%--------------------------------------------------
k=2*pi.*f./Nu;
%--------------------------------------------------

%3D Fourier transform calculation
%--------------------------------------------------
sizescan=size(BSCAN);
modelfin=zeros(sizescan);
BSCANf=fft(BSCAN);
BSCANFa=(fft(BSCANf,[],2));
BSCANFa=fftshift(BSCANFa,2);
BSCANFb=(fft(BSCANFa,[],3));
BSCANFb=fftshift(BSCANFb,3);


%--------------------------------------------------

%Compensation kernel calculation and compensation
%--------------------------------------------------
compmat=kernel_generator(sizescan(2),2*pi*f./Nu,R);
Bcomp=BSCANFb.*compmat;
%--------------------------------------------------

%Transformation to the theta-iota space
%--------------------------------------------------
Bfinb=ifft(ifftshift(Bcomp,3),[],3);
Bfina=ifft(ifftshift(Bfinb,2),[],2);

%--------------------------------------------------

%Phase unwrapping
%--------------------------------------------------
[rho_mat,theta_mat]=meshgrid(theta,theta);   
theta_true_mat=(rho_mat+theta_mat)/2;
angle_comp_mat=cos((rho_mat-theta_mat)/2);

angle_comp=zeros(length(f),sizescan(2),sizescan(2));

for i=1:length(f)

    angle_comp(i,:,:)=angle_comp_mat;
    
end

phase_Bfina=angle(Bfina);
phase_Bfina_comp=phase_Bfina./angle_comp;
B_angle_comp=abs(Bfina).*exp(1i.*phase_Bfina_comp); 
%--------------------------------------------------

%Mapping to the epsilon frequency space
%--------------------------------------------------
Bfin2=ifft(B_angle_comp);  
B_angle_comp=fft(Bfin2.*(abs(BSCAN)>0));
[k_alpha_index,k_beta_index]=pair_generator(sizescan(2),theta);
k_s_span_length=2*sizescan(2)-1;
I_k_theta_true=zeros(sizescan(1),k_s_span_length);
   
for i=1:k_s_span_length
    l=1;
    if i<=sizescan(2);
        
        j=i;
        
    end
    
    if i>sizescan(2)
        
        j=2*sizescan(2)-i;
        
    end; 
    
    for l=1:j
        
        I_k_theta_true(:,i)= I_k_theta_true(:,i)+(B_angle_comp(:,k_alpha_index(l,i),k_beta_index(l,i)));
        
    end
end
%--------------------------------------------------

% Populates the remaining of the frequency space if the initial frequency
% is not zero
%--------------------------------------------------
if f(1)>0
    df=f(2)-f(1);
    r_points=round(f(1)/df);
    size_i_k=size(I_k_theta_true);
    full_freq=zeros(r_points+size_i_k(1),size_i_k(2));
    full_freq(r_points+1:end,:)=I_k_theta_true;
    f_full=0:df:(r_points+size_i_k(1)-1)*df;
    sizescan(1)=r_points+size_i_k(1);
else
    f_full=f;
    full_freq=I_k_theta_true;
end

%--------------------------------------------------

% Mapping from the f-epsilon frequency space to the kx-ky frequency space
%--------------------------------------------------
k_full=2*pi.*f_full./Nu;
k_s_span=[(theta(1)+theta)/2 (theta(end)+theta(2:end))/2];
[testgridx,testgridy]=meshgrid(k_s_span,2*k_full);
kvec=linspace(-2*k_full(end),2*k_full(end),(sizescan(1)-1)*2+1);
kangle=zeros((sizescan(1)-1)*2+1,(sizescan(1)-1)*2+1);
[kx,ky]=meshgrid(kvec,kvec);
krad=sqrt(kx.^2+ky.^2);
kangle(1:sizescan(1)-1,sizescan(1)+1:(sizescan(1)-1)*2+1)=-(atan(ky(1:sizescan(1)-1,sizescan(1)+1:(sizescan(1)-1)*2+1)./kx(1:sizescan(1)-1,sizescan(1)+1:(sizescan(1)-1)*2+1)));
kangle(1:sizescan(1),1:sizescan(1)-1)=pi-atan(ky(1:sizescan(1),1:sizescan(1)-1)./kx(1:sizescan(1),1:sizescan(1)-1));
kangle(1:sizescan(1)-1,sizescan(1))=pi/2;
kangle(sizescan(1):(sizescan(1)-1)*2+1,1:sizescan(1)-1)=pi-atan(ky(sizescan(1):(sizescan(1)-1)*2+1,1:sizescan(1)-1)./kx(sizescan(1):(sizescan(1)-1)*2+1,1:sizescan(1)-1));
kangle(sizescan(1):(sizescan(1)-1)*2+1,sizescan(1)+1:(sizescan(1)-1)*2+1)=2*pi-atan(ky(sizescan(1):(sizescan(1)-1)*2+1,sizescan(1)+1:(sizescan(1)-1)*2+1)./kx(sizescan(1):(sizescan(1)-1)*2+1,sizescan(1)+1:(sizescan(1)-1)*2+1));
kangle(sizescan(1)+1:(sizescan(1)-1)*2+1,sizescan(1))=3*pi/2;
kangle(sizescan(1),sizescan(1))=0;
%--------------------------------------------------

%Elimiation of null points in the frequency space    
%--------------------------------------------------
ZI = interp2(testgridx,testgridy,full_freq,kangle,krad,'linear');
[l,m]=find(isnan(ZI));
for a=1:length(l) 
    ZI(l(a),m(a))=0; 
end;

%--------------------------------------------------

%Inversion to the image space
%--------------------------------------------------
imafin=ifftshift(ifft2(fftshift(ZI)));
imafin=rot90((imafin),2);%180 degree shift not included in the kernel
sizeima=size(imafin);
%--------------------------------------------------

%Zero adjusting for odd indexed frequency spaces
%--------------------------------------------------
if mod(sizeima(1),2)==1
    imafin=circshift(imafin,[1,1]);
end
%--------------------------------------------------

