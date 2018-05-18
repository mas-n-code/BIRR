function [summaryStruc]=ContolSet_table(ControlSet)
%function [ControlSet]=ControlSet_table(ControlSet)
%Specific function for control set

% Based on ErrorSet_table
%Calculate ponderated mean with uncertainties of structure metrics and IQ
%metrics
% 1. Calculate weighted mean and uncertainties for structures response
% 2. Plot structures means and their uncertainties. and how they compare to
% control values.
% 3. Caluclate average IQM amd their uncertainties based on (1) values


%**************************************************************************

%%  Obtain each experiment metrics



Experiment_Name={'Control Set summary'};
f_names=fieldnames(ControlSet);
m_size=size(f_names,1)
%  tumor, fibro and back mean matrix
Tumor_Mean_M=zeros(m_size,1);
Fibro_Mean_M=zeros(m_size,1);
Back_Mean_M=zeros(m_size,1);

IQ_ScR_M=zeros(m_size,1);
IQ_TfR_M=zeros(m_size,1);
IQ_CcR_M=zeros(m_size,1);


Tumor_Std_M=zeros(m_size,1);
Fibro_Std_M=zeros(m_size,1);
Back_Std_M=zeros(m_size,1);

for ii=1:length(f_names)
Tumor_Mean_M(ii)=ControlSet.(f_names{ii}).ImageMetrics.Tumor.Mean;
Fibro_Mean_M(ii)=ControlSet.(f_names{ii}).ImageMetrics.Fibro.Mean;
Back_Mean_M(ii)=ControlSet.(f_names{ii}).ImageMetrics.Back.Mean;



Tumor_Std_M(ii)=ControlSet.(f_names{ii}).ImageMetrics.Back.Std;
Fibro_Std_M(ii)=ControlSet.(f_names{ii}).ImageMetrics.Fibro.Std;
Back_Std_M(ii)=ControlSet.(f_names{ii}).ImageMetrics.Back.Std;

IQ_ScR_M(ii)=ControlSet.(f_names{ii}).ImageMetrics.q0all.ScR_M;
IQ_TfR_M(ii)=ControlSet.(f_names{ii}).ImageMetrics.q0all.TfR_M;
IQ_CcR_M(ii)=ControlSet.(f_names{ii}).ImageMetrics.q0all.CcR_M;

end



%% Calculate  Confidence Intervals of strucutres %%depending on size of array
Tumor_t_const=2.1314;
Fibro_t_const=2.1604;
Back_t_const=1.968;


Tumor_SEM_M=Tumor_Std_M/sqrt(16);
Tumor_CI_M=Tumor_SEM_M*Tumor_t_const;


Fibro_SEM_M=Fibro_Std_M/sqrt(14);
Fibro_CI_M=Fibro_SEM_M*Fibro_t_const;


Back_SEM_M=Back_Std_M/sqrt(298);
Back_CI_M=Back_SEM_M*Back_t_const;

%CI = mean +/- t-const@95*SEM, in this example only the +/- value is
%calculated since mseb will add it to the value in y


%% Generate table with each experiment values
GroupTable=table(f_names,...
    Tumor_Mean_M,...
    Fibro_Mean_M,...
    Back_Mean_M,...
    Tumor_Std_M,...
    Fibro_Std_M,...
    Back_Std_M,...
    Tumor_CI_M,...
    Fibro_CI_M,...
    Back_CI_M,...
    IQ_ScR_M,...
    IQ_TfR_M,...
    IQ_CcR_M...
    ); 

summaryStruc.GroupTable= GroupTable;

%% Calculate average of values based on three experiments

three_Exp_t_const=4.303;


%*****************************************
Tumor_3exp_means=mean(Tumor_Mean_M);
Tumor_3exp_std=std(Tumor_Mean_M);
Tumor_3exp_SEM=Tumor_3exp_std/sqrt(3);
Tumor_3exp_CI=three_Exp_t_const*Tumor_3exp_SEM;


