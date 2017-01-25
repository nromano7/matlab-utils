function a = forcefields(a,b)
%% a = forcefields(a,b)
% assign like fields from b to a. attempt to force original data format
% jdv 01242017

an = fieldnames(a);
bn = fieldnames(b);
names = bn(ismember(bn,an));

for ii = 1:length(names)

    oldtype = class(a.(names{ii}));
    newtype = class(b.(names{ii}));

    if strcmp(oldtype,'double') && (strcmp(newtype,'cell') || strcmp(newtype,'char'))
        % handles {'1','2'} -> [1,2]
        newval = str2double(b.(names{ii}));
    else
        newval = b.(names{ii});
    end

    a.(names{ii}) = newval;
end
