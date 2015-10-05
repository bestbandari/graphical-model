function [ graph, round, max_score ] = bayesian_network( G, D, n, degree, alpha, scale, seed)
%BAYESIAN NETWORK Summary of this function goes here
%   Detailed explanation goes here
    max_score = -inf;
    round = 0;
    n_graph = 0;
    
    tic;
    while(1)
        
        [g_set, n_g] = next_graph(G, n, degree);
        score = zeros(n_g,1);
        
        for i = 1:n_g
            score(i) = bayesian_score(g_set(:,:,i), D, degree, alpha, scale);
        end
        
        [t_score, t_index] = max(score);
        if  t_score > max_score
            max_score = t_score;
            G = g_set(:,:,t_index);
        else
            break;
        end
        
        round = round + 1;
        n_graph = n_graph + n_g;
        toc;
        if  mod(round, 10) == 0
            file = sprintf('./mediate/%d_%06d.mat', seed, round);
            save(file, 'round', 'max_score', 'G');
        end
    end
    
    
    graph = G;
end

function [g_set, n_g] = next_graph(G, n, d)
    g_set = zeros(n, n, n*n+n*d*d);
    k = 1;
    temp = 0;

    for i = 1:n
        for j = 1:n
            
            if  G(i,j) == 1
                g_set(:,:,k) = delete_graph(G, i, j);
                k = k + 1;
                [g_set(:,:,k), succ] = reverse_graph(G, i, j, n, d);
                if  succ == 1
                    k = k + 1;
                end
            else
                [g_set(:,:,k), succ] = add_graph(G, i, j, n, d);
                if  succ == 1
                    k = k + 1;
                end
                temp = temp + 1;
            end
            
        end
    end
    
    n_g = k - 1;
end

function [g, succ] = add_graph(G, i, j, n, d)
    g = zeros(n);
    
    G(i,j) = 1;
    [~, n_pa] = parent(G, j, d);
    if  n_pa > d
        succ = 0;
        return;
    end
    if  ~myisdag(G)
        succ = 0;
        return;
    end
    
    succ = 1;
    g = G;
    
end

function [g, succ] = delete_graph(G, i, j)
    G(i,j) = 0;
    succ = 1;
    g = G;
end

function [g, succ] = reverse_graph(G, i, j, n, d)
    g = zeros(n);
    
    G(i,j) = 0;
    G(j,i) = 1;
    [~, n_pa] = parent(G, i, d);
    if  n_pa > d
        succ = 0;
        return;
    end
    if  ~myisdag(G)
        succ = 0;
        return;
    end
    
    succ = 1;
    g = G;
end








