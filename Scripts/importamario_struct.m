tic
display('Importing');
the_files = dir('*Mono***.txt');



for i=1:length(the_files)
    %b=the_files(i).name;
    %the_files(i).name=the_files(i).name(6:end-18);
    eval(['load ' the_files(i).name ' -ascii']);
    
    A(i,1)={the_files(1).name(1:end-6)};
    
    %Ref(i).name=A{i,1};
    %Ref(i).data={A(i,1)};
    
    
    %s(i)=eval(b);
    %eval([p(i) '=' 'load ' the_files(i).name ' -ascii']);
    
    %Ref(i).X=
end
toc
clearvars A i s the_files;

tic;
display('Creating Structure');
%get a list of the workspace
imported = whos;

%initialiste a structure
newSet = struct;

for ii = 1:length(imported)
    newSet(ii).name= imported(ii).name;
    newSet(ii).values = eval(imported(ii).name);
     newSet(ii).data=data_reader_daniel(newSet(ii).values);
end
toc;




clearvars imported ii