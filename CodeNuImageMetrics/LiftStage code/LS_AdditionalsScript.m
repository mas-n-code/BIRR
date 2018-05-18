% ROC Excel correcter and SpatialPos Exceler for Lift Stage


lsPath='G:\Google Drive\masterSets\LiftStage\1 Top\';
rsPath='G:\Google Drive\masterSets\RotaryStage\';

%%
% Load control values
%Load Control values, this will be used to compare all the experiments
    load([lsPath,'LST CON\LSTCON_0824_PC.mat']); % Load PC
    load([lsPath,'LST CON\LSTCON_0824_LsProp']);  % Load SProp
    
%Define some global vairables  
sf1=1;
%{
 
 G_name='G_SpatialErrors';
 F_name='F_RocSummary Excel';
%}    
Control_ROC=PC.E1.ROC.Roc_TumorVsFC;
rs_PC=load([rsPath,'CONTROL SCANS\RPCON_0823_PC.mat']);
rs_PCSUM=rs_PC.PC.Set_Summary;

%% CONTROLS


%% ---1 RCAE
clear PE DTag tSummy Nu

%-Load Set PE
Ess='CAE';
PPath=([lsPath,'LST ',Ess,'\']);
cd(PPath);
load([lsPath,'LST ',Ess,'\TSBCAE_0825_PE']);      

%-DefineTag
DTag=['LST',Ess,'_0916_']; 
%-Define TPath
TPath='G:\Dropbox\ResearchMagic\T H E S I S\Chapter 4\FigFolder\03Results\403_lsCAE\';
cd(TPath)
close all;
plot_ImageofOne(PE.E1.P_P1.A_masked,LsProp,'On')
if sf1, savethisoneTS(TPath,'403_LSCAE_01a_E1P1',8.24,6.7,'c','siTrans'); else end % SAVE to thesis Doc path ;)

plot_ImageofOne(PE.E2.P_P1.A_masked,LsProp,'On')
if sf1, savethisoneTS(TPath,'403_LSCAE_01b_E2P1',8.24,6.7,'c','siTrans'); else end % SAVE to thesis Doc path ;)

plot_ImageofOne(PE.E3.P_P1.A_masked,LsProp,'On')
if sf1, savethisoneTS(TPath,'403_LSCAE_01c_E3P1',8.24,6.7,'c','siTrans'); else end % SAVE to thesis Doc path ;)

%-- Nu ROC-AUC plot 
%%{
% Generate plot
 ROC_MetaPlotter_LS(Control_ROC,PE,'Soft')
% Save Plot
 if sf1, savethisoneAsIs(PPath,DTag,'10 ROC Curves together'); else end %->Old Place
%-> Thesis Place
 if sf1, savethisoneTS(TPath,'403_LSCAE_03',10,9,'noc','siTrans'); else end % SAVE to thesis Doc path ;)
  
  
%}

%-- Nu ICM plot 
%{ 
%Load control variable
rs_PCSUM=rs_PC.PC.Set_Summary;

%-Define Thick marks 
xValues=[0.05,.1,.2];
xTicksValues=0:0.05:0.2;
xTicksLabels=[{'0'},{'      0.05 cm'},{'      0.10 cm'},{'      0.15 cm'},{'      0.20 cm'}];

%-Combines summaries into one with control as the first element
combined_summary=[PC.Set_Summary;PE.Set_Summary]; 

%-/> Adjusted summary
MixSum=combined_summary;

    %-/>> Define t for Confidence Intervals
        ln=3;
        alpha=0.05; %
        % using a 95% confidence interval
        three_exp_t_critValue=tinv(1-(alpha/2),ln-1);
        disp(['t critical value ',num2str(three_exp_t_critValue)]);
        % three_Exp_t_const=4.302;  

    for ii=1:4 %Trims CI to critValue 4.302
    MixSum(ii).gScR_SE=MixSum(ii).gScR_s/sqrt(ln);
    MixSum(ii).gTfR_SE=MixSum(ii).gTfR_s/sqrt(ln);
    MixSum(ii).gCcR_SE=MixSum(ii).gCcR_s/sqrt(ln);

    MixSum(ii).gScR_CI=three_exp_t_critValue*MixSum(ii).gScR_SE;
    MixSum(ii).gTfR_CI=three_exp_t_critValue*MixSum(ii).gTfR_SE;
    MixSum(ii).gCcR_CI=three_exp_t_critValue*MixSum(ii).gCcR_SE;
    end 

    %-/>> Replace control SE and CI to those of rotary stage.
    MixSum(1).gScR_SE=rs_PCSUM(1).gScR_SE;
    MixSum(1).gTfR_SE=rs_PCSUM(1).gTfR_SE;
    MixSum(1).gCcR_SE=rs_PCSUM(1).gTfR_SE;

    MixSum(1).gScR_CI=rs_PCSUM(1).gScR_CI;
    MixSum(1).gTfR_CI=rs_PCSUM(1).gTfR_CI;
    MixSum(1).gCcR_CI=rs_PCSUM(1).gCcR_CI;
    
    
%--Runs the plotting comand. 
LS_ICM_Eplot(MixSum,xValues,xTicksValues,xTicksLabels);

%-Accuracy and Precision Marks (Disabled)
%{
AGoal= .20;  % Goal was 2mm accuracy
AValue= .203; % +0.05 uncertainty
PGoal= 0.10;  %  Goal was 1 mm precision,
PValue=0.192; % verified

%-Accuracy Threshold
plot([AGoal; AGoal], [0;40], ':g','LineWidth',1)
plot([AValue; AValue], [0;40], ':m','LineWidth',1)
%}

%-If enabled, saves the fig
 if sf1, savethisoneAsIs(PPath,DTag,'D Plotted Contrast Metrics MIX'); else end
 
 if sf1, savethisoneTS(TPath,'403_LSCAE_02',13,10); else end % SAVE to thesis Doc path ;)
  
  
   
