% creating random ranges:
cd('F:\UserElGuapo\DBOx\Dropbox\ResearchMagic\RandomProyects\160110 12 Effects of AR\MASTER Dataset\AllErrors\RE Base\Uniform Errors')
% Generate random uniform errors
uRa_E1=randi(3,1,72)-2; %Uniform random Array 1
uRa_E2=randi(5,1,72)-3;
uRa_E4=randi(9,1,72)-5;
uRa_E12=randi(25,1,72)-13;

figure;
subplot(2,2,1)
hist(uRa_E1,3);
title('Error Array at 1')

subplot(2,2,2)
hist(uRa_E2,3);
title('Error Array at 2')


subplot(2,2,3)
hist(uRa_E4,3);
title('Error Array at 4')

subplot(2,2,4)
hist(uRa_E12,5);
title('Error Array at 12')
xlim([-12 12])


savethisone('Uniform random error for Antenna positioning') 



save uRa_E1 uRa_E1
save uRa_E2 uRa_E2
save uRa_E4 uRa_E4
save uRa_E12 uRa_E12



% Generate random normal errors

cd('F:\UserElGuapo\DBOx\Dropbox\ResearchMagic\RandomProyects\160110 12 Effects of AR\MASTER Dataset\AllErrors\RE Base\Normal Errors')

nRa_E1=round((1/4).*randn([1 72],'single')+1); %norm random Array, shifted to be centered at 1 with sigma equals mu/4
nRa_E2=round((2/4).*randn([1 72],'single')+2); %norm random Array, shifted to be centered at 2 with sigma equals mu/4
nRa_E4=round((4/4).*randn([1 72],'single')+4); %norm random Array, shifted to be centered at 4 with sigma equals mu/4
nRa_E12=round((12/4).*randn([1 72],'single')+12); %norm random Array, shifted to be centered at 12 with sigma equals mu/4

close all;
figure;
subplot(2,2,1)
hist(nRa_E1,3);
title('Error Array at 1')

subplot(2,2,2)
hist(nRa_E2,4);
title('Error Array at 2')


subplot(2,2,3)
hist(nRa_E4,6);
title('Error Array at 4')
set(gca,'XTick', [0 4 8]);
xlim([0 8]);

subplot(2,2,4)
hist(nRa_E12,6);
title('Error Array at 12')
set(gca,'XTick', [0 12 20]);
xlim([0 20]);

savethisone('Normal random error for Antenna positioning') 


save nRa_E1 nRa_E1
save nRa_E2 nRa_E2
save nRa_E4 nRa_E4
save nRa_E12 nRa_E12

%% Section of the codes that tests the "Actual accuracy error condition"

cd('F:\UserElGuapo\DBOx\Dropbox\ResearchMagic\RandomProyects\160110 12 Effects of AR\MASTER Dataset\AllErrors\RE Base\Sinusoidal Error')

set(0,'defaultAxesFontName', 'Times New Roman')
set(0,'DefaultAxesFontSize',16)
set(0,'DefaultFigureColormap',paruly)
cmap=colormap(paruly);
col_Tumor=cmap(50,:);
col_Fibro=cmap(35,:);
col_Back=cmap(10,:);



rA_amp= 0.26/2; %  or .26/2 % VERIFIED AMP ERROR
rA_mAo=-0.04; % mean axis offset //Not Verified

rAsin_x=0:1.25:358.75;
rAsin_y=-rA_amp*sin(rAsin_x*(2*pi/360))+rA_mAo;
plot(rAsin_x,rAsin_y,'o'), grid on;
ylim([-.25 0.25])
xlim([0 360])

hold on; plot(rAsin_x, 0)
Sa_EDeg=rAsin_y(1:4:end);

close all;
figure; hold on;
plot(0:1.25*4:358.75,Sa_EDeg,'o','MarkerFaceColor',[0.5 0.4 0.3],'MarkerSize',7)
plot(0:1.25*4:358.75,Sa_EDeg*15,'o','MarkerFaceColor',[0.7 0.4 0.3],'MarkerSize',7)
plot(0:0.1:355,0,'LineWidth',18)
xlabel('Position ( \circ)')
ylabel('Deviation ( \circ)')
Sa_EPos=round(Sa_EDeg*15/1.25);
xlim([0 360])
ylim([-3 3])
title('Accuracy error in rotary stage vs induced')

save Sa_EPos15 Sa_EPos
save Sa_EDeg Sa_EDeg
savethisone('SinAccError')

close all

% --- TEST the ERRor Generator


Full_Ref=1:1:288*2;
Full_Data=Full_Ref;


[SetRef_RAacc,SetData_RAcc,indexError,SetNorm]= RAcc_Err(Sa_EPos,Full_Ref,Full_Data);
hold on;
plot(SetNorm)
plot(SetRef_RAacc-SetNorm,'r')
plot(SetData_RAcc-SetNorm,'g')

