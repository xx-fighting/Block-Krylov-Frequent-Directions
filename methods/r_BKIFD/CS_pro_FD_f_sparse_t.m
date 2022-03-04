function [B,t1,t2] = CS_pro_FD_f_sparse(A,k,l,q)

n = size(A,1);
d = size(A,2);

m = floor(n/l);

B = zeros(2*k,d);
t1 = 0;
t2 = 0;
for i = 1:m
    F = A((i-1)*l+1:i*l, :);
    [Z,tk,to] = krylov_cs_sparse(F,k,q);
    t1 = t1+tk;
    t2 = t2+to;
    t3 = tic;
    
    P = Z'*F;
    if i == 1
        B(1:k,:) = P;
        continue
    end
    B(k+1:end,:) = P;
    [~,S,V] = svd(B, 'econ');
    S = Reduce_Rank_fast(S, 2*k);
    B = S*V';
    t2 = t2 + toc(t3); 
end
t = m*l;
if t < n
    F = A(m*l+1:end,:);
    [Z,tk,to] = krylov_cs_sparse(F,k,q);
    t1 = t1+tk;
    t2 = t2+to;
    t3 = tic;
    P = Z'*F;
    B(k+1:end,:) = P;
    [~,S,V] = svd(B, 'econ');
    S = Reduce_Rank_fast(S, 2*k);
    B = S*V';
    t2 = t2 + toc(t3);
end
    
