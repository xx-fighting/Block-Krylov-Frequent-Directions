function [Sprime] = Reduce_Rank(S, k)

% s = diag(S);
% sprime = zeros(size(s));
% skip = round(k*(1-alpha));
% 
% sprime(1:skip) = s(1:skip);
% 
% dirac_ind = k - round(k*alpha/2) + 1;
% dirac = s(dirac_ind)^2;
% sprime(skip+1:end) = sqrt( max(s(skip+1:end).^2 - dirac,0) );
% 
% 
% Sprime = diag(sprime);

s = diag(S);
dirac = s(k)^2;
s = sqrt(max(s.^2-dirac,0));
Sprime = diag(s(1:k));


end

