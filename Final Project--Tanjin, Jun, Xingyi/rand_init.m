function [ graph ] = rand_init(n,d)
%RAND_INIT Summary of this function goes here
%   Detailed explanation goes here

    graph = rand_graph(n,d);
    while ~myisdag(graph)
        graph = rand_graph(n,d);
    end
end

function graph = rand_graph(n,d)
    graph = zeros(n);
    for i = 1:n
        seq = rand_binary_seq(n);
        while  sum(seq) >d
            seq = rand_binary_seq(n);
        end
        graph(:,i) = seq;
        graph(i,i) = 0;
    end

end

function seq = rand_binary_seq(n)
    seq = zeros(n,1);
    prob = 1/(n-1);
    
    for i = 1:n
        if  prob>rand()
            seq(i) = 1;
        end
    end
    
end
