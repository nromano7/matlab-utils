function example
%% Message Logger [logger] Example. 
%
% author: john devitis
% create date: 11272016
clc
fprintf('Message Log Example:\n');
N=10;
%% Write to console.
main(N,1);

%% Write to file.
fid = fopen('logger-example.txt','w');
main(N,fid);

end

function main(N,fid)
    % Create instance of message logger.
    logg = logger('Logged Loop Example',fid);
    
    % Write to console (fid=1, default). Or to file (fid=fopen)
    logg.fid = fid;
    
    % Print whatever we want to console (or file if fid given). 
    for ii = 1:5
        logg.print('Yeehaww, lets start logging!')
    end

    % Do work.
    logg.print('Enough of that. Lets loop some more.')
    for n = 1:N
        logg.task('Loop',n,N)   % Log the start of a task.
        % Work.                 % Do something.
        logg.done()             % Log task completion.                 
    end

    % Log main process completion and shutdown.
    logg.finish() 
    
    % Clean up.    
    if fid ~= 1; edit('logger-example.txt'); fclose(fid); end;
    % Error screen no output request - necessary for any handles object 
    if nargout == 0
        clear logg
    end
end