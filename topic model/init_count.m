function [ word_doc, index_word_doc, n_wk, n_k, n_dk, n_d, z ] = init_count(d, n, w, k )
%COUNT Summary of this function goes here
%   Detailed explanation goes here

    word_doc = zeros(d,1);
    for i = 1:d
        for j = 1:n
            word_doc(i) = word_doc(i) + w(i,j);
        end
    end
    
    max_word = max(word_doc);
    index_word_doc = zeros(d,max_word);
    z = zeros(d,max_word);
    
    for i = 1:d
        p = 1;
        accu = 0;
        for j = 1:word_doc(i)
            while  p <= n && j > accu + w(i,p)
                accu = accu + w(i,p);
                p = p + 1;
            end
            index_word_doc(i,j) = p;
        end
    end
    
    n_wk = zeros(n, k);
    n_k = zeros(1, k);
    n_dk = zeros(d, k);
    n_d = zeros(1, d);
    
    for i = 1:d
        for j = 1:word_doc(i)

            topic = randi(k);
            z(i,j) = topic;
            n_wk(index_word_doc(i,j),topic) = n_wk(index_word_doc(i,j),topic) + 1;
            n_k(topic) = n_k(topic) + 1;
            n_dk(i, topic) = n_dk(i, topic) + 1;
            n_d(i) = n_d(i) + 1;
            
        end
    end

end

