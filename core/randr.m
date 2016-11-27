function r = randr(m,n,lb,ub)
%% randr(m,n,lb,ub) -> random number in range lb<->ub of size(m,n)
% 
% lb -> lower bound
% ub -> upper bound
%
% r -> random number in range
% 
% author: john devitis
% create date: 31-Oct-2016 16:50:08
	r = (ub-lb).*rand(m,n)+lb;
end
