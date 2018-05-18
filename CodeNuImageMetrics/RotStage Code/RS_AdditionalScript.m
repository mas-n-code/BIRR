% ROC Excel correcter and SpatialPos Exceler for Lift Stage
DDD='_0929_';
STag='rs';
lsPath='G:\Google Drive\masterSets\LiftStage\1 Top\';
rsPath='G:\Google Drive\masterSets\RotaryStage\';

%%
% Load control values
%Load Control values, this will be used to compare all the experiments
    load([rsPath,'CONTROL SCANS\RPCON_0823_PC.mat']);
    load([rsPath,'CONTROL SCANS\D0819_sProp']);  % Load SProp
    
%Define some global vairables  
sf1=1;
%{
 
 G_name='G_SpatialErrors';
 F_name='F_RocSummary Excel';
%}    
Control_ROC=PC.E1.ROC.Roc_TumorVsFC;

rs_PCSUM=PC.Set_Summary;


%% THE CONTROL IMAGES

%% ---1 CON CON
clear PE DTag tSummy Nu
%-DefineTag
Ess='CON';
DTag=[STag,Ess,DDD]; 

%-Load Set PE



%-Define TPath
TPath='G:\Dropbox\ResearchMagic\T H E S I S\Chapter 4\FigFolder\02Methods\ConRec\';

close all;
%E1P1
plot_ImageofOne(PC.E1.P_P1.A_masked,sProp,'On','Control scan \itp_1')
if sf1, savethisoneTS(TPath,['403_',Ess,'_01a_E1P1'],8.00,6.25,'c','siTrans'); else end % SAVE to thesis Doc path ;)

%E1P2
plot_ImageofOne(PC.E1.P_P2.A_masked,sProp,'On','Control scan \itp_2')
if sf1, savethisoneTS(TPath,['403_',Ess,'_01a_E1P2'],8.00,6.25,'c','siTrans'); else end % SAVE to thesis Doc path ;)

%E1P3
plot_ImageofOne(PC.E1.P_P3.A_masked,sProp,'On','Control scan \itp_3')
if sf1, savethisoneTS(TPath,['403_',Ess,'_01a_E1P3'],8.00,6.25,'c','siTrans'); else end % SAVE to thesis Doc path ;)






%% ---1 RSAE SAE Accuracy
clear PE DTag tSummy Nu TPath Ess PPath
%-DefineTag
Ess='SAE';
DTag=[STag,Ess,DDD]; 

%-Load Set PE

PPath=([rsPath,Ess,'\']);
cd(PPath); %_ probalby check were the values are being stored
load([PPath,'R',Ess,'_0828_PE.mat']);      


%-Define TPath
TPath=['G:\Dropbox\ResearchMagic\T H E S I S\Chapter 4\FigFolder\03Results\403R',Ess,'\'];
close all;


%E1
plot_ImageofOne(PE.E1.P_P1.A_masked,sProp,'On')
if sf1, savethisoneTS(TPath,['403_',Ess,'_01a_E1P1'],8.24,6.7,'c','siTrans'); else end % SAVE to thesis Doc path ;)

% %E2
% plot_ImageofOne(PE.E2.P_P1.A_masked,sProp,'On')
% if sf1, savethisoneTS(TPath,['403_',Ess,'_01x_E1P1'],8.24,6.7); else end % SAVE to thesis Doc path ;)
% 
% %E4
% plot_ImageofOne(PE.E4.P_P1.A_masked,sProp,'On')
% if sf1, savethisoneTS(TPath,['403_',Ess,'_01x_E4P1'],8.24,6.7); else end % SAVE to thesis Doc path ;)

%E12
plot_ImageofOne(PE.E12.P_P1.A_masked,sProp,'On')
if sf1, savethisoneTS(TPath,['403_',Ess,'_01b_E12P1'],8.24,6.7,'c','siTrans'); else end % SAVE to thesis Doc path ;)

