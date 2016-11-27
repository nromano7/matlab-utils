%% jdv 11032015;
classdef fig < handle
    properties
      dataobj % master object 
      fh % figure handle
      ah % axes handle
      ph % plot handle(s)
      lhUpdate   % UpdateGraph listener handle
      lhNuke     % ace in the hole baby
      lhIdentify % identity listen
      lhX        % Lm property PostSet listener handle
      lhY        % Y listener
    end
    methods
        function obj = fig(datObj)
            if nargin > 0
                obj.dataobj = datObj; 
                obj.fh = figure;
                obj.ah = axes;
                obj.createLisn;
                obj.createPlot;
            end
        end
        
        function createLisn(obj)
            % create listeners
            % add global events to slave figure
            obj.lhUpdate = addlistener(obj.dataobj,'Update',...
                @(src,evnt)listenUpdate(obj,src,evnt));
            obj.lhNuke = addlistener(obj.dataobj,'Destroy',...
                @(src,evnt)listenDestroy(obj,src,evnt));
            obj.lhIdentify = addlistener(obj.dataobj,'Identify',...
                @(src,evnt)listenIdentify(obj,src,evnt));
                
            % latch values to caller object
            obj.lhX = addlistener(obj.dataobj,'x','PostSet',...
                    @(src,evnt)listenX(obj,src,evnt));   
            obj.lhY = addlistener(obj.dataobj,'y','PostSet',...
                    @(src,evnt)listenX(obj,src,evnt)); 
        end
        
        function createPlot(obj)
            % create plot
            if ishandle(obj.ah)
                x = obj.dataobj.x;
                y = obj.dataobj.y;
                obj.ph = plot(obj.ah,x,y);
            end
        end
        
        function updatePlot(obj)
            x = obj.dataobj.x;
            y = obj.dataobj.y;
            set(obj.ph,'XData',x,'YData',y);
        end
        
        function listenIdentify(obj,src,evnt)
            % listener for identify
            fprintf(['I am a slaved figure named ' obj.fh.Name])
            fprintf([' and I am listening to ' func2str(src.fcnH) '\n'])
        end
        
        function listenX(obj,~,~)
            % listener for x change
            if ishandle(obj.ph)
                obj.updatePlot;
            end
        end
        
        
        function listenUpdate(obj,~,~)
            % listener for update request
            if ishandle(obj.ph)
                obj.updatePlot;
            end
        end
        
        function listenDestroy(obj,~,~)
            % shut this mofo down
            if ishandle(obj.fh)
                delete(obj.fh)
            end
        end        
    end
    

end