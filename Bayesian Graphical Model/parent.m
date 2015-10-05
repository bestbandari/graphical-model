function [ pa, n_pa ] = parent( graph, x, d )
%PARENT Summary of this function goes here
%   Detailed explanation goes here
    n = size(graph,1);
    pa = zeros(d,1);
    
    j = 1;
    for i = 1:n
        if  graph(i,x) == 1
            pa(j) = i;
            j = j + 1;
        end
    end
    n_pa = j-1;
    
end

