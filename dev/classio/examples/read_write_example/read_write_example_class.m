classdef read_write_example_class < classio
%% classdef read_write_example_class
% 
% 
% 
% author: john devitis
% create date: 24-Oct-2016 18:31:59

%% object properties
	properties
        firstName = 'john'
        lastName = 'dev'
        age = 'dont ask'
	end

%% dependent properties
	properties (Dependent)
	end

%% private properties
	properties (Access = private)
	end

%% dynamic methods
	methods
	%% constructor
		function self = read_write_example_class()
            
		end

	%% ordinary methods

	%% dependent methods

	end

%% static methods
	methods (Static)
	end

%% protected methods
	methods (Access = protected)
	end

end
