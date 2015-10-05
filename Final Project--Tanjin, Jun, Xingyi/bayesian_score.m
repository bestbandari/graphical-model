function [ score ] = bayesian_score( G, D, degree, palpha, scale)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

[n_nodes, ~] = size(D);
score = 0;

for i = 1 : n_nodes
    %get all instantiations of parents of Xi
    [pa, n_pa] = parent(G,i,degree);
    [m_stat,pa_stat,x_stat] = getstat(pa, n_pa, D, i, scale);
    
    for p = 1 : size(pa_stat,1)
        
        alpha = zeros(scale,1);
        m = zeros(scale,1);
        
        if  pa_stat(p) == 0
            continue;
        end
        for j = 1 : scale          
            alpha_ij = calAlpha_ij(palpha,x_stat(j),pa_stat(p));
            alpha(j) = alpha_ij;
            m(j) = m_stat((p-1)*scale+j);
        end
        
        score = score + myfactor(alpha,m);
    end
end

%add graph complexity penalty into the score
n_edges = sum(sum(G));
score = score - n_edges;
end



function [ m_stat, pa_stat, x_stat ] = getstat(pa, n_pa, D, xi, scale)
%get all instantiations of parents of Xi

ncol = size(D,scale);

m_stat = zeros(scale^(n_pa+1),1);
pa_stat = zeros(scale^n_pa,1);
x_stat = zeros(scale,1);

for i = 1:ncol
    index = 0;
    for j = 1:n_pa
       index = index + D(pa(j),i) * scale^(n_pa-j);
    end
    
    pa_stat(index+1) = pa_stat(index+1) + 1;
    index = index * scale + D(xi,i) + 1;
    m_stat(index) = m_stat(index) + 1;
    x_stat(D(xi,i)+1) = x_stat(D(xi,i)+1) + 1;
end
end




