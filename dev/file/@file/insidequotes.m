function out = insidequotes(in)
%% insidequotes
% 
% 
% 
% author: john devitis
% create date: 04-Aug-2016 04:00:41

    % look for anything inside quotes
    out = regexp(in,'(?<=")(.*?)+(?=")','match');
    % unpack cell array of results
    out = [out{:}];
    % make sure its a row vector
    if size(out,1) < size(out,2)
        out = out'; % transpose
    end
	
end
