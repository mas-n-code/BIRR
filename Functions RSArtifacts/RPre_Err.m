% Function RPre_Err
% 
% Load base of uniform or normal error files
% Generates a index of files required for a perfectly folded 72 file
% combine error index file with errorless index file
% 
% In RPre Target file is unnafected. 

function [SetRef_RAacc,SetData_RAcc,indexError,SetNorm]= RPre_Err(error_Array,Full_Ref,Full_Data)
Ref_Plus=[Full_Ref,Full_Ref]; %Generates the full ref and data plus files
Data_Plus=[Full_Data,Full_Data];

setsize=size(Full_Ref,2)/4;
setHeight=size(Full_Ref,1);
disp(setHeight)
error_Array=error_Array*2; % Multiplied to accunt for imaginary column
indexFold=(1:8:288*2);
indexError=(indexFold+error_Array);
indexError(indexError<=0)=(288*2)+indexError(indexError<=0); % convert to 288 any negative value

SetRef_RAacc=zeros(setHeight,setsize); %Empty files for reference and data errrs
SetData_RAcc=zeros(setHeight,setsize);



 SetRef_RAacc(:,1:2:setsize)=Ref_Plus(:,indexFold);
 SetRef_RAacc(:,2:2:setsize)=Ref_Plus(:,indexFold+1);
 
 SetData_RAcc(:,1:2:setsize)=Data_Plus(:,indexError);    %-- Pre indexFold. RACC_ERR uses indexError
 SetData_RAcc(:,2:2:setsize)=Data_Plus(:,indexError+1);
 
SetNorm(:,1:2:setsize)=Ref_Plus(:,indexFold);
SetNorm(:,2:2:setsize)=Ref_Plus(:,indexFold+1);
 