%%compare inc and reference angles
%%Inc angles
try close (5); close(6);
catch 
end
figure(5);

sizArray=length(IncAngleArray(2:end)');

x = IncAngleArray(2:end)';
y = IncAngleArray(2:end)';
z = IncAngleArray(2:end)';
zn= IncAngleArray(2:end)';
group = [repmat({'Normal'},sizArray , 1); repmat({'Corrected LR'}, sizArray, 1); repmat({'Corrected DXO'}, sizArray, 1);...
   repmat({'Corrected DXO New'}, sizArray, 1)];
boxplot([x;y;z;zn], group,'Notch','on')
title('Box plot, Increment angle')
ylabel('Angle (\deg)')
refl=refline(0,theta_step);
refl.LineStyle=':';
ylim([theta_step-0.25 theta_step+.25]);

figure(6);

x = RefAngleArray;
y = RefAngleArray;
z= RefAngleArray;
zn= RefAngleArray;
group = [repmat({'Normal'}, length(x), 1); repmat({'Corrected LR'}, length(y), 1);...
    repmat({'Corrected DXO'}, length(y), 1);repmat({'Corrected DXO New'}, length(y), 1)];
boxplot([x;y;z;zn], group,'Notch','on')
title('Box plot, Ref Angle')
ylabel('Angle (\deg)')
ylim([25-0.25 25+.25]);
refl=refline(0,25);
refl.LineStyle=':';

figure; hold on;
histogram(IncAngleArray(2:end)'-theta_step);
histogram(RefAngleArray-25)
histogram(devV_main)
legend('Inc Angle','Ref Angle')
   