%-Save the xlxs file for later use
mario_estructExceler2table(MixSum,PPath,[DTag,'D Table of Contrast Metrics MIX'])
%-End
%}

%--Spatial Error and 
%{
%--------Spatial Error--------
PE=LS_SummaryFixer(PE,LsProp,DTag);
% Formula start
tSummy=LS_POS_Summary(PE,DTag,LsProp);
% export to excel
estructExceler2table(tSummy,[lsPath,G_name],[DTag,G_name]);
%}

%--AUC metrics and table%
%{
%--------AUC Metrics--------
Nu=ROC_MetaExceler(Control_ROC,PE);
estructExceler2table(Nu,[cd,'\',DTag,F_name],[DTag,F_name])

% END Saves RAE_Processed
save([DTag,'PE'],'PE')
%}   

%% 2 RCPE
clear PE DTag tSummy Nu Tpath PPath

%----Load Set PE
Ess='CPE';
PPath=([lsPath,'LST ',Ess,'\']);
cd(PPath);
load([lsPath,'LST ',Ess,'\TSBCPE_0825_PE']);  


%-DefineTag
DTag=['LST',Ess,'_0916_']; 
%-Define TPath
TPath='G:\Dropbox\ResearchMagic\T H E S I S\Chapter 4\FigFolder\03Results\403_lsCPE\';
cd(TPath)
close all;

plot_ImageofOne(PE.E1.P_P1.A_masked,LsProp,'On');
if sf1, savethisoneTS(TPath,'403_LSCPE_01a_E1P1',8.24,6.7,'c','siTrans'); else end % SAVE to thesis Doc path ;)

plot_ImageofOne(PE.E2.P_P1.A_masked,LsProp,'On');
if sf1, savethisoneTS(TPath,'403_LSCPE_01b_E2P1',8.24,6.7,'c','siTrans'); else end % SAVE to thesis Doc path ;)

plot_ImageofOne(PE.E3.P_P1.A_masked,LsProp,'On');
if sf1, savethisoneTS(TPath,'403_LSCPE_01c_E3P1',8.24,6.7,'c','siTrans'); else end % SAVE to thesis Doc path ;)


%-- DIAGNOSTIC IMAGE
yH=5.90; xW=5.65;
% E1
Single_DiagnosticPlot_Plox(PE.E1.P_P1,LsProp,'0.05 cm case')
if sf1, savethisoneTS(TPath,['403_LS',Ess,'_04_E1'],xW,yH,'noCbar','siTrans'); else end % SAVE to thesis Doc path ;)

%E2
Single_DiagnosticPlot_Plox(PE.E2.P_P1,LsProp,'0.10 cm case')
if sf1, savethisoneTS(TPath,['403_LS',Ess,'_04_E2'],xW,yH,'noCbar','siTrans'); else end % SAVE to thesis Doc path ;)

%E3
Single_DiagnosticPlot_Plox(PE.E3.P_P1,LsProp,'0.20 cm case')
if sf1, savethisoneTS(TPath,['403_LS',Ess,'_04_E3'],xW,yH,'noCbar','siTrans'); else end % SAVE to thesis Doc path ;)



%-- Nu ROC-AUC plot 
%%{
% Generate plot
 ROC_MetaPlotter_LS(Control_ROC,PE,'Soft')
% Save Plot
 if sf1, savethisoneAsIs(PPath,DTag,'10 ROC Curves together'); else end %->Old Place
%-> Thesis Place
 if sf1, savethisoneTS(TPath,'403_LSCPE_03',10,9,'noC','siTrans'); else end % SAVE to thesis Doc path ;)


