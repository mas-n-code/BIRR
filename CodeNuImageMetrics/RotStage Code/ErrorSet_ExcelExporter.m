function ErrorSet_ExcelExporter(ErrorSet,ExportMode,DTag) 
% SLOW PROGRAM function ErrorSet_ExcelExporter(ErrorSet,ExportMode,DTag) 
% Function that saves all necesary files to excel files
%Working with esummary to save processor power;
parent_dir=cd;
new_dir=[parent_dir,'\',DTag,'C_ExcelFiles'];
mkdir(new_dir)
cd(new_dir);

if  strcmp(ExportMode,'Group')
estructExceler2(ErrorSet.Set_Summary,[DTag,'E_SetSummary']);

else 
% estructExceler(GroupSet.E1.ImageMetrics.eSummary,[GroupSet.E1.ImageMetrics.Name,'eSummary'],1);
% estructExceler(GroupSet.E2.ImageMetrics.eSummary,[GroupSet.E2.ImageMetrics.Name,'eSummary'],1);
% estructExceler(GroupSet.E4.ImageMetrics.eSummary,[GroupSet.E4.ImageMetrics.Name,'eSummary'],1);
% estructExceler(GroupSet.E12.ImageMetrics.eSummary,[GroupSet.E12.ImageMetrics.Name,'eSummary'],1);

end
cd(parent_dir)


function estructExceler2(eStruct,file_name)

%By Mario
%based on David Sanchez
%http://www.mathworks.com/matlabcentral/answers/158415-saving-a-structure-to-excel


% write the last field values in a single matrix
my_last_field = fieldnames(eStruct);

%generate cell array
eCellArray = struct2cell(eStruct);

% write the matrix to excel WorkSheet
pos=1;
xLRange=['A' num2str(pos)];
xlswrite([file_name '.xls'],my_last_field',1,xLRange)
pos=pos+1;
xLRange=['A' num2str(pos)];
xlswrite([file_name '.xls'],eCellArray',1,xLRange)
end
end