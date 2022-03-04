function [B] = Sparse_G_FD(A,q,ell)

[n,d] = size(A);
B = zeros(2*ell, d);

m = floor(n/d);
% q = 5;
for i = 1:m
    buffer = A((i-1)*d+1:i*d, :);
%     size(buffer)
    [S,V] = simIter(buffer, q,ell);
    S = Reduce_Rank(S, ell);
    
    if i == 1
        B(1:ell,:) = S*V';
        continue
    end

    B(ell+1:end,:) = S*V';
    [~,S,V] = svd(B, 'econ');
    V = V(:,1:ell);
    S = Reduce_Rank(S, ell);
%     size(V)
%     size(S)
    B1 = S*V'; 
    B(1:ell,:) = B1;
end
t = m*d;
res = n-t;
if (t < n) && (res > ell) 
    buffer = A(t+1:end,:);
    [S,V] = simIter(buffer, q,ell);
    S = Reduce_Rank(S, ell);
   
    B(ell+1:end,:) = S*V';
    [~,S,V] = svd(B, 'econ');
    V = V(:,1:ell);
    S = Reduce_Rank(S, ell);
%     size(V)
%     size(S)
    B1 = S*V'; 
    B(1:ell,:) = B1;
end
B = B(1:ell,:);


