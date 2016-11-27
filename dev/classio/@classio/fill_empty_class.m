function newobj = fill_empty_class(self, newobj)
%% fillempty
% 
% fills empty fields in var1 with values from corresponding fields in var2
% 
% author: John Braley; John DeVitis
% create date: 08-Sep-2016 16:11:14
    fields = fieldnames(self);
    numfields = length(fields);
    for ii = 1:numfields
        if isprop(newobj,fields{ii}) && isempty(newobj.(fields{ii}))
            newobj.(fields{ii}) = self.(fields{ii});
        end
    end	
end
