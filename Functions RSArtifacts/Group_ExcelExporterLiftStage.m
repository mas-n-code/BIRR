function Group_ExcelExporterLiftStage(GroupSet,ExportMode) 
% SLOW PROGRAM
% Function that saves all necesary files to excel files
%Working with esummary to save processor power;

if  strcmp(ExportMode,'Group')
estructExceler(GroupSet.GeSummary,[GroupSet.GName,' GeSummary'],1);


else 
estructExceler(GroupSet.E1.ImageMetrics.eSummary,[GroupSet.E1.ImageMetrics.Name,'eSummary'],1);
estructExceler(GroupSet.E2.ImageMetrics.eSummary,[GroupSet.E2.ImageMetrics.Name,'eSummary'],1);
estructExceler(GroupSet.E3.ImageMetrics.eSummary,[GroupSet.E3.ImageMetrics.Name,'eSummary'],1);

end