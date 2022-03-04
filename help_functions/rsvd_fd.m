function [err] = rsvd_fd(A,q, K)
%-------------------------------------------------------------------------------------


[M,N] = size(A);
P = min(2*K,N);
X = randn(N,P);
Y = A*X;
[W1 ,~]= qr(Y,0);
for i = 1:q
    [Z,~] = qr(A'*W1,0);
    [W1,~] = qr(A*Z,0);
end
B = W1'*A;
[W2,S,V] = svd(B,'econ');
U = W1*W2;
K=min(K,size(U,2));
U = U(:,1:K);
S = S(1:K,1:K);
V=V(:,1:K);
A_k = U*S*V';

err = norm(A-A_k,'fro')^2;
