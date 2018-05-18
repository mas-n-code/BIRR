% The following scrip generates polar plots that shows how rotary stage errors are induced

% 1 Plot with perfect location of antennas 
% 2 Plot with normal array of antennas for data scan
% 3 Plot with normal array of antennas for reference scan

r=25; xc=0; yc=0;
t_Grid=0:1.25:360-1.25;
rad_Grid=deg2rad(t_Grid);
r_vecG=repmat(r,288);

% %p_grid
% x = r*cos(deg2rad(t_Grid)) + xc;
% y = r*sin(deg2rad(t_Grid)) + yc;
% plot(x,y,'Color',[0.2 0.2 0.2],'Marker','o')
% axis equal
%% Plot Control/perfect
figure;
polarplot(rad_Grid,r_vecG,'.','Color',[0.9 0.9 0.9]);
ax=gca;
ax.ThetaTick=(0:15:360-15);
ax.RLim=[0 30;];
ax.RTick=[];
ax.ThetaMinorTick='On';
ax.TickLength = [0.02 0.02];
ax.ThetaGrid= 'Off';
ax.RGrid= 'Off';
ax.MinorGridLineStyle='--';
ax.FontName='Times New Roman';
ax.FontSize=12;
hold on

% plot Ideal values;
n_pos=18;
n_a=360/n_pos;
r_vec=repmat(r,n_pos);
line_w=3;

t_Ideal=0:n_a:360-n_a;
rad_Ideal=deg2rad(t_Ideal);


pI=polarplot(rad_Ideal,r_vec,'o',...
    'Color',[.8 .8 .8],...
    'LineWidth',line_w,...
    'MarkerFaceColor',[.2 .2 .8],...
    'MarkerSize',20);

% plot Ref values;

t_Ref=0:n_a:360-n_a;
rad_Ref=deg2rad(t_Ref);


pR=polarplot(rad_Ref,r_vec,'o',...
    'Color',[67/255 73/255 255/255],...
    'LineWidth',line_w,...
    'MarkerFaceColor',[67/255 73/255 255/255],...
    'MarkerSize',14);

% plot Scan values;

t_Scan=0:n_a:360-n_a;
rad_Scan=deg2rad(t_Scan);


pS=polarplot(rad_Scan,r_vec,'o',...
    'Color',[255/255 208/255 67/255],...
    'LineWidth',line_w,...
    'MarkerFaceColor',[255/255 208/255 67/255],...
    'MarkerSize',5);

%%legend


% print fig control values 
pathpath='G:\Dropbox\ResearchMagic\T H E S I S\Chapter 4\MatlabOutput';
savethisoneTo(pathpath,'D0912_','Control Rotary')



%% SAE

figure;
polarplot(rad_Grid,r_vecG,'.','Color',[0.9 0.9 0.9]);
ax=gca;
ax.ThetaTick=(0:15:360-15);
ax.RLim=[0 30;];
ax.RTick=[];
ax.ThetaMinorTick='On';
ax.TickLength = [0.02 0.02];
ax.ThetaGrid= 'Off';
ax.RGrid= 'Off';
ax.MinorGridLineStyle='--';
ax.FontName='Times New Roman';
ax.FontSize=12;
hold on

% plot Ideal values;
n_pos=18;
n_a=360/n_pos;
r_vec=repmat(r,n_pos);
line_w=3;

t_Ideal=0:n_a:360-n_a;
rad_Ideal=deg2rad(t_Ideal);


pI=polarplot(rad_Ideal,r_vec,'o',...
    'Color',[.8 .8 .8],...
    'LineWidth',line_w,...
    'MarkerFaceColor',[.9 .9 .9],...
    'MarkerSize',20);

% plot Ref values;

t_Ref=0:n_a:360-n_a;
t_Ref(2)=t_Ref(2)+5;
rad_Ref=deg2rad(t_Ref);


pR=polarplot(rad_Ref,r_vec,'o',...
    'Color',[67/255 73/255 255/255],...
    'LineWidth',line_w,...
    'MarkerFaceColor',[67/255 73/255 255/255],...
    'MarkerSize',14);

