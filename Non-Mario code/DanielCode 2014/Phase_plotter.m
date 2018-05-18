plot(angle(fft(Profile2(:,1))))
hold
[Profile_SSS1,Profile_SSS2]=Profile_extractor(Params.dataset,63);
plot(angle(fft(Profile_SSS2(:,1))),'r')
hold