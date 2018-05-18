                    
tic
the_files = dir('*A**138*.txt');

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