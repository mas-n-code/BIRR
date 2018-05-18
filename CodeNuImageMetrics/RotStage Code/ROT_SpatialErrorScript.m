% Tumor pos summary maker 

%  First, collecs a summary for every E
% IS a label needed?, if not, then 
% Export the full Eset summary to an excel file

% then make the last column to convert to cm position
%
clearvars
labPath='E:\TheCloud\';
guaperPath='F:\UserElGuapo\';
sPath='Google Drive\masterSets\RotaryStage\';
try
    hPath=[guaperPath,sPath];
    cd(hPath)
    
catch
    hPath=[labPath,sPath];
    cd(hPath)
end
clear labPath guaperPath sPath

%%
% Load control values
%Load Control values, this will be used to compare all the experiments
    load([hPath,'CONTROL SCANS\RPCON_0823_PC.mat']); % Load PC
    load([hPath,'\CONTROL SCANS\D0819_sProp.mat']);  % Load SProp
    
%% Saving directory
mkdir('G_SpatialErrors')

%% 1 RSAE
clear PE DTag tSummy

%----Load Set PE
cd([hPath,'SAE'])
DTag='RSAE_0828_'; 
load([hPath,'SAE\RSAE_0821_PE']);               
%----------------
PE=ROT_SummaryFixer(PE,sProp,DTag);
% Formula start
tSummy=ROT_POS_Summary(PE,DTag,sProp);

% export to excel
estructExceler2table(tSummy,[hPath,'G_SpatialErrors'],[DTag,'G Spatial Erros']);
% END Saves RAE_Processed
save([DTag,'PE'],'PE')




%% 2 RCAE
clear PE DTag tSummy

%----Load Set PE
cd([hPath,'CAE'])
DTag='RCAE_0828_'; 
load([hPath,'CAE\RCAE_0820_PE']);               
%----------------
PE=ROT_SummaryFixer(PE,sProp,DTag);
% Formula start
tSummy=ROT_POS_Summary(PE,DTag,sProp);

% export to excel
estructExceler2table(tSummy,[hPath,'G_SpatialErrors'],[DTag,'G Spatial Erros']);
% END Saves RAE_Processed
save([DTag,'PE'],'PE')


%% 3 SPE
clear PE DTag tSummy

%----Load Set PE
cd([hPath,'SPE'])
DTag='RSPE_0828_'; 
load([hPath,'SPE\RSPE_0821_PE']);               
%----------------
PE=ROT_SummaryFixer(PE,sProp,DTag);
% Formula start
tSummy=ROT_POS_Summary(PE,DTag,sProp);

% export to excel
estructExceler2table(tSummy,[hPath,'G_SpatialErrors'],[DTag,'G Spatial Erros']);
% END Saves RAE_Processed
save([DTag,'PE'],'PE')


%% 4 CPE
clear PE DTag tSummy

%----Load Set CPE
cd([hPath,'CPE'])
DTag='RCPE_0828_'; 
load([hPath,'CPE\RCPE_0821_PE']);               
%----------------
PE=ROT_SummaryFixer(PE,sProp,DTag);
% Generate eXcel files
% Export the summary?ErrorSet_ExcelExporter(PE,'Group',DTag)
 
% Formula start
tSummy=ROT_POS_Summary(PE,DTag,sProp);

% export to excel
estructExceler2table(tSummy,[hPath,'G_SpatialErrors'],[DTag,'G Spatial Erros']);

% END Saves RAE_Processed
save([DTag,'PE'],'PE')

%%  
%______
%---------- Extra RAE and RPE
%""""""""""""""


%%
clear PE DTag tSummy

%----Load Set CPE
cd([hPath,'RAE'])
DTag='RRAE_0828_'; 
load([hPath,'RAE\RRAE_0823_PE']);               
%----------------
PE=ROT_SummaryFixer(PE,sProp,DTag);
% Generate eXcel files
% Export the summary?ErrorSet_ExcelExporter(PE,'Group',DTag)


% Formula start
tSummy=ROT_POS_Summary(PE,DTag,sProp);

% export to excel
estructExceler2table(tSummy,[hPath,'G_SpatialErrors'],[DTag,'G Spatial Erros']);




% END Saves RAE_Processed
save([DTag,'PE'],'PE')

%%
clear PE DTag tSummy

%----Load Set PE
cd([hPath,'RPE'])
DTag='RRPE_0828_'; 
load([hPath,'RPE\RRPE_0823_PE']);               
%----------------
PE=ROT_SummaryFixer(PE,sProp,DTag);
% Generate eXcel files
% Export the summary?ErrorSet_ExcelExporter(PE,'Group',DTag)


% Formula start
tSummy=ROT_POS_Summary(PE,DTag,sProp);

% export to excel
estructExceler2table(tSummy,[hPath,'G_SpatialErrors'],[DTag,'G Spatial Erros']);

% END Saves RAE_Processed
save([DTag,'PE'],'PE')

