function [raw_fig,imafin_z,max_value]=monofun_mario(ref,data,l_size,p,flip,g_title)
%monofun_mario(ref,data,l_size,p,flip)
%monofun_mario Hapilly process the data using the multi_rec_fill
%   ref is the element to be used as reference
%   data is, of course, the data
%  l_size is the number of locations
% p is a bolean selctor for window
% flip is used to invert y axis
% g_title, graph title put 0 if default
close all;


speed=2.67e8; %what a speed gotta do
radius=0.27;
if (g_title==0)
title_plot=[inputname(2),' minus ',inputname(1)];
else
    title_plot=g_title;
end


s11_ref=data_reader_daniel(ref);%reference
s11_data=data_reader_daniel(data);%data!

if (p==1)
s11_patch_ref=s11_data-s11_ref;
s11_patch_ref(1:5,:)=0;
s11_patch_ref(17:end,:)=1e-20;
 %windowed data


else 
    s11_patch_ref=s11_data-s11_ref;
end


raw_fig= abs(s11_patch_ref).^2;

figure('position', [300, 400, 800, 420]);imagesc(raw_fig(1:30,:)); %raw data view 





colorbar;
title( title_plot);
xlabel('Antenna Location');
ylabel('Frequency Segment');
h=colorbar;
%ylabel(h, 'Watts')


[ BSCAN2 ] = data_former( s11_patch_ref,zeros(601,l_size),145/57.3 );
Params.dataset=BSCAN2;
Params.freqvals=linspace(2e6,6e9,601);
Params.angles=linspace(0,2*pi,l_size);
Params.radius=radius; %radius! may need to change in the fute!
Params.speed=speed
imafin=Multi_rec_full(Params);
sizmat=size(imafin);



imx=linspace(-15,15,61).*(speed/(4*(6e9)));%(Mu/(2*(6e9)))=0.0121 where Mu=1.45e8
imy=imx*-1;
X1=round(sizmat(1)/2-15);X2=round(sizmat(1)/2+15);Y1=round(sizmat(2)/2-15);Y2=round(sizmat(2)/2+15);

imafin_z=imafin(X1:X2,Y1:Y2);
imafin_abs=abs(imafin_z).^2;

if (flip ~=0)
    
    imafin_abs=abs(flipud(imafin_z)).^2;
    %imafin_abs=fliplr(imafin_abs);
end
  
%close;
figure;
a=imagesc(imx,imy,imafin_abs); % creates the graph we know and love
set(gca,'YDir','normal');% This will reverse both the y-axis and the image.

colorbar;
title(title_plot);
xlabel('x axis(meters)');
ylabel('y axis(meters)');
h=colorbar;

max_value=max(max(imafin_abs))

end

