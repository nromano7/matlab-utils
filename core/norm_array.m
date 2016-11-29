function out = norm_array(A)
%% norm_array(in) -> normalize any size 2d array
% author: john devitis
% create date: 31-Oct-2016 18:50:07
	out = bsxfun(@rdivide, A, max(abs(A),[],1));	
end
