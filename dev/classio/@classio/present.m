function n = present(base,target)
%% present(base,target) 
% 
% checks if target (string) class is present in base container structure. 
% * only looks one level deep.
% * modified for classio static method
% 
% inputs:
%   base -> structure containing classes as fields
%   target -> name of desired class (string)
%
% outputs: 
%   n -> number of entries, target, in container, base
% 
% example:
%   base.c = classy();
%   base.f1 = funky();
%   base.f2 = funky();
%   n = classio.present(base,'funky');
%   if n; fprintf('found %i times\n',n); end
%
% author: john devitis
% create date: 27-Oct-2016 13:58:07	
	n = 0;
	names = fieldnames(base); 
	for ii = 1:length(names)
        if strcmp(class(base.(names{ii})),target)
            n = n+1;
        end
    end	
end
