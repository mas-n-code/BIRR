function data_time=data_reader(mat)
sizemat=size(mat);

data_matrix=zeros(sizemat(1),sizemat(2)/2);

for k=1:sizemat(2)/2
    
    data_matrix(:,k)=mat(:,2*(k-1)+1)+1i*mat(:,2*k);

end;

winhan=repmat(hanning(sizemat(1)),1,sizemat(2)/2);
data_time=ifft(data_matrix.*winhan);
%data_time=ifft(data_matrix);
