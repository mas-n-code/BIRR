function PlotSearchResult(range,res)
    [~, z]=max(res.max);
    disp(strcat('Max = ',num2str(range(z),'%10.3e')));
    [~, z]=max(res.lap);
    disp(strcat('Laplace = ',num2str(range(z),'%10.3e')));
    [~, z]=min(res.ent);
    disp(strcat('Entropy = ',num2str(range(z),'%10.3e')));
    [~, z]=max(res.var);
    disp(strcat('Variance = ',num2str(range(z),'%10.3e')));
    [~, z]=max(res.sob);
    disp(strcat('Sobel = ',num2str(range(z),'%10.3e')));
    [~, z]=max(res.con);
    disp(strcat('Contrast = ',num2str(range(z),'%10.3e')));
    
    figure;plot(range,res.max./max(res.max),range,res.lap./max(res.lap),range,res.ent./max(res.ent),range,res.var./max(res.var),range,res.sob./max(res.sob),range,res.con./max(res.con))
    legend('max','lap','ent','var','sob','con');
end