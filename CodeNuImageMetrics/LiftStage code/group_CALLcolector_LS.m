function [ExpSet] = group_CALLcolector_LS(ExpSet)
%function  [ExpSet] = group_CALLcolector_LS(ExpSet)
% collects regions from all the set groups 

call_tumor= [ExpSet.P_P1.R_tValues.tumor;
             ExpSet.P_P2.R_tValues.tumor
             ];
        
call_fibro = [ExpSet.P_P1.R_tValues.fibro;
              ExpSet.P_P2.R_tValues.fibro];
        
call_clutter = [ExpSet.P_P1.R_tValues.clutter;
              ExpSet.P_P2.R_tValues.clutter];
          
call_rest= [ExpSet.P_P1.R_Values.rest; % Note that Call_rest has background information below threshold level, but it shall not contain target info
            ExpSet.P_P2.R_Values.rest];
        
        % Add them to Parent structure
ExpSet.CALL.call_tumor=call_tumor;
ExpSet.CALL.call_fibro=call_fibro;
ExpSet.CALL.call_clutter=call_clutter;
ExpSet.CALL.call_rest=call_rest;
