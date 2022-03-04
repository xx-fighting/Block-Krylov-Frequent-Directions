function [ A] =Generate_FD(n,d,k,r)

S = randn(n,k);
D = 0:(k-1);
D = diag(1-D/k);
U = randn(d,k);
U = orth(U);
W = randn(n,d)/r;
A_o = S*D*U';
A = A_o + W;

end

