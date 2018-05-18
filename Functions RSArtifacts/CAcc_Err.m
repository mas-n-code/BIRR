%%Function CAcc_Err(Set_Ref,Set_Data)
% Generates a Collective Accuracy Errors in raw data with a shift Dis
% in both data sets

function [SetRef_CAcc,SetData_CAcc]= CAcc_Err(dis,Set_Ref,Set_Data,Full_Ref,Full_Data)
Ref_Plus=[Full_Ref,Full_Ref]; %Generates the full ref and data plus files
Data_Plus=[Full_Data,Full_Data];

setsize=size(Set_Ref,2);


SetRef_CAcc=zeros(size(Set_Ref)); %Empty files for reference and data errrs
SetData_CAcc=zeros(size(Set_Data));



for ii=1:2:setsize
    SetRef_CAcc(:,ii)=Ref_Plus(:,(ii*4)-3+(dis*2)); % The current recorded single scatter information is replaced by  "dis" times to the right.
    SetRef_CAcc(:,ii+1)=Ref_Plus(:,(ii*4)+1-3+(dis*2));
end

for ii=1:2:setsize
    SetData_CAcc(:,ii)=Data_Plus(:,(ii*4)-3+(dis*2));
    SetData_CAcc(:,ii+1)=Data_Plus(:,(ii*4)+1-3+(dis*2));
end


%CAacc_Err tester
% load('F:\UserElGuapo\Google Drive\masterSets\RotaryStage\test_variables.mat')
%[test.E1.ref123,test.E1.data123]=CAcc_Err(1,setB_test_fold72,setB_test_fold72,setA_test,setA_test); 
%[test.E1.ref123,test.E1.data123]=CAcc_Err(2,setB_test_fold72,setB_test_fold72,setA_test,setA_test); 
%[test.E1.ref123,test.E1.data123]=CAcc_Err(4,setB_test_fold72,setB_test_fold72,setA_test,setA_test); 
%[test.E1.ref123,test.E1.data123]=CAcc_Err(12,setB_test_fold72,setB_test_fold72,setA_test,setA_test); 