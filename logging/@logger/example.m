function example
%% Message Logger [logger] Example. 
%
% author: john devitis
% create date: 11272016

    clc
    N=100; 
    fprintf('Message Log Example:\n');

%% Write to console (default)

    logg = logger('Console Logging');
    % Print time stamped messages of whatever we want.
    for ii = 1:5
        logg.print('Yeehaww, lets start logging!')
    end
    logg.print('Enough of that. Lets loop some more.')
    % Do work.
    for n = 1:N
        logg.task('Main Loop',n,N)  % Log the start of a task.
        % Work.                     % Do something.
        logg.done()                 % Log task completion.                 
    end
    % Signal process completion
    logg.stop()


%% Write to file.

    logg = logger('File Logging','logger-example.txt');

    % Print time stamped messages of whatever we want.
    for ii = 1:5
        logg.print('Yeehaww, lets start logging!')
    end
    logg.print('Enough of that. Lets loop some more.')
    % Do work.
    for n = 1:N
        logg.task('Main Loop',n,N)  % Log the start of a task.
        % Work.                     % Do something.
        logg.done()                 % Log task completion.                 
    end
    % Signal process completion
    logg.stop()
    
    % Show log file 
    edit('logger-example.txt');

%% Clean up. Error screen no output request
    %  necessary for any handle objects 
    if nargout == 0; clear logg; end


end