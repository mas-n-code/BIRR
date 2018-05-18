function [ROC]=ROT_ROC_RUN(call_Arrays)

% Generate pos and neg boxes
call_posBox = call_Arrays.call_tumor;
        
call_negBox = [call_Arrays.call_fibro;
               call_Arrays.call_clutter];

roc_data = [call_posBox;call_negBox];
roc_flag = [ones(size(call_posBox));zeros(size(call_negBox))];  % positives have a value of one, neg =0
roc_tresholds=0;
roc_alpha=0.05;

roc_output = roc_M_GC2017([roc_data,roc_flag],roc_tresholds,roc_alpha,1);

% No option, but runs a boxplot
ROC.Roc_TumorVsFC=roc_output;
ROC.Roc_TumorVsFC.roc_data=roc_data;
ROC.Roc_TumorVsFC.roc_flag=roc_flag;
ROC.Roc_TumorVsFC.call_posBox=call_posBox;
ROC.Roc_TumorVsFC.call_negBox=call_negBox;
