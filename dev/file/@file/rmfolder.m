function rmfolder(self,n)
%% rmfolder
% 
% removes the trailing folder in self.path
%  effectivly `cd ..` to the object path
% 
% optional para: n -> number of folders to remove
%
%
% author: john devitis
% create date: 20-Oct-2016 20:12:52
    if nargin < 2; n = 1; end
    for ii = 1:n
        self.path = fileparts(self.path);
    end
end
