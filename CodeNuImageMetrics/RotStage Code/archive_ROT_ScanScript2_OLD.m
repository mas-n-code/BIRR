
%--------------------------------------------------------------------------
%---------------------mario_ROT_ScanScript2-----------------------------
%--------------------------------------------------------------------------

% Process the erroneous scan images, extracts the energy from the tumor and
% fibro at their corresponding locations. Elminate bottom 95% (clutter)
% Generate boxplots of three control scans. 

%% -- Initialize
%Load sProp settings from Control Scans
try cd('F:\UserElGuapo\Google Drive\masterSets\RotaryStage\CONTROL SCANS');
catch
    cd('E:\Users\mario\Google Drive\masterSets\RotaryStage\CONTROL SCANS');
end
load 


% Open directory where Erroneous Images are located
try cd('F:\UserElGuapo\Google Drive\masterSets\RotaryStage\SAE'); %<- Starts with the Single Accuracy Error 5 deg
catch cd('E:\Users\mario\Google Drive\masterSets\RotaryStage\SAE')
end

% Load Scan caracteristics 
load SAEs_ScansOnly

SAE4_P1=SAEs_ScansOnly.PD_P1.E4.SCAN.Fig_c_RecZoomFlip_abs;
SAE4_P2=SAEs_ScansOnly.PD_P2.E4.SCAN.Fig_c_RecZoomFlip_abs;
SAE4_P3=SAEs_ScansOnly.PD_P3.E4.SCAN.Fig_c_RecZoomFlip_abs;

%% 01 Printo SAE angle 5

figure; imagesc(SAEs_ScansOnly.PD_P3.E12.SCAN.Fig_c_RecZoomFlip_abs)

plot_ImageofThree(SAE4_P1,...
    SAE4_P2,...
    SAE4_P3,...
    sProp)

%% 02 Extracts values from pre-defined regions and masks the array

[PD_P1.E4.A_masked,PD_P1.E4.R_Values]=mario_segmenter_FromTargetMask(SAE4_P1,sProp.Masks);
[PD_P2.E4.A_masked,PD_P2.E4.R_Values]=mario_segmenter_FromTargetMask(SAE4_P2,sProp.Masks);
[PD_P3.E4.A_masked,PD_P3.E4.R_Values]=mario_segmenter_FromTargetMask(SAE4_P3,sProp.Masks);

%update image arrays, only used to plot
SAE4_P1=PD_P1.E4.A_masked;
SAE4_P2=PD_P2.E4.A_masked;
SAE4_P3=PD_P3.E4.A_masked;

% Print masked (circular) arrays
plot_ImageofThree(SAE4_P1,...
    SAE4_P2,...
    SAE4_P3,...
    sProp)
savethisoneAsIs('Test GoGoRanger')
%% 03 Remove values under background threshold level
thres_val=sProp.threshVal_back;

[PD_P1.E4,PD_P2.E4,PD_P3.E4]= mario_TryThresholdTool(thres_val,PD_P1.E4,PD_P2.E4,PD_P3.E4,sProp);


%% 04 Generate group regions for group analysis    %<----------------------- Needs much work, probably better to do ALL ERRORS AT ONCE


call_tumor= [PD_P1.E4.R_tValues.tumor;
             PD_P2.E4.R_tValues.tumor;
             PD_P3.E4.R_tValues.tumor;];
        
call_fibro = [PD_P1.E4.R_tValues.fibro;
              PD_P2.E4.R_tValues.fibro;
              PD_P3.E4.R_tValues.fibro];
        
call_clutter = [PD_P1.E4.R_tValues.clutter;
              PD_P2.E4.R_tValues.clutter;
              PD_P3.E4.R_tValues.clutter];
          
call_rest= [PD_P1.E4.R_Values.rest; % Note that Call_rest has background information of no use
            PD_P2.E4.R_Values.rest;
            PD_P3.E4.R_Values.rest];
        
        % Add them to Parent structure
call_Arrays.call_tumor=call_tumor;
call_Arrays.call_fibro=call_fibro;
call_Arrays.call_clutter=call_clutter;
call_Arrays.call_rest=call_rest;

call_metrics.tumor.median=median(call_tumor);
call_metrics.fibro.median=median(call_fibro);
call_metrics.clutter.median=median(call_clutter);

call_metrics.tumor.mean=mean(call_tumor);
call_metrics.fibro.mean=mean(call_fibro);
call_metrics.clutter.mean=mean(call_clutter);


mario_plotterOfSwarm(PD_P1.E4,PD_P2.E4,PD_P3.E4)
savethisone11('04 swarm scatter E4')


%% 05 Run ROC curve test

Group_roc_E4=ROT_ROC_RUN(call_Arrays);
savethisone11('05 ROC SAE E4')

%% 06 Run SCR test (or other tests)
%Run Image metric RetroFix

[PD_P1] = Phantom_ImageMetricsRetroFix(PD_P1); 
[PD_P1] = Phantom_RecoQualityMetrics(PD_P1); 

[PD_P2] = Phantom_ImageMetricsRetroFix(PD_P2); 
[PD_P2] = Phantom_RecoQualityMetrics(PD_P2); 

[PD_P3] = Phantom_ImageMetricsRetroFix(PD_P3); 
[PD_P3] = Phantom_RecoQualityMetrics(PD_P3); 



%% 07 Run diagnostic scrpit                   <-------------------------------Under constructions
%Finds tumors avobe thresholds, if more than 2 pixel, it counts and detects
% its center. 
[PD_P1]=Phantom_DiagnosticScript(PD_P1,sProp);
[PD_P2]=Phantom_DiagnosticScript(PD_P2,sProp);
[PD_P3]=Phantom_DiagnosticScript(PD_P3,sProp);

SAE_Processed.PD_P1=PD_P1;
SAE_Processed.PD_P2=PD_P2;
SAE_Processed.PD_P3=PD_P3;
SAE_Processed.GroupAnalysis.E4.ROC=Group_roc_E4;
SAE_Processed.GroupAnalysis.E4.call_Arrays =call_Arrays;

%Saves SAE_Processed
Save SAE_Processed SAE_Processed

