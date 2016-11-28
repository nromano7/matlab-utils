classdef logger < handle
%% Message Logger Class
% 
% Example:
%   N = 10;
%   logg = logger('Logged Loop Example');
%   for n=1:N
%       logg.task('Loop iteration',n,N)
%       % do work
%       logg.done()
%   end
%   logg.finish;
%
% author: john devitis
% create date: 26-Nov-2016 13:54:58
% classy ver: 0.1.1

%% object properties
	properties
        prefix = 'LOG'          % line write prefix
        name = 'Logged Loop'    % process name
        born                    % datetime string of log creation
        fid = 1                 % default printing to console. provide valid fid to write to file
        
        delim = '\t'                % line delimiter
        header_order = [1 2 3]      % prefix, time, process, task 
        prefix_format = '%s:'       % prefix format string
        time_format = '%s'          % time format string
        name_format = 'Process(%s)' % process id format string      
        task_format = 'Task(%s)'    % task id format string
    end
    
%% dependent properties
    properties (Dependent)
        header
    end

%% constructor
	methods
		function self = logger(name,fid)
            % record create time and publish start
            self.born = datestr(datetime);
            % initialize w/ name if given
            if nargin > 0; self.name = name; end
            % if fileid given, notify console and log to file
            if nargin > 1; self.fid = fid; end;
            % signal start
            self.start();
		end
	end

%% ordinary methods
	methods 
        function print_header(self)
        %% print sorted header
            fprintf(self.fid,strcat(self.header,self.delim));
        end
        
        function print(self,txt,pf,nl)
        %% print logged message
        %  pf=1 for header. nl=1 for new line. 
            if nargin < 3; pf = 1; end;
            if nargin < 4; nl = 1; end;
            if pf; self.print_header(); end;
            if nl; ftxt = '%s\n';
            else ftxt = '%s'; end
            fprintf(self.fid,sprintf(ftxt,txt));
        end
        
        function start(self,name)
        %% logg main process start
        %  note - optional start name override
            if nargin < 2; name = self.name; end;
            self.print(sprintf('Starting "%s".',name));
            if self.fid == 1; self.print('Logging to console.');
            else self.print('Logging to file.'); end;
        end
        
        function finish(self)
        %% log process completion and shutdown.
        %  note - shutdown is wrapped here so we know that was completed
        %  successfully.
            self.print('Main process finished.');
            self.alivetime();
            self.shutdown();
            self.print('Done.');
        end
        
        function shutdown(self)
        %% over-writable method for deterministic shutdown 
            self.print('Shutting down...');
        end
                
        function task(self,name,n,N)
        %% start named task. 
            ftxt = strjoin({self.task_format,''},self.delim);
            % default task name if none given
            if nargin < 2; name = 'Loop Iteration'; end; 
            % if no loop numbers given, just print name
            if nargin < 3; txt = sprintf(ftxt,name);
            % if loop numbers given, print n of N tasks
            else txt = sprintf(strcat(ftxt,'\t%i\tof\t%i\t...'),name,n,N); end
            self.print(txt,1,0);
        end
        
        function done(self)
        %% log task completion. 
            self.print('\tDone.',0,1);
        end
            
        function alivetime(self)
        %% print process alive time 
            tot = etime(clock,datevec(self.born));
            self.print(sprintf('Alive for %4.2f seconds (%4.2f minutes).',tot,tot/60));
        end
        
        function run(self,N)
        %% run through N logging events as demo process. helpful for 
        % sorting out format string
            clc; fprintf('Logger demo-run:\n')
            if nargin < 2; N = 10; end;
            self.start('start demo-run')
            for n = 1:N
                self.task('demo-run',n,N);
                self.done()
            end
            self.finish()
        end
        
	end % /ordinary

%% dependent methods
    methods 
        function header = get.header(self)
        %% get header based on format strings
            strings = {self.prefix_format, self.time_format, self.name_format};
            values = {self.prefix, datestr(datetime), self.name};
            fstring = strjoin(strings(self.header_order),self.delim);
            header = sprintf(fstring,values{self.header_order});
        end
    end % /dependent
    
%% static methods
	methods (Static)
        example
	end % /static

end
