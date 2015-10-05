function [ d,n,w,v ] = load_data( doc, vocab )
%LOAD_DATA Summary of this function goes here
%   Detailed explanation goes here
    c = csvread(doc); 
    d = c(1,1);
    n = c(2,1);
    w = zeros(d,n);
    
    for i = 4: size(c,1)
        w(c(i,1),c(i,2)) = c(i,3);
    end
    
    f = fopen(vocab);
    v = textscan(f, '%s\n');
    fclose(f);
    
end

