function [errorSet]=ErrorSet_tableLiftStageREP(errorSet)
% function [Sae]=ErrorSet_table(ErrorSet)

%Calculate ponderated mean with uncertainties of structure metrics and IQ
%metrics
% 1. Calculate weighted mean and uncertainties for structures response
% 2. Plot structures means and their uncertainties. and how they compare to
% control values.
% 3. Caluclate average IQM amd their uncertainties based on (1) values
% 4. Plot IQM and their uncertainties
%%  1. Calculate weighted mean and uncertainties for structures response
Experiment_Name={errorSet.PD_P1.GeSummary.Name};

%  tumor, fibro and back mean matrix
Tumor_Mean_M= [errorSet.PD_P1.GeSummary.TumorMean;errorSet.PD_P2.GeSummary.TumorMean;];
Fibro_Mean_M= [errorSet.PD_P1.GeSummary.FibroMean;errorSet.PD_P2.GeSummary.FibroMean;];
Back_Mean_M= [errorSet.PD_P1.GeSummary.BackMean;errorSet.PD_P2.GeSummary.BackMean;];



% tumor uncertainty matrix
Tumor_Std_M= [errorSet.PD_P1.GeSummary.TumorStd;errorSet.PD_P2.GeSummary.TumorStd;];
Fibro_Std_M= [errorSet.PD_P1.GeSummary.FibroStd;errorSet.PD_P2.GeSummary.FibroStd;];
Back_Std_M= [errorSet.PD_P1.GeSummary.BackStd;errorSet.PD_P2.GeSummary.BackStd;];


% Generate empty Arrays for each Error case
ii_e=2;     %error case index;


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
%Evaluate weighted mean for each structure at each error level (Sample 3)
for i_row = 1:ii_e
[wTumor_Mean_Mat(i_row,:), wTumor_Unc_Mat(i_row,:)] =wav_calculator(Tumor_Mean_M(:,i_row)',Tumor_Std_M(:,i_row)');  %Input must be a 1 row vector
[wFibro_Mean_Mat(i_row,:), wFibro_Unc_Mat(i_row,:)] =wav_calculator(Fibro_Mean_M(:,i_row)',Fibro_Std_M(:,i_row)');
[wBack_Mean_Mat(i_row,:), wBack_Unc_Mat(i_row,:)] =wav_calculator(Back_Mean_M(:,i_row)',Back_Std_M(:,i_row)');

%Assign weighted structure signals mean values per error experiment 
    S_Tumor=wTumor_Mean_Mat(i_row,:);
    S_Fibro=wFibro_Mean_Mat(i_row,:);
    S_Back=wBack_Mean_Mat(i_row,:);

    Unc_Tumor=wTumor_Unc_Mat(i_row,:);
    Unc_Fibro=wFibro_Unc_Mat(i_row,:);
    Unc_Back=wBack_Unc_Mat(i_row,:);
    
    %calculate weighted IQM
wScR_M(i_row,:)= 20*log10(S_Tumor/S_Back);             % From function <I_ScR>
wTfR_M(i_row,:)= 20*log10(S_Tumor/S_Fibro);                 % From function <I_TfR>
wCcR_M(i_row,:)= 10*log10((S_Tumor^2-S_Fibro^2)/S_Back^2);  % From function <I_CtfCR>

%Caculate uncertainties of IQM: 
%Uncertainty of scr
Unc_scr=(S_Tumor/S_Back)*sqrt( (Unc_Tumor/S_Tumor)^2 + (Unc_Back/S_Back)^2 );
    Unc_scr_db=20*(1/log(10))*(Unc_scr/(S_Tumor/S_Back));
%tmpUNC(i_row,:)=Unc_scr;
wScR_UncM(i_row,:)=Unc_scr_db;

%Uncertainty of tfr
    Unc_tfr=(S_Tumor/S_Fibro)*sqrt( (Unc_Tumor/S_Tumor)^2 + (Unc_Fibro/S_Fibro)^2 );
    Unc_tfr_db=20*(1/log(10))*(Unc_tfr/(S_Tumor/S_Fibro));
%tmpUNC(i_row,:)=Unc_scr;
wTfR_UncM(i_row,:)=Unc_tfr_db;


%Uncertainty of CcR
%disp('Back'); disp(S_Fibro);
%disp('LB'); disp(S_Fibro^2);


U_L1_T=2*S_Tumor*Unc_Tumor;
U_L1_F=2*S_Fibro*Unc_Fibro;
U_L1_B=2*S_Back*Unc_Back;

L2=S_Tumor^2-S_Fibro^2;  %disp('L2'); disp(L2);
U_L2=rssq([U_L1_T,U_L1_F]);

