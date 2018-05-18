function group_plotOfThree_LS(ExpSet,sProp,DTag,ETag,sf1)
% Plots an image of the three scans for each experiment
Im1=ExpSet.P_P1.A_masked;
Im2=ExpSet.P_P2.A_masked;

Im3=NaN(size(Im2));
Im3(sProp.Masks.mask_tumorHandBig)=Im2(sProp.Masks.mask_tumorHandBig);
Im3(sProp.Masks.mask_fibroHandBig)=Im2(sProp.Masks.mask_fibroHandBig);
plot_ImageofThree(Im1,Im2,Im3,sProp,'On')

if sf1, savethisoneAsIs(DTag,[ETag,'01 Plot ImageofThree']),end