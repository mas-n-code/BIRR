function [BSCAN,f,dd,Mu,dR,theta]=cylscan(Fini,Ffin,Nfreq,ZeroP,Er,Rad,Sloc,Yap,Yloc,Xn,Zn,Yn,En);
%This function generates the BMI image of point scatterers for a stepped
%frequency radar system allong a cylindrical scan trajectory
%-------------------------------------
% Output Variables
% 
% BSCAN:        The B-scan ifft image generated from the radar by the point- 
%               scatterers
%f:             frequency steps array [Hz]
%dd:            Spatial increment allong the synthetic aperture [m]
%Mu:            Speed of propagation in the medium [m/s]
%dR:            Range resolution [m]
%theta          Angle position vector
tic
GHz=1e9;
c=3e8;  %[var] free space speed of propagation [m/s]

%-------------------------------------
%FREQUENCY INFORMATION
%These variables pertain to the frequency parameters of the SFCW radar
%system.
% Fini         [var] min frequency of system [GHz]
% Ffin          [var] max frequency of system [GHz]
% ZeroP         [var] zero pad factor, this is the factor by which the A-scans will be zero-padded
% Er            [var] Reletive dielectric constant of the ground
%---------------------------------------
%APERTURE INFORMATION
%These variables pertain to the scan trajectory parameters of the SFCW radar
%system.
% sloc        [var] number of spacial samples(radial)
% Yloc        [var] number of spacial samples(linear)   
%----------------------------------------
%TARGET INFORMATION
%These variable pertain to the point-scatters
% Xn            [var] X coordinates of targets (cross-range)   
% Zn            [var] Z coordinates of targets (range)
% En            [var] Er values of targets (range)
%----------------------------------------
%----------------------------------------
%Preliminary procedures
Fini=Fini*GHz; Ffin=Ffin*GHz;
BW=Ffin-Fini;       %system bandwidth [GHz]
a=1:Nfreq;             %frequency step vector
f=linspace(Fini,Ffin,Nfreq); %frequency vector [GHz]
df=f(2)-f(1);       %incremental frequency step size [GHz]
%---------------------------------------
[xc,zc,theta]=thetagen(Rad,Sloc); %Aperture position vector [rads]
dd=theta(2)-theta(1);       %incremental aperture step size [rads]
yc=linspace(-Yap/2,Yap/2,Yloc);
%---------------------------------------
Mu=c./sqrt(Er);      %speed of propagation in the medium [m/s]
Ttarg=length(Xn);    %[var] number of point scatterers
% sigma=ones(Ttarg,1);  % scattering cross-section of point scatterers

sigma=refleccoef(En,Er);  %calls function "refleccoef.m" to calculate the reflection coeficient 
%                          of each target 
%--------------------------------------

[darr,warrxz,warry,warrz]=distcyl(length(Xn),Xn,Zn,Yn,xc,zc,yc,theta);  %calls function "distcyl.m" to calculate distance 
%                                       and angle from each target to each point of u
%---- -----------------------------------
id=zeros(Sloc,Nfreq,Ttarg);
data=zeros(Yloc,Sloc,Nfreq);
% reflecmat=reflecgen(warr,sigma);
for m=1:Yloc
   for i=1:Sloc
    for n=1:Ttarg

         id(i,a,n)=sigma(n).*pat(warrxz(m,n,i)).*patz(warrz(m,n,i)).*exp(-j*2*pi*f(a)*2*darr(m,n,i)/Mu)./(8*darr(m,n,i).^4);
     end; 
    data(m,i,a)=sum(id(i,a,:),3);    %total response function for all targets at possition u
%     datafin(m,i,floor(Fini/df)+1:floor(Fini/df)+Nfreq)=data(m,i,:);
    end 
end;
BSCAN=zeros((Nfreq)*ZeroP,Sloc,Yloc);
for v=1:Yloc
scantemp(:,:)=data(v,:,:);
BSCAN(:,:,v)=(ifft(scantemp.',(Nfreq)*ZeroP));%Range profiles
end;
f=linspace(Fini,Ffin,Nfreq);
dR=Mu/2/BW;                  %Range resolution
toc
timex=toc