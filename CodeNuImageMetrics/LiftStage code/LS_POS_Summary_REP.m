function tSummy=LS_POS_Summary_REP(PE,DTag,sProp)
% tSummy=ROT_POS_Summary=(PE,sProp)
% This beautiful function extracts the position of a tumor and transforms
% ugly pixel coordinates to beautiful 
resP=-sProp.imx_t(1)+sProp.imx_t(2);
trueCMPos_x=sProp.location_tumor(1);
trueCMPos_y=sProp.location_tumor(2);
trueDegPos=atan2d(trueCMPos_y,trueCMPos_x);

% Loop start
c=1;
fnE=fieldnames(PE);
for k=1:2 % Number of Es 3 for Lift stage
    for i=1:2 % Number of Ps, 2 for Lift stage
        fnP=fieldnames(PE.(fnE{k}).GeSummary);
        
        for j=9:13 %Number of columnes copied
            [tSummy(c).(fnP{j})]= [PE.(fnE{k}).GeSummary(i).(fnP{j})];
        end    
        tSummy(c).Tag=[DTag,fnE{k},'_P',num2str(i)];
        tSummy(c).PsCM_x=(tSummy(c).dTL_x-21)*resP;
        tSummy(c).PsCM_y=(tSummy(c).dTL_y-21)*resP*-1; % change of sign due to flipup
        tSummy(c).SpE_CM_x=tSummy(c).PsCM_x-trueCMPos_x;
        tSummy(c).SpE_CM_y=tSummy(c).PsCM_y-trueCMPos_y;
        tSummy(c).SpE_Mag=rssq([tSummy(c).SpE_CM_x,tSummy(c).SpE_CM_y]);
        tSummy(c).PsDeg=atan2d(tSummy(c).PsCM_y,tSummy(c).PsCM_x);
        tSummy(c).SpE_Deg=tSummy(c).PsDeg-trueDegPos;
        c=c+1;
    end
end