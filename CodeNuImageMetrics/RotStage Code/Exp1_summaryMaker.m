function [ErrorSet] = Exp1_summaryMaker(ErrorSet,DTag) 
% Summary Maker for a Sing Experiment run (controls and shit)
% Based on ErrorSet_summaryMaker

[ErrorSet.E1]=nested_groupSummary(ErrorSet.E1);

%createGroup Summary
ErrorSet.Set_Summary=  [ErrorSet.E1.EXP_SUMMARY];

%ErrorSet.Set_Summary.Tag=[[DTag,'1.25°'];[DTag,'2.5°'];[DTag,'5°'];[DTag,'15°']];      
ErrorSet.Set_Summary(1).Tag=[DTag,'Experiment 1'];

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




