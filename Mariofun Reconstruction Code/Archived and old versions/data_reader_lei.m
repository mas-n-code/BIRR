function data_time=data_reader(mat)
sizemat=size(mat);

data_matrix=zeros(sizemat(1),sizemat(2)/2);

for k=1:sizemat(2)/2
    
   % data_matrix(:,k)=mat(:,2*(k-1)+1)+1i*mat(:,2*k);
     data_matrix(:,k)=10.^(mat(:,2*(k-1)+1)./20).*exp(1i.*(mat(:,2*k)./180.*pi));
end;

winhan=repmat(hanning(sizemat(1)),1,sizemat(2)/2);
data_time=ifft(data_matrix.*winhan);

%data_time=fftshift(data_time);
