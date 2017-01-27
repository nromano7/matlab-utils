classdef sqlite_table
%% classdef sqlite_table
%
%
%
% author: john devitis
% create date: 24-Jan-2017 23:12:31
% classy version: 0.1.2

%% object properties
properties
	name
	columns
	data
	types
end

%% dependent properties
properties (Dependent)

end

%% private properties
properties (Access = private)
end

%% constructor
methods
	function self = sqlite_table()
	end
end

%% ordinary methods
methods
	function s = table2struct(self)
		s = cell2struct(self.data,self.columns,2);
	end
	function names = get_col_names(self)
		names = strjoin(self.columns,',');
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
