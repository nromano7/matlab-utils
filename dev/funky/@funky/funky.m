classdef funky < file
%% classdef funky
% 
% 
% 
% author: john devitis
% create date: 04-Aug-2016 00:45:52

%% object properties
	properties
        author  % author of function
        header  % header insert
        text    % help text
        out
        in
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
        function self = funky(fullpath)
            if nargin < 1       % error screen empty input
                fullpath = [];  % empty fullpath input (handled in @file)
            end            
            % call file superclass constructor
            self@file(fullpath);            
            % ensure class extension is for m-file
            self.ext = '.m';
        end

	%% dependent methods

    end 

%% static methods
	methods (Static)
	end

%% protected methods
	methods (Access = protected)
	end

end
