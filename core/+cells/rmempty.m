function out = rmempty(in)
%% rmempty -> removes empty entries in 1D/2D. returns cell array vector
% 
% author: john devitis
% create date: 31-Oct-2016 02:02:55
    out = in(~cellfun('isempty',in));
end
