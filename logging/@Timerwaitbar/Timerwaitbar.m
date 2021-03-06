%% TIMER WAITBAR
%
%  Progress waitbar and command line logging. The predictive functionality
%  was taken from E. Ogier's March 28th, 2016 release. His original 
%  implementation can be found in ~/libs/+timer_waitbar. 
%
%  Authors  : John DeVitis; E. Ogier 
%
%  USAGE
%  - TWB = Timerwaitbar(ITERATIONS); Creation of a Timerwaitbar for ITERATIONS loops
%  - TWB.update();                   Timerwaitbar update when a loop is performed
%  - TWB.abort();                    Print early termination noticr and delete object
%  - TWB.print_update();             Print update to command line but do not increase tick counter
%  - STATUS = TWB.isinterrupted();   Timerwaitbar status ([false]/true if cancelation)
%  - TWB.delete();                   Timerwaitbar destruction
%
%  DESCRIPTION OF TIMER WAITBAR FIELDS
%  - WIP: Work In Progress [%]
%  - ETR: Estimated Time Remaining  [HH:MM:SS] if ETR < 24h | [d'd' HH:MM:SS] if ETR >= 24h
%  - ETA: Estimated Time of Arrival [HH:MM:SS] if today)    | [ddd HH:MM]     if later


classdef timerwaitbar < handle
    
    % Properties 
    properties
        name = 'Logged-Timed Loop'
        born % string of create time
        lastupdate

    end
   
    % Properties (private access)
    properties (Access = 'private')
        Interruption    = false; % Interruption status
        Iterations      = 0;     % Number of iterations to perform
        Waitbar         = [];    % Waitbar self
        Counter         = 0;     % Iteration counter
        InitialTime     = 0;     % First iteration time
        InitialTimeDays = 0;     % First iteration time in whole days
    end
    
    % Methods
    methods
        
        % Constructor
        function self = timerwaitbar(Iterations,name)
            % record activity
            self.born = datestr(datetime); 
            self.lastupdate = self.born;
            
            self.Iterations = Iterations; 
            self.Counter    = 0;
            
            if nargin > 1
                self.name = name;
            end
            
            % create waitbar ui
            self.Waitbar = waitbar(0,'','Name',self.name,'CreateCancelBtn','setappdata(gcbf,''canceling'',1)');
            setappdata(self.Waitbar,'canceling',0);
            
            % create waitbar ui            
            self.print_update('started')
        
        end
        
        function print_prefix(self)
            fprintf('TWB::Process(%s)::Time(%s)::',self.name,datestr(datetime));
        end
               
        function print_update(self,task)
            self.print_prefix()
            if nargin > 1
                fprintf(sprintf('%s\n',task));
            else
                fprintf('\n');
            end
        end
        
        function print_alivetime(self)
            tot = self.seconds_alive();
            self.print_update(sprintf('alive for %4.2f seconds (%4.2f minutes)',...
                tot,tot/60));
        end
        

        
        function tot=seconds_alive(self)
            tot = etime(clock,datevec(self.born));
        end

        % Function 'isinterrupted' (cancelation status)
        function Status = isinterrupted(self)
            
            Status = self.Interruption;            
            
        end
        
        % Function 'update' (waitbar update)
        function update(self)
                        
            % record time of update
            self.lastupdate = datestr(datetime);
                                    
            % Time initialization
            if self.Counter == 0
               Date = clock;
               self.InitialTime = Date;               
               self.InitialTimeDays = floor(datenum(Date));
            end
            
            % Waitbar creation
            if isempty(self.Waitbar)

            end
                        
            % Iterations counter increment
            self.Counter = self.Counter+1;
            
            % Progression
            p = self.Counter/self.Iterations;
                      
            % Elapsed time from first iteration
            dt = etime(clock,self.InitialTime);
            
            % Estimations
            ETR = (1/p-1)*dt/86400;   % Estimated time remaining  [day]
            ETA = datenum(clock)+ETR; % Estimated time of arrival [day]
            
            % ETR string
            if ETR < 1
                ETRstring = datestr(ETR,'HH:MM:SS');    % ETR <  1day
            else
                ETRstring = datestr(ETR,'dd HH:MM:SS'); % ETR >= 1day
                ETRstring = strrep(ETRstring,' ','d ');
            end
            
            % ETA string
            if floor(ETA) == self.InitialTimeDays
                ETAstring = datestr(ETA,'HH:MM:SS PM');  % ETA : today
            else
                ETAstring = datestr(ETA,'ddd HH:MM PM'); % ETA : later
            end
            
            % Progress bar update (WIP | ETR | ETA)
            waitbar(p,self.Waitbar,sprintf('WIP: %.1f%%  |  ETR: %s  |  ETA: %s',100*p,ETRstring,ETAstring));
            
            % Interruption status
            self.Interruption = getappdata(self.Waitbar,'canceling');
            
            % print status
            self.print_update(sprintf('finished task %i of %i',self.Counter,self.Iterations));
            
            % Waitbar deletion (ending or cancelation)
            if p == 1 || self.Interruption
                delete(self.Waitbar);
            end
            
        end
        
        function deleteui(self)
            if ~isempty(self.Waitbar)
                delete(self.Waitbar);  
            end
        end
        
        function abort(self)
            self.print_update('aborted');
            delete(self);
        end
        
        function delete(self)
            self.print_alivetime()
            self.deleteui()
            delete(self)
        end
        
    end
    
    methods (Static)
        example(N)
    end
end
