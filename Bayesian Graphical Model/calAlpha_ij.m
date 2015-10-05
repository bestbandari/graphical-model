function [ alpha ] = calAlpha_ij( K, n_Xij, n_ui)
%Estimate the graph parameter prior p(theta|G)
% Use empty BN with uniform distribution (BDeu score)
%   K     - given imaginary sample size
%   n_Xij - count of the jth configuration of the random var Xi
%   n_ui  - count of one configuration of the parents of Xi

alpha = K / (n_Xij * n_ui);

end