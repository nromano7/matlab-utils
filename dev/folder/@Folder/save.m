function save(obj)
% SAVE
% save instance of folder object for later use

    f_name = strcat(obj.folder_name,'_object');
    f_path_name = fullfile(obj.folder_path,f_name);
    save(f_path_name,'obj','-v7.3')

end
