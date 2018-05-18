function  [DeviationT,DeviationT_Newport]=art_rot(posV,targV,runs,c_f,prepared)
%% [DeviationT,DeviationT_Newport] art_rot(posV,targV,runs,coverage_factor,pre-prepared);
%V1.3 Date: 2015_12_17
% Calculates Accuracy and Repeatability values of the actual and target
% positions of the size [n,1]. It also requires the number of runs to
% separate in forward and reverse direction. Assumes posV are ordered in
% sequential scans
% coverage factor in ISO 230-2 is 2;
% coverage factor in newport is 3;


%prepares array, not really well implemented. 
targVs=targV(2:end-1);
nPos=length(targV);
if (strcmp(prepared,'No'))
    long_targV=repmat(targV,runs,1);
dev_posV=posV-long_targV;
dev_posV=dev_posV-dev_posV(1);

elseif (strcmp(prepared,'Yes'))
    %dev_posV=posV-targV(2);
    dev_posV=posV;
end

devM=reshape(dev_posV,[nPos,runs]);
%devM=posM-diag(targV')*ones(size(posM));

% Separate Forward and Reverse arrats
devFW=devM(:,1:2:end);
devRV=devM(:,2:2:end);
%% %% %% ISO 230-2 2006 Standard %% %% %%
%% Calculate means, 
%Note that the first and last positions are not to be 
%evaluated in following calc.
%2.10 mean unidirectional positional deviation at a position
FWx_mu=mean(devFW(2:end-1,:),2);
RVx_mu=mean(devRV(2:end-1,:),2);
%Absolute values
FWx_mu_abs=abs(FWx_mu);
RVx_mu_abs=abs(RVx_mu);

%% Calculate Standar uncertainty
% 2.15  estimator of the standard uncertainty of the positional deviations
FWx_std=std(devFW(2:end-1,:),0,2);
RVx_std=std(devRV(2:end-1,:),0,2);

%%Superior and Inferior uncertainty limits
FW_l_sup=FWx_mu+FWx_std*c_f;
FW_l_inf=FWx_mu-FWx_std*c_f;

RV_l_sup=RVx_mu+RVx_std*c_f;
RV_l_inf=RVx_mu-RVx_std*c_f;




%% Unidirectional Repeatability at position

%2.11 mean bi-directional positional deviation at a position
xi_mu=mean([FWx_mu,RVx_mu],2);

%% Reversal Value
%2.12 Reversal value at a position
Bi=FWx_mu-RVx_mu;
Bi_abs=abs(Bi);             % Absolute Reversal value

%2.13 Reversal Value of an axis
B=max(abs(Bi));

%2.14 Mean reversal value of an axis
B_mu=mean(Bi);

% Reversal value with coverage factor (for 2.17)
Bx_cf=(c_f*FWx_std)+(c_f*RVx_std)+Bi_abs; 

%% Repeatability
%2.16 unidirectional repeatability of positioning at a position
FW_Rx=FWx_std*c_f*2;                    
RV_Rx=RVx_std*c_f*2;                    

%2.17 bi-directional repeatability of positioning at a position
Ri=max([Bx_cf,FW_Rx,RV_Rx],[],2);       

%2.18 Max unidirectional repeatability of positioning
FW_Rmax=max(FW_Rx);
RV_Rmax=max(RV_Rx);

%2.19 Bi-directional repeatability of positioning of an axis
R=max(Ri);

%% Positional Deviation (Accuracy)
%2.20 unidirectional systematic positional deviation of an axis
FW_Ex=max(FWx_mu)-min(FWx_mu);
RV_Ex=max(RVx_mu)-min(RVx_mu);

%2.21 bi-directional systematic positional deviation of an axis
E_Systematic=max(max(FWx_mu),max(RVx_mu))-min(min(FWx_mu),min(RVx_mu));

%2.22 mean bi-directional positional deviation of an axis
M_Mean=max(xi_mu)-min(xi_mu);

%2.23 unidirectional accuracy of positioning of an axis
FW_A=max(FW_l_sup)-min(FW_l_inf);
RV_A=max(RV_l_sup)-min(RV_l_inf);

%2.24 bi-directional accuracy of positioning of an axis
Max_AP=max([FW_l_sup;RV_l_sup]);
Min_AP=min([FW_l_inf;RV_l_inf]);
A=max([FW_l_sup;RV_l_sup])-min([FW_l_inf;RV_l_inf]);

%% %% %% Newport Criteria %% %% %%
% Repeatability (Mean)
N_FWRx=mean(FWx_std)*3;
N_RVRx=mean(RVx_std)*3;
N_R_mu=mean(mean([FWx_std,RVx_std],2))*3;

% Reversal Value (Mean)
N_B_mu=B_mu;
% Accuracy (Mean)
N_A_mu=M_Mean;


%% %% %% Generate table of results %% %% %%
DeviationT=table(B,B_mu,E_Systematic,M_Mean,FW_A,RV_A,A,R);

DeviationT_Newport=table(N_R_mu,N_B_mu,N_A_mu);


aTableArray = table2array(DeviationT);
TranspDeviationT = array2table(aTableArray.');

%%plot int
figure; hold all;
plot(targV,devM,...
                'o',...
                'LineWidth',1,...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor',[1 .5 0],...
                'MarkerSize',4)
plot(targVs,FW_l_sup,...
    ':b',...
    targVs,FW_l_inf,...
    ':b');



plot(targVs,RV_l_sup,...
    ':m',...
    targVs,RV_l_inf,...
    ':m');


%%Plot x_mu
plot(targVs,FWx_mu,...
                    '-b',...
                    'LineWidth',2);
                
plot(targVs,RVx_mu,...
                    '-m',...
                    'LineWidth',2);



%%Plot Mean deviation
plot(targVs,xi_mu,...
                    '-k',...
                    'LineWidth',3);
                
ceroline=refline(0,0);
set(ceroline,'Color','k')

% Plot the accuracy range-line
%{
plot([15,300],[Max_AP,Max_AP],'Color',[0.8 .5 0]);
plot([15 15], [Max_AP,Min_AP],'Color',[0.8 .5 0]);
plot([15 100],[Min_AP,Min_AP],'Color',[0.8 .5 0]);
%}
%ylim([-1.2*max([FWx_mu_abs;RVx_mu_abs]),1.2*max([FWx_mu_abs;RVx_mu_abs])]);


ylim([-0.35 0.35])
ylabh =ylabel('Deviation ( \circ)','rot',0);
set(ylabh,'Position',get(ylabh,'Position') - [0.2 0.0 0])

xlabel('Position ( \circ)')
xlim([0 360])
title('Deviation curve for Rotary stage')
