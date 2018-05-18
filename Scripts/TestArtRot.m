%%test ARTROT
theta_step=22.5;
targV=(0:theta_step:337.5)';
posV=[cirMain_E_z0z4_RT13B.absAngle]';
c_f=2;
runs=5;
[Iso230,NewPort]=art_rot(posV,targV,runs,c_f);
