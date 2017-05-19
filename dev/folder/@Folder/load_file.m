function load_file(obj,file_name)
%LOAD_FILE. Load file from object reference folder.

% determine if loading .mat or .txt file
txt_flag = strfind(file_name,'.txt');

if isempty(txt_flag)
    % load mat file in calling workspace
    evalin('caller', sprintf('load(''%s'')',...
        fullfile(obj.folder_path,file_name)))
else
    % read text file to calling workspace
    f_name = file_name(1:strfind(file_name,'.')-1);
    evalin('caller',sprintf(strcat(f_name,'=','dlmread(''%s'');'),...
        fullfile(obj.folder_path,file_name)))
end
   
    

end
