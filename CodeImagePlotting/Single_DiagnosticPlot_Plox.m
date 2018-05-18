function Single_DiagnosticPlot_Plox(Phantom,sProp,elTitle)
fZoom=[-8.5 8.5]; %8 fo rs 8.5 for lift
fSize=11;
fName='Times New Roman';
fLwidth=0.5;

if   Phantom.tDiagnosis.tX
        tumors=sProp.Masks.mask_tumorHand;
        center=Phantom.tDiagnosis.center;

        tumorsImage=double(tumors);
        tumorsImage(center(2),center(1))=2;
        % Generate figure, lot of definitions here
        imagesc(sProp.imx_t,sProp.imy_t,tumorsImage);
                
        % Uncomment the following line to preserve the X-limits of the axes
        xlim(gca,fZoom);
        % Uncomment the following line to preserve the Y-limits of the axes
        ylim(gca,fZoom);

        
        set(gca,...
             'FontName',fName, ...
            'FontSize',fSize, ... %'PlotBoxAspectRatio',[1 1 1],...
            'PlotBoxAspectRatio',[1 1 1],...
            'YDir','normal',...
            'TickDir','out',...
            'TickLength',[0.02 0.02],...
            'XTickLabel',{'-15','-10','-5','0','5','10','15'},...
            'XTick',[-15 -10 -5 0 5 10 15],...
            'YTickLabel',{'-15','-10','-5','0','5','10','15'},...
            'YTick',[-15 -10 -5 0 5 10 15]);
            
        
        xlabel('x-axis (cm)');
        ylabel('y-axis (cm)');
        title(elTitle,'FontWeight','normal','FontName',fName,'FontSize',fSize);
        %disp([s_name,'07 Diagnosed Tumor location'])
        
    end
