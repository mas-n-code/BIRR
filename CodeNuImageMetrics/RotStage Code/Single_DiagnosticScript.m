function [tFound]=Single_DiagnosticScript(Phantom,sProp)
% Runs the diagnostic command

tFound.tX=0;

tFound.imgTumors_mask=(Phantom.A_tmasked>=sProp.threshVal_tumor);

tFound.values=Phantom.A_tmasked(tFound.imgTumors_mask);

if length(tFound.values)>=2
    tFound.tX=1;
    [tFound.center(:,2),tFound.center(:,1)]=find(Phantom.A_tmasked==(max(tFound.values)));
    s_tring1=('Tumor! Present on this image');
    tumors=sProp.Masks.mask_tumorHand;
    isthere=tumors(tFound.center(2),tFound.center(1));
    if isthere
        
        s_tring2=(', where expected!');
    else
        s_tring2=('... somewhere?');
    end
    tFound.OnRegion=isthere;
    sOutcome=[s_tring1,s_tring2];
       
else
    sOutcome='Lucky! You cancer is gone';
    tFound.OnRegion=NaN;
end
disp(sOutcome);
tFound.Outcome=sOutcome;