%--Nu ICM plot 
%%{ 
%Load control variable
sf1=1; 
xValues=[1.25,2.5,5,15];
xTicksValues=[0,1.25,2.5,5,7.25,10,12.25,15];
xTicksLabels=[{'0°'},{'1.25°'},{'2.5°'},{'5°'},{'7.25°'},{'10°'},{'12.25°'},{'15°'}];

%-Combines summaries into one with control as the first element
combined_summary=[PC.Set_Summary;PE.Set_Summary]; 

    %Runs the plotting comand. 
    ROT_ICM_Eplot(combined_summary,xValues,xTicksValues,xTicksLabels);

    %Accuracy Threshold
     set(gca,'ylim',[0,30]);
     
if sf1, savethisoneTS(TPath,['403_',Ess,'_02'],13,10,'noc','siTrans'); else end % SAVE to thesis Doc path ;)
     
%}

%-- Nu ROC-AUC plot 
% Generate plot
 ROC_MetaPlotter(Control_ROC,PE,'Soft');
 
 if sf1, savethisoneTS(TPath,['403_',Ess,'_03'],10,9,'noCBar','siTrans'); else end % SAVE to thesis Doc path ;)
 %}

 
%% ---3 RSPE SPE Precision
clear PE DTag tSummy Nu TPath Ess PPath

%-DefineTag
Ess='SPE';
DTag=[STag,Ess,DDD]; 
sf1=1; 

%-Load Set PE
PPath=([rsPath,Ess,'\']);
cd(PPath); %_ probalby check were the values are being stored
load([PPath,'R',Ess,'_0828_PE.mat']);      

%-Define TPath
TPath=['G:\Dropbox\ResearchMagic\T H E S I S\Chapter 4\FigFolder\03Results\403R',Ess,'\'];
cd(TPath)
close all;


%-- IMAGE RECO
%E1
plot_ImageofOne(PE.E1.P_P1.A_masked,sProp,'On')
if sf1, savethisoneTS(TPath,['403_',Ess,'_01a_E1P1'],8.24,6.7,'c','siTrans'); else end % SAVE to thesis Doc path ;)

% %E2
% plot_ImageofOne(PE.E2.P_P1.A_masked,sProp,'On')
% if sf1, savethisoneTS(TPath,['403_',Ess,'_01x_E1P1'],8.24,6.7); else end % SAVE to thesis Doc path ;)
% 
% %E4
% plot_ImageofOne(PE.E4.P_P1.A_masked,sProp,'On')
% if sf1, savethisoneTS(TPath,['403_',Ess,'_01x_E4P1'],8.24,6.7); else end % SAVE to thesis Doc path ;)

%E12
plot_ImageofOne(PE.E12.P_P1.A_masked,sProp,'On')
if sf1, savethisoneTS(TPath,['403_',Ess,'_01b_E12P1'],8.24,6.7,'c','siTrans'); else end % SAVE to thesis Doc path ;)


%-- Nu ICM PLOT 
%%{ 
%Load control variable
xValues=[1.25,2.5,5,15];
xTicksValues=[0,1.25,2.5,5,7.25,10,12.25,15];
xTicksLabels=[{'0°'},{'1.25°'},{'2.5°'},{'5°'},{'7.25°'},{'10°'},{'12.25°'},{'15°'}];

%-Combines summaries into one with control as the first element
combined_summary=[PC.Set_Summary;PE.Set_Summary]; 

    %Runs the plotting comand. 
    ROT_ICM_Eplot(combined_summary,xValues,xTicksValues,xTicksLabels);

    %Accuracy Threshold
     set(gca,'ylim',[0,30]);
     
if sf1, savethisoneTS(TPath,['403_',Ess,'_02'],13,10,'noCBar','siTrans'); else end % SAVE to thesis Doc path ;)   
%}


%-- Nu ROC-AUC PLOT 
% Generate plot
 ROC_MetaPlotter(Control_ROC,PE,'Soft');
 
 if sf1, savethisoneTS(TPath,['403_',Ess,'_03'],10,9,'noCBar','siTrans'); else end % SAVE to thesis Doc path ;)
 %}
  
 

 
  %% ---4 CAE CAE Accuracy
clear PE DTag tSummy Nu TPath Ess PPath

%-DefineTag
Ess='CAE';
DTag=[STag,Ess,DDD]; 
sf1=1; 

