%clear; 
dirll=dir('*.s2p');
 dircell=struct2cell(dirll)' ;  
filenames=dircell(:,1);
my_size=size(filenames);
nu=3e8;
R=0.31;
B=17e9;
%for a=1:my_size(1)
for a=1:my_size(1)
     count =a
    header=filenames(a);
    header=header{1};
      newData1 = importdata(header,' ',9);
        vars = fieldnames(newData1);
          for k= 1:length(vars)
               assignin('base', vars{k}, newData1.(vars{k}));
           end
          %data_size=size(data);
          %n=data_size(1);
         result_data(:,2*a-1)=data(:,2);
         result_data(:,2*a)=data(:,3);
         %m=m+n;
 end;
result_c=data_reader_lei(result_data);
raw_fig= abs(result_c).^2;
imagesc(raw_fig);
clearvars -except result_c result_data raw_fig;
%res=Holo_rec(result_c,nu,R,B);
%imagesc(abs(res)^2)