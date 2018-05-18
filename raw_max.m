function max_value=raw_max(ref,data)
s11_ref=data_reader_daniel(ref);%reference
s11_data=data_reader_daniel(data);%data!
resulting=s11_ref-s11_data; % substracted
raw_fig= abs(resulting).^2;
max_value=max(max(raw_fig));

words = 'Max in RawData =';
X = [words,num2str(max_value,3)];

disp(X)