%-Load Set PE
PPath=([rsPath,Ess,'\']);
cd(PPath); %_ probalby check were the values are being stored
load([PPath,'R',Ess,'_0828_PE.mat']);      

%-Define TPath
TPath=['G:\Dropbox\ResearchMagic\T H E S I S\Chapter 4\FigFolder\03Results\403R',Ess,'\'];
cd(TPath)
close all;


%-- IMAGE RECO
%E1
% plot_ImageofOne(PE.E1.P_P1.A_masked,sProp,'On')
% if sf1, savethisoneTS(TPath,['403_',Ess,'_01a_E1P1'],8.24,6.7,'c','siTrans'); else end % SAVE to thesis Doc path ;)

% %E2
% plot_ImageofOne(PE.E2.P_P1.A_masked,sProp,'On')
% if sf1, savethisoneTS(TPath,['403_',Ess,'_01x_E1P1'],8.24,6.7,'c','siTrans'); else end % SAVE to thesis Doc path ;)
% 
%E4
plot_ImageofOne(PE.E4.P_P1.A_masked,sProp,'On')
if sf1, savethisoneTS(TPath,['403_',Ess,'_01a_E4P1'],8.24,6.7,'c','siTrans'); else end % SAVE to thesis Doc path ;)

%E12
plot_ImageofOne(PE.E12.P_P1.A_masked,sProp,'On')
if sf1, savethisoneTS(TPath,['403_',Ess,'_01b_E12P1'],8.24,6.7,'c','siTrans'); else end % SAVE to thesis Doc path ;)


%-- DIAGNOSTIC IMAGE
yW=5.6; xW=5.68;
%E1
Single_DiagnosticPlot_Plox(PE.E1.P_P1,sProp,'1.25\circ')
if sf1, savethisoneTS(TPath,['403_',Ess,'_04_E1P1'],xW,yH,'noCbar','siTrans'); else end % SAVE to thesis Doc path ;)

%E2
Single_DiagnosticPlot_Plox(PE.E2.P_P1,sProp,'2.5\circ')
if sf1, savethisoneTS(TPath,['403_',Ess,'_04_E2P1'],xW,yH,'noCbar','siTrans'); else end % SAVE to thesis Doc path ;)

%E3
Single_DiagnosticPlot_Plox(PE.E4.P_P1,sProp,'5\circ')
if sf1, savethisoneTS(TPath,['403_',Ess,'_04_E4P1'],xW,yH,'noCbar','siTrans'); else end % SAVE to thesis Doc path ;)

%E12
Single_DiagnosticPlot_Plox(PE.E12.P_P3,sProp,'15\circ')
if sf1, savethisoneTS(TPath,['403_',Ess,'_04_E12P1'],xW,yH,'noCbar','siTrans'); else end % SAVE to thesis Doc path ;)






%-- Nu ICM PLOT 
%%{ 
%Load control variable
xValues=[1.25,2.5,5,15];
xTicksValues=[0,1.25,2.5,5,7.25,10,12.25,15];
xTicksLabels=[{'0°'},{'1.25°'},{'2.5°'},{'5°'},{'7.25°'},{'10°'},{'12.25°'},{'15°'}];

%-Combines summaries into one with control as the first element
combined_summary=[PC.Set_Summary;PE.Set_Summary]; 

    %Runs the plotting comand. 
    ROT_ICM_Eplot(combined_summary,xValues,xTicksValues,xTicksLabels);

    %Accuracy Threshold
     set(gca,'ylim',[0,30]);
     
if sf1, savethisoneTS(TPath,['403_',Ess,'_02'],13,10,'noCBar','siTrans'); else end % SAVE to thesis Doc path ;)   
%}


%-- Nu ROC-AUC PLOT 
% Generate plot
 ROC_MetaPlotter(Control_ROC,PE,'Soft');
 
 if sf1, savethisoneTS(TPath,['403_',Ess,'_03'],10,9,'noCBar','siTrans'); else end % SAVE to thesis Doc path ;)
 %}
  
  %% ---5 CPE CPE Precison
clear PE DTag tSummy Nu TPath Ess PPath

%-DefineTag
Ess='CPE';
DTag=[STag,Ess,DDD]; 
sf1=1; 

