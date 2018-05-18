function res = ApplyWindowS(raw,sup_l,inf_l)
siz=size(raw);
 raw(1:sup_l,:)=1e-20*(1+1i);

 raw(inf_l:end,:)=1e-20*(1+1i);

res=raw;
end