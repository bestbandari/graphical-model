a = 1;
b = 1;


i = 1;
%{
psi_1 = cell(3,1);
th_1 = cell(3,1);
distribution_1 = cell(3,1);
top_1 = cell(3,2);
%}
[d,n,w,v] = load_data('./data/docword.kos.txt', './data/vocab.kos.txt');
for k = [2,5,10]
%    [ word_doc, index_word_doc, n_wk, n_k, n_dk, n_d, z ] = init_count(d, n, w, k );

%    [ psi_1{i,1}, th_1{i,1} ] = gibs( word_doc, index_word_doc, n_wk, n_k, n_dk, n_d, z, d, n, w, k, a, b );

    [distribution_1{i,1}] = evaluate(psi_1{i,1}, n, k);

    [top_1{i,1}, top_1{i,2}] = top10(distribution_1{i,1}, v, k );
    
    i = i + 1;
end

%{
i = 1;
%{
psi_2 = cell(3,1);
th_2 = cell(3,1);
distribution_2 = cell(3,1);
top_2 = cell(3,2);
%}
[d,n,w,v] = load_data('./data/docword.nips.txt', './data/vocab.nips.txt');
for k = [2,5,10]
%    [ word_doc, index_word_doc, n_wk, n_k, n_dk, n_d, z ] = init_count(d, n, w, k );

%    [ psi_2{i,1}, th_2{i,1} ] = gibs( word_doc, index_word_doc, n_wk, n_k, n_dk, n_d, z, d, n, w, k, a, b );

    [distribution_2{i,1}] = evaluate(psi_2{i,1}, n, k);

    [top_2{i,1}, top_2{i,2}] = top10(distribution_2{i,1}, v, k );
    
    i = i + 1;
end
%}