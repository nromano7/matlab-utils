classdef Folder < handle
% Class object for dealing with general i/o tasks of folders and files.
    
    properties 
        parent_path  
        folder_path
        folder_name
    end
    
    methods
        
        % - Class Constructor - %
        
        function obj = Folder(parent_path)
            if nargin > 0
                obj.parent_path = parent_path;
            end
        end 

        % - Set Methods - % 
        
        function obj = set.parent_path(obj,arg)
            obj.parent_path = arg;
        end
        
        function obj = set.folder_path(obj,arg)
            
            % set folder path
            obj.folder_path = arg;
            
            % get parts
            [pathstr,name,~] = fileparts(arg);
            
            % assign parts
            obj.parent_path = pathstr;
            obj.folder_name = name;
        end
        
        function obj = set.folder_name(obj,arg)
            obj.folder_name = arg;
            %obj.folder_path = fullfile(obj.parent_path,arg);
        end
            
        
    end
    
end


