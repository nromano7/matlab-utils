function c = forcefields_lower(a,b)
%% c = forcefields_lower(a,b)
% assign like fields from b to a. attempt to force original data format. a new
% struct, c, is created with lowered fieldnames
% jdv 01302017

an = fieldnames(a);
bn = fieldnames(b);
names = bn(ismember(lower(bn),lower(an)));

vals = {};

for ii = 1:length(names)

    oldtype = class(a.(an{ii}));
    newtype = class(b.(bn{ii}));

    if strcmp(oldtype,'double') && (strcmp(newtype,'cell') || strcmp(newtype,'char'))
        % handles {'1','2'} -> [1,2]
        newval = str2double(b.(bn{ii}));
    else
        newval = b.(bn{ii});
    end

    %c.(names{ii}) = newval;
    vals{ii,1} = newval;
end

c = cell2struct(vals,names);
