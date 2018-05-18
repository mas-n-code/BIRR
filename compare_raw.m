close all;
ref=TT_ref_afterCalmaybe;
data=TT_Rod_2dPos_rep_cal;


s11_ref=data_reader_daniel(ref);%reference
s11_data=data_reader_daniel(data);%data!
resulting=s11_ref-s11_data; % substracted data
%z_res=resulting(100:108,:); %  zoom for only the 8 bits from 100 to 100
z_2=resulting;


wind_sup=10; % determine the supperior window limit
wind_inf=25;
z_2(1:wind_sup,:)=0;
z_2(wind_inf:end,:)=1e-20;



%z_2(8:20,:)=resulting(120:132,:); %moving values to the 16 bin in z_2


figure('name','Raw ref');imagesc(abs(s11_ref).^2); %raw one 
figure('name','Raw Data');imagesc(abs(s11_data).^2); %raw two
figure('name','Resulting');imagesc(abs(resulting).^2); % 
figure('name','Resulting with window');imagesc(abs(z_2).^2);  % z-2copied  values to the 8 bin
raw_fig=(abs(z_2).^2);
figure('name','Zoomed resulting with window data','position', [300, 400, 800, 420]);
imagesc(raw_fig(1:30,:)); %raw data view 

Max=max(resulting);
