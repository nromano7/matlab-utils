function create_folder(obj,varargin)
%CREATE_FOLDER. Create folder with designated path.
%Input argument must be name of new folder or name/value pair for sub
%folder. 
% 
% Examples: create_folder('Folder A')
%           create_folder('subfolder','Folder B')

% check if creating new folder or subfolder of cuurent folder object
is_sub = false;
if any(strcmp(varargin,'subfolder'))
    is_sub = true;
end

if is_sub
    % for creating subfolder in current folder
    f_path = obj.folder_path;
    f_name = varargin{2};
elseif nargin == 2
    % for creating new folder in parent_path
    f_path = obj.parent_path;
    f_name = varargin{1};    
end
full_path = fullfile(f_path,f_name);

[status,message,~] = mkdir(full_path);

% handle exceptions and assign
if ~is_sub && status == 1 && isempty(message) 
    % sucessul and no warning message so assign property
    obj.folder_path = full_path;
    obj.folder_name = f_name;
elseif ~is_sub && status == 1 && ~isempty(message)
    % sucessful with warning message, property still assigned
    % warning message likely "Directory already exists."
    obj.folder_path = full_path;
    obj.folder_name = f_name;
    warning(message)
elseif is_sub && status == 1 && ~isempty(message)
    warning(message)
elseif status == 0
    % unsuccessful, retuen error message
    error(message)
end

end