%--Nu ICM plot 
%{ 
%-Define Thick marks 
xValues=[0.05,.1,.2];
xTicksValues=0:0.05:0.2;
xTicksLabels=[{'0'},{'      0.05 cm'},{'      0.10 cm'},{'      0.15 cm'},{'      0.20 cm'}];

%-Combines summaries into one with control as the first element
combined_summary=[PC.Set_Summary;PE.Set_Summary]; 

%-/> Adjusted summary
MixSum=combined_summary;

    %-/>> Define t for Confidence Intervals
        ln=3;
        alpha=0.05; %
        % using a 95% confidence interval
        three_exp_t_critValue=tinv(1-(alpha/2),ln-1);
        disp(['t critical value ',num2str(three_exp_t_critValue)]);
        %three_exp_t_critValue=4.302;  

    for ii=1:4 %Trims CI to critValue 4.302
    MixSum(ii).gScR_SE=MixSum(ii).gScR_s/sqrt(ln);
    MixSum(ii).gTfR_SE=MixSum(ii).gTfR_s/sqrt(ln);
    MixSum(ii).gCcR_SE=MixSum(ii).gCcR_s/sqrt(ln);

    MixSum(ii).gScR_CI=three_exp_t_critValue*MixSum(ii).gScR_SE;
    MixSum(ii).gTfR_CI=three_exp_t_critValue*MixSum(ii).gTfR_SE;
    MixSum(ii).gCcR_CI=three_exp_t_critValue*MixSum(ii).gCcR_SE;
    end 

    %-/>> Replace control SE and CI to those of rotary stage.
    MixSum(1).gScR_SE=rs_PCSUM(1).gScR_SE;
    MixSum(1).gTfR_SE=rs_PCSUM(1).gTfR_SE;
    MixSum(1).gCcR_SE=rs_PCSUM(1).gTfR_SE;

    MixSum(1).gScR_CI=rs_PCSUM(1).gScR_CI;
    MixSum(1).gTfR_CI=rs_PCSUM(1).gTfR_CI;
    MixSum(1).gCcR_CI=rs_PCSUM(1).gCcR_CI;
    
    
%--Runs the plotting comand. 
LS_ICM_Eplot(MixSum,xValues,xTicksValues,xTicksLabels);

%-Accuracy and Precision Marks (Disabled)
%{
AGoal= .20;  % Goal was 2mm accuracy
AValue= .203; % +0.05 uncertainty
PGoal= 0.10;  %  Goal was 1 mm precision,
PValue=0.192; % verified

%-Accuracy Threshold
plot([AGoal; AGoal], [0;40], ':g','LineWidth',1)
plot([AValue; AValue], [0;40], ':m','LineWidth',1)
%}

%-If enabled, saves the fig
 if sf1, savethisoneAsIs(PPath,DTag,'D Plotted Contrast Metrics MIX'); else end
 
 if sf1, savethisoneTS(TPath,'403_LSCPE_02',13,10); else end % SAVE to thesis Doc path ;)
  
  
   
%-Save the xlxs file for later use
mario_estructExceler2table(MixSum,PPath,[DTag,'D Table of Contrast Metrics MIX'])
%-End
%}

%Spatial Error and AUC metrics and table%
%{
%--------Spatial Error--------
PE=LS_SummaryFixer(PE,LsProp,DTag);
% Formula start
tSummy=LS_POS_Summary(PE,DTag,LsProp);
% export to excel
estructExceler2table(tSummy,[lsPath,G_name],[DTag,G_name]);

%--------AUC Metrics--------
Nu=ROC_MetaExceler(Control_ROC,PE);
estructExceler2table(Nu,[cd,'\',DTag,F_name],[DTag,F_name])

% END Saves RAE_Processed
save([DTag,'PE'],'PE')
%}

%%  
%______
%---------- Extra REP
%""""""""""""""

%% 3 RREP
clear PE DTag tSummy Nu

%----Load Set PE
Ess='REP';
cd([lsPath,'LST ',Ess])
DTag=['LST',Ess,'_0828_']; 
load([lsPath,'LST ',Ess,'\LSTREP_0826_PE']);    

%Spatial Error and AUC metrics and table%
%{
%--------Spatial Error--------
PE=LS_SummaryFixer(PE,LsProp,DTag);
% Formula start
tSummy=LS_POS_Summary_REP(PE,DTag,LsProp);
% export to excel
estructExceler2table(tSummy,[lsPath,G_name],[DTag,G_name]);

%--------AUC Metrics--------
Nu=ROC_MetaExceler(Control_ROC,PE);
estructExceler2table(Nu,[cd,'\',DTag,F_name],[DTag,F_name])

% END Saves RAE_Processed
save([DTag,'PE'],'PE')
%}