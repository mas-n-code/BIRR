function [ErrorSet] = Exp1_RUN_DiagnosticScript(ErrorSet,sProp) 
% Function made for a single ExperimentSet error or Control
% [PhantomSet] =Phantom_DiagnosticScript(PhantomSet) 
% Calculates the existance of a tumor
%
% Built for rotary stage simulated error

  [ErrorSet.E1]=nested_DiagnosticScript(ErrorSet.E1,sProp);

function ExpSet=nested_DiagnosticScript(ExpSet,sProp)
ExpSet.P_P1.tDiagnosis=Single_DiagnosticScript(ExpSet.P_P1,sProp);

ExpSet.P_P2.tDiagnosis=Single_DiagnosticScript(ExpSet.P_P2,sProp);
    try
    ExpSet.P_P3.tDiagnosis=Single_DiagnosticScript(ExpSet.P_P3,sProp);
    catch
        disp('     No exp 3' )
    end

