% make a cole cole diagram
%Load Tyson Measureemnts
Meas_Ty_All = xlsread('G:\Dropbox\ResearchMagic\RandomProyects\171101 Debye and Cole Cole\Permittivity Measurements\Dielectrics1to6Tysoon_M','A14:H814');
TPath='G:\Dropbox\ResearchMagic\T H E S I S\Chapter 3\ch3_FigFolder\';

%Constants
Eo_vacuum=8.854187E-12; % Epsilon naught, Vacuum permitivity

fL=16.5;
fH=9.45;
f 
Meas.Freq=Meas_Ty_All(:,1);
Meas.FreqSmall=Meas_Ty_All(1:2:end,1);
Meas.AllPerm=Meas_Ty_All(:,2:4);
Meas.AllImag=Meas_Ty_All(:,6:8);

%RelPermittivities
Meas.Perm.Gly=Meas_Ty_All(:,2);
Meas.Perm.TT30=Meas_Ty_All(:,3);
Meas.Perm.Saline=Meas_Ty_All(:,4);


%Conductivity
Meas.Condu.All=(Meas.AllImag.*Eo_vacuum).*(repmat(2*pi*Meas.Freq,1,3));
Meas.Condu.Gly=Meas.Condu.All(:,1);
Meas.Condu.TT30=Meas.Condu.All(:,2);
Meas.Condu.Saline=Meas.Condu.All(:,3);

%Set colors
RRed=[0.6350    0.0780    0.1840];
BBlue=[0    0.4470    0.7410];
GGren=[0.4660    0.6740    0.1880];

%% Sugitani Values

% CANCER, Stroma, Adipo
E_inf=[7.17,7.94,4.26]; % Permittivity of high frequency limits
E_m=[59.45,33.2,9.26]; % Permittivity of middle frequency limits
E_s=[67.99,40.3,12.6]; % Permittivity of low frequency limits
t_tau=[0.212,0.23,0.164]*1E-9; % Relaxation
t_tauQ=[13.9,13.7,18.29]*1E-12;
B_betta=[0.11,0.074,0.0617];
sigma_condu=[0.759,0.553,0.184];

%Stroma
% E_inf=7.94; % Permittivity of high frequency limits
% E_m=33.2; % Permittivity of middle frequency limits
% E_s=40.3; % Permittivity of low frequency limits
% t_tau=0.23*1E-9; % Relaxation
% t_tauQ=13.7*1E-12;
% B_betta=0.074;
% sigma_condu=0.553;

w_freq=0.5E9:1E8:20E9;
w_freq_ang=w_freq*2*pi;

Ecmx_Suig=zeros(3,length(w_freq));
Ecmx_Suig_TanDelta=zeros(3,length(w_freq));
Ecmx_Suig_ConductEff=zeros(3,length(w_freq));

for ii=1:3;
Ecmx_Suig(ii,:)= E_inf(ii) + (E_m(ii)-E_inf(ii))./(1+power(1j*w_freq_ang*t_tauQ(ii),1-B_betta(ii))) + (E_s(ii)-E_m(ii))./(1+1j*w_freq_ang*t_tau(ii)) - (sigma_condu(ii)./(w_freq_ang*Eo_vacuum))*1j; %(E_m-E_inf)./(1+(1j*w_freq*t_tauQ).^(1-B_betta))
 Ecmx_Suig_TanDelta(ii,:)=imag(Ecmx_Suig(ii,:))./real(Ecmx_Suig(ii,:));
 Ecmx_Suig_ConductEff(ii,:)=1-imag(Ecmx_Suig(ii,:)).*w_freq_ang*Eo_vacuum;

end
%Emorecmplx= E_inf + (E_m-E_inf)./(1+power(1j*w_freq*t_tauQ,1-B_betta)) + (E_s-E_m)./(1+1j*w_freq*t_tau) - (sigma_condu./(w_freq*Eo_vacuum))*1j; %(E_m-E_inf)./(1+(1j*w_freq*t_tauQ).^(1-B_betta))


close all;
% Permittivity plot
figure(1);
set(gca, 'ColorOrder', [RRed;GGren;BBlue], 'NextPlot', 'replacechildren'); % Set proper colors
plot(w_freq,real(Ecmx_Suig),'-','LineWidth',2); 
ylim([0,120]); xlim([1E9,6E9])
title('Permittivity of Breast Tissues Over 1 to 6 GHz')
ylabel('Permittivity');
xlabel('Frequency (GHz)');
hold on;

set(gca, ...
  'Box'         , 'on'     , ...
   'XTickLabel',{'1','2','3','4','5','6'},...
   'XTick',[1 2 3 4 5 6]*1E9,...
  'TickDir'     , 'in'     , ...
  'TickLength'  , [.02 .02]);