L3=L2/(S_Back^2);% disp('L3'); %disp(L3);
U_L3=L3*rssq([U_L2/L2,U_L1_B/(S_Back^2)]);

L4=log10(L3);% disp('L4'); %disp(L4);
U_L4=(1/log(10))*(U_L3/L3);

wCcR_UncM(i_row,:)=10*U_L4;
end

% Generate table with structure means
table_sum=table([Experiment_Name(1);Experiment_Name(2)],...
    wTumor_Mean_Mat,...
    wFibro_Mean_Mat,...
    wBack_Mean_Mat,...
    wTumor_Unc_Mat,...
    wFibro_Unc_Mat,...
    wBack_Unc_Mat,...
    wScR_M,...
    wTfR_M,...
    wCcR_M,...
    wScR_UncM,...
    wTfR_UncM,...
    wCcR_UncM); 

errorSet.EeSummarywMeans= table_sum;

%% Calculate common average values

errorSet.ByErr.E1=...
    [...
    errorSet.PD_P1.GeSummary(1,:),...
    errorSet.PD_P2.GeSummary(1,:),...
    ];

errorSet.ByErr.E2=...
    [...
    errorSet.PD_P1.GeSummary(2,:),...
    errorSet.PD_P2.GeSummary(2,:),...
    ];




errorSet.ByErr.All=[errorSet.ByErr.E1,...
        errorSet.ByErr.E2...
        ...
        ];

s_names=fieldnames(errorSet.ByErr);







[ScR_M_cMean,TfR_M_cMean,CcR_M_cMean,ScR_M_cS,TfR_M_cS,CcR_M_cS]=deal(zeros(ii_e,1)); %Initialize matrix

for ii=1:ii_e
    ScR_M_cMean(ii)=mean([errorSet.ByErr.(s_names{ii}).ScR_M]);
    TfR_M_cMean(ii)=mean([errorSet.ByErr.(s_names{ii}).TfR_M]);
    
    
    %----Correction for errroneus CcR calculation
    %{
        localError=errorSet.ByErr.(s_names{ii});
        %errorSet.ByErr.(s_names{ii}).CcR_M=[10*log10(([localError.TumorMean].^2-[localError.FibroMean].^2)./([localError.BackMean].^2))'];
        NewCcR=10*log10(([localError.TumorMean].^2-[localError.FibroMean].^2)./([localError.BackMean].^2));
        errorSet.ByErr.(s_names{ii})(1).CcR_M=NewCcR(1);
        errorSet.ByErr.(s_names{ii})(2).CcR_M=NewCcR(2);
        errorSet.ByErr.(s_names{ii})(3).CcR_M=NewCcR(3);
        
        % Formula used %10*log10((S_Tumor^2-S_Fibro^2)/S_Back_^2);
    %}
    %----Continues calculating means
    CcR_M_cMean(ii)=mean([errorSet.ByErr.(s_names{ii}).CcR_M]);
    
    
    ScR_M_cS(ii)=std([errorSet.ByErr.(s_names{ii}).ScR_M]);
    TfR_M_cS(ii)=std([errorSet.ByErr.(s_names{ii}).TfR_M]);
    CcR_M_cS(ii)=std([errorSet.ByErr.(s_names{ii}).CcR_M]);
    
    
    
    
end


% calculate Three Experiments SEM and CI
ScR_M_cSEM=ScR_M_cS/sqrt(3);
TfR_M_cSEM=TfR_M_cS/sqrt(3);
CcR_M_cSEM=CcR_M_cS/sqrt(3);

three_Exp_t_const=12.71; %two exp 12.71 three 4.303
ScR_M_cCI=three_Exp_t_const*ScR_M_cSEM;
TfR_M_cCI=three_Exp_t_const*TfR_M_cSEM;
CcR_M_cCI=three_Exp_t_const*CcR_M_cSEM;

 



values_names={'ACC';'PRE'};

errorSet.IQMSummary=table(...
    values_names,...
    ScR_M_cMean,...
    TfR_M_cMean,...
    CcR_M_cMean,...
    ScR_M_cS,...
    TfR_M_cS,...
    CcR_M_cS,...
    ScR_M_cSEM,...
    TfR_M_cSEM,...
    CcR_M_cSEM,...
    ScR_M_cCI,...
    TfR_M_cCI,...
    CcR_M_cCI,...
    values_names);












%%
% 3. Caluclate wAverage IQM amd their uncertainties based on (1) values
%Unc_scr=x*sqrt( (sv1/V1)^2 + (sv2/V2)^2 );
%Unc_scr_db=20*(1/log(10))*(Unc_scr/S_Tumor/S_Back);

% 2. Plot structures means and their uncertainties. and how they compare to
% control values.


% 4. Plot IQM and their uncertainties

