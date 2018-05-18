%%[SetRef_SAcc,SetData_SAcc]= SAcc_Err(dis,x_p,Set_Ref,Set_Data,Full_Ref,Full_Data)
% Generates a Single Accuracy  Error in raw data for Background and Target
% elements with a shift 'dis' in antenna position 'x_p' (antenna position must an odd number
% between 1 - 143)

function [SetRef_SAcc,SetData_SAcc]= SAcc_Err(dis,x_p,Set_Ref,Set_Data,Full_Ref,Full_Data)
Ref_Plus=[Full_Ref,Full_Ref];
Data_Plus=[Full_Data,Full_Data];

SetRef_SAcc=Set_Ref;
SetData_SAcc=Set_Data;


SetRef_SAcc(:,x_p)= Ref_Plus(:,(x_p*4-3+dis*2));
SetRef_SAcc(:,x_p+1)= Ref_Plus(:,(x_p*4+1-3+dis*2));

SetData_SAcc(:,x_p)= Data_Plus(:,(x_p*4-3+dis*2));
SetData_SAcc(:,x_p+1)= Data_Plus(:,(x_p*4+1-3+dis*2));
