 function Nu=ROC_MetaExceler(Control_ROC,PE)
% Generates an excel file with all the ROC information of interest, %
% control roc and every error file

fn=fieldnames(PE);
%Nu.Tag=['ROT Control';{PE.Set_Summary(:,1).Tag}'];
Nu(1).Tag='Control';
Nu(1).AUC=Control_ROC.AUC;
Nu(1).SE=Control_ROC.SE;
Nu(1).CI_L=Control_ROC.ci(1);
Nu(1).CI_U=Control_ROC.ci(2);
Nu(1).PositiveCases=Control_ROC.n_pos;
Nu(1).NegativeCases=Control_ROC.n_neg;
[Nu(1).chiSq_value,...
 Nu(1).probability,...
 Nu(1).outcome] = STAT_ROC_Calculator(...
    Control_ROC.AUC             , ...
    Control_ROC.SE              , ...
    Control_ROC.AUC             , ...
    Control_ROC.SE);


for i=1:length(fn)-1;
Nu(i+1).AUC=PE.Set_Summary(i).ROC_AUC;
Nu(i+1).Tag=PE.Set_Summary(i).Tag;
Nu(i+1).SE=PE.Set_Summary(i).ROC_SE;
Nu(i+1).CI_L=PE.(fn{i}).ROC.Roc_TumorVsFC.ci(1);
Nu(i+1).CI_U=PE.(fn{i}).ROC.Roc_TumorVsFC.ci(2);
Nu(i+1).PositiveCases=length(PE.(fn{i}).ROC.Roc_TumorVsFC.call_posBox);
Nu(i+1).NegativeCases=length(PE.(fn{i}).ROC.Roc_TumorVsFC.call_negBox);

[Nu(i+1).chiSq_value,...
 Nu(i+1).probability,...
 Nu(i+1).outcome] = STAT_ROC_Calculator(...
    Control_ROC.AUC             , ...
    Control_ROC.SE              , ...
    PE.Set_Summary(i).ROC_AUC   , ...
    PE.Set_Summary(i).ROC_SE);
end

%% The folowing section was commented to make saving path outside of function

%{
parent_dir=cd;
Ex_name='F_RocSummary Excel';
new_dir=[parent_dir,'\',DTag,Ex_name];
mkdir(new_dir)
cd(new_dir);

%export
estructExceler2(Nu,[DTag,Ex_name]);
cd(parent_dir)

% function estructExceler2(eStruct,file_name)
% writetable(struct2table(eStruct),[file_name '.xlsx'])

end
%}


end