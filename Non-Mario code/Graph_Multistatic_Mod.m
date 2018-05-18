function [imx,BMR]=Graph_Multistatic_Mod(speed,rad,s11,s21,freq,angle,zm,graph)
% Based on Diegos Code by Diego Rodriguez [Feb 2018 29th]   
%%  INPUT
    %%speed= SPEED OF RECONSTRUCTION in m/s. Cn. speed on air is C
    %%r=Radious of scan geometry in M
    %%s11= s11 dataset to be reconstructed. In the time domain
    %%s21= s21 dataset to be reconstructed. In the time domain. if not
    %%present use empty array []
    %%freq= frequency range, for the planar 804 the default is [1e9 8e9]
    %%angle = angle between the antenna s11 and the antenna for s21, in
    %%degrees, default is 145
    %%zm=number of pixels the end image would be. zm=20 would yield a 41x41
    %%graph= bolean varible, if false it will only perfom the
    %%reconstruction. 
    
    %Mario Mod:
    wind_sup=8;
    wind_inf=15;
    
    % Work
    dsz=[];
    if isempty(s11)
        dsz=size(s21);
        s11=zeros(dsz);
    else
        dsz=size(s11);
    end
    
    if isempty(s21)
        s21=zeros(dsz);
    end
    th=linspace(0,2*pi,dsz(2));
    f=linspace(freq(1),freq(2),dsz(1));
    Params.dataset=data_former(ApplyWindow(s11,wind_sup,wind_inf),ApplyWindow(s21,wind_sup,wind_inf),angle*pi/180);
    Params.freqvals=f;
    Params.speed=speed;
    Params.radius= rad;
    Params.angles=th;
    Params.zm=zm;
    imx=linspace(-zm,zm,2*zm+1).*(speed/(4*(f(end)-f(1))));
    BMR=Multi_rec_full100m(Params);
    if(graph)
        figure;imagesc(imx,imx,abs(BMR.ima).^2);
        colorbar;
        axis xy;
    end
end