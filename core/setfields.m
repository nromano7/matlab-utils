function a = setfields(a,b)
%% a = setfields(a,b)
% assign alike fields from b to a
% jdv 01232017
an = fieldnames(a);
bn = fieldnames(b);
names = bn(ismember(bn,an));
for ii = 1:length(names)
    a.(names{ii}) = b.(names{ii});
end
