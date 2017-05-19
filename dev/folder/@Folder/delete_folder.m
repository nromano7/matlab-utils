function delete_folder(obj,varargin)
%DELETE_FOLDER. Deletes folder with designated path.
%Call 's' as input argument to delete folder containing other subfolders or
%files.

if isempty(varargin)
    % removes folder only if no contents
    [status,message,~] = rmdir(fullfile(obj.folder_path));
elseif strcmp(varargin,'force')
    % removes folder and contents regardless of permissios
    [status,message,~] = rmdir(fullfile(obj.folder_path),'s');
end

if status == 0
    % unsuccessful b/c folder contains contents, return error message
    msg = {message(1:end-1),'because folder contains files or subfolders.',...
        'To remove all folders, files, or subfolders, call method with input',...
        'argument ''force''.'};
    error(strjoin(msg));
end

end

