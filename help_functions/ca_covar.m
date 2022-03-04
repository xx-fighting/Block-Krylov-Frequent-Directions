function [error] = ca_covar(A,B)

error = norm(A'*A - B'*B)/norm(A,'fro')^2;
end

