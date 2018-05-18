function [ErrorSet] = ErrorSet_summaryMaker_LS_REP(ErrorSet,DTag) 

[ErrorSet.E1]=nested_groupSummary(ErrorSet.E1);
[ErrorSet.E2]=nested_groupSummary(ErrorSet.E2);

%createGroup Summary
ErrorSet.Set_Summary=  [ErrorSet.E1.EXP_SUMMARY;
                        ErrorSet.E2.EXP_SUMMARY];
% Tags of the first column  
ErrorSet.Set_Summary(1).Tag=[DTag,'Repeatability' ];
ErrorSet.Set_Summary(2).Tag=[DTag,'Reproduced'];



function [ExpSet]=nested_groupSummary(ExpSet)
% generate the GeSummary structure    
ExpSet.GeSummary=[ExpSet.P_P1.ImageMetrics.eSummary;...
                    ExpSet.P_P2.ImageMetrics.eSummary;...
                    ];
                
% Generate the ExperimentSummary / Requires .GeSummary
ExpSet=ExpSet_summaryCreator(ExpSet);
 
end

end             




