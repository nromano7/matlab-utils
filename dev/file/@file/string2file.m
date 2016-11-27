function string2file(self,contents)
%% string2file(contents)
% 
% 
% 
% 
% author: john devitis
% create date: 04-Aug-2016 03:32:01
    
    % create folder if it doesn't exist
	self.create_folder();
    
    % open file and overwrite (in case it doesn't exist)
    fid = self.open('w');
    
    % write contents to disk line by line
    fprintf(fid,'%s\n',contents{:}); 
	
	% close file
    status = fclose(fid);
    
    % check if something went wrong
    if status ~= 0
        % display warning
        warning(ferror(fid));
    end        
	
end
