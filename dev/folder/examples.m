%% Folder 
% is a MATLAB utility class used to simplify general i/o tasks perfromed in
% MATLAB. The object instantiated with the folder class is a reference to a
% folder located on the user's operating system.

%% A few examples of how to use the folder class:

% create instance of folder class without inputs
f = Folder;

% create instance of folder class with class constructor
% input is the 'parent_path' to the folder to be referenced.
f = Folder('C:\Users\Nick\Desktop');

% create a folder with 'folder_name' in the parent_path
f.create_folder('example_folder_name')

% add subfolder to folder being referenced by folder object
f.create_folder('subfolder','example_subfolder_name')

% IF FOLDER ALREADY EXISTS set folder_path of folder that already exists
% (automatically populates parent_path & folder_name properties)
f = Folder;
f.folder_path = 'C:\Users\Nick\Desktop\example_folder_name';

% delete the folder referenced by the folder object
f.delete_folder % error message returned if folder has contents

% force delete folder and folder contents
f.delete_folder('force')

% make the referenced folder the current directory
f.make_current

% save folder object to referenced folder for later use
f.save

% save work space variables to .mat or .txt file in folder
x = 1:100;
y = 1:50;
f.save_file(x,y) % default saves x as .mat file called x
f.save_file(x,y,'.txt') % saves x as .txt file called x

% load .mat or .txt file from object's referenced forlder
f.load_file('x.mat')
f.load_file('y.txt')

% delete file(s) from referenced folder
f.delete_file('x.mat','y.txt')




