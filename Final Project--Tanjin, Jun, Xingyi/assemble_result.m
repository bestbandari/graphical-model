filelist = dir('./result');
filelist = filelist(3:end);
load('data.mat');
data = exp_dis;

result_g = zeros(size(data,1), size(data,1), length(filelist) );

for iter = 1:length(filelist)
    if  filelist(iter).isdir == 0
        file = sprintf('%s%s', './result/', filelist(iter).name);

        load(file);

        result_g(:,:,iter) = G;
    end
    
end

[ conf_gene, conf_edge ] = mystat( result_g );



