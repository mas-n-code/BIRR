pth='C:\Users\Mario\Dropbox\Data_sets--HP (1)\Breast Cancer Foundation Clinical System\Pre-trials\September\Thursday 25' ;
list=dir(pth);
speed=2.17e8; %Speed to use
r=0.31; %Radious
zm=15; % zoom in to the image, in this case the generated image is 30x30
m_size=72;
expString='_AG_';
refString='_AH_';
f=linspace(20e6,6e9,601);
Params.speed=speed;
Params.freqvals=f;
Params.radius=r;
Params.angles=linspace(0,2*pi,m_size);
refcube=zeros(601,m_size,15);
rawCube=zeros(601,m_size,15);
expCube=zeros(zm*2+1,zm*2+1,15);
for lx=1:length(list)
    if(length(strfind(list(lx).name,'.txt'))==1 && length(strfind(list(lx).name,refString))==1)
        Raw_data=importdata(strcat(pth,'\',list(lx).name));
        reads=ifft(data_reader_s(Raw_data));
        xps='([0-9]+';
        [startIndex,endIndex] = regexp(list(lx).name,xps);
        num=str2num(list(lx).name(startIndex+1:endIndex))+1;
        refcube(:,:,num)=reads;
    end
end
for lx=1:length(list)
    if(length(strfind(list(lx).name,'.txt'))==1 && length(strfind(list(lx).name,expString))==1)
        Raw_data=importdata(strcat(pth,'\',list(lx).name));
        reads=ifft(data_reader_s(Raw_data));
        xps='([0-9]+';
        [startIndex,endIndex] = regexp(list(lx).name,xps);
        num=str2num(list(lx).name(startIndex+1:endIndex))+1;
        reads=reads-refcube(:,:,num);
        if(mod(num,2)==0)
           reads=fliplr(reads);
        end
        reads(1:7,:)=0;
        reads(20:end,:)=1e-20;
        rawCube(:,:,num)=reads;
        %%-----to avoid reconstruction coment this section----------
        [ BSCAN2 ] = data_former(reads, zeros(601,m_size),135/180*pi );
        Params.dataset=BSCAN2;
        imafin=Multi_rec_full(Params);
        sizmat=size(imafin);
        X1=round(sizmat(1)/2-zm);X2=round(sizmat(1)/2+zm);Y1=round(sizmat(2)/2-zm);Y2=round(sizmat(2)/2+zm);
        expCube(:,:,num)=imafin(X1:X2,Y1:Y2);
        %%-----to avoid reconstruction coment this section----------
    end
end