%-Load Set PE
PPath=([rsPath,Ess,'\']);
cd(PPath); %_ probalby check were the values are being stored
load([PPath,'R',Ess,'_0828_PE.mat']);      

%-Define TPath
TPath=['G:\Dropbox\ResearchMagic\T H E S I S\Chapter 4\FigFolder\03Results\403R',Ess,'\'];
cd(TPath)
close all;


%-- IMAGE RECO
%E1
plot_ImageofOne(PE.E1.P_P1.A_masked,sProp,'On')
if sf1, savethisoneTS(TPath,['403_',Ess,'_01a_E1P1'],8.24,6.7,'c','siTrans'); else end % SAVE to thesis Doc path ;)

% %E2
plot_ImageofOne(PE.E2.P_P1.A_masked,sProp,'On')
if sf1, savethisoneTS(TPath,['403_',Ess,'_01b_E2P1'],8.24,6.7,'c','siTrans'); else end % SAVE to thesis Doc path ;)

%E4
plot_ImageofOne(PE.E4.P_P1.A_masked,sProp,'On')
if sf1, savethisoneTS(TPath,['403_',Ess,'_01c_E4P1'],8.24,6.7,'c','siTrans'); else end % SAVE to thesis Doc path ;)

%E12
plot_ImageofOne(PE.E12.P_P1.A_masked,sProp,'On')
if sf1, savethisoneTS(TPath,['403_',Ess,'_01d_E12P1'],8.24,6.7,'c','siTrans'); else end % SAVE to thesis Doc path ;)


%-- DIAGNOSTIC IMAGE
yH=5.68; xW=5.68;
%E1
% Single_DiagnosticPlot_Plox(PE.E1.P_P1,sProp,'1.25\circ')
% if sf1, savethisoneTS(TPath,['403_',Ess,'_04_E1P1'],xW,yH,'noCbar','siTrans'); else end % SAVE to thesis Doc path ;)
% 
% %E2
% Single_DiagnosticPlot_Plox(PE.E2.P_P1,sProp,'2.5\circ')
% if sf1, savethisoneTS(TPath,['403_',Ess,'_04_E2P1'],xW,yH,'noCbar','siTrans'); else end % SAVE to thesis Doc path ;)

%E3
Single_DiagnosticPlot_Plox(PE.E4.P_P1,sProp,'5\circ case')
if sf1, savethisoneTS(TPath,['403_',Ess,'_04_E4P1'],xW,yH,'noCbar','siTrans'); else end % SAVE to thesis Doc path ;)

%E12
Single_DiagnosticPlot_Plox(PE.E12.P_P3,sProp,'15\circ case')
if sf1, savethisoneTS(TPath,['403_',Ess,'_04_E12P1'],xW,yH,'noCbar','siTrans'); else end % SAVE to thesis Doc path ;)


%-- Nu ICM PLOT 
%%{ 
%Load control variable
xValues=[1.25,2.5,5,15];
xTicksValues=[0,1.25,2.5,5,7.25,10,12.25,15];
xTicksLabels=[{'0°'},{'1.25°'},{'2.5°'},{'5°'},{'7.25°'},{'10°'},{'12.25°'},{'15°'}];

%-Combines summaries into one with control as the first element
combined_summary=[PC.Set_Summary;PE.Set_Summary]; 

    %Runs the plotting comand. 
    ROT_ICM_Eplot(combined_summary,xValues,xTicksValues,xTicksLabels);

    %Accuracy Threshold
     set(gca,'ylim',[0,30]);
     
if sf1, savethisoneTS(TPath,['403_',Ess,'_02'],13,10,'noCBar','siTrans'); else end % SAVE to thesis Doc path ;)   
%}


%-- Nu ROC-AUC PLOT 
% Generate plot
 ROC_MetaPlotter(Control_ROC,PE,'Soft');
 
 if sf1, savethisoneTS(TPath,['403_',Ess,'_03'],10,9,'noCBar','siTrans'); else end % SAVE to thesis Doc path ;)
 %}
 
 %% ---6 RAE RAE Accuracy
clear PE DTag tSummy Nu TPath Ess PPath

%-DefineTag
Ess='RAE';
DTag=[STag,Ess,DDD]; 
sf1=1; 

