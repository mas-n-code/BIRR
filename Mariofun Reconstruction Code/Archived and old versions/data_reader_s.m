function data_time=data_reader_s(mat)
sizemat=size(mat);

data_matrix=zeros(sizemat(1),sizemat(2)/2);

for k=1:sizemat(2)/2
    %div=max(abs(mat(:,2*(k-1)+1)+1i*mat(:,2*k)));
    data_matrix(:,k)=(mat(:,2*(k-1)+1)+1i*mat(:,2*k));
end;

%data_time=ifft(data_matrix);
data_time=data_matrix;