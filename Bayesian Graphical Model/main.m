% set this option to 1 to enable bootstrap strategy.
bootstrap = 0;

% set the initial random seed
seed = 1002;

load('data.mat');

for seed = seed:seed+500
    run
end