% load excel of  values Tyson
plot(Meas.Freq(1:20:end),Meas.Perm.Saline(1:20:end),'^','MarkerFaceColor',RRed,'MarkerSize',5);
plot(Meas.Freq(1:20:end),Meas.Perm.TT30(1:20:end),'o','MarkerFaceColor',GGren,'MarkerSize',5);
plot(Meas.Freq(1:20:end),Meas.Perm.Gly(1:20:end),'s','MarkerFaceColor',BBlue,'MarkerSize',5);
LLeg=legend(gca,'Tumor (Sugitani et al.)','Fibroglandular (Sugitani et al.)','Adipose (Sugitani et al.)','Saline (measured)','TritonX-100 30% (measured)','Glycerine (measured)');
LLeg.Box='On';
LLeg.FontName='Times New Roman';
LLeg.FontSize=10;
LLeg.Position=[0.580501937155984,0.651381876192508,0.325517669025846,0.270182973089935];
% Save plot1
%%
savethisoneTS(TPath,'441_Permittivity',fL,fH,'noC','siTrans'); % SAVE to thesis Doc path ;)

% Plot tyson values
% graph_errorBar=repmat([65-35;50-15;25-0.8],1,length(w_freq));
% muLineProps.col{1}=RRed;
% muLineProps.col{2}=GGren;
% muLineProps.col{3}=BBlue;
% pp1=mseb(w_freq,real(Ecmx_Suig(:,:)),graph_errorBar,muLineProps,0);
%Conductivity Plot


%% Conductivity
figure(2);
set(gca, 'ColorOrder', [RRed;GGren;BBlue], 'NextPlot', 'replacechildren'); % Set proper colors
plot(w_freq,real(Ecmx_Suig_ConductEff),'-','LineWidth',2); 
ylim([0,10]); xlim([1E9,6E9])
title('Suigitani Conductivity')
hold on;

%Plot Tyson
plot(Meas.Freq(1:20:end),Meas.Condu.Saline(1:20:end),'^','MarkerFaceColor',RRed,'MarkerSize',5);
plot(Meas.Freq(1:20:end),Meas.Condu.TT30(1:20:end),'o','MarkerFaceColor',GGren,'MarkerSize',5);
plot(Meas.Freq(1:20:end),Meas.Condu.Gly(1:20:end),'s','MarkerFaceColor',BBlue,'MarkerSize',5);

%Graph parameters
set(gca, ...
  'Box'         , 'on'     , ...
   'XTickLabel',{'1','2','3','4','5','6'},...
   'XTick',[1 2 3 4 5 6]*1E9,...
   'YTick',[1 2 3 4 5 6 7 8 9 10 11 12 13 14 15],...
  'TickDir'     , 'in'     , ...
  'TickLength'  , [.02 .02]);
title('Conductivity of Breast Tissues Over 1 to 6 GHz')
ylabel('Conductivity (S/m)')
xlabel('Frequency (GHz)');

LLeg=legend(gca,'Tumor (Sugitani et al.)','Fibroglandular (Sugitani et al.)','Adipose (Sugitani et al.)','Saline (measured)','TritonX-100 30% (measured)','Glycerine (measured)');
LLeg.Box='On';
LLeg.FontName='Times New Roman';
LLeg.FontSize=10;
LLeg.Position=[0.1517    0.6541    0.3258    0.2702];

%Save the plot
savethisoneTS(TPath,'441_Conductivity',fL,fH,'noC','siTrans'); % SAVE to thesis Doc path ;)



%plot([1,3,6,10]*1e9,[61.5,55,45,36],'ro'); Validation points


%% Lazebnik

% 
 close all;
%Equation
w_freq=0.5E9:1E8:20E9;
w_freq_angular=w_freq*2*pi;
Eo_vacuum=8.854187E-12; % Epsilon naught, Vacuum permitivity

% CANCER 35
E_inf=[7.821,5.573,3.140]; % Permittivity of high frequency limits
E_delta=[41.48,34.57,1.708]; % Permittivity of middle frequency limits
t_tau = [10.66,9.149,14.65]*1.0E-12; % Relaxation FOr some reason, the 5 works
a_alpha=[0.047,0.095,0.061];
sigma_condu=[0.713,0.524,0.036];

Ecm_Lz1_Adopo=zeros(3,length(w_freq));
Ecm_Lz1_Adopo_tan_delta=zeros(3,length(w_freq));
conduEFF=zeros(3,length(w_freq));
for ii=1:3;
    Ecm_Lz1_Adopo(ii,:)= E_inf(ii) + (E_delta(ii))./(1+power(1j*w_freq_angular*t_tau(ii),1-a_alpha(ii))) + (sigma_condu(ii)./(w_freq_angular*Eo_vacuum*1j)); %(E_m-E_inf)./(1+(1j*w_freq*t_tauQ).^(1-B_betta))
    Ecm_Lz1_Adopo_tan_delta(ii,:)=imag(Ecm_Lz1_Adopo(ii,:))./real(Ecm_Lz1_Adopo(ii,:));
    conduEFF(ii,:)=1-imag(Ecm_Lz1_Adopo(ii,:)).*w_freq_angular*Eo_vacuum;
end

%Conductivity= 


figure(2); 
plot(w_freq,real(Ecm_Lz1_Adopo),'--','LineWidth',2); 
ylim([0,60]); 


figure(3);
plot(w_freq,conduEFF,'--','LineWidth',2); 


