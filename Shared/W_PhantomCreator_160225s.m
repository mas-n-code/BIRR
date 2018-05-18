% W_PhantomConstructor 
%By Mario Solis
% Feb 25 2016 
%% Load ASCII Files

%@ Guaper
%cd('F:\UserElGuapo\DBOx\Dropbox\ResearchMagic\RandomProyects\160114 Serbian Breast Phantom\160225 Wisnconsin Repository\Class3 Phantom 2');

%@ 
%cd('C:\Users\El Mario\Documents\DopboxMyAcount\Dropbox\ResearchMagic\RandomProyects\160114 Serbian Breast Phantom\160225 Wisnconsin Repository\Class3 Phantom 2');

%@
cd('C:\Users\Mario\Dropbox\ResearchMagic\RandomProyects\160114 Serbian Breast Phantom\160225 Wisnconsin Repository\Class3 Phantom 2');

fileID = fopen('breastinfo.txt');

formatSpec = '%*s s1=%d s2=%d s3=%d %*s';

C = textscan(fileID,formatSpec,...            
                'Delimiter', '\n', ...
                'CollectOutput', true);
s=C{1};

%% Load and generate Grids
% Grid 1
if ~exist('V_type','var')
    V_type=load('mtype.txt');
end
G_type=zeros(s);
G_type=int8(G_type);

cc=1; %counter
for kk=1:s(3);
    for jj=1:s(2);
        for ii=1:s(1);
            voxel=V_type(cc);
                switch voxel; %selection of tissue and value, by
                
                case -1 % -1 Values represent immersion medium
                voxel=-5; 
                case 1.1 %1.1 Values represent Fibroconnective/glandular-1    
                voxel=4; 
               
                end
            G_type(ii,jj,kk)=voxel;
            cc=cc+1;
        end
    end
end

save 'G_type'


%% Display 3D Grid

 h = vol3d('cdata',G_type,'texture','3D'); % Vol3d is a 
  view(3);  
  axis tight;  daspect([1 1 .4])
   alphamap('rampup')
   alphamap(.06 .* alphamap);
  colormap jet
  

  
%
%                   Tissue type           Media number
% 
%             Immersion medium      -1
%                        Skin       -2
%                      Muscle       -4
% Fibroconnective/glandular-1       1.1
% Fibroconnective/glandular-2       1.2
% Fibroconnective/glandular-3       1.3
%                  Transitional     2
%                       Fatty-1     3.1
%                       Fatty-2     3.2
%                       Fatty-3     3.3 
