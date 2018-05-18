function PE=ROT_SummaryFixer(PE,sProp,DTag)
% RemakesSummary/Diagnostic of the PE.
PE=ErrorSet_RUN_DiagnosticScript(PE,sProp);
PE=ErrorSet_ImageMetricsRetroFix(PE); 
PE=ErrorSet_RecoQualityMetricsRetroFix(PE);
PE=ErrorSet_summaryMaker(PE,DTag);