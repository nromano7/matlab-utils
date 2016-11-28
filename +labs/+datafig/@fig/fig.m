classdef fig < msglogger
%% classdef fig
% 
% 
% 
% author: 
% create date: 27-Nov-2016 17:35:50
% classy version: 0.1.2

%% object properties
	properties
        x
        y
        fh
        ah
        ph
	end

%% dependent properties
	properties (Dependent)
	end

%% private properties
	properties (Access = private)
    end
    
%% events
    events
    end

%% constructor
	methods
		function self = fig(name,fid)
            self@msglogger(name,fid)
            self.fh = figure('Name',self.name);
        end
    end

%% listener constructor
    methods
        function create_listeners(self)
        end
    end
    
%% ordinary methods
	methods 
        function identify(self)
            
        end
	end % /ordinary

%% dependent methods
	methods 
	end % /dependent

%% static methods
	methods (Static)
	end % /static

%% protected methods
	methods (Access = protected)
	end % /protected

end
