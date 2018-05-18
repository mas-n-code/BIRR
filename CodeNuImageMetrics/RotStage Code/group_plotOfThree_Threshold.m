function group_plotOfThree_Threshold(ExpSet,sProp,DTag,s_FigName,sf1)
% Plots an image of the three scans for each experiment
Im1=ExpSet.P_P1.A_tmasked;
Im2=ExpSet.P_P2.A_tmasked;
Im3=ExpSet.P_P3.A_tmasked;
plot_ImageofThree(Im1,Im2,Im3,sProp,'Off')

if sf1, savethisoneAsIs(DTag,s_FigName),end