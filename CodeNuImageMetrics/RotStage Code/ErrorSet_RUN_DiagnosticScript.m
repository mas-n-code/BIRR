function [ErrorSet] = ErrorSet_RUN_DiagnosticScript(ErrorSet,sProp) 
% [PhantomSet] =Phantom_DiagnosticScript(PhantomSet) 
% Calculates the existance of a tumor
%
% Built for rotary stage simulated error

  [ErrorSet.E1]=nested_DiagnosticScript(ErrorSet.E1,sProp);
  [ErrorSet.E2]=nested_DiagnosticScript(ErrorSet.E2,sProp);
  [ErrorSet.E4]=nested_DiagnosticScript(ErrorSet.E4,sProp);
  [ErrorSet.E12]=nested_DiagnosticScript(ErrorSet.E12,sProp);

function ExpSet=nested_DiagnosticScript(ExpSet,sProp)
ExpSet.P_P1.tDiagnosis=Single_DiagnosticScript(ExpSet.P_P1,sProp);
ExpSet.P_P2.tDiagnosis=Single_DiagnosticScript(ExpSet.P_P2,sProp);
ExpSet.P_P3.tDiagnosis=Single_DiagnosticScript(ExpSet.P_P3,sProp);


