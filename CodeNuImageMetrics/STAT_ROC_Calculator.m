function [chiSq_value,probability,outcome] = STAT_ROC_Calculator(Auc1,SE1,Auc2,SE2)
% [chiSq_value,probability] = S_ROC_Calculator(Auc1,SE1,Auc2,SE2)
% Gives back 
% Uses the chi distribution in place of a t model, when the samples are
% large they follow the chi square
% 
%http://support.sas.com/kb/45/339.html
% Exampple
 % [chiSq_value,probability,outcome] = STAT_ROC_Calculator(.801,0.0411,0.655,0.0593)
% Auc1=0.801;
% Auc2=0.655;
% SE1=0.0411;
% SE2=0.0593;
% 

chiSq_value=((Auc1-Auc2)^2)/sumsqr([SE1,SE2]);

probability=1-chi2cdf(chiSq_value,1);

if probability<=0.05
    outcome='!The AUC are different';
else
    outcome='No significant difference';
end
    % example