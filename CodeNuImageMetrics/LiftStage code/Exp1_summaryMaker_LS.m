function [ErrorSet] = Exp1_summaryMaker_LS(ErrorSet,DTag) 

[ErrorSet.E1]=nested_groupSummary(ErrorSet.E1);

%createGroup Summary
ErrorSet.Set_Summary=  [ErrorSet.E1.EXP_SUMMARY];
% Tags of the first column  
ErrorSet.Set_Summary(1).Tag=[DTag,'LS Top Control' ];



function [ExpSet]=nested_groupSummary(ExpSet)
% generate the GeSummary structure    
ExpSet.GeSummary=[ExpSet.P_P1.ImageMetrics.eSummary;...
                    ExpSet.P_P2.ImageMetrics.eSummary;...
                    ];
                
% Generate the ExperimentSummary / Requires .GeSummary
ExpSet=ExpSet_summaryCreator(ExpSet);
 
end

end             




