 function ErrorSet=LS_RawFileLoader(ErrorSet,f_directory)
cd(f_directory);
Ref_files = dir('**Mono*[A]***.txt');
TumorFibro_files=dir('*Mono*[C]***.txt');
Tumor_files = dir('**Mono*[B]***.txt');

ErrorSet.PD_P1.E1.set_ref=load(Ref_files(1).name);
ErrorSet.PD_P2.E1.set_ref=load(Ref_files(2).name);

ErrorSet.L0.P1.set_data=load(TumorFibro_files(1).name);
ErrorSet.L0.P2.set_data=load(TumorFibro_files(2).name);

ErrorSet.L0.P1.set_tumor=load(Tumor_files(1).name);
ErrorSet.L0.P2.set_tumor=load(Tumor_files(2).name);