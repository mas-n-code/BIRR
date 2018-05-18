function estructExceler2table(eStruct,filePath,fileName)

%By Mario
%based on David Sanchez
%http://www.mathworks.com/matlabcentral/answers/158415-saving-a-structure-to-excel


% write the last field values in a single matrix
% my_last_field = fieldnames(eStruct);
% 
% %generate cell array
% eCellArray = struct2cell(eStruct);
% 
% % write the matrix to excel WorkSheet
% pos=1;
% xLRange=['A' num2str(pos)];
% xlswrite([file_name '.xls'],my_last_field',1,xLRange)
% pos=pos+1;
% xLRange=['A' num2str(pos)];
% xlswrite([file_name '.xls'],eCellArray',1,xLRange)
% end


%%%%
%%%
% my_data = zeros(16,L);
% for k=1:L
%     my_data(:,k) = a.b.c.(my_last_field{k});
% end
% write the matrix to excell sheet
mkdir(filePath);
writetable(struct2table(eStruct),[filePath,'\',fileName,'.xlsx'])
disp([filePath,fileName,'.xlsx'])