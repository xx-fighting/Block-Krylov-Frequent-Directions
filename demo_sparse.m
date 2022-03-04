
clear

number = 21;

n = 60000; % data size
d = 5000; % data dimension
k1 = 100; % idea rank


p = 0.001; % sparsity

A = sprand(n,d,p);

n1 = 11; % times of sketch size
ell = size(A,2)*2; % batch size
q = 2;  % Iteration
nbetak = 10; % used in SpFD
sparse = 1;
 

times = 3; % get average result


id = {'FD','SFD','SpFD10','CS-BKIFD','GA-BKIFD'};
symbol = [ '+', 'o','x', 'd','d','d'];
mark = {'-', '-', '-', '-', ':', '--'};
color = ['k' 'g','b', 'r','r','r'];
a = pwd;
path = [a,'/result/data/'];
list = length(id);
time = zeros(times,list,n1);
proj_err = zeros(times,list,n1);
covar_err = zeros(times,list,n1);
err_A = rsvd_fd(A,5,k1);

fprintf('Initialization over \n')

for tim = 1:times
   
		for j = 1:n1
			for i = 1:list
			k = k1+(j-1)*10;
			[proj_err(tim,i,j), covar_err(tim,i,j), time(tim,i,j)] = FD_vary(A,k,i,ell,q,nbetak,err_A,k1, sparse);
			fprintf('method %s, sketch %d , proj %d, cov %d, time %d \n', id{i},k, proj_err(tim,i,j), covar_err(tim,i,j), time(tim,i,j))
		end
		fprintf('Method %s has done \n',id{i});
	end

end
proj_err = squeeze(mean(proj_err,1));
covar_err = squeeze(mean(covar_err,1));
time = squeeze(mean(time,1));

Store = cat(3,proj_err, covar_err, time);

t = [path, 'res', num2str(number)];
save(t ,'Store')

f_s = 10;
L_s = 15;
T = k1:10:k1+(n1-1)*10 ;
Tx = 1:n1;
draw_pic(Store,number,f_s,L_s,T,Tx, id, symbol,mark, color)
















