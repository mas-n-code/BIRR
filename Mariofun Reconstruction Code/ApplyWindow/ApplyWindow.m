%Apply Diego Window
% Diego Says:
%what kind of window to use for what data? no one knows
%Diego suggest the following book Radiological Imaging from Barret and Schwindell [for windows ] . 
% and also for Fourier. The fourier transforms and its applications. 
% Tukey is a hammin windows when 1 


function res = ApplyWindow(raw,sup_l,inf_l)
siz=size(raw);
wins1 = tukeywin(siz(1),0.75); % Diego suggest to use 1 based on empirical analyisis of the reconstruction 0.75 is a less step win
wind=repmat(wins1,1,siz(2));
raw=ApplyWindowS(raw,sup_l,inf_l);
res=ifft(fft(raw).*wind);
end