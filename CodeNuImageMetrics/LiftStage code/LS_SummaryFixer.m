function PE=LS_SummaryFixer(PE,sProp,DTag)
% RemakesSummary/Diagnostic of the PE.
PE=ErrorSet_RUN_DiagnosticScript_LS(PE,sProp);
PE=ErrorSet_ImageMetricsRetroFix_LS(PE); 
PE=ErrorSet_RecoQualityMetricsRetroFix_LS(PE);
try PE=ErrorSet_summaryMaker_LS(PE,DTag);
catch
    PE=ErrorSet_summaryMaker_LS_REP(PE,DTag);
end