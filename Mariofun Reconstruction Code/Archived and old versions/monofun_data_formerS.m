function [imafin_z,imafin_abs]=monofun_data_formerS(s11_minus_ref,l_size,fl_low,fl_high)

% function that uses multi_rec using Params and s11_minus_ref
% 
% <<<<Input variables:
% s11_minus_ref
% l_size
%fl_low=1e9;
%fl_high=8e9;
%
%recver=100;
%zz=1; % Zoom to 40 / 40 image
%diegoW=1; %(1: Frequency Window, 0: Time Window);
%zoomf=20; % determine the zoom factor of the image in cm for the rec image
 %what a speed gotta do, 2.54 for glycerine at 13cm but diego suggest 2.7 now, what a 
 % electrical radius of the antennas, See Diego's thesis 285 for 13 cm, 305 for 15
%d_points=1001; % Number of frequency/time points
 %fl_low=1e9;
 %fl_high=8e9;
 % determine the supperior window limit 9 soo 10 to 15  tend to be are the best accoring to 
 % determine the inferior window limit 21
% 
%>>>> Output variables:
%  imafin z 
%  imafin abs


%fl_low=1e9;
%fl_high=8e9;


%% -----------Step 5: Reconstruct ---------


%[ BSCAN2 ] = data_former( s11_data,zeros(d_points,l_size),145/57.3 ); %temporar wrong
%
[ BSCAN2 ] = data_former( s11_minus_ref,zeros(d_points,l_size),145/57.3 ); 
% %offset: angle offset between the radiating and the receiving locations in
%the bistatic dataset {In this case, i use only monostatic, thus offset value is irrelevant}
%GOOOd one
%
Params.dataset=BSCAN2;
Params.freqvals=linspace(fl_low,fl_high,d_points);
Params.angles=linspace(0,2*pi,l_size);
Params.radius=radius; %radius! may need to change in the fute!
Params.speed=speed;
Params.L1= Loss1;%Loss factor in breast medium
Params.surbin= Surbin;%
Params.diameter=diameter;
%---- Decide wich rec you want-----%
%New vs old MultiRec
%------Supported Versions
%Multi_rec_full100m.m
%Multi_rec_full101 UNSUPORTED
%Multi_rec_full101m.m this is the same as 100
%Multi_rec_full_comp201.m
%Multi_rec_full_comp202 UNSUPORTED
disp(recver)
switch recver
    case 201
        BMR=Multi_rec_full_comp201(Params);
        Ver_Multi_rec_full='Comp v2.0.1';
        
    case 211 
        BMR = BMR_SVD( data,[3 20],Params );
        Ver_Multi_rec_full='Comp v2.1.1 wSVD';
        
    case 101
        BMR=Multi_rec_full101(Params); 
        Ver_Multi_rec_full='Full v1.0.1';
        
    otherwise %ver100
        BMR=Multi_rec_full100m(Params);
        Ver_Multi_rec_full='Full v1.0.0';
end
%{        
if (ver==201)
    
else
    BMR=Multi_rec_full101(Params);
    Ver_Multi_rec_full='Full v1.0.0';
end
%}
% BMR=Multi_rec_full(Params); %old section used for reconstruciton


size_ofmat=size(BMR.ima);
%disp(['Size of mat = ',num2str(size_ofmat)]);

% Apply zoom and project image
if(zz==1)&&(recver==100)
    BMR.ima(1,1)
    
    imx=linspace(-zoomf,zoomf,(zoomf*2+1)).*(speed*100/(4*(fl_high)));%(Mu/(2*(6e9)))=0.0121 where Mu=1.45e8
    imy=imx*-1;
    
    X1=round(size_ofmat(1)/2-zoomf);X2=round(size_ofmat(1)/2+zoomf);Y1=round(size_ofmat(2)/2-zoomf);Y2=round(size_ofmat(2)/2+zoomf);
    
    imafin_z=BMR.ima(X1:X2,Y1:Y2);
    
   imafin_abs=abs(imafin_z).^2;
    else
        imafin_abs=abs(BMR.ima).^2;
end

if (flip_i ~=0)
    
    imafin_abs=flipud(imafin_abs);
    %imafin_abs=fliplr(imafin_abs);
end