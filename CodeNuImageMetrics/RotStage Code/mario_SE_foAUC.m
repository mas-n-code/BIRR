
function SE=mario_SE_foAUC(AUC,Npos,Nneg)
% Calculates SE for the AUC based excluselvely on Hanley and McNeil 1982
% Version: August 22, 2017
A2=AUC^2;
Q1=AUC/(2-AUC);
Q2=2*A2/(1+AUC);

comp1=AUC*(1-AUC);
comp2=(Npos-1)*(Q1-A2);
comp3=(Nneg-1)*(Q2-A2);
Va=(comp1+comp2+comp3)/(Npos*Nneg);
SE=sqrt(Va);