Fibro_3exp_means=mean(Fibro_Mean_M);
Fibro_3exp_std=std(Fibro_Mean_M);
Fibro_3exp_SEM=Fibro_3exp_std/sqrt(3);
Fibro_3exp_CI=three_Exp_t_const*Fibro_3exp_SEM;


Back_3exp_means=mean(Back_Mean_M);
Back_3exp_std=std(Back_Mean_M);
Back_3exp_SEM=Back_3exp_std/sqrt(3);
Back_3exp_CI=three_Exp_t_const*Back_3exp_SEM;
%*****************************************
%% Confidence interval OF  image quality metrics


ScR_3exp_mean=mean(IQ_ScR_M);
ScR_3exp_std=std(IQ_ScR_M);
ScR_3exp_SEM=ScR_3exp_std/sqrt(3);
ScR_3exp_CI=three_Exp_t_const*ScR_3exp_SEM;

TfR_3exp_mean=mean(IQ_TfR_M);
TfR_3exp_std=std(IQ_TfR_M);
TfR_3exp_SEM=TfR_3exp_std/sqrt(3);
TfR_3exp_CI=three_Exp_t_const*TfR_3exp_SEM;

CcR_3exp_mean=mean(IQ_CcR_M);
CcR_3exp_std=std(IQ_CcR_M);
CcR_3exp_SEM=CcR_3exp_std/sqrt(3);
CcR_3exp_CI=three_Exp_t_const*CcR_3exp_SEM;

table3experimentsSummary=table({'Mens and standard values based on three experiments'},...
    Tumor_3exp_means,...
    Fibro_3exp_means,...
    Back_3exp_means,...
    Tumor_3exp_std,...
    Fibro_3exp_std,...
    Back_3exp_std,...
    Tumor_3exp_SEM,...
    Fibro_3exp_SEM,...
    Back_3exp_SEM,...
    Tumor_3exp_CI,...
    Fibro_3exp_CI,...
    Back_3exp_CI,... % now IQM
    ScR_3exp_mean,...
    TfR_3exp_mean,...
    CcR_3exp_mean,...
    ScR_3exp_std,...
    TfR_3exp_std,...
    CcR_3exp_std,...
    ScR_3exp_SEM,...
    TfR_3exp_SEM,...
    CcR_3exp_SEM,...
    ScR_3exp_CI,...
    TfR_3exp_CI,...
    CcR_3exp_CI...
    ); 

summaryStruc.table3exp= table3experimentsSummary;

%% Tables with uncertainties in Structureas and IQM uncertainties propagated from structures



% Generate empty Arrays for each Error case
ii_e=1;     %error case index;


wTumor_Mean_Mat=zeros(ii_e,1);
wFibro_Mean_Mat=zeros(ii_e,1);
wBack_Mean_Mat=zeros(ii_e,1);

wTumor_Unc_Mat=zeros(ii_e,1);
wFibro_Unc_Mat=zeros(ii_e,1);
wBack_Unc_Mat=zeros(ii_e,1);

wScR_M=zeros(ii_e,1);
wTfR_M=zeros(ii_e,1);
wCcR_M=zeros(ii_e,1);

wScR_UncM=zeros(ii_e,1);
wTfR_UncM=zeros(ii_e,1);
wCcR_UncM=zeros(ii_e,1);

tmpUNC=zeros(ii_e,1);
% ---------
%Evaluate weighted mean for each structure at each error level (Sample 3)
for i_row = 1:ii_e
[wTumor_Mean_Mat(i_row,:), wTumor_Unc_Mat(i_row,:)] =wav_calculator(Tumor_Mean_M(:,i_row)',Tumor_Std_M(:,i_row)');  %Input must be a 1 row vector
[wFibro_Mean_Mat(i_row,:), wFibro_Unc_Mat(i_row,:)] =wav_calculator(Fibro_Mean_M(:,i_row)',Fibro_Std_M(:,i_row)');
[wBack_Mean_Mat(i_row,:), wBack_Unc_Mat(i_row,:)] =wav_calculator(Back_Mean_M(:,i_row)',Back_Std_M(:,i_row)');
% ---------
%Assign weighted structure signals mean values per error experiment 
    S_Tumor=wTumor_Mean_Mat(i_row,:);
    S_Fibro=wFibro_Mean_Mat(i_row,:);
    S_Back=wBack_Mean_Mat(i_row,:);

    Unc_Tumor=wTumor_Unc_Mat(i_row,:);
    Unc_Fibro=wFibro_Unc_Mat(i_row,:);
    Unc_Back=wBack_Unc_Mat(i_row,:);
