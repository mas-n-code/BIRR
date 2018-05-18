%UncertaintyExplorator
%% Calculates and plots uncertainties on the means of contrast

%cd('F:\UserElGuapo\DBOx\Dropbox\ResearchMagic\RandomProyects\160110 12 Effects of AR\MASTER Dataset');
cd('C:\Users\Mario\Dropbox\ResearchMagic\RandomProyects\160110 12 Effects of AR\MASTER Dataset');
load('CG ImageMetrics.mat')


%% Set colors
cmap=colormap(paruly);
Tumor_col=cmap(50,:);
Fibro_col=cmap(35,:);
Back_col=cmap(10,:);



%%
Tumor1=CG1.ImageMetrics.Tumor.Mean;
Tumor2=CG2.ImageMetrics.Tumor.Mean;
Tumor3=CG3.ImageMetrics.Tumor.Mean;

Tumor1_Unc=CG1.ImageMetrics.Tumor.Std;
Tumor2_Unc=CG2.ImageMetrics.Tumor.Std;
Tumor3_Unc=CG3.ImageMetrics.Tumor.Std;

%%
Fibro1=CG1.ImageMetrics.Fibro.Mean;
Fibro2=CG2.ImageMetrics.Fibro.Mean;
Fibro3=CG3.ImageMetrics.Fibro.Mean;

Fibro1_Unc=CG1.ImageMetrics.Fibro.Std;
Fibro2_Unc=CG2.ImageMetrics.Fibro.Std;
Fibro3_Unc=CG3.ImageMetrics.Fibro.Std;


%%

Back1=CG1.ImageMetrics.Back.Mean;
Back2=CG2.ImageMetrics.Back.Mean;
Back3=CG3.ImageMetrics.Back.Mean;

Back1_Unc=CG1.ImageMetrics.Back.Std;
Back2_Unc=CG2.ImageMetrics.Back.Std;
Back3_Unc=CG3.ImageMetrics.Back.Std;


%% Confidence Intervals
Tumor_t_const=2.1314;
Fibro_t_const=2.1604;
Back_t_const=1.968;

Tumor_UNC=[Tumor1_Unc Tumor2_Unc Tumor3_Unc];
Tumor_SEM=Tumor_UNC/sqrt(16);
Tumor_CI=Tumor_SEM*Tumor_t_const;

Fibro_UNC=[Fibro1_Unc Fibro2_Unc Fibro3_Unc];
Fibro_SEM=Fibro_UNC/sqrt(14);
Fibro_CI=Fibro_SEM*Fibro_t_const;

Back_UNC=[Back1_Unc Back2_Unc Back3_Unc];
Back_SEM=Back_UNC/sqrt(298);
Back_CI=Back_SEM*Back_t_const;

%CI = mean +/- t-const@95*SEM, in this example only the +/- value is
%calculated since mseb will add it to the value in y



%%
%% Examples SD
x=1:3;
y_meanS=[Tumor1 Tumor2 Tumor3;Fibro1 Fibro2 Fibro3;Back1 Back2 Back3 ];

% caclulate errors (simetric)
y_std = [Tumor1_Unc Tumor2_Unc Tumor3_Unc; Fibro1_Unc Fibro2_Unc Fibro3_Unc;Back1_Unc Back2_Unc Back3_Unc];

figure;title('NormalPlot')
plot(x,y_meanS);

figure; title('ShadedError MeansFibro back and tumor'),
mseb(x,y_meanS,y_std,[],1); 
legend('Tumor','Fibro-glandular','Background')
xlim([0 4])


%%
title('')
savethisone('ShadedErrorMeans')

%% Examples CI
x=1:3;
y_meanS=[Tumor1 Tumor2 Tumor3;Fibro1 Fibro2 Fibro3;Back1 Back2 Back3 ];

% calculate errors
y_CI = [Tumor_CI;Fibro_CI;Back_CI];

figure;title('NormalPlot')
plot(x,y_meanS);



figure; title('ShadedError Means and 95%CI of mean');
lineProps.col ={Tumor_col,Fibro_col,Back_col};

mseb(x,y_meanS,y_CI,lineProps,1); 
legend1=legend('Tumor','Fibro-glandular','Back');

set(legend1,...
    'Position',[0.53 0.25 0.25 0.15]);

xlim([0 4])


%%
title('')
savethisone('ShadedErrorMeans and CI')



