function [ err_B, cv_B,t] = FD_vary(A,k,i,ell,q,nbetak,err_A,k1, sparse)


if i == 1
    % Fast FD
    tic
    [B_f] =  FD_fast(A, k , 1);
    t = toc;
    cv_B =  ca_covar(A,B_f);
    [~,~,V_B_f] = svd(B_f,'econ');
    err_B = ca_err_fd(A,V_B_f,k1)/err_A;
end

if i == 2
    % SFD
    %A = full(A);
    tic
    [B_f] =  Sparse_G_FD(A,q,k);
    t = toc;
    A = full(A);
    cv_B =  ca_covar(A,B_f);
    [~,~,V_B_f] = svd(B_f,'econ');
    err_B = ca_err_fd(A,V_B_f,k1)/err_A;
end

if i == 3
    % SpFD10
    tic
     sketcher = FrequentDirections(k,'alpha',1,'sparse',true);
     sketcher.beta = size(A,1)/nbetak/k;
      sketcher(A);
      t = toc;
      cv_B = sketcher.coverr(A);
       Am_ = sketcher.approx(A,k1);
        err_B = norm(A-Am_,'fro')^2/err_A;
end

if i == 4
    % Ours
      a = tic;
      if sparse 
          [B_f] =  CS_pro_FD_f_sparse(A,k,ell,q);
      else
          [B_f] =  CS_pro_FD_f(A,k,ell,q);
      end
    
    t = toc(a);
	cv_B = 0;
	err_B = 0;
    A = full(A);
    cv_B =  ca_covar(A,B_f);
    [~,~,V_B_f] = svd(B_f,'econ');
    f_err = ca_err_fd(A,V_B_f,k1);
    err_B = f_err/err_A;
end

if i == 5
    % Ours
    a = tic;
    [B_f] =  GA_pro_FD_f(A,k,ell,q);
    t = toc(a);
	cv_B = 0;
	err_B = 0;
    A = full(A);
    cv_B =  ca_covar(A,B_f);
    [~,~,V_B_f] = svd(B_f,'econ');
    f_err = ca_err_fd(A,V_B_f,k1);
    err_B = f_err/err_A;
end




end

