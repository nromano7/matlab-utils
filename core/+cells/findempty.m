function ind = findempty(c)
%% nonzeros
% 
% find non zero indices in a cell array
% 
% author: john devitis
% create date: 30-Oct-2016 19:51:52
	ind = find(~cellfun(@isempty,c));
end
