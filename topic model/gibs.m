function [ psi, th ] = gibs( word_doc, index_word_doc, n_wk, n_k, n_dk, n_d, z, d, n, w, k, a, b )
%GIBS Summary of this function goes here
%   Detailed explanation goes here
    z_old = zeros(size(z));
    mini = size(z,1)*size(z,2);
    
    round = 1;
    while( mini >= length(find(z-z_old)~=0) )
        mini = length(find(z-z_old)~=0);
        z_old = z;
        for i = 1:d
            for j = 1:word_doc(i)
                topic = z(i,j);
                n_wk(index_word_doc(i,j), topic) = n_wk(index_word_doc(i,j), topic) - 1;
                n_k(topic) = n_k(topic) - 1;
                n_dk(i, topic) = n_dk(i, topic) - 1;
                n_d(i) = n_d(i) - 1;

                dis = get_distribution(index_word_doc(i,j), i, n_wk, n_k, n_dk, n_d, n, k, a, b );
                new_topic = randsample(k,1,true,dis);
                z(i,j) = new_topic;
                
                n_wk(index_word_doc(i,j), new_topic) = n_wk(index_word_doc(i,j), new_topic) + 1;
                n_k(new_topic) = n_k(new_topic) + 1;
                n_dk(i, new_topic) = n_dk(i, new_topic) + 1;
                n_d(i) = n_d(i) + 1;

            end
        end
        fprintf('%d, %d, mini:%d\n', round, length(find(z-z_old)~=0), mini);
        round = round + 1;
    end
    
    psi = get_estimate(n_wk, n_k, b, k, n);
    th = get_estimate(n_dk, n_d, a, k, d);
end

function [ret] = get_estimate(n_wk, n_k, b, k, n)
    ret = zeros(n,k);
    for i = 1:n
        for j = 1:k
            ret(i, j) = (n_wk(i, j) + b)/(n_k(j) + n*b);
        end
    end
end

function [dis] = get_distribution( word, doc, n_wk, n_k, n_dk, n_d, n, k, a, b )
    prob = zeros(k, 1);
    
    for i = 1:k
        prob(i) = (n_wk(word,i) + b)/(n_k(i) + n*b) * (n_dk(doc, i) + a)/(n_d(i) + k*a);
    end
    
    dis = prob / sum(prob);

end

