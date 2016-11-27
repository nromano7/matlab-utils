function out = removeEmptyElementsInArray(in,ind)
%% removeEmptyElementsInArray
% 
% 
%  
% author: john devitis
% create date: 30-Oct-2016 15:33:26
	if nargin < 2
        import structures.*
        ind = findEmptyElementsInArray(in);
    end
    out = in(find(not(ind))); % save non zeros
end
