classdef progressbar < handle
%% classdef progressbar
% 
% This is a OOP refactor of Paul Proteus' original textprogressbar (located
% in ~/libs/+textprogressbar);
% 
% author: john devitis
% create date: 26-Nov-2016 14:27:15
% classy ver: 0.1.1

%% object properties
	properties
        name = 'A long running task...' % process name
        N                               % total number of iterations
        strCR=[]
        strPercentageLength=10
        strDotsMaximum=10
	end

%% dependent properties
	properties (Dependent)
        
	end

%% private properties
	properties (Access = private)
        n
	end

%% constructor
	methods
		function self = progressbar(N,name)
            self.N = N;
            if nargin > 1
                self.name = name;
            end
            self.update(sprintf('%s\t',self.name));
        end
	end

%% ordinary methods
	methods 
        function advance(self)
            self.n = self.n+1;
        end
        function update(self,c)
            self.advance()
			if isempty(self.strCR) && ~ischar(c)
				% Progress bar must be initialized with a string
				error('The text progress must be initialized with a string');
			elseif isempty(self.strCR) && ischar(c)
				% Progress bar - initialization
				fprintf('%s',c);
				self.strCR = -1;
			elseif ~isempty(self.strCR) && ischar(c)
				% Progress bar  - termination
				self.strCR = [];  
				fprintf([c '\n']);
			elseif isnumeric(c)
				% Progress bar - normal progress
                c = (c/self.N)*100;
				percentageOut = [num2str(c) '%%'];
				percentageOut = [percentageOut repmat(' ',1,self.strPercentageLength-length(percentageOut)-1)];
				nDots = floor(c/100*self.strDotsMaximum);
				dotOut = ['[' repmat('.',1,nDots) repmat(' ',1,self.strDotsMaximum-nDots) ']'];
				strOut = [percentageOut dotOut];
				% Print it on the screen
				if self.strCR == -1
					% Don't do carriage return during first run
					fprintf(strOut);
				else
					% Do it during all the other runs
					fprintf([self.strCR strOut]);
                end
				% Update carriage return
				self.strCR = repmat('\b',1,length(strOut)-1);
			else
				% Any other unexpected input
				error('Unsupported argument type');
            end
            % check if finished
            if self.n == self.N
                self.update('Done')
            end
        end
        
        function done(self)
            self.update(sprintf(' Done.'));
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
