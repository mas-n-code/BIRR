function ExpSet= ExpSet_RUN_Hypothesis(ExpSet)

%Two-sample Kolmogorov-Smirnov test.
% Determines whether two independent samples come from the same distribution
% if h=1 then the null hypothesis (same dist) is rejected at the alpha level (0.05%)
% if h=1 At the 95% confidence interval, the null hypothesis that both samples come from the same distribution is rejected 

[h1,p1] = kstest2(ExpSet.CALL.call_tumor,ExpSet.CALL.call_fibro,'Alpha', 0.05);
[h2,p2] = kstest2(ExpSet.CALL.call_tumor,[ExpSet.CALL.call_clutter],'Alpha', 0.05);
[h3,p3] = kstest2(ExpSet.CALL.call_tumor,[ExpSet.CALL.call_fibro;ExpSet.CALL.call_clutter],'Alpha', 0.05);
[h4,p4] = kstest2(ExpSet.CALL.call_tumor,ExpSet.CALL.call_rest,'Alpha', 0.05);

ExpSet.HYP.RejectTumorSameasFibro=[h1,p1];
ExpSet.HYP.RejectTumorSameasClutter=[h2,p2];
ExpSet.HYP.RejectTumorSameasFibroClutter=[h3,p3];
ExpSet.HYP.RejectTumorSameasRest=[h4,p4];