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
	values
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
		s = cell2struct(self.values,self.columns,2);
	end
	function s = xgetStruct(self)
		warning('off','MATLAB:structOnObject')
		s = struct(self);
		for ii = 1:length(self.columns)
			x = struct(self.columns{ii},self.values(:,ii));
			s = forcefields(s,x);
			%s.(self.columns{ii}) = x.(self.columns{ii});
			%s = cell2struct(self.values(:,ii),self.columns{ii},1);
		end
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
