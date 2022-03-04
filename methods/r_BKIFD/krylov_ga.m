function [Z, time_k, time_o] = krylov_ga(A, k, q)

J = k ;

t1 = tic;

[n,d] = size(A);
K = randn(d,J);
A_c = A*K;
tmp = A*A';
Cout_A = zeros(n,J*q);

Cout_A(:,1:J) = A_c;
t = A;
for i = 1:q
    t = tmp*t;
%    t = A'*t;
%    t = A*t;
    Cout_A(:,J*i+1:J*(i+1)) = t*K;
end

time_k = toc(t1) ;

t2 = tic;
%fprintf('get the gaussian sketch %d \n', timeb);

[Q,~] = qr(Cout_A,0);

M = Q'*tmp*Q;
%M1 = A'*Q;
%M = M1'*M1;
[U_k,~,V] = svd(M, 'econ');

Z = Q*U_k(:,1:min(k,size(U_k,2)));
time_o = toc(t2);
end

