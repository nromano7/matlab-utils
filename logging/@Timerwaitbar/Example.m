function example(N)
clc
% Number of iterations (in seconds).
if nargin<1; N = 15; end
fprintf('Timerwaitbar Example:\n(this example should take roughly %i seconds)\n\n',N);

% Create instance of Timerwaitbar.
twb = timerwaitbar(N,'Example');

% Do work.
for n = 1:N
    
    % Work.
    pause(1);   

    % Update UI with status message. 
    twb.update();
    
    % Handle shutdown.
    if twb.isinterrupted()
        twb.abort()
        break
    end
        
end

% Clean up.
delete(twb)