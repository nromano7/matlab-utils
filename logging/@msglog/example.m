function example(N)
clc
% Number of iterations (in seconds).
if nargin<1; N = 20; end
fprintf('Message Log Example:\n');

% Create instance of Timerwaitbar.
logg = msglog.msglog('Logged Loop Example');
% textprogressbar('txt  ')
% Do work.
for n = 1:N
    logg.start(sprintf('task %i',n))
    
    % Work.
    pause(.05);   

    % Update UI with status message. 
    logg.update(n);
    
end
