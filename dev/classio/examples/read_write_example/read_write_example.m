function read_write_example()
%% read_write
% 
% 
% 
% author: john devitis
% create date: 24-Oct-2016 18:31:09
	
    %% find script dir (to locate exmaple data files later)
    [pth,name,~] = fileparts(mfilename('fullpath'));
	
    %% create instance of user's class 
    %  * here we'll use the default class included with the exmaple. it has
    % fields already populated for brevity
    cio = read_write_example_class();

    %% save object properties to json
    cio.obj2json(pth); % defaults to save as <object_name>.json
    
    %% create instance to read json
    cio2 = read_write_example_class();
    cio2.json2obj('read_write_example_class.json')
    cio2 % view fields to confirm read
	
    %% profit.
	
end
 