% plot Scan values;

t_Scan=0:n_a:360-n_a;
t_Scan(2)=t_Scan(2)+5;   %<-
rad_Scan=deg2rad(t_Scan);


pS=polarplot(rad_Scan,r_vec,'o',...
    'Color',[255/255 208/255 67/255],...
    'LineWidth',line_w,...
    'MarkerFaceColor',[255/255 208/255 67/255],...
    'MarkerSize',5);

%%legend


% print fig control values 
pathpath='G:\Dropbox\ResearchMagic\T H E S I S\Chapter 4\MatlabOutput';
savethisoneTo(pathpath,'D0912_','SingleAccuracyError')

%% CAE

figure;
polarplot(rad_Grid,r_vecG,'.','Color',[0.9 0.9 0.9]);
ax=gca;
ax.ThetaTick=(0:15:360-15);
ax.RLim=[0 30;];
ax.RTick=[];
ax.ThetaMinorTick='On';
ax.TickLength = [0.02 0.02];
ax.ThetaGrid= 'Off';
ax.RGrid= 'Off';
ax.MinorGridLineStyle='--';
ax.FontName='Times New Roman';
ax.FontSize=12;
hold on

% plot Ideal values;
n_pos=18;
n_a=360/n_pos;
r_vec=repmat(r,n_pos);
line_w=3;

t_Ideal=0:n_a:360-n_a;
rad_Ideal=deg2rad(t_Ideal);


pI=polarplot(rad_Ideal,r_vec,'o',...
    'Color',[.8 .8 .8],...
    'LineWidth',line_w,...
    'MarkerFaceColor',[.9 .9 .9],...
    'MarkerSize',20);

% plot Ref values;

t_Ref=0:n_a:360-n_a;
t_Ref=t_Ref+5; %<-
rad_Ref=deg2rad(t_Ref);


pR=polarplot(rad_Ref,r_vec,'o',...
    'Color',[67/255 73/255 255/255],...
    'LineWidth',line_w,...
    'MarkerFaceColor',[67/255 73/255 255/255],...
    'MarkerSize',14);

% plot Scan values;

t_Scan=0:n_a:360-n_a;
t_Scan=t_Scan+5;   %<-
rad_Scan=deg2rad(t_Scan);


pS=polarplot(rad_Scan,r_vec,'o',...
    'Color',[255/255 208/255 67/255],...
    'LineWidth',line_w,...
    'MarkerFaceColor',[255/255 208/255 67/255],...
    'MarkerSize',5);

%%legend


% print fig control values 
pathpath='G:\Dropbox\ResearchMagic\T H E S I S\Chapter 4\MatlabOutput';
savethisoneTo(pathpath,'D0912_','CollectiveAccuracyError')

%% CPE

figure;
polarplot(rad_Grid,r_vecG,'.','Color',[0.9 0.9 0.9]);
ax=gca;
ax.ThetaTick=(0:15:360-15);
ax.RLim=[0 30;];
ax.RTick=[];
ax.ThetaMinorTick='On';
ax.TickLength = [0.02 0.02];
ax.ThetaGrid= 'Off';
ax.RGrid= 'Off';
ax.MinorGridLineStyle='--';
ax.FontName='Times New Roman';
ax.FontSize=12;
hold on

% plot Ideal values;
n_pos=18;
n_a=360/n_pos;
r_vec=repmat(r,n_pos);
line_w=3;

t_Ideal=0:n_a:360-n_a;
rad_Ideal=deg2rad(t_Ideal);


pI=polarplot(rad_Ideal,r_vec,'o',...
    'Color',[.8 .8 .8],...
    'LineWidth',line_w,...
    'MarkerFaceColor',[.9 .9 .9],...
    'MarkerSize',20);

% plot Ref values;

t_Ref=0:n_a:360-n_a;
% t_Ref=t_Ref+5; %<-
rad_Ref=deg2rad(t_Ref);


pR=polarplot(rad_Ref,r_vec,'o',...
    'Color',[67/255 73/255 255/255],...
    'LineWidth',line_w,...
    'MarkerFaceColor',[67/255 73/255 255/255],...
    'MarkerSize',14);

% plot Scan values;

t_Scan=0:n_a:360-n_a;
t_Scan=t_Scan+5;   %<-
rad_Scan=deg2rad(t_Scan);


pS=polarplot(rad_Scan,r_vec,'o',...
    'Color',[255/255 208/255 67/255],...
    'LineWidth',line_w,...
    'MarkerFaceColor',[255/255 208/255 67/255],...
    'MarkerSize',5);

%%legend


% print fig control values 
pathpath='G:\Dropbox\ResearchMagic\T H E S I S\Chapter 4\MatlabOutput';
savethisoneTo(pathpath,'D0912_','ColectivePrecisionError')

%% SPE

figure;
polarplot(rad_Grid,r_vecG,'.','Color',[0.9 0.9 0.9]);
ax=gca;
ax.ThetaTick=(0:15:360-15);
ax.RLim=[0 30;];
ax.RTick=[];
ax.ThetaMinorTick='On';
ax.TickLength = [0.02 0.02];
ax.ThetaGrid= 'Off';
ax.RGrid= 'Off';
ax.MinorGridLineStyle='--';
ax.FontName='Times New Roman';
ax.FontSize=12;
hold on

% plot Ideal values;
n_pos=18;
n_a=360/n_pos;
r_vec=repmat(r,n_pos);
line_w=3;

t_Ideal=0:n_a:360-n_a;
rad_Ideal=deg2rad(t_Ideal);


pI=polarplot(rad_Ideal,r_vec,'o',...
    'Color',[.8 .8 .8],...
    'LineWidth',line_w,...
    'MarkerFaceColor',[.9 .9 .9],...
    'MarkerSize',20);

% plot Ref values;

t_Ref=0:n_a:360-n_a;
% t_Ref=t_Ref+5; %<-
rad_Ref=deg2rad(t_Ref);


pR=polarplot(rad_Ref,r_vec,'o',...
    'Color',[67/255 73/255 255/255],...
    'LineWidth',line_w,...
    'MarkerFaceColor',[67/255 73/255 255/255],...
    'MarkerSize',14);

% plot Scan values;

t_Scan=0:n_a:360-n_a;
t_Scan(2)=t_Scan(2)+5;   %<-
rad_Scan=deg2rad(t_Scan);


pS=polarplot(rad_Scan,r_vec,'o',...
    'Color',[255/255 208/255 67/255],...
    'LineWidth',line_w,...
    'MarkerFaceColor',[255/255 208/255 67/255],...
    'MarkerSize',5);

%%legend


% print fig control values 
pathpath='G:\Dropbox\ResearchMagic\T H E S I S\Chapter 4\MatlabOutput';
savethisoneTo(pathpath,'D0912_','SinglePrecisionError')

%% Random
% Random seed

%randiTest=randi([-4,4],1,18);
% figure; bar(randiTest);
% t_test=t_Scan;
% t_test(randiTest==4)=t_test(randiTest==4)+5;

figure;
polarplot(rad_Grid,r_vecG,'.','Color',[0.9 0.9 0.9]);
ax=gca;
ax.ThetaTick=(0:15:360-15);
ax.RLim=[0 30;];
ax.RTick=[];
ax.ThetaMinorTick='On';
ax.TickLength = [0.02 0.02];
ax.ThetaGrid= 'Off';
ax.RGrid= 'Off';
ax.MinorGridLineStyle='--';
ax.FontName='Times New Roman';
ax.FontSize=12;
hold on

% plot Ideal values;
n_pos=18;
n_a=360/n_pos;
r_vec=repmat(r,n_pos);
line_w=3;

t_Ideal=0:n_a:360-n_a;
rad_Ideal=deg2rad(t_Ideal);


pI=polarplot(rad_Ideal,r_vec,'o',...
    'Color',[.8 .8 .8],...
    'LineWidth',line_w,...
    'MarkerFaceColor',[.9 .9 .9],...
    'MarkerSize',20);

% plot Ref values;

t_Ref=0:n_a:360-n_a;
t_Ref(randiTest==4)=t_Ref(randiTest==4)+15;
t_Ref(randiTest==-4)=t_Ref(randiTest==-4)-15;
t_Ref(randiTest==3)=t_Ref(randiTest==3)+5;
t_Ref(randiTest==-3)=t_Ref(randiTest==-3)-5;
rad_Ref=deg2rad(t_Ref);


pR=polarplot(rad_Ref,r_vec,'o',...
    'Color',[67/255 73/255 255/255],...
    'LineWidth',line_w,...
    'MarkerFaceColor',[67/255 73/255 255/255],...
    'MarkerSize',14);

% plot Scan values;

t_Scan=0:n_a:360-n_a;
t_Scan(randiTest==4)=t_Scan(randiTest==4)+15;
t_Scan(randiTest==-4)=t_Scan(randiTest==-4)-15;
t_Scan(randiTest==3)=t_Scan(randiTest==3)+15;
t_Scan(randiTest==-3)=t_Scan(randiTest==-3)-15;
rad_Scan=deg2rad(t_Scan);


pS=polarplot(rad_Scan,r_vec,'o',...
    'Color',[255/255 208/255 67/255],...
    'LineWidth',line_w,...
    'MarkerFaceColor',[255/255 208/255 67/255],...
    'MarkerSize',5);

%%legend


% print fig control values 
pathpath='G:\Dropbox\ResearchMagic\T H E S I S\Chapter 4\MatlabOutput';
savethisoneTo(pathpath,'D0912_','RandomAccuracyLOW')
%% Random
% Random seed

%randiTest=randi([-4,4],1,18);
% figure; bar(randiTest);
% t_test=t_Scan;
% t_test(randiTest==4)=t_test(randiTest==4)+5;

figure;
polarplot(rad_Grid,r_vecG,'.','Color',[0.9 0.9 0.9]);
ax=gca;
ax.ThetaTick=(0:15:360-15);
ax.RLim=[0 30;];
ax.RTick=[];
ax.ThetaMinorTick='On';
ax.TickLength = [0.02 0.02];
ax.ThetaGrid= 'Off';
ax.RGrid= 'Off';
ax.MinorGridLineStyle='--';
ax.FontName='Times New Roman';
ax.FontSize=12;
hold on

% plot Ideal values;
n_pos=18;
n_a=360/n_pos;
r_vec=repmat(r,n_pos);
line_w=3;

t_Ideal=0:n_a:360-n_a;
rad_Ideal=deg2rad(t_Ideal);


pI=polarplot(rad_Ideal,r_vec,'o',...
    'Color',[.8 .8 .8],...
    'LineWidth',line_w,...
    'MarkerFaceColor',[.9 .9 .9],...
    'MarkerSize',20);

% plot Ref values;

t_Ref=0:n_a:360-n_a;
t_Ref(randiTest==4)=t_Ref(randiTest==4)+15;
t_Ref(randiTest==-4)=t_Ref(randiTest==-4)-15;
t_Ref(randiTest==3)=t_Ref(randiTest==3)+5;
t_Ref(randiTest==-3)=t_Ref(randiTest==-3)-5;
t_Ref(randiTest==2)=t_Ref(randiTest==2)+2.5;
t_Ref(randiTest==-2)=t_Ref(randiTest==-2)-2.5;
rad_Ref=deg2rad(t_Ref);


pR=polarplot(rad_Ref,r_vec,'o',...
    'Color',[67/255 73/255 255/255],...
    'LineWidth',line_w,...
    'MarkerFaceColor',[67/255 73/255 255/255],...
    'MarkerSize',14);

% plot Scan values;

t_Scan=0:n_a:360-n_a;
t_Scan(randiTest==4)=t_Scan(randiTest==4)+15;
t_Scan(randiTest==-4)=t_Scan(randiTest==-4)-15;
t_Scan(randiTest==3)=t_Scan(randiTest==3)+5;
t_Scan(randiTest==-3)=t_Scan(randiTest==-3)-5;
t_Scan(randiTest==2)=t_Scan(randiTest==2)+2.5;
t_Scan(randiTest==-2)=t_Scan(randiTest==-2)-2.5;
rad_Scan=deg2rad(t_Scan);


pS=polarplot(rad_Scan,r_vec,'o',...
    'Color',[255/255 208/255 67/255],...
    'LineWidth',line_w,...
    'MarkerFaceColor',[255/255 208/255 67/255],...
    'MarkerSize',5);

%%legend


% print fig control values 
pathpath='G:\Dropbox\ResearchMagic\T H E S I S\Chapter 4\MatlabOutput';
savethisoneTo(pathpath,'D0912_','RandomAccuracyHigh')

%% Random
% Random Precision

%randiTest=randi([-4,4],1,18);
% figure; bar(randiTest);
% t_test=t_Scan;
% t_test(randiTest==4)=t_test(randiTest==4)+5;

figure;
polarplot(rad_Grid,r_vecG,'.','Color',[0.9 0.9 0.9]);
ax=gca;
ax.ThetaTick=(0:15:360-15);
ax.RLim=[0 30;];
ax.RTick=[];
ax.ThetaMinorTick='On';
ax.TickLength = [0.02 0.02];
ax.ThetaGrid= 'Off';
ax.RGrid= 'Off';
ax.MinorGridLineStyle='--';
ax.FontName='Times New Roman';
ax.FontSize=12;
hold on

% plot Ideal values;
n_pos=18;
n_a=360/n_pos;
r_vec=repmat(r,n_pos);
line_w=3;

t_Ideal=0:n_a:360-n_a;
rad_Ideal=deg2rad(t_Ideal);


pI=polarplot(rad_Ideal,r_vec,'o',...
    'Color',[.8 .8 .8],...
    'LineWidth',line_w,...
    'MarkerFaceColor',[.9 .9 .9],...
    'MarkerSize',20);

% plot Ref values;

t_Ref=0:n_a:360-n_a;
% t_Ref(randiTest==4)=t_Ref(randiTest==4)+15;
% t_Ref(randiTest==-4)=t_Ref(randiTest==-4)-15;
% t_Ref(randiTest==3)=t_Ref(randiTest==3)+5;
% t_Ref(randiTest==-3)=t_Ref(randiTest==-3)-5;
% t_Ref(randiTest==2)=t_Ref(randiTest==2)+2.5;
% t_Ref(randiTest==-2)=t_Ref(randiTest==-2)-2.5;
rad_Ref=deg2rad(t_Ref);


pR=polarplot(rad_Ref,r_vec,'o',...
    'Color',[67/255 73/255 255/255],...
    'LineWidth',line_w,...
    'MarkerFaceColor',[67/255 73/255 255/255],...
    'MarkerSize',14);

% plot Scan values;

t_Scan=0:n_a:360-n_a;
t_Scan(randiTest==4)=t_Scan(randiTest==4)+15;
t_Scan(randiTest==-4)=t_Scan(randiTest==-4)-15;
t_Scan(randiTest==3)=t_Scan(randiTest==3)+5;
t_Scan(randiTest==-3)=t_Scan(randiTest==-3)-5;
t_Scan(randiTest==2)=t_Scan(randiTest==2)+2.5;
t_Scan(randiTest==-2)=t_Scan(randiTest==-2)-2.5;
rad_Scan=deg2rad(t_Scan);


pS=polarplot(rad_Scan,r_vec,'o',...
    'Color',[255/255 208/255 67/255],...
    'LineWidth',line_w,...
    'MarkerFaceColor',[255/255 208/255 67/255],...
    'MarkerSize',5);

%%legend


% print fig control values 
pathpath='G:\Dropbox\ResearchMagic\T H E S I S\Chapter 4\MatlabOutput';
savethisoneTo(pathpath,'D0912_','RandomPrecisionHigh')