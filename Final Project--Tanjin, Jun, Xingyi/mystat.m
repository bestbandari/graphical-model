function [ gene_conf, edge_conf ] = mystat( res_g )
%MYSTAT Summary of this function goes here
%   Detailed explanation goes here

    n_graph = size(res_g, 3);
    n_gene = size(res_g, 1);

    gene_conf = zeros(n_gene,2);
    edge_conf = zeros(n_gene*n_gene,2);

    for i = 1:n_graph
        gene_conf(:,1) = gene_conf(:,1) + sum(res_g(:,:,i),1)' + sum(res_g(:,:,i),2);
    end

    [gene_conf(:,1), gene_conf(:,2)] = sort( gene_conf(:,1) / n_graph, 'descend' );

    [edge_conf(:,1), edge_conf(:,2)] = sort( reshape( (sum(res_g, 3) / n_graph), n_gene*n_gene, 1 ), 'descend');
    
    edge_conf(:,3) = fix((edge_conf(:,2) - 1) / (n_gene) + 1);
    
    edge_conf(:,2) = mod(edge_conf(:,2) - 1, n_gene) + 1;
end

