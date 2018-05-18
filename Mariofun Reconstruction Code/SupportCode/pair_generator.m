function [k_alpha_index,k_beta_index]=pair_generator(steps,k_s)

k_s_span_length=2*steps-1;
k_s_span=[k_s(1)+k_s k_s(end)+k_s(2:end)];

%Defining the alpha-beta pairs for each kx value

k_alpha_index=zeros(steps,k_s_span_length);
k_beta_index=zeros(steps,k_s_span_length);


for i=1:k_s_span_length
    
    if i<=steps
        
        alpha_index=i;
        beta_index=1;
        j=0;
        k=i+1;
       
        while (alpha_index-beta_index)>=0
            j=j+1;
            k=k-1;
            k_alpha_index(j,i)=alpha_index; 
            k_beta_index(j,i)=beta_index;
            
            %Adding symetric values at the end of the array
            k_alpha_index(k,i)=beta_index;
            k_beta_index(k,i)=alpha_index;
            
            alpha_index=alpha_index-1;
            beta_index=beta_index+1;
            
        end
        
        
        
    end
    
    if i>steps
        
        alpha_index=steps;
        beta_index=i+1-steps;
        j=0;
        k=2*steps-i+1;
        
        
         while (alpha_index-beta_index)>=0
            j=j+1;
            k=k-1;
            
            k_alpha_index(j,i)=alpha_index; 
            k_beta_index(j,i)=beta_index;
            
            %Adding symetric values at the end of the array
            k_alpha_index(k,i)=beta_index;
            k_beta_index(k,i)=alpha_index;
            
            alpha_index=alpha_index-1;
            beta_index=beta_index+1;
            
        end
        
        
    end
        
    
    
    
end