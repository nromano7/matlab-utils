classdef dat < handle
%% classdef datafig
% 
% 
% 
% author: 
% create date: 27-Nov-2016 17:34:57
% classy version: 0.1.2

%% object properties
	properties
        x = linspace(0,1,100);
        fcn = @sin
	end

%% dependent properties
	properties (Dependent)
        y
	end

%% private properties
	properties (Access = private)
    end
    
%% events
    events
        Identify
    end

%% constructor
	methods
		function self = dat()
		end
	end

%% ordinary methods
	methods 
        function identify(self)
            notify(self,'Identify');
        end
        
        function f = create(self,name,fid)
            f = labs.datafig.fig(name,fid);
        end
	end % /ordinary

%% dependent methods
	methods 
        function y = get.y(self)
            y = feval(self.fcn,self.x);
        end
	end % /dependent

%% static methods
	methods (Static)
	end % /static

%% protected methods
	methods (Access = protected)
	end % /protected

end
