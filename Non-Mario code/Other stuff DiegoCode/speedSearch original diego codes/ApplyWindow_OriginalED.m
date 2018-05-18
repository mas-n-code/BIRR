function res = ApplyWindow_OriginalED(raw)
    siz=size(raw);
    wins1 = tukeywin(siz(1),1);
    wind=repmat(wins1,1,siz(2));
    res=ifft(fft(raw,[],1).*wind,[],1);
end