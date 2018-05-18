
function imafin=wavecyl_multi_spin(BSCAN,f,Mu,R,theta)

k=2*pi.*f./Mu;

sizescan=size(BSCAN);
modelfin=zeros(sizescan);
BSCANf=fft(BSCAN);
BSCANFa=(fft(BSCANf,[],2));
BSCANFa=fftshift(BSCANFa,2);
BSCANFb=(fft(BSCANFa,[],3));
BSCANFb=fftshift(BSCANFb,3);

compmat=kernel_generator(sizescan(2),2*pi*f./Mu,R);

Bcomp=BSCANFb.*compmat; 

Bfinb=ifft(ifftshift(Bcomp,3),[],3);
Bfina=ifft(ifftshift(Bfinb,2),[],2);



[rho_mat,theta_mat]=meshgrid(theta,theta);  
theta_true_mat=(rho_mat+theta_mat)/2;
angle_comp_mat=cos((rho_mat-theta_mat)/2);
% angle_comp_mat=sec((rho_mat-theta_mat)/2);

angle_comp=zeros(length(f),sizescan(2),sizescan(2));
for i=1:length(f) 

    angle_comp(i,:,:)=angle_comp_mat;
     
end

%B_angle_comp=(Bfina).^(1./cos(angle_comp));
phase_Bfina=angle(Bfina);
phase_Bfina_comp=phase_Bfina./angle_comp; 
B_angle_comp=abs(Bfina).*exp(1i.*phase_Bfina_comp);


Bfin2=ifft(B_angle_comp);

B_angle_comp=fft(Bfin2.*(abs(BSCAN)>0));

Bfin=ifft(Bfina);
Bfint=ifft(B_angle_comp);
[k_alpha_index,k_beta_index]=pair_generator(sizescan(2),theta);

k_s_span_length=2*sizescan(2)-1; 

I_k_theta_true=zeros(sizescan(1),k_s_span_length);
I_k_theta_true2=zeros(sizescan(1),sizescan(2));
    
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

l=5;
for i=1:73
    j=i+73-8;
    if j>73
        j=j-73;
    end

    I_k_theta_true2(:,i)=B_angle_comp(:,i,j);
end;
    
% k=4*pi*f./Mu;
% 
% test_filter=fftshift(fft(I_k_theta_true,[],2),2);
% size_mat=size(test_filter);
% compmat2=kernel_generator2(size_mat(2),k,.2);
% test_clean=test_filter.*compmat2;
% I_k_theta_true=ifft(ifftshift(test_clean,2),[],2);

Bfin3=ifft(I_k_theta_true); 
%I_k_theta_true2(:,69:end)=conj(I_k_theta_true2(:,69:end));

tic;


%k_s_span=[(theta(1)+theta)/2 (theta(end)+theta(2:end))/2];
[testgridx,testgridy]=meshgrid(theta,2*k);
kvec=linspace(-2*k(end),2*k(end),(sizescan(1)-1)*2+1);
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


    
ZI = interp2(testgridx,testgridy,I_k_theta_true2,kangle,krad,'linear');


[l,m]=find(isnan(ZI));
for a=1:length(l)
    ZI(l(a),m(a))=0;
end;
toc;

multimat=krad;

ZI=ZI.*multimat;

imafin=ifftshift(ifft2(ifftshift(ZI),(sizescan(1)-1)*2+1,(sizescan(1)-1)*2+1));
imafin=flipud(fliplr(imafin));
