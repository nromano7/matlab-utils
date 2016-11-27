function [ind,val] = plot_peakselect(xx,yy,x_lim)
%% function [ind,val] = plot_peakselect(xx,yy,x_lim)
%
% left click to select peak
% right click last selection to exit
%
%   xx        - x vector to plot 
%   yy        - y vector(s) to plot
%   x_lim     - x plot bounds [left right]
%
%   ind       - peak index
%   val       - max value at peak index
%
% note - checks sign of first element
%           finds max for pos values
%           finds min for neg values
%
% jdv 09082015
% jdv 09092015

    % plot values 
    fh = figure; ah = axes;
    plot(ah,xx,yy,'.-');
    xlim(ah,x_lim); grid(ah,'on'); 
    
    % manual peak selection
    ind = plot_pick(xx); % returns index of peaks
    
    % get max or min values
    val = get_peak(yy,ind);
    
    % add peaks to plot (visual only)
    plot_addpeaks(ah,xx,ind,val);

end


function ind = plot_pick(xx)
%% pick peaks on plot
nn = 1;  % counter index
chk = 1; % exit flag (0 to exit)
    % peak selection until exit flag
    while chk == 1
        % get user input
        [x,y,b] = ginput(1);        
        % find nearest x indices
        [~,id] = searchVector(xx,x);        
        % save selected peak
        ind(nn) = id;  % peak index        
        % advance counter
        nn = nn+1;                
        % save exit flag to chk
        chk = b;            
    end
end


function [val,col] = get_peak(yy,ind)
%% get peak values
    % if positive values then get max
    if sign(yy(ind(1),1)) == 1
        % find max
        [val,col] = max(abs(yy(ind,:)),[],2);
    else
        % find min
        [val,col] = min(abs(yy(ind,:)),[],2);
        % correct sign
        val = val*-1;
    end
end


function plot_addpeaks(ah,xx,ind,val)
%% add peaks to plot
    hold(ah,'all');
    plot(ah,xx(ind),val,'ro');
    hold(ah,'off');
end