% ---------    
    %calculate weighted IQM
wScR_M(i_row,:)= 20*log10(S_Tumor/S_Back);             % From function <I_ScR>
wTfR_M(i_row,:)= 20*log10(S_Tumor/S_Fibro);                 % From function <I_TfR>
wCcR_M(i_row,:)= 10*log10((S_Tumor^2-S_Fibro^2)/S_Back^2);  % From function <I_CtfCR>
% ---------
%Caculate uncertainties of IQM: 
%Uncertainty of scr
    Unc_scr=(S_Tumor/S_Back)*sqrt( (Unc_Tumor/S_Tumor)^2 + (Unc_Back/S_Back)^2 );
    Unc_scr_db=20*(1/log(10))*(Unc_scr/(S_Tumor/S_Back));
    %tmpUNC(i_row,:)=Unc_scr;
wScR_UncM(i_row,:)=Unc_scr_db;
% ----------
%    Uncertainty of tfr
    Unc_tfr=(S_Tumor/S_Fibro)*sqrt( (Unc_Tumor/S_Tumor)^2 + (Unc_Fibro/S_Fibro)^2 );
    Unc_tfr_db=20*(1/log(10))*(Unc_tfr/(S_Tumor/S_Fibro));
%tmpUNC(i_row,:)=Unc_scr;
    wTfR_UncM(i_row,:)=Unc_tfr_db;

    U_L1_T=2*S_Tumor*Unc_Tumor;
    U_L1_F=2*S_Fibro*Unc_Fibro;
    U_L1_B=2*S_Back*Unc_Back;

    L2=S_Tumor^2-S_Fibro^2;  disp('L2'); disp(L2);
    U_L2=rssq([U_L1_T,U_L1_F]);

    L3=L2/(S_Back^2); disp('L3'); disp(L3);
    U_L3=L3*rssq([U_L2/L2,U_L1_B/(S_Back^2)]);

    L4=log10(L3); disp('L4'); disp(L4);
    U_L4=(1/log(10))*(U_L3/L3);

wCcR_UncM(i_row,:)=10*U_L4;
end



% Generate table with structure means
table_sum=table({'Control Weighted means 3 '},...
    wTumor_Mean_Mat,...
    wFibro_Mean_Mat,...
    wBack_Mean_Mat,...
    wTumor_Unc_Mat,...
    wFibro_Unc_Mat,...
    wBack_Unc_Mat);

summaryStruc.WeightedMeans_structures= table_sum;

table_wIQM=table({'Control Weighted IQM'},...  % This talbe calculates is calculated as follow, first the weighted means of the image structures are calculated along with its uncertainties, then
    wScR_M,...                                 % the IQM are calculated using these weightedMeans, uncertainties in IQM are propagated from structure uncertainties
    wTfR_M,...
    wCcR_M,...
    wScR_UncM,...
    wTfR_UncM,...
    wCcR_UncM); 
summaryStruc.IQMfrom_wMeans= table_wIQM;






%%
% 3. Caluclate wAverage IQM amd their uncertainties based on (1) values
%Unc_scr=x*sqrt( (sv1/V1)^2 + (sv2/V2)^2 );
%Unc_scr_db=20*(1/log(10))*(Unc_scr/S_Tumor/S_Back);

% 2. Plot structures means and their uncertainties. and how they compare to
% control values.


% 4. Plot IQM and their uncertainties

%}