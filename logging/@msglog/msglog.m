classdef msglog < handle
%% classdef msglog
% 
% 
% 
% author: john devitis
% create date: 26-Nov-2016 13:54:58
% classy ver: 0.1.1

%% object properties
	properties
        name = 'Logged Loop'
        born 
        lastupdate
	end

%% dependent properties
	properties (Dependent)
	end

%% private properties
	properties (Access = private)
	end

%% constructor
	methods
		function self = msglog(name)
            if nargin > 1
                self.name = name;
            end
            self.born = datestr(datetime);
            self.lastupdate = self.born;
            self.print('started');
		end
	end

%% ordinary methods
	methods 
        function print_prefix(self)
            fprintf('MSG::Process(%s)::Time(%s)::',self.name,datestr(datetime));
        end
        function start(self,task)
            msglog.textprogressbar.textprogressbar(task)
        end
        
        function print(self,task)
            self.print_prefix()
            if nargin > 1
                fprintf(sprintf('%s\n',task));
            else
                fprintf('\n');
            end
        end
        function printnl(self,task)
            self.print_prefix()
            if nargin > 1
                fprintf(sprintf('%s',task));
            else
                fprintf('');
            end
        end
        
        function update(self,n)
%             self.print(sprintf('finished task %i of %i',n,N));
            msglog.textprogressbar.textprogressbar(n)
        end
        
        function finish(self)
            self.print('Done.');
            self.alivetime();
        end
        
        
        function alivetime(self)
            tot = self.seconds_alive();
            self.print(sprintf('alive(%4.2f seconds (%4.2f minutes))',...
                tot,tot/60));
        end
        
        function tot = seconds_alive(self)
            tot = etime(clock,datevec(self.born));
        end
        
        
	end % /ordinary

%% dependent methods
	methods 
	end % /dependent

%% static methods
	methods (Static)
        example(N)
	end % /static

%% protected methods
	methods (Access = protected)
	end % /protected

end
