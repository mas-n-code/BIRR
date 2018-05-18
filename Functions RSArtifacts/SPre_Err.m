%%Function SPre_Err(Dis,x_p,Set_Ref,Set_Data,Full_Ref,~)
% Generates a Single Precision  Errors in raw data with a shift Dis
% in x_p (antenna position must be odd and between 1 - 143)
% Worst position must be 49,50,51

function [SetRef_SPre,SetData_SPre]= SPre_Err(Dis,x_p,Set_Ref,Set_Data,Full_Ref,~)
Ref_Plus=[Full_Ref,Full_Ref];
%Data_Plus=[Full_Data,Full_Data];

SetRef_SPre=Set_Ref;
SetData_SPre=Set_Data;


SetRef_SPre(:,x_p)= Ref_Plus(:,(x_p*4-3+Dis*2));
SetRef_SPre(:,x_p+1)= Ref_Plus(:,(x_p*4+1-3+Dis*2));

%{
%SPre_Err tester
x_p=50*2+1; %xp must be odd!
load('F:\UserElGuapo\Google Drive\masterSets\RotaryStage\test_variables.mat')
[test.E1.ref123,test.E1.data123]=SPre_Err(1,x_p,setB_test_fold72,setB_test_fold72,setA_test,setA_test); 
figure; bar(test.E1.ref123-setB_test_fold72)
[test.E2.ref123,test.E2.data123]=SPre_Err(2,x_p,setB_test_fold72,setB_test_fold72,setA_test,setA_test); 
figure; bar(test.E2.ref123-setB_test_fold72)
[test.E4.ref123,test.E4.data123]=SPre_Err(4,x_p,setB_test_fold72,setB_test_fold72,setA_test,setA_test);
figure; bar(test.E4.ref123-setB_test_fold72)
[test.E12.ref123,test.E12.data123]=SPre_Err(12,x_p,setB_test_fold72,setB_test_fold72,setA_test,setA_test); 
figure; bar(test.E12.ref123-setB_test_fold72)
%}