function [ErrorSet] = ErrorSet_summaryMaker_LS_CON(ErrorSet,DTag) 

[ErrorSet.E1]=nested_groupSummary(ErrorSet.E1);
% [ErrorSet.E2]=nested_groupSummary(ErrorSet.E2);
% [ErrorSet.E3]=nested_groupSummary(ErrorSet.E3);

%createGroup Summary
ErrorSet.Set_Summary=  [ErrorSet.E1.EXP_SUMMARY;
                        ];
% Tags of the first column  
ErrorSet.Set_Summary(1).Tag=[DTag,'0.0 cm' ];



function [ExpSet]=nested_groupSummary(ExpSet)
% generate the GeSummary structure    
ExpSet.GeSummary=[ExpSet.P_P1.ImageMetrics.eSummary;...
                    ExpSet.P_P2.ImageMetrics.eSummary;...
                    ];
                
% Generate the ExperimentSummary / Requires .GeSummary
ExpSet=ExpSet_summaryCreator(ExpSet);
 
end

end             




