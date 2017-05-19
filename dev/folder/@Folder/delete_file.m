function delete_file(obj,varargin)
%DELETE_FILE. Deletes files(s) in folder.
%Input argument can be single or multiple file names.

% Ensure deleted files & folders go to the recycle bin.
recycle('on')

for n = 1:length(varargin)
    delete(fullfile(obj.folder_path,varargin{n}))
end

end