%-Load Set PE
PPath=([rsPath,Ess,'\']);
cd(PPath); %_ probalby check were the values are being stored
load([PPath,'R',Ess,'_0828_PE.mat']);      

%-Define TPath
TPath=['G:\Dropbox\ResearchMagic\T H E S I S\Chapter 4\FigFolder\03Results\403R',Ess,'\'];
cd(TPath)
close all;


% %-- IMAGE RECO
% %E1
% plot_ImageofOne(PE.E1.P_P1.A_masked,sProp,'On')
% if sf1, savethisoneTS(TPath,['403_',Ess,'_01a_E1P1'],8.24,6.7,'c','siTrans'); else end % SAVE to thesis Doc path ;)
% 
% % %E2
% plot_ImageofOne(PE.E2.P_P1.A_masked,sProp,'On')
% if sf1, savethisoneTS(TPath,['403_',Ess,'_01b_E2P1'],8.24,6.7,'c','siTrans'); else end % SAVE to thesis Doc path ;)

%E4
plot_ImageofOne(PE.E4.P_P1.A_masked,sProp,'On')
if sf1, savethisoneTS(TPath,['403_',Ess,'_01a_E4P1'],8.24,6.7,'c','siTrans'); else end % SAVE to thesis Doc path ;)

%E12
plot_ImageofOne(PE.E12.P_P1.A_masked,sProp,'On')
if sf1, savethisoneTS(TPath,['403_',Ess,'_01b_E12P1'],8.24,6.7,'c','siTrans'); else end % SAVE to thesis Doc path ;)


%-- DIAGNOSTIC IMAGE
yH=5.68; xW=5.68;
%E1
% Single_DiagnosticPlot_Plox(PE.E1.P_P1,sProp,'1.25\circ')
% if sf1, savethisoneTS(TPath,['403_',Ess,'_04_E1P1'],xW,yH,'noCbar','siTrans'); else end % SAVE to thesis Doc path ;)
% 
% %E2
% Single_DiagnosticPlot_Plox(PE.E2.P_P1,sProp,'2.5\circ')
% if sf1, savethisoneTS(TPath,['403_',Ess,'_04_E2P1'],xW,yH,'noCbar','siTrans'); else end % SAVE to thesis Doc path ;)

% %E3
% Single_DiagnosticPlot_Plox(PE.E4.P_P1,sProp,'5\circ case')
% if sf1, savethisoneTS(TPath,['403_',Ess,'_04_E4P1'],xW,yH,'noCbar','siTrans'); else end % SAVE to thesis Doc path ;)
% 
% %E12
% Single_DiagnosticPlot_Plox(PE.E12.P_P3,sProp,'15\circ case')
% if sf1, savethisoneTS(TPath,['403_',Ess,'_04_E12P1'],xW,yH,'noCbar','siTrans'); else end % SAVE to thesis Doc path ;)


%-- Nu ICM PLOT 
%%{ 
%Load control variable
xValues=[1.25,2.5,5,15];
xTicksValues=[0,1.25,2.5,5,7.25,10,12.25,15];
xTicksLabels=[{'0°'},{'1.25°'},{'2.5°'},{'5°'},{'7.25°'},{'10°'},{'12.25°'},{'15°'}];

%-Combines summaries into one with control as the first element
combined_summary=[PC.Set_Summary;PE.Set_Summary]; 

    %Runs the plotting comand. 
    ROT_ICM_Eplot(combined_summary,xValues,xTicksValues,xTicksLabels);

    %Accuracy Threshold
     set(gca,'ylim',[0,30]);
     
if sf1, savethisoneTS(TPath,['403_',Ess,'_02'],13,10,'noCBar','siTrans'); else end % SAVE to thesis Doc path ;)   
%}


%-- Nu ROC-AUC PLOT 
% Generate plot
 ROC_MetaPlotter(Control_ROC,PE,'Soft');
 
 if sf1, savethisoneTS(TPath,['403_',Ess,'_03eps'],10,9,'noCBar','siTrans'); else end % SAVE to thesis Doc path ;)
 %}
 
 
 %% ---6 RPE RPE Precision
clear PE DTag tSummy Nu TPath Ess PPath

%-DefineTag
Ess='RPE';
DTag=[STag,Ess,DDD]; 
sf1=1; 

