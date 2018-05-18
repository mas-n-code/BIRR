function compmat=kernel_generator(steps,k,R)
%Input parameters
%steps: number of samples in the theta axis
%k: 2*wavenumber
%R: Radius of the scan array

%Creating the data matrices
func=zeros(length(k),steps);
compmat=zeros(length(k),steps);
odd_flag=0;


%Creating the epsilon array
E=2*pi/(360/steps);
Earr=linspace(-E/4,E/4,steps);
%Earr=linspace(-(steps-pad_factor)/4,(steps-pad_factor)/4,steps);

[KA,KT,KB]=meshgrid(Earr,k,Earr);

resmat=sqrt((KT.*R).^2-KA.^2)+sqrt((KT.*R).^2-KB.^2);
angle_alphamat=asin(KA./(KT.*R));
angle_betamat=asin(KB./(KT.*R));
func=exp(1i*resmat-1i*KA.*angle_alphamat-1i.*KB.*angle_betamat);%+1i.*KA.*pi+1i.*KB.*pi);
R_term_alpha=sqrt((KT.*R).^2-KA.^2);
R_term_beta=sqrt((KT.*R).^2-KB.^2);

funcmag=sqrt(KA.^2./R_term_alpha);%.*sqrt(KB.^2./R_term_beta);
funcmag=funcmag.*(imag(funcmag)==0);
% func=funcmag.*func;

if mod(steps,2)==1;
    sing_index=floor(steps/2)+1;
    func(1,sing_index,:)=0;
    func(1,:,sing_index)=0;    
end

compmat=func;%.*funcmag;
