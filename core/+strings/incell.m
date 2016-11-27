function present = incell(strs,str)
%% presentInCell
% 
% elements -> cell array
% str -> string
% 
% author: john devitis
% create date: 30-Oct-2016 19:57:11
	present = cellfun(@(s) ~isempty(strfind(str, s)), strs);
end