%% Present IQM with only reproducibility uncertainty SD
ScR_v=[CG1.PowImageMetrics.q0all.ScR_M,CG2.PowImageMetrics.q0all.ScR_M,CG3.PowImageMetrics.q0all.ScR_M];
TfR_v=[CG1.PowImageMetrics.q0all.TfR_M,CG2.PowImageMetrics.q0all.TfR_M,CG3.PowImageMetrics.q0all.TfR_M];
CcR_v=[CG1.PowImageMetrics.q0all.CcR_M,CG2.PowImageMetrics.q0all.CcR_M,CG3.PowImageMetrics.q0all.CcR_M];

ScR_mu=mean(ScR_v);
ScR_un=2*std(ScR_v);

TfR_mu=mean(TfR_v);
TfR_un=2*std(TfR_v);

CcR_mu=mean(CcR_v);
CcR_un=2*std(CcR_v);

IQMu_error_v=repmat([ScR_un;TfR_un;CcR_un],1,3);
IQMu_mean_v=repmat([ScR_mu;TfR_mu;CcR_mu],1,3);

x1=[1,2,3];
mulineprops.style=':';
mulineprops.width=1;
figure; hold on;  mseb(x1,IQMu_mean_v,IQMu_error_v,mulineprops,1);
%ho=plot(x1,[ScR_v;TfR_v;CcR_v]);
h=mseb(x1,[ScR_v;TfR_v;CcR_v],zeros(3,3),[],1);
title('IQM (SD)')
l1=legend([h.mainLine],'ScR','TfR','CcR','Location','Best');
%set(l1,...
%    'Position','Best'); %[0.53 0.25 0.25 0.15]

%savethisone('IQM and SD')


%% Present IQM with only reproducibility uncertainty CI

ScR_mu=mean(ScR_v);
ScR_un=4.302*std(ScR_v)/sqrt(3);

TfR_mu=mean(TfR_v);
TfR_un=4.302*std(TfR_v)/sqrt(3);

CcR_mu=mean(CcR_v);
CcR_un=4.302*std(CcR_v)/sqrt(3);

IQMu_error_v=repmat([ScR_un;TfR_un;CcR_un],1,3);
IQMu_mean_v=repmat([ScR_mu;TfR_mu;CcR_mu],1,3);

x1=[0,2,4];
mulineprops.style=':';
mulineprops.width=1;
figure; hold on; mseb(x1,IQMu_mean_v,IQMu_error_v,mulineprops,1);

laline.style='o--';
x1=[1,2,3];
h=mseb(x1,[ScR_v;TfR_v;CcR_v],zeros(3,3),laline,1);
title('IQM (SD)')
l1=legend([h.mainLine],'ScR','TfR','CcR','Location','Best');
set(l1,...
    'Position',[0.40 0.25 0.25 0.15]); %
%hide labels and title

%%
xlim([0.5,3.5])
ylabel('dB')
title('')
savethisone('IQM with CI uncertainties from 3 samples')


%% ---------------------------------Create an extra case
%%
TumorX=CG1.ImageMetrics.Tumor.Mean;
TumorX_Unc=CG1.ImageMetrics.Tumor.Std;


FibroX=4.02E-5;
FibroX_Unc=CG1.ImageMetrics.Fibro.Std;



BackX=CG1.ImageMetrics.Back.Mean;
BackX_Unc=CG1.ImageMetrics.Back.Std;

%%
close all;
x=1:4;
y_meanS=[Tumor1 Tumor2 Tumor3 TumorX;Fibro1 Fibro2 Fibro3 FibroX;Back1 Back2 Back3 BackX];

% caclulate errors (simetric)
y_std = [Tumor1_Unc Tumor2_Unc Tumor3_Unc TumorX_Unc; Fibro1_Unc Fibro2_Unc Fibro3_Unc FibroX_Unc;Back1_Unc Back2_Unc Back3_Unc BackX_Unc];

figure;title('NormalPlot with X')
plot(x,y_meanS);

figure; title('ShadedError MeansFibro back and tumor'),
mseb(x,y_meanS,y_std,[],1); 
legend('Tumor','Fibro-glandular','Background')
xlim([0.75 4.25])


ax=gca;
set(ax,'XTick', [1 2 3 4]);
set(ax,'XTickLabel',{'CS 1' 'CS 2' 'CS 3' 'X'});
title('');
savethisone('ShadedErrorMeans and SD with X');


%% Confidence Intervals
Tumor_t_const=2.1314;
Fibro_t_const=2.1604;
Back_t_const=1.968;

