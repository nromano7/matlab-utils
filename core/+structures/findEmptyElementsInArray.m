function ind = findEmptyElementsInArray(s,mode)
%% findEmptyElementsInArray
% 
% inputs: 
%   s       - array of structures
%   mode ['all'] - 'all'/'any' seek behavior  
%
% outputs:
%   ind - vector of indices whos structure had ALL fields empty
%       - returns zero if structure is not array
% 
% author: john devitis
% create date: 30-Oct-2016 15:25:09
    if nargin < 2 || isempty(mode)
        mode = 'all';
    end
    switch mode
        case 'all'
            ind = arrayfun(@(a) all(structfun(@isempty,a)),s);
        case 'any'
            ind = arrayfun(@(a) any(structfun(@isempty,a)),s);
    end
end