%-Load Set PE
PPath=([rsPath,Ess,'\']);
cd(PPath); %_ probalby check were the values are being stored
load([PPath,'R',Ess,'_0828_PE.mat']);      

%-Define TPath
TPath=['G:\Dropbox\ResearchMagic\T H E S I S\Chapter 4\FigFolder\03Results\403R',Ess,'\'];
cd(TPath)
close all;


% %-- IMAGE RECO
%E1
plot_ImageofOne(PE.E1.P_P1.A_masked,sProp,'On')
if sf1, savethisoneTS(TPath,['403_',Ess,'_01a_E1P1'],8.24,6.7,'c','siTrans'); else end % SAVE to thesis Doc path ;)

% %E2
plot_ImageofOne(PE.E2.P_P1.A_masked,sProp,'On')
if sf1, savethisoneTS(TPath,['403_',Ess,'_01b_E2P1'],8.24,6.7,'c','siTrans'); else end % SAVE to thesis Doc path ;)

%E4
plot_ImageofOne(PE.E4.P_P1.A_masked,sProp,'On')
if sf1, savethisoneTS(TPath,['403_',Ess,'_01c_E4P1'],8.24,6.7,'c','siTrans'); else end % SAVE to thesis Doc path ;)

%E12
plot_ImageofOne(PE.E12.P_P1.A_masked,sProp,'On')
if sf1, savethisoneTS(TPath,['403_',Ess,'_01d_E12P1'],8.24,6.7,'c','siTrans'); else end % SAVE to thesis Doc path ;)


%-- DIAGNOSTIC IMAGE
yH=5.95; xW=5.68;
%E1
% Single_DiagnosticPlot_Plox(PE.E1.P_P1,sProp,'1.25\circ')
% if sf1, savethisoneTS(TPath,['403_',Ess,'_04_E1P1'],xW,yH,'noCbar','siTrans'); else end % SAVE to thesis Doc path ;)
% 
% %E2
% Single_DiagnosticPlot_Plox(PE.E2.P_P1,sProp,'2.5\circ')
% if sf1, savethisoneTS(TPath,['403_',Ess,'_04_E2P1'],xW,yH,'noCbar','siTrans'); else end % SAVE to thesis Doc path ;)

% %E3
% Single_DiagnosticPlot_Plox(PE.E4.P_P1,sProp,'5\circ case')
% if sf1, savethisoneTS(TPath,['403_',Ess,'_04_E4P1'],xW,yH,'noCbar','siTrans'); else end % SAVE to thesis Doc path ;)
% 
% %E12
Single_DiagnosticPlot_Plox(PE.E12.P_P1,sProp,'15\circ case (\itp_1)')
if sf1, savethisoneTS(TPath,['403_',Ess,'_04_E12P1'],xW,yH,'noCbar','siTrans'); else end % SAVE to thesis Doc path ;)


%-- Nu ICM PLOT 
%%{ 
%Load control variable
xValues=[1.25,2.5,5,15];
xTicksValues=[0,1.25,2.5,5,7.25,10,12.25,15];
xTicksLabels=[{'0°'},{'1.25°'},{'2.5°'},{'5°'},{'7.25°'},{'10°'},{'12.25°'},{'15°'}];

%-Combines summaries into one with control as the first element
combined_summary=[PC.Set_Summary;PE.Set_Summary]; 

    %Runs the plotting comand. 
    ROT_ICM_Eplot(combined_summary,xValues,xTicksValues,xTicksLabels);

    %Accuracy Threshold
     set(gca,'ylim',[0,30]);
     
if sf1, savethisoneTS(TPath,['403_',Ess,'_02'],13,10,'noCBar','siTrans'); else end % SAVE to thesis Doc path ;)   
%}


%-- Nu ROC-AUC PLOT 
% Generate plot
 ROC_MetaPlotter(Control_ROC,PE,'Soft');
 
 if sf1, savethisoneTS(TPath,['403_',Ess,'_03'],10,9,'noCBar','siTrans'); else end % SAVE to thesis Doc path ;)
 %}
 
 %% ---7 CAE fix CAE fix
clear PE DTag tSummy Nu TPath Ess PPath

