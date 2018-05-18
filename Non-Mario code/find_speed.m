function [range_D,res,speed]=find_speed(s11,s21,rad,spdini,spdfin,points,freq,angle,zm)
%Function Find Speed by Diego Rodriguez [Feb 2018 29th]
    range_D=linspace(spdini,spdfin,points);
    sizdm=size(s11);
    results=zeros(length(range_D),1);
    entres=zeros(length(range_D),1);
    sobres=zeros(length(range_D),1);
    lapres=zeros(length(range_D),1);
    varv=zeros(length(range_D),1);
    contr=zeros(length(range_D),1);
    if(isempty(s21))
        s21=zeros(sizdm);
    end
    tic;
    for lsx=1:length(range_D)
        [~,BMR]=Graph_Multistatic_Mod(range_D(lsx),rad,s11,s21,freq,angle,zm,0);
        imafin=BMR.ima;
        results(lsx)=max(max(abs(imafin).^2));
        entres(lsx)=entropy(mat2gray(abs(imafin).^2));
        edgima=simplesobel(abs(imafin));
        sobres(lsx)=var(edgima(:).^2);
        edgimaL=simpleLaplace(abs(imafin));
        lapres(lsx)=var(edgimaL(:).^2);
        varv(lsx)=var(var(imafin.^2));
        contr(lsx)=sum(sum(abs(imafin).^2))./(sum(sum(abs(imafin))).^2);
    end
    toc
    res.max=results;
    res.lap=lapres;
    res.ent=entres;
    res.sob=sobres;
    res.var=varv;
    res.con=contr;
    [~, z]=max(sobres);
    speed=range_D(z);
end