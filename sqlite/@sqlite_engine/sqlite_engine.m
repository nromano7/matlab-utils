classdef sqlite_engine < handle
%% classdef sqlite_engine
%
%
%
% author: john devitis
% create date: 24-Jan-2017 20:26:57
% classy version: 0.1.2

%% object properties
	properties
		filename
		conn
		sql = ''
		fetched = 0
		sql_log = {}
	end

%% dependent properties
	properties (Dependent)
	end

%% private properties
	properties (Access = private)
	end

%% constructor
	methods
		function self = sqlite_engine(filename)
			if nargin > 0, self.filename = filename; self.connect; end
		end

		function delete(self)
			close(self.conn);
		end

		function close(self)
			close(self.conn);
		end
	end

%% ordinary methods
	methods
		function connect(self)
			self.conn = sqlite(self.filename);
		end

		function data = fetch(self)
			data = [];
			if not(isempty(self.sql)),
				data = fetch(self.conn,self.sql);
				self.fetched = 1;
			end
			if self.fetched, self.reset; end
		end

		function append_log(self)
			self.sql_log{end+1} = self.sql;
		end

		function self = reset(self)
			self.append_log;
			self.sql = '';
		end

		function self = select(self,col,tabl)
			self.reset;
			self.addsql(sprintf('SELECT %s FROM %s',col,tabl));
		end

		function self = where(self,sql)
			self.addsql(sprintf('WHERE %s',sql))
        end

        function self = or(self,varargin)
            for ii = 1:length(varargin)
            	self.addsql(sprintf('OR %s',varargin{ii}));
            end
        end

        function self = and(self,varargin)
            for ii = 1:length(varargin)
            	self.addsql(sprintf('AND %s',varargin{ii}));
            end
        end

		function self = orderby_desc(self,x)
			self.addsql(sprintf('ORDER BY %s DESC',a));
		end

		function self = orderby_asc(self,x)
			self.addsql(sprintf('ORDER BY %s ASC',x));
		end

		function addsql(self,sql,delim)
		% concat sqlite strings
			if nargin < 3, delim = ' '; end
			if isempty(self.sql), self.sql = sql;
			else self.sql = strjoin({self.sql, sql}, delim); end
		end

		function sql = string(self)
			sql = self.sql;
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
