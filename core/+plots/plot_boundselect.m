function [bnds,peakLoc] = plot_boundselect(xx,yy,x_lim)
%% function [bnds,peakLoc] = plot_boundselect(xx,yy,x_lim)
%
% plot to select left/right bounds for multiple peaks
% right click to select peak
% left click at left and right bounds
%
% Inputs:
%   xx        - x vector to plot 
%   yy        - y vector(s) to plot
%   x_lim     - [left right] indices
%
% Outputs:
%   bnds(:,1) - left bound index
%   bnds(:,2) - right bound index
%   peakLoc   - peak index
%
% jdv 09082015

    % plot CMIF 
    fh = figure; ah = axes;
    plot(ah,xx,yy,'.-')
    xlim(ah,x_lim);
    grid(ah,'on'); 

    % manual peak selection
    [bnds,peakLoc] = plot_pick(xx);

    % add peaks to plot (visual only)
    plot_addpeaks(ah,xx,yy,bnds,peakLoc);

end


function [bnds,peakLoc] = plot_pick(xx)
%% peakLoc = plot_pick(xx,yy)
% jdv 09082015
nn = 1;  % counter index
chk = 1; % exit flag (0 to exit)
bnds = [];
    % peak selection until exit flag
    while chk == 1
        % get first tick user input
        %   either left bound or exit flag
        [x1,y1,b1] = ginput(1);
        % check selection
        if b1 == 2 
            % middle click 
            chk = 0; % exit flag
        else
            % get right bnd and peak
            %   note - x2(1:2,[x,y])
            x2 = ginput(2); 
            % find nearest x indices
            [~,inds] = searchVector(xx,[x1; x2(:,1)]);
            % save bounds for selection, nn
            bnds(nn,1) = inds(1);   % left bnd
            bnds(nn,2) = inds(2);   % right bnd
            peakLoc(nn) = inds(3);  % peak index
            % advance counter
            nn = nn+1;                
        end
    end
end

function plot_addpeaks(ah,xx,yy,bnds,peakLoc)
%%
%
% jdv -09082015
    % find index of max values around peaks
    [~,rank] = max(abs(yy(peakLoc,:)),[],2);
    % add to plot
    hold(ah,'all');
    ne = length(peakLoc);
    for ii = 1:ne
        % plot bnds for peak ii
        plot(ah,xx(bnds(ii,1)),yy(bnds(ii,1),rank(ii)),'ks');   % left bnd
        plot(ah,xx(bnds(ii,2)),yy(bnds(ii,2),rank(ii)),'ks');   % right bnd
        plot(ah,xx(peakLoc(ii)),yy(peakLoc(ii),rank(ii)),'ro'); % peak
    end
    hold(ah,'off');
end