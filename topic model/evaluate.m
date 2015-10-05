function [ distribution ] = evaluate( psi, n, k)
%EVAL Summary of this function goes here
%   Detailed explanation goes here
    distribution = cell(k,1);
    for i = 1:k
        distribution{i,1} = zeros(n,2);
        [distribution{i,1}(:, 1), distribution{i,1}(:, 2)] = sort(psi(:,i), 'descend');
    end
    
end

