function d_theta=phase_sift_calculator(a,b)

d_theta=acos(dot(a,b)/(norm(a)*norm(b)));

%http://www.mathworks.com/matlabcentral/newsreader/view_thread/301847

t=1:1:length(a);
p=16;
amp=(max(b)-min(b))/2;
%a=7*sin(2*pi*(1/p)*(t))';

%b=amp*sin(2*pi*(1/p)*(t)-1)';
figure; hold on;
  plot(t,a);
plot(t,b);

 %the_s=acos(dot(a,b)/(norm(a)*norm(b)));
%the_s=acos(dot(a,b) ./ (dot(a,a)*dot(b,b)))
%the_s=phase_sift_calculator(a,b);

c=amp*sin(2*pi*(1/p)*(t-1)-d_theta)';
plot(t,c,'--');
title('Test of shiftess')
legend('a','b','b+shift')
hold off