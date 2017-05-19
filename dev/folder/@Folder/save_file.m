function save_file(obj,varargin)
%SAVE_FILE. Saves workspace variable to folder. 
% Allows for saving variables as .mat or .txt files

% save variables as mat or ascii text files
if ~isempty(varargin)   
    
    % default file type is .mat
    extension = '.mat';
    version = '-v7.3';
    txt = 0; % for excluding last argument from save()
    
    % get file extension and version if .txt
    if any(strcmp(varargin,'.txt'))
        extension = '.txt';
        version = '-ascii';
        txt = 1;
    end
        
    for n = 2:nargin-txt
        variable_name = inputname(n);  
        f_name = strcat(variable_name,extension);
        f_path_name = fullfile(obj.folder_path,f_name);
        if txt
            if isa(varargin{n-1},'double')
                % write to text file
                dlmwrite(f_path_name,varargin{n-1})
            else
                msg = {'Variable',variable_name,'cannot',...
                    'be saved to .txt file.'};
                error(strjoin(msg));
            end
        else
            % save to .mat file
            eval(strcat(variable_name,'= varargin{n-1};'))
            save(f_path_name, variable_name, version)
        end
    end
else
    error('No variables to save.')
end

end


