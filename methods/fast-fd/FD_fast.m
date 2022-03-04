function [B] = FD_fast(A, k , fullsize)

if nargin < 3
    fullsize = 0;
end

[m,n] = size(A);

B = zeros(2*k, n);
B(1:k, :) = A(1:k,:);

for i = k+1:m
    indB = find(~any(B,2));
    
    if ~isempty(indB)
        B(indB(1),:) = A(i,:);
    else
        [U,S,V] = svd(B, 'econ');
        S = Reduce_Rank_fast(S, 2*k);       
        B = S*V';
    end
end

B = B(1:k,:);

