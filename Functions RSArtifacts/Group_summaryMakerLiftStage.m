function [GroupSet] = Group_summaryMakerLiftStage(GroupSet) 
[GroupSet.E1]=eSummaryMaker(GroupSet.E1);
[GroupSet.E2]=eSummaryMaker(GroupSet.E2);
[GroupSet.E3]=eSummaryMaker(GroupSet.E3);


%createGroup Summary
GroupSet.GeSummary=[GroupSet.E1.ImageMetrics.eSummary;...
                    GroupSet.E2.ImageMetrics.eSummary;...
                    GroupSet.E3.ImageMetrics.eSummary...
                    ];
                    
