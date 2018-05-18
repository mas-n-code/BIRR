function [dataset]= downSample(data,points)
    if(and(isreal(data),abs(sum(sum(data)))>0))
        data=data_reader_s(data);
    end
    if(points==0)
        dataset=ifft(data);
        return;
    end
    %data=ifft(data);
    dsize=size(data);
    if(rem(dsize(2)/points,1)~=0)
        dataset=ifft(data);
        return;
    end
    
    if(dsize(2)/points<=2)
        diff=dsize(2)-points;
        mdif=dsize(2)/diff;
        dataset=data;
        for i=0:(diff-1);
            dataset(:,((diff-i)*mdif))=[];
        end
        dataset=ifft(dataset);
    else
        diff=points;
        mdif=dsize(2)/diff;
        dataset=zeros(dsize(1),points);
        for i=1:(diff);
           dataset(:,i)=data(:,((i)*mdif));
        end
        dataset=ifft(dataset);
    end
end