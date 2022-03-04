function [S,V] = simIter(A, q, ell)

% [m,d] = size(A);
% G = randn(d,ell);
% t = A' * A;
% A1 = A*(t)^q;
% [Q,~] = qr(A1*G,0);
% M = Q'*A;
% [~,S,V] = svd(M,'econ');
% S = S(1:ell,1:ell);
% V = V(:,1:ell);
%%%%%%%%%%
[m, d] = size(A);
q = ceil(log(m)/0.25);
G = randn(m, ell);

for i = 1:q
    [G,~] = qr(G,0);
    G = A * A' * G;
end
% t = A * A';
% AT = A'*(t)^q;

% for i = 1:q
%     G = A*(AT * G);
% end

[Q,~] = qr(A'*G,0);
M = A*Q;
[~,S,U] = svd(M,'econ');
U = U';

V = U(:,1:ell)' * Q';
V = V';
S = S(1:ell,1:ell);
%%%%%%%%
% [n,d]= size(A);
% G = randn(d, ell);
% for i = 1:q
%     [G,~] = qr(G,0);
%     G = A' * A * G;
% end
% [Q,~] = qr(A*G, 0);
% M = Q' * A;
% % M = A' * Q;
% [~,S,V] = svd(M, 'econ');


end

