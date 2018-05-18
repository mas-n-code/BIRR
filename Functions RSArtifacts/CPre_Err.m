%%Function CPre(Dis,Set_Ref,Set_Data,Full_Ref,~)
% Generates a Collective Precision  Errors in raw data with a shift Dis

function [SetRef_CPre,SetData_CPre]= CPre_Err(Dis,Set_Ref,Set_Data,Full_Ref,~)
Ref_Plus=[Full_Ref,Full_Ref];
%Data_Plus=[Full_Data,Full_Data];

%dis=4;%1.25deg per dis. 4 is equal to 5deg or 1 step, 12 is equal to 15 deg
%supershort='RSART L288P172 w CPE 5\circ ';

SetRef_CPre=zeros(size(Set_Ref));
SetData_CPre=Set_Data;



for ii=1:2:size(SetRef_CPre,2)
    SetRef_CPre(:,ii)=Ref_Plus(:,ii*4-3 +Dis*2);
    SetRef_CPre(:,ii+1)=Ref_Plus(:,ii*4+1-3+Dis*2);
end

%CAacc_Err tester
%{
load('F:\UserElGuapo\Google Drive\masterSets\RotaryStage\test_variables.mat')
[test.E1.ref123,test.E1.data123]=CPre_Err(1,setB_test_fold72,setB_test_fold72,setA_test,setA_test); 
[test.E2.ref123,test.E1.data123]=CPre_Err(2,setB_test_fold72,setB_test_fold72,setA_test,setA_test); 
[test.E4.ref123,test.E1.data123]=CPre_Err(4,setB_test_fold72,setB_test_fold72,setA_test,setA_test); 
[test.E12.ref123,test.E1.data123]=CPre_Err(12,setB_test_fold72,setB_test_fold72,setA_test,setA_test);
figure; hold all;
plot(setB_test_fold72)
plot(test.E1.ref123)%,'Color',[0.15 0 0.25]); 
plot(test.E2.ref123)%,'Color',[0.15 0.15 0.40]); 
plot(test.E4.ref123)%,'Color',[0.15 0.15 0.55]); 
plot(test.E12.ref123)%,'Color',[0.15 0.35 0.70]); 
%}


