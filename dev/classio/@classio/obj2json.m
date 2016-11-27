function obj2json(self,pth,name)
%% obj2json(pth,name)
% 
% wrapper function for jsonlab -> save/load json files
%
% inputs: 
%   pth -> path to file
%   name -> file name (.json assumed)
% 
% * defaults to use classname as filename - override with optional 'name' 
% input
% * also defaults to using the root object as the class name
%
% author: john devitis
% create date: 24-Oct-2016 15:06:31
    ext = '.json';
    
    % check path
	if nargin < 2
        error('please supply a destination for file');
    end
    
    % check filename
    if nargin < 3
        warning('no filename supplied, using class name')
        name = class(self); % get class name
    end
    
    % check for nestTable to avoid error converting custom Table class
    if isa(self,'nestedTable')
        chkTable = 1;
        % need to convert Table to structure
        names = fieldnames(self);
        for ii = 1:length(names)
            if isa(self.(names{ii}),'Table')
                
%                 % build struct array
%                 %  loop entries/records
%                 for kk = 1:self.(names{ii}).rowNumber
%                     cpy.(names{ii})
%                     
%                 end
                % table class, dump to structure
                cpy.(names{ii}).name = self.(names{ii}).name;
                cpy.(names{ii}).fileName = self.(names{ii}).fileName;
                cpy.(names{ii}).data = self.(names{ii}).data;
                cpy.(names{ii}).colNames = self.(names{ii}).colNames;
                cpy.(names{ii}).rowNames = self.(names{ii}).rowNames;
                cpy.(names{ii}).levels = self.(names{ii}).levels;
                
            else
                % create copy
                cpy.(names{ii}) = self.(names{ii});
            end
        end
    else
        chkTable = 0;
    end
    
    % format json string
    if chkTable == 0
        str = savejson(name,self); % original
    else
        str = savejson(name,cpy);  % new Table class check
    end
    
    % save to file - CAUTION - this will overwrite filename
    fprintf('Saving %s class... ',name);
    fid = fopen(fullfile(pth,[name ext]),'w');
	fwrite(fid,str);
    fclose(fid);	
    fprintf('Done.\n');
	
end
