function [ErrorSet] = ErrorSet_RUN_DiagnosticScript_LS(ErrorSet,sProp) 
% [PhantomSet] =Phantom_DiagnosticScript(PhantomSet) 
% Calculates the existance of a tumor
%
% Built for rotary stage simulated error

  [ErrorSet.E1]=nested_DiagnosticScript(ErrorSet.E1,sProp);
    try 
  [ErrorSet.E2]=nested_DiagnosticScript(ErrorSet.E2,sProp);

  [ErrorSet.E3]=nested_DiagnosticScript(ErrorSet.E3,sProp);
  catch
      disp('No E3 this year')
  end

function ExpSet=nested_DiagnosticScript(ExpSet,sProp)
ExpSet.P_P1.tDiagnosis=Single_DiagnosticScript(ExpSet.P_P1,sProp);
ExpSet.P_P2.tDiagnosis=Single_DiagnosticScript(ExpSet.P_P2,sProp);



