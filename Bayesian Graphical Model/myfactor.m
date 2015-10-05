function [ val ] = myfactor( alpha, m )
%
%   calculate the whole score for Xi in an elegant way
%   
    scale = size(alpha,1);
    val = 0;
    
    for i = 1:scale
        
        for j = 1:m(i)
            val = val + log(alpha(i) + m(i) - j);
        end
        
    end
    
    sum_a = sum(alpha);
    sum_m = sum(m);
    
    for i = 1:sum_m
        val = val - log(sum_a + sum_m - i);
    end

end

