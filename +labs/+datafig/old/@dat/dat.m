%% jdv 10062015; 11032015;
classdef dat < handle
    properties 
        fcnH = @sin;    % function handle
        figH            % current figure handle
    end        
    
    % observable props
    properties (SetObservable = true)
        x = 0:.1:2*pi; % evaluate fcn at x
    end
    
    % dependent props
    properties (SetObservable = true, Dependent = true)
        y 
    end
    
    % global properties
    events
        Update      % refresh plot listeners
        Destroy     % destroy listeners
        Identify    % identify listeners
    end
    
    methods
        function obj = dat(x,fcn)
            % constructor to create instance of dat class
            if nargin > 1
                obj.fcnH = fcn;
                obj.x = x;
            end
        end
        
        function y = get.y(obj)
            % get dependent property y
            y = feval(obj.fcnH,obj.x);
        end        
        
        function create(obj)
            % create instance of slave fig class
            import vmatools.classes.fig
            obj.figH = fig(obj);
        end                
        
        function refresh(obj)
            % call to update (not needed but left in)
            notify(obj,'Update');
        end        
        
        function nuke(obj)
            % destroy listeners
            notify(obj,'Destroy');
        end        
        
        function ident(obj)
            % call to identify
            notify(obj,'Identify');
        end
    end
end
