function [ExpSet]=ExpSet_summaryCreator(ExpSet)
% Generates summary of results for a ExpSet

% Define t for Confidence Intervals
    ln=length([ExpSet.GeSummary.TumorMean]);
    alpha=0.05; %
    % using a 95% confidence interval
    three_exp_t_critValue=tinv(1-(alpha/2),ln-1);
    disp(['t critical value ',num2str(three_exp_t_critValue)]);
    % three_Exp_t_const=4.302;  


%ROC
EXP_S.ROC_AUC=ExpSet.ROC.Roc_TumorVsFC.AUC;
EXP_S.ROC_SE=ExpSet.ROC.Roc_TumorVsFC.SE;

%Hypothesis testing
EXP_S.H_RejTIsFibro=ExpSet.HYP.RejectTumorSameasFibro(1);
EXP_S.H_RejTIsClutter=ExpSet.HYP.RejectTumorSameasClutter(1);
EXP_S.H_RejTIsCandF=ExpSet.HYP.RejectTumorSameasFibroClutter(1);
EXP_S.H_RejTIsRest=ExpSet.HYP.RejectTumorSameasRest(1);

%calculate imageMetrics
EXP_S.gScR=mean([ExpSet.GeSummary.ScR_M]);
EXP_S.gTfR=mean([ExpSet.GeSummary.TfR_M]);
EXP_S.gCcR=mean([ExpSet.GeSummary.CcR_M]);

EXP_S.gScR_s=std([ExpSet.GeSummary.ScR_M]);
EXP_S.gTfR_s=std([ExpSet.GeSummary.TfR_M]);
EXP_S.gCcR_s=std([ExpSet.GeSummary.CcR_M]);

EXP_S.gScR_SE=EXP_S.gScR_s/sqrt(ln);
EXP_S.gTfR_SE=EXP_S.gTfR_s/sqrt(ln);
EXP_S.gCcR_SE=EXP_S.gCcR_s/sqrt(ln);

EXP_S.gScR_CI=three_exp_t_critValue*EXP_S.gScR_SE;
EXP_S.gTfR_CI=three_exp_t_critValue*EXP_S.gTfR_SE;
EXP_S.gCcR_CI=three_exp_t_critValue*EXP_S.gCcR_SE;

%calculate means of means

EXP_S.gTumor_Mean=mean([ExpSet.GeSummary.TumorMean]);
EXP_S.gFibro_Mean=mean([ExpSet.GeSummary.FibroMean]);
EXP_S.gBack_Mean=mean([ExpSet.GeSummary.BackMean]);
EXP_S.gClutter_Mean=mean([ExpSet.GeSummary.ClutterMean]);

EXP_S.gTumor_Meanstd=std([ExpSet.GeSummary.TumorMean]);
EXP_S.gFibro_Meanstd=std([ExpSet.GeSummary.FibroMean]);
EXP_S.gBack_Meanstd=std([ExpSet.GeSummary.BackMean]);
EXP_S.gClutter_Meanstd=std([ExpSet.GeSummary.ClutterMean]);

EXP_S.gTumor_MeanSE=EXP_S.gTumor_Meanstd/sqrt(ln);
EXP_S.gFibro_MeanSE=EXP_S.gFibro_Meanstd/sqrt(ln);
EXP_S.gBack_MeanSE=EXP_S.gBack_Meanstd/sqrt(ln);
EXP_S.gClutter_MeanSE=EXP_S.gClutter_Meanstd/sqrt(ln);

% returner
ExpSet.EXP_SUMMARY=EXP_S;