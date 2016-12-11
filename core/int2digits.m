function out = int2digits(in)
%% int2digits -> split a positive integer into array of digits.
% author: john devitis
% create date: 10-Dec-2016 14:52:52
	out = sprintf('%.0f',in)-'0';
end
