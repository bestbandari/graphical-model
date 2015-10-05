function [ word, prob ] = top10( distribution, v, k )
%TOP10 Summary of this function goes here
%   Detailed explanation goes here
    word = cell(10, k);
    prob = zeros(10, k);
    top = zeros(10, k);
    for i = 1:k
        top(:,i) = distribution{i,1}(1:10, 2);
        prob(:,i) = distribution{i,1}(1:10, 1);
        for j = 1:10
            word{j, i} = v{1,1}(top(j,i));
        end
    end
    
end

