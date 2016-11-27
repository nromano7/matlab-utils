function create_folder(self)
%% create_folder()
%
% check if directory exists. create folder if doesn't.
%
% jdv 08062016

    % check if directory exists
    if ~exist(self.path,'dir') 
        % create folder if it doesn't exist
        [status,message,~] = mkdir(self.path);

        % 1. check for warnings
        % 2. inspect message to see if folder was created 
        if status~=1 
            warning(message);
        elseif ~strcmp(message,'Directory already exists.') && ~isempty(message)
            fprintf('%s\n',message);
        end
    end
end