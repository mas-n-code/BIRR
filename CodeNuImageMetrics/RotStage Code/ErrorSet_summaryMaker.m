function [ErrorSet] = ErrorSet_summaryMaker(ErrorSet,DTag) 

[ErrorSet.E1]=nested_groupSummary(ErrorSet.E1);
[ErrorSet.E2]=nested_groupSummary(ErrorSet.E2);
[ErrorSet.E4]=nested_groupSummary(ErrorSet.E4);
[ErrorSet.E12]=nested_groupSummary(ErrorSet.E12);

%createGroup Summary
ErrorSet.Set_Summary=  [ErrorSet.E1.EXP_SUMMARY;
                        ErrorSet.E2.EXP_SUMMARY;
                        ErrorSet.E4.EXP_SUMMARY;
                        ErrorSet.E12.EXP_SUMMARY
                        ];
%ErrorSet.Set_Summary.Tag=[[DTag,'1.25°'];[DTag,'2.5°'];[DTag,'5°'];[DTag,'15°']];      
ErrorSet.Set_Summary(1).Tag=[DTag,'1.25°'];
ErrorSet.Set_Summary(2).Tag=[DTag,'2.50°'];
ErrorSet.Set_Summary(3).Tag=[DTag,'5.00°'];
ErrorSet.Set_Summary(4).Tag=[DTag,'15.00°'];

function [ExpSet]=nested_groupSummary(ExpSet)
% generate the GeSummary structure    
ExpSet.GeSummary=[ExpSet.P_P1.ImageMetrics.eSummary;...
                    ExpSet.P_P2.ImageMetrics.eSummary;...
                    ExpSet.P_P3.ImageMetrics.eSummary;...
                    ];
                
% Generate the ExperimentSummary / Requires .GeSummary
ExpSet=ExpSet_summaryCreator(ExpSet);
 
end

end             




