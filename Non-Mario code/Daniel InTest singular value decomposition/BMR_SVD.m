function  BMR  = BMR_SVD( dataset,level,Params )
%BMR_SVD.m
%   Performs a preprocessing of the Breast Microwave Radar datasets using
%   Singular Value Decomposition
%Input Parameters:
% dataset: BMR dataset
% level: levels of SVD to be included in the denoise dataset
% Params: Reconstruction parameters structure


[u,s,v]=svd(dataset);
SVD_data=zeros(1001,72);

for i=level(1):level(2)
    SVD_data=SVD_data+s(i,i)*u(:,i)*v(:,i)';
end

SVD_data(18:end,:)=1e-30;


Params.dataset= data_former( SVD_data, zeros(size(dataset)),145/57.3 );
size(Params.dataset)
BMR=Multi_rec_full_comp201(Params);


end

