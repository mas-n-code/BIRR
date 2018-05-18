%% SB16B IncAngle to Absolute positions.
AbsAngleFrom_IncA=cumsum(IncAngleArray);
IncCom=IncAngleArray;
IncCom(1)=IncCom(72);
devV_main_incTransform=AbsAngleFrom_IncA-[0:5:5*72*runs-1];
figure; hold on
%plot(AbsAngleFrom_IncA)
%plot(0:5:5*72*runs-1)
plot(devV_main_incTransform,'linewidth',3);
plot(IncCom-5);
plot(devV_main)

devV_main-devV_main_incTransform;
