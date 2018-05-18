% W_PhantomConstructor 
% Reads a Breast phantom package and displays the 3D-Grid using vol3d
%By Mario Solis
% Feb 25 2016 
%% Load ASCII Files

%
cd('C://PATH'); %% Input here the path to the Phantom files

% Reads breastinfo to determine the dimensions of the grid
fileID = fopen('breastinfo.txt');
formatSpec = '%*s s1=%d s2=%d s3=%d %*s';
C = textscan(fileID,formatSpec,...            
                'Delimiter', '\n', ...
                'CollectOutput', true);
s=C{1};

%% Load and generate Grids
% Grid 1, breast tissue type 
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
                switch voxel; %selection of tissue and value, can be modified and tissues 'turned off'; see table at the end.
                
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

 h = vol3d('cdata',G_type,'texture','3D'); % vol3d generates the 3D volume
  view(3);  
  axis tight;  daspect([1 1 .4])
   alphamap('rampup')  % Higher values will be more opaque 
   alphamap(.06 .* alphamap); % Lowers the alpha value
  colormap jet
  

  
% %%%% Table for  tissue type and corresponding media number for mtype.txt
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

%
%https://uwcem.ece.wisc.edu/phantomRepository.html
%https://uwcem.ece.wisc.edu/MRIdatabase/InstructionManual.pdf