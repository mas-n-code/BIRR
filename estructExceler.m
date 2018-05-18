
function estructExceler(eStruct,name,bool_rotFile)
% function estructExceler(eStruct,name)
% August update: XY positions changed to string so that they can be
% exported

%By Mario
%based on David Sanchez
%http://www.mathworks.com/matlabcentral/answers/158415-saving-a-structure-to-excel

aaa=size(eStruct,1);
if bool_rotFile==1
    for iii= 1:aaa
eStruct(iii).TumorXYMax=num2str(eStruct(iii).TumorXYMax);
eStruct(iii).FibroXYMax=num2str(eStruct(iii).FibroXYMax);
eStruct(iii).BackXYMax=num2str(eStruct(iii).BackXYMax);
   end
end 

my_last_field = fieldnames(eStruct);
% write the last field values in a single matrix

%generate cell array

eCellArray = struct2cell(eStruct);

% write the matrix to excell sheet
pos=1;
xLRange=['A' num2str(pos)];
xlswrite([name '.xls'],my_last_field',1,xLRange)
pos=pos+1;
xLRange=['A' num2str(pos)];

xlswrite([name '.xls'],eCellArray',1,xLRange)

%%Previous code, was depricated when I found that it was not working for
%%Srting arrays. converting to cell arrays seems to solve the problems
%{
L = numel(my_last_field);
lengthA=length([eStruct.(my_last_field{1})]);
my_data = zeros(lengthA,L);
for k=1:L
    my_data(:,k) = eStruct.(my_last_field{k});
end

%}