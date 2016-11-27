function ind = indexempty(in)
%% indexempty -> returns 1D/2D bool array of size(in)
% 
% author: john devitis
% create date: 31-Oct-2016 02:09:15
    ind = ~cellfun('isempty',in);
end
