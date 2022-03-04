function [error] = ca_err_fd(A,V,r)

Vr = V(:,1:r);
error = norm(A-A*(Vr*Vr'),'fro')^2;

    
end
