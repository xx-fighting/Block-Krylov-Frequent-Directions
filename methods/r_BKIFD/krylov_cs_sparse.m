function [Z, time_k, time_o] = krylov_cs_sparse(A, k, q)

J = k ;


t1 = tic;


h = randi(J, size(A, 2), 1);
s = randi(2, size(A, 2), 1)*2-3;
n = size(A,1);


%A1 = A';
%A_c = countSketch_sparse(A1,int64(h),J,s);
%A_c = A_c';

% A_c = countSketch(A,int64(h),J,s,1);
A_c = countSketch_sparse(A,int64(h),J,s);

%tmp = A*A';
Cout_A = zeros(n,J*q);

Cout_A(:,1:J) = A_c;
t = A;
for i = 1:q
    t = A'*t;
    t = A*t;
    Cout_A(:,J*i+1:J*(i+1)) = countSketch_sparse(t,int64(h),J,s);
end

time_k = toc(t1) ;
t2 = tic;
%fprintf('get the count sketch %d \n', timeb);


[Q,~] = qr(Cout_A,0);

%M = Q'*tmp*Q;
M1 = A'*Q;
M = M1'*M1;

[U_k,~,V] = svd(M, 'econ');

%Z = Q*U_k(:,1:k);
Z = Q*U_k(:,1:min(k,size(U_k,2)));
time_o = toc(t2);
% Z = Q(:,1:k);
end
