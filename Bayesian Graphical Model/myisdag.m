function [ ret ] = myisdag( G )
%MYISDAG Summary of this function goes here
%   Detailed explanation goes here
    ret = graphisdag(sparse(G));
end