Tumor_UNC=[Tumor1_Unc Tumor2_Unc Tumor3_Unc TumorX_Unc];
Tumor_SEM=Tumor_UNC/sqrt(16);
Tumor_CI=Tumor_SEM*Tumor_t_const;

Fibro_UNC=[Fibro1_Unc Fibro2_Unc Fibro3_Unc FibroX_Unc];
Fibro_SEM=Fibro_UNC/sqrt(14);
Fibro_CI=Fibro_SEM*Fibro_t_const;

Back_UNC=[Back1_Unc Back2_Unc Back3_Unc BackX_Unc];
Back_SEM=Back_UNC/sqrt(298);
Back_CI=Back_SEM*Back_t_const;


x=1:4;
y_meanS=[Tumor1 Tumor2 Tumor3 TumorX;Fibro1 Fibro2 Fibro3 FibroX;Back1 Back2 Back3 BackX];

% calculate errors
y_CI = [Tumor_CI;Fibro_CI;Back_CI];

figure;title('NormalPlot w X')
plot(x,y_meanS);



figure; title('Means and 95%CI w X');
lineProps.col ={Tumor_col,Fibro_col,Back_col};

mseb(x,y_meanS,y_CI,lineProps,1); 
legend1=legend('Tumor','Fibro-glandular','Back');

set(legend1,...
    'Position',[0.53 0.25 0.25 0.15]);

xlim([0 5])

set(ax,'XTick', [1 2 3 4]);
set(ax,'XTickLabel',{'CS 1' 'CS 2' 'CS 3' 'X'});
title('');
savethisone('ShadedErrorMeans and CI with X');


%%
ScR_v=[CG1.PowImageMetrics.q0all.ScR_M,CG2.PowImageMetrics.q0all.ScR_M,CG3.PowImageMetrics.q0all.ScR_M];
TfR_v=[CG1.PowImageMetrics.q0all.TfR_M,CG2.PowImageMetrics.q0all.TfR_M,CG3.PowImageMetrics.q0all.TfR_M];
CcR_v=[CG1.PowImageMetrics.q0all.CcR_M,CG2.PowImageMetrics.q0all.CcR_M,CG3.PowImageMetrics.q0all.CcR_M];


ScR_mu=mean(ScR_v);
ScR_un=4.302*std(ScR_v)/sqrt(3);

TfR_mu=mean(TfR_v);
TfR_un=4.302*std(TfR_v)/sqrt(3);

CcR_mu=mean(CcR_v);
CcR_un=4.302*std(CcR_v)/sqrt(3);

IQMu_error_v=repmat([ScR_un;TfR_un;CcR_un],1,3);
IQMu_mean_v=repmat([ScR_mu;TfR_mu;CcR_mu],1,3);

x1=[0,2,4];
mulineprops.style=':';
mulineprops.width=1;
figure; hold on; mseb(x1,IQMu_mean_v,IQMu_error_v,mulineprops,1);

laline.style='o--';
x1=[1,2,3,4];
h=mseb(x1,[[ScR_v,30.22];[TfR_v,1.21];[CcR_v,12.46]],zeros(3,4),laline,1);
title('IQM (SD)')
l1=legend([h.mainLine],'ScR','TfR','CcR','Location','Best');
set(l1,...
    'Position',[0.40 0.25 0.25 0.15]); %

xlim([0 5])
ax=gca;
set(ax,'XTick', [1 2 3 4]);
set(ax,'XTickLabel',{'CS 1' 'CS 2' 'CS 3' 'X'});
title('');
savethisone('ShadedErrorMeans and CI with X');

ylabel('dB')
title('')

%hide labels and title

%%
xlim([0.5,3.5])

savethisone('IQM with CI uncertainties from 3 samples and x')


%% SAE errors in metrics against means of control scans

ScR_v_SAE=
TfR_v_SAE=
CcR_v_SAE=

x1=[0,2,4];
mulineprops.style=':';
mulineprops.width=1;
figure; hold on; mseb(x1,IQMu_mean_v,IQMu_error_v,mulineprops,1);

[]

laline.style='o--';
x1=[1,2,3,4];



h=mseb(x1,[[ScR_v,30.22];[TfR_v,1.21];[CcR_v,12.46]],zeros(3,4),laline,1);
title('IQM (SD)')
l1=legend([h.mainLine],'ScR','TfR','CcR','Location','Best');
set(l1,...
    'Position',[0.40 0.25 0.25 0.15]); %


ylabel('dB')

set(ax,'XTick', [1 2 3 4]);
set(ax,'XTickLabel',{'1.25' '3' '5' '15'});