%-DefineTag
Ess='CAEFix';
DTag=[STag,Ess,DDD]; 
sf1=1; 

%-Load Set PE
PPath=([rsPath,Ess,'\']);
cd(PPath); %_ probalby check were the values are being stored
load([PPath,'R',Ess,'_0829_PE.mat']);      %CAE fix is the only 29 here

%-Define TPath
TPath=['G:\Dropbox\ResearchMagic\T H E S I S\Chapter 4\FigFolder\03Results\403R',Ess,'\'];
cd(TPath)

close all;


% %-- IMAGE RECO
% %E1
% plot_ImageofOne(PE.E1.P_P1.A_masked,sProp,'On')
% if sf1, savethisoneTS(TPath,['403_',Ess,'_01a_E1P1'],8.24,6.7,'c','siTrans'); else end % SAVE to thesis Doc path ;)
% 
% % %E2
% plot_ImageofOne(PE.E2.P_P1.A_masked,sProp,'On')
% if sf1, savethisoneTS(TPath,['403_',Ess,'_01b_E2P1'],8.24,6.7,'c','siTrans'); else end % SAVE to thesis Doc path ;)
% 
% %E4
% plot_ImageofOne(PE.E4.P_P1.A_masked,sProp,'On')
% if sf1, savethisoneTS(TPath,['403_',Ess,'_01c_E4P1'],8.24,6.7,'c','siTrans'); else end % SAVE to thesis Doc path ;)

%E12
plot_ImageofOne(PE.E12.P_P1.A_masked,sProp,'On')
if sf1, savethisoneTS(TPath,['403_',Ess,'_01_E12P1'],8.24,6.7,'c','siTrans'); else end % SAVE to thesis Doc path ;)


%-- DIAGNOSTIC IMAGE
yH=5.95; xW=5.68;
%E1
% Single_DiagnosticPlot_Plox(PE.E1.P_P1,sProp,'1.25\circ')
% if sf1, savethisoneTS(TPath,['403_',Ess,'_04_E1P1'],xW,yH,'noCbar','siTrans'); else end % SAVE to thesis Doc path ;)
% 
% %E2
% Single_DiagnosticPlot_Plox(PE.E2.P_P1,sProp,'2.5\circ')
% if sf1, savethisoneTS(TPath,['403_',Ess,'_04_E2P1'],xW,yH,'noCbar','siTrans'); else end % SAVE to thesis Doc path ;)

% %E3
% Single_DiagnosticPlot_Plox(PE.E4.P_P1,sProp,'5\circ case')
% if sf1, savethisoneTS(TPath,['403_',Ess,'_04_E4P1'],xW,yH,'noCbar','siTrans'); else end % SAVE to thesis Doc path ;)
% 
% %E12
Single_DiagnosticPlot_Plox(PE.E12.P_P1,sProp,'15\circ case (\itp_1)')
if sf1, savethisoneTS(TPath,['403_',Ess,'_04_E12P1'],xW,yH,'noCbar','siTrans'); else end % SAVE to thesis Doc path ;)


%-- Nu ICM PLOT 
%%{ 
%Load control variable
xValues=[1.25,2.5,5,15];
xTicksValues=[0,1.25,2.5,5,7.25,10,12.25,15];
xTicksLabels=[{'0°'},{'1.25°'},{'2.5°'},{'5°'},{'7.25°'},{'10°'},{'12.25°'},{'15°'}];

%-Combines summaries into one with control as the first element
combined_summary=[PC.Set_Summary;PE.Set_Summary]; 

    %Runs the plotting comand. 
    ROT_ICM_Eplot(combined_summary,xValues,xTicksValues,xTicksLabels);

    %Accuracy Threshold
     set(gca,'ylim',[0,30]);
     
if sf1, savethisoneTS(TPath,['403_',Ess,'_02'],13,10,'noCBar','siTrans'); else end % SAVE to thesis Doc path ;)   
%}


%-- Nu ROC-AUC PLOT 
% Generate plot
 ROC_MetaPlotter(Control_ROC,PE,'Soft');
 
 if sf1, savethisoneTS(TPath,['403_',Ess,'_03'],6.5,6.1,'noCBar','siTrans'); else end % SAVE to thesis Doc path ;)
 %}