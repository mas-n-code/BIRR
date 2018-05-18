function ErrorSet_plot_DiagnosticPlot_LS(ErrorSet,sProp,sf1,DTag)
%Plots locations of tumors and of where they are expected to be on the
%image
  nested_Diagnosticplot(ErrorSet.E1,sProp,sf1,DTag,'E1_');
  try
  nested_Diagnosticplot(ErrorSet.E2,sProp,sf1,DTag,'E2_');
  nested_Diagnosticplot(ErrorSet.E3,sProp,sf1,DTag,'E3_');
  catch
      disp('¬')
      disp('--> --> Single Experiment Mode')
  end

    function ExpSet=nested_Diagnosticplot(ExpSet,sProp,sf1,DTag,s_name)
    Single_DiagnosticPlot(ExpSet.P_P1,sProp,sf1,DTag,[s_name, 'P1 ']);
    Single_DiagnosticPlot(ExpSet.P_P2,sProp,sf1,DTag,[s_name,'P2 ']);   
   
    end

    function Single_DiagnosticPlot(Phantom,sProp,sf1,DTag,s_name)
        if Phantom.tDiagnosis.tX
        tumors=sProp.Masks.mask_tumorHand;
        center=Phantom.tDiagnosis.center;

        tumorsImage=double(tumors);
        tumorsImage(center(2),center(1))=2;
        % Generate figure, lot of definitions here
        imagesc(sProp.imx_t,sProp.imy_t,tumorsImage);
                
        % Uncomment the following line to preserve the X-limits of the axes
        xlim(gca,[-12.5 12.5]);
        % Uncomment the following line to preserve the Y-limits of the axes
        ylim(gca,[-12.5 12.5]);

        
        set(gca,...
            'YDir','normal',...
            'Units','centimeters',... %'Position',[30 1.5 10 13.5],...
            'PlotBoxAspectRatio',[1 1 1],...
            'Layer','top',...
            'TickDir','out',...
            'TickLength',[0.02 0.02],...
            'XTickLabel',{'-15','-10','-5','0','5','10','15'},...
            'XTick',[-15 -10 -5 0 5 10 15],...
            'YTickLabel',{'-15','-10','-5','0','5','10','15'},...
            'YTick',[-15 -10 -5 0 5 10 15]);
        
        xlabel('x-axis (cm)');
        ylabel('y-axis (cm)');
        
        %disp([s_name,'07 Diagnosed Tumor location'])
        if sf1, savethisoneAsIs(DTag,[s_name,'07 Diagnosed Tumor location']), end 

        else
            disp('Notumorss')
        end %end if
    end
end