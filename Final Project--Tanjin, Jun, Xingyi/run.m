
data = exp_dis;

rng(seed);

n = size(data,1);
d = 3;
scale = 2;
alpha = 2;

graph = rand_init(n,d);

if  bootstrap == 1
    seq = randi(size(data,2),size(data,2),1,true);
    data = data(:,seq);
end

[ G, round, max_score ] =  bayesian_network(graph,data,n,d,alpha, scale, seed);


file = sprintf('./result/%d_%s.mat', seed, date() );
save(file);
