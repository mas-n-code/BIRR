%%try phase shift
t=1:0.1:100;
p=16;
amp=5;
a=7*sin(2*pi*(1/p)*(t))';

b=amp*sin(2*pi*(1/p)*(t)-1)';
figure; hold on;
plot(t,a),plot(t,b);

 %the_s=acos(dot(a,b)/(norm(a)*norm(b)));
%the_s=acos(dot(a,b) ./ (dot(a,a)*dot(b,b)))
the_s=phase_sift_calculator(a,b);

c=amp*sin(2*pi*(1/p)*(t)-the_s)';
plot(t,c,'--');
mean(b-c)


lasd = 5;
lamean = 22.5;
a = lasd.*randn(1000,1) + lamean;
b = 0.5*lasd.*randn(1000,1) + lamean;
figure; hold on
histogram (a,25,'Normalization','probability')
histogram (b,25,'Normalization','probability')
figure;
group = [repmat({'a'}, 1000, 1); repmat({'b'}, 1000, 1)];
boxplot([a;b],group,'Notch','on');