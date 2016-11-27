classdef htm <hgsetget
    %% HELP
    %htm
    %A simplified interface for writing information to html files
    %
    %SAMPLE USAGE
    %h = htm(); %creates the handle
    %h.start('test.html'); %opens the file and writes header
    %h.h1('Caption');
    %h.text({'two lines of sample text','with a forced break'},'nl');
    %plot(rand(10)); %creates a figure
    %h.figure(gcf); %adds the figure to html
    %h.table([1 2 3; 4 5 6]); %adds a table of values
    %h.stop; %writes footer and closes the file
    %h.zip; %saves the html and figure to a zip file
    %h.show %opens the file in matlab web browser
    %h.edit %opens the file in matlab editor
    %
    %help htm>demo %more detailed examples
    %
    %METHODS BY KIND
    %file:     start,stop,clear
    %write:    text,h1,h2,h3,h4,h5,comment,dev,newline
    %write:    include,figure,table,ref,link,list,toggle
    %display:  show,edit,read,zip
    %metadata: setmeta,addmeta,clearmeta,getmeta
    %other:    verb,quiet,bughunt,help,delete
    %
    %ALL METHODS IN DETAIL
    %
    %CREATE
    %h=htm(filename);
    %creates the handle h to an htm object
    %filename is optional
    %
    %DESTROY
    %h.delete;
    %destroys the object, but not the handle to it.
    %use 'clear h' to destroy the handle
    %
    %CLEAR
    %h.clear;
    %deletes the target htm file, and all figures it created.
    %
    %EXIST
    %h.exist;
    %returns true/false if the html file in field h.file exists
    %
    %START
    %h.start(filename)
    %filename optional, but must be given during either creation or start
    %opens the file for writing and creates the standard header
    %if the file alrady exists, removes the footer and appends
    %
    %STOP
    %h.stop() writes the standard footer and closes the file
    %
    %TEXT
    %h.text(string_or_cellofstrings,options)
    %writes the given text to the open file, with line breaks \n
    %options
    %<XX> will use XX as the class of each string. e.g.
    %h.text('sample','<H1>') will write '<H1>sample</H1>' to file
    %h.text('sample','nl'); adds <BR> and newline \n to the end
    %h.H1('sample'); writes using H1 format, I.e. <H1>sample</H1>
    %ditto for H1, H2, H3, H4, H5, comment, dev
    %
    %INCLUDE
    %h.include(foo,suffix);
    %copies the content of file foo to the currently open file, line-by-line
    %
    %FIGURE
    %h.figure(hfig,options)
    %prints figures given by handles "hfig" to file in 800x600 png format with a thumbnail link
    %options
    %'320x200','640x480','800x600','1024x768','1152x769','nnnxnnn','custom'
    %   sets resolutions, 'custom' uses current resolution, nnnxnnn can be
    %   any size. Pixel sizes are not exact.
    %'id',string
    %   tags the figure with link anchor "#fig:string" to be referenced by hyperlink
    %'link',string
    %   replaces the default thumbnail tag with the string
    %'name',string
    %   specify the name of the output figure file
    %   if that file exists, will iterate numbers until a new filename is found
    %   e.g. h.figure(h,'name','figure'); tries figure1.jpg, figure2.jpg, etc
    %'caption',string
    %   puts the figure in a table with string as the header
    %'comment',string
    %   puts the figure in a table with string at the footer
    %'ref',string
    %   allows you to reference the figure using <a href="#fig:string>text</a>
    %'tooltip',string
    %   adds a tooltip that will show when you mouseover the figure
    %'alttxt',string
    %   alt txt that is shown if the figure can not be found
    %
    %TABLE
    %h.table(A,options)
    %Prints 2-d matrix A (string, number or cellstring array) to a table
    %if A is 3-d, creates a 2d table for each part of A.
    %OPTIONS
    %'caption',string
    %   sets the table caption to a string (default no caption)
    %'width',number
    %   sets the table width to that number of pixels
    %'xhdr',(number array or string or cellstring array)
    %   header of the columns
    %'yhdr',(number array or string or cellstring array)
    %   header of the rows
    %'xgroup',(cellstring array),[number array]
    %   supergroups above headers. Each element is separated by a line
    %   pairs of string and size
    %'ygroup',(cellstring array),[number array]
    %   pairs of strings and size
    %'class',string
    %   sets the table class (for css purposes)
    %'footer',string
    %   writes the string to the footer
    %'footspan',number
    %   colspan of the footer, but default full
    %'id',string
    %   tags the table with link anchor "#tab:string" to be referenced by hyperlink
    %'flagged',<values save size as A>
    %   highlights the cells that are not zero. 1's will be yellow, 2's blue, 3's red, 4's green, all others gray
    %'bodyalign',string
    %   alignment of text in each column of the  body cells (l|r|c)
    %   if this is a single value, it will be used for all columns
    %'headalign',string
    %   alignment of text in the x/y headers (l|r|c)
    %   use only a single value
    %'round',number
    %   rounds content to this many decimal places
    %
    %LIST
    %h.list(cell_of_strings,options)
    %Prints an unsorted list
    %options
    %id,string :
    %tags the list with anchor #lst:string to be referenced by hyperlink
    %style,string : sets the css style of the list
    %
    %LINK
    %h.link(string,link,options)
    %Prints hypertext reference to link displaying string
    %options
    %'nl'
    %   inserts a newline after the link (<BR> and \n)
    %'H1','H2','H3','H4'
    %   writes the link test in header format
    %
    %
    %REF
    %h.ref(type,id,text)
    %adds a hyperlink to a referenced part of the document:
    %<a href="#type:string">text</a>
    %e.g. if you have created a figure using h.figure(gcf,'id','bestpicture');
    %you can create a link to it elsewhere using
    %h.ref('fig','bestpicture','link to the best picture');
    %refence types are:
    %lst list
    %fig figure
    %tab table
    %sec text (includes all subtypes e.g. headers)
    %tog toggle sections
    %
    %TOGGLE
    %h.toggle(text)
    %creates a hide/unhide section
    %h.toggle('end') closes the toggle section
    %options
    %id,string :
    %tags the toggle with anchor #tog:string to be referenced by hyperlink
    %
    %METADATA
    %htm stores metadata on the document.
    %h.setmeta('class','value'); sets the metafield to the given value
    %h.addmeta('class','value'); adds the given value to existing values
    %h.getmeta returns the value of all metadata
    %h.getmeta('class') returns the value of the given class
    %metadata for the fields 'title','creator','date','figures','tables','headers'
    %is automatically generated and updated.
    %metadata is written to the end of the file when it is stopped
    %metadata is read from the file when it is started
    %metadata 'figures' keeps track of the figures this document has created
    %these are the figure it will delete during a "clear"
    %metadata "title" is automatically set to the first H1 entry unless the
    %user specifies a title.
    %metadata creator/date are set at file stop, overwriting user values
    %
    %DISPLAY
    %h.show opens the file in the web browser
    %h.edit opens the file in the matlab editor
    %h.read returns a string of the file contents
    %h.zip(foo) zips htm and any attached figures to a zipfile
    % if foo is omitted, will use the current filename with .zip extension
    % embedded figures will only display properly if they are in the
    % same folder as the html, or a subfolder of same.
    %
    %detailed examples can be displated with 'help htm.demo'
    %
    % Security considerations:
    % Uses direct access to file system
    % deletes files by name
    % accesses command line to get user ID.
    
    %% DEVNOTES
    %EDIT 20070111 removed thumbnails and use png format (via imgwrite)
    %REASON: disk size of reports are becoming a problem, so removing the .fig and
    %_thumb copies of the same figure reduces disk usage at the expense of
    %rendering speed. PNGs are smaller. Since all reports are intended to be
    %seen as local copies on relatively recent machines, the increased
    %rendering load is assumed to be okay
    %WARNING: this is a screen grab - any other windows overlapping the figure
    %will be printed instead.
    %EDIT 20080109 expanded help, link and id are now specified
    %EDIT 20091106 changed to saving figures using saveas
    %this seems to avoid "black figure" errors when screensaver is on
    %EDIT 20091202 references to figures/tables, table autorotate to match
    %headers
    %EDIT 20101221 remove reference to whoami, so can deploy without session
    %environment
    %EDIT 20110509 adding flagging of individual cells in table with color
    %TODO status checked, not set manually
    %EDIT 20110323 ported to object-oriented. MAJOR CHANGE.
    %EDIT 20110516 adding help to all methods, so "doc htm" is more legible
    %EDIT 20110518 table allows xhdr without yhdr, and vice versa
    %EDIT 20110720 table added xgroup/ygroup options. code cleanup
    %              table added support for 3d tables
    %              table added 'round' option
    %              ref added help
    %EDIT20110803 table added option to flag in three colours, not two
    %EDIT20111108 figure saveas loses figure size information, examine
    %other means of doing the job
    %EDIT20111121 adding h.grab method, if file not closed properly this
    %will search for metadata links and populate as appropriate
    %EDIT20111130 table colours included 3=red, colours more pastel-y
    %edit 20120614 added newline and figure tooltip and alttxt
    %edit 20120704 figures can be any resolution, given by nnnxnnn, but
    %pixel size is not exact.
    %EDIT20120704 custom error messages for trying to set properties that
    %are private
    %EDIT20120710 added option to zip file and figures
    %EDIT20120716 added robust derived properties for fid, file and status
    %EDIT20130710
    %   file name now automatically changes to include full file name
    %   figure references are now relative to html file location
    %   username no longer cropped by 1
    %   zip file warns when figures are being added with non-relative
    %   foldernames
    
    %% BUGS
    %clear does not remove figures with relative filenames correctly
    %assume figure names are relative to base or full path ?
    
    %% TODO
    %ADD PROPERTY "OPTIONS" that encapsulates verb,debug,allowtoggle
    %ADD function to create table of contents in the start
    
    %% PROPERTIES
    %These properties can only be set and got by htm itself
    properties (SetAccess = private, GetAccess = private)
        %metafields, cell array of strings
        %names of the fields of metadata to append to html files
        %coupled with properly metavalues
        %metadata is added as the file is being closed, after the </body> tag
        metafields = {'title','creator','date','figures','tables','headers'};
        %metavalues, cell array
        %values of the fields of metadata to append to html files
        %coupled with property metafields
        %metadata is added as the file is being closed, after the </body> tag
        metavalues = {'','','',{},{},{}};
        %class of each metadata (s= string, c = cellstring, n = numbers
        %other classes of cell are not allowed as metavalues
        metaclass = 'sssccc';
        %possible values true/false
        %if trying to open a file that is open elsewhere, forcibly close
        %the other file handle
        forceclose = true;
    end
    %These properties can only be set by htm itself, but seen by all
    properties (SetAccess = private);
        %file handle, number
        %the fid of the currently open file
        %-1 if no file is open
        fid  = -1;
        
        %file name, string
        %the filename with full path, of the file currently in use
        %the file might not be open, property fid determines that.
        file = '';
    end
    %These properties are dependent, they can only be got
    properties (Dependent = true, SetAccess = private)
        %possible values 'nofile','write','read','closed','orphan'
        status
    end
    %these properties can be got and set by all
    properties
        %true if verbose mode is on
        %gives additional feedback to command line.
        verb = true;
        %true if debug mode is on
        %causes additional feedback and breakpoints.
        debug = false;
        %allowtoggle, boolean
        %wether the file will allow show/hide toggles
        allowtoggle = false;
    end
    
    %% METHODS
    methods
        %% CUSTOM SET AND GET METHODS FOR PROPERTIES
        function status = get.status(obj)
            if ~exist(obj.file,'file'); status = 'nofile'; return; end
            if obj.fid<0; status = 'closed'; return; end
            [~,perm] = fopen(obj.fid);
            if regexp(perm,'r\w*\+'); status = 'write'; return; end
            if regexp(perm,'r'); status = 'read'; return; end
            if ~obj.isvalid; status = 'orphan'; return; end
            warning('htm:internal','Can''t determine status');
        end
        function set.status(~,~)
            error('the value of this property cannot be set directly');
        end
        function file = get.file(obj)
            if obj.fid>0
                obj.file = fopen(obj.fid);
            end
            file = obj.file;
        end
        function set.file(obj,str)
            %TODO modify filename to include fullpath
            if ~ischar(str); error('filename must be a string'); end
            [fol,base,ext] = fileparts(str);
            if isempty(fol); fol = pwd; end
            if isempty(ext); ext = '.html'; end
            obj.file = fullfile(fol,[base ext]);
        end
        function out = get.fid(obj)
            %check if fid is no longer valid (closed)
            foo = fopen(obj.fid);
            if obj.fid>0 && isempty(foo)
                obj.fid = -1;
            end
            out = obj.fid;
        end
        function set.fid(obj,val)
            obj.fid = val;
        end
        function set.allowtoggle(obj,val)
            if obj.exist; error('file already exists, cannot change this property after the header has been written'); end
            if ischar(val)
                switch val
                    case {'On','on','ON','true','True','TRUE','1'}; val = true;
                    case {'off','Off','OFF','false','False','FALSE','0'}; val = true;
                    otherwise
                        error(['unknown option "' num2str(val) '" for property allowtoggle'])
                end
            end
            if isnumeric(val)
                val = val~=0;
            end
            if ~islogical(val);
                error('allowtoggle property can only be set to true or false');
            end
            obj.allowtoggle = val;
        end
        function set.debug(obj,val)
            if numel(val)>1; error('this option must be set to a single (scalar) value'); end
            if ~isnumeric(val) && ~islogical(val); error('this option must be set to true or false (1 or 0)'); end
            if isnumeric(val) && ~islogical(val)
                val = val~=0;
            end
            switch val;
                case true;
                    obj.verb = true;
                    obj.debug = true;
                case false
                    obj.debug = false;
            end
        end
        function set.verb(obj,val)
            if numel(val)>1; error('this option must be set to a single (scalar) value'); end
            if ~isnumeric(val) && ~islogical(val); error('this option must be set to true or false (1 or 0)'); end
            if isnumeric(val) && ~islogical(val)
                val = val~=0;
            end
            obj.verb = val;
        end
    end
    
    methods (Access = private)
        %% OPEN AND CLOSE FILES (PRIVATE)
        function open_write(obj)
            %if a file is currently open, throw an error
            if ismember(obj.status,{'read','write'}); error('cannot open another file until the current file is closed'); end
            %if the file is in use by another handle, throw an error
            fids = fopen('all');
            for i=1:numel(fids);
                if fids(i) ~=obj.fid && isequal(fopen(fids(i)),obj.file);
                    error(['This file is already being accessed by fid ' num2str(fids(i)) '. You can close the other access using "fclose(' num2str(fids(i)) ')", or possibly h.stop']);
                end
            end
            %if the new file does not exist, create an empty file
            if ~exist(obj.file,'file');
                temp_fid = fopen(obj.file,'w+'); if ~temp_fid; disp('error opening file'); keyboard; end;
                fclose(temp_fid);
            end
            %open the new file for reading and writing
            obj.fid = fopen(obj.file,'r+');
            if obj.fid<0;
                warning('htm:FileError','failed to open file');
                keyboard
            end
        end
        function open_read(obj)
            %if a file is already open, close that
            if ismember(obj.status,{'read','write'}); obj.close; obj.clearmeta; end
            %if the file does not exist, error
            if ~exist(obj.file,'file'); error(['attempted to read a file that does not exist "' obj.file '"']); end
            obj.fid = fopen(obj.file,'r');
            if obj.fid<0;
                warning('html:FileError','failed to open file');
            else
                obj.readmeta;
                if obj.verb; disp(['opened "' obj.file '" for read']); end
            end
        end
        function close(obj)
            if obj.fid<0
                if obj.verb; disp('that file is not open, nothing to close'); end
                return
            end
            fclose(obj.fid); obj.fid = -1;
            if obj.verb; disp(['closed "' obj.file '"']); end
        end
        function replace(obj,str)
            %replace the content of the current file with str
            fclose(obj.fid); obj.fid = -1;
            delete(obj.file);
            fid_temp = fopen(obj.file,'w');
            fprintf(fid_temp,'%s',str);
            switch obj.status;
                case {'write','finished'}; %do nothing
                case {'close','nofile'}; fclose(fid_temp); fid_temp = -1;
                case 'read' ; fclose(fid_temp); fid_temp = fopen(obj.file,'r');
            end
            obj.fid = fid_temp;
        end
        %% READ AND WRITE TO FILE (PRIVATE)
        function write(obj,cel,suffix,prefix,supersuffix,superprefix)
            if nargin<3; suffix=''; end
            if nargin<4; prefix=''; end
            if nargin<5; supersuffix=''; end
            if nargin<6; superprefix=''; end
            if ~isequal(obj.status,'write'); error('file is not open for writing, nothing written'); end
            if ~iscell(cel);cel = {cel}; end
            fprintf(obj.fid,'%s',superprefix);
            for txt=cel; fprintf(obj.fid,'%s%s%s\n',prefix,txt{1},suffix); end
            if ~isempty(supersuffix); fprintf(obj.fid,'%s\n',supersuffix); end
        end
        function writeheader(obj,str)
            if nargin<2;
                str = {
                    '<HEAD>',...
                    '<STYLE type="text/css">',...
                    'TABLE {background-color: white; border: black; border-width: 1; border: solid; text-align: "center" ; font-size: 12; }',...
                    'TH {background-color: #F0FFF0 ; font-size: 14 ; }',...
                    'TH.yhdr {backgroud-color: #F00000 ;}',...
                    'TD {text-align: right ; }',...
                    'TD.footer {text-align: left ; background-color: #FFFFFF ; }',...
                    'CAPTION {background-color: #E5EEE5 ; font-size: 20 ; text-align: "left" ;}',...
                    'BODY {background-color: #F8FFF8 ; font-size: 16; }',...
                    'Q {color: #999999; margin-left: "20px"; }',...
                    'DEV {color: #999999; margin-left: "20px"; visibility="hidden";}',...
                    'A.toggle {color: #005500; text-decoration: "none"}',...
                    '</STYLE>'};
                if obj.allowtoggle;
                    str =[str ...
                        {'<script language="javascript">',...
                        'function getItem(id)',...
                        '{',...
                        '    var itm = false;',...
                        '    if(document.getElementById)',...
                        '        itm = document.getElementById(id);',...
                        '    else if(document.all)',...
                        '        itm = document.all[id];',...
                        '    else if(document.layers)',...
                        '        itm = document.layers[id];',...
                        '    return itm;',...
                        '}',...
                        'function toggleItem(id)',...
                        '{',...
                        '    itm = getItem(id);',...
                        '    if(!itm)',...
                        '    return false;',...
                        '    if(itm.style.display == ''none'')',...
                        '        itm.style.display = '''';',...
                        '    else',...
                        '        itm.style.display = ''none'';',...
                        '        return false;',...
                        '}',...
                        '</script>'}];
                end
                str = [str ,...
                    {'</HEAD>',...
                    '<body>'}];
            end
            obj.write(str)
        end
        function writefooter(obj,str)
            %THE VISIBLE FOOTER STRING
            if nargin<2
                str = ['Created ' datestr(now,'yyyymmdd')];
                try
                    if ispc; [~,id] = dos('echo %USERDOMAIN%%USERNAME%'); id = id(1:end-1); end; %remove the carriage return at the end
                    if isunix; [~,id] = unix('whoami'); end
                    if ismac;  [~,id] = unix('whoami'); id = id(1:end-1); end
                    if ~exist('id','var'); id = 'UNKNOWN '; end
                    str = [str ' by user ' id];
                catch %#ok<CTCH>
                    id = 'UNKNOWN';
                end
                
                try %#ok<TRYNC>
                    a = dbstack;
                    if numel(a)<3;
                        str = [str ' at command line'];
                    else
                        str = [str ' in file "' a(3).file '"'];
                    end
                end
            end
            obj.write('<BR>');
            obj.write(str);
            obj.write('</body>');
            obj.setmeta('creator',id);
            obj.setmeta('date',datestr(now,'yyyymmdd_HHMMSS'));
            %write the data to file
            obj.writemeta()
        end
        function removefooter(obj)
            %fseek through the current file until you find start of </body>
            %overwrite remainder of file with whitespace
            %fseek to the point you started overwriting from
            
            if ~isequal(obj.status,'write'); keyboard; obj.open_write; end
            if ~isequal(obj.status,'write'); error('could not open file'); end
            fseek(obj.fid,0,'eof');
            filelength = ftell(obj.fid);
            
            fseek(obj.fid,0,'bof');
            buffer = repmat(' ',[1 7]);
            %count = 0;
            while true
                %count = count+1;
                c = fscanf(obj.fid,'%c',1);
                if isempty(c); hit = false; break; end
                buffer = [buffer(2:end) c];
                if isequal(lower(buffer),'</body>'); hit = true; break; end
                
                %if count>1E4; keyboard; end
            end
            if ~hit; warning('no footer found, file does not appear to have been stopped properly'); end %#ok<WNTAG>
            if hit;
                %skip back to start of tag, then start deleting
                fseek(obj.fid,-7,'cof');
                currPos = ftell(obj.fid);
                whitespace = repmat(' ',[1 filelength-currPos]);
                fprintf(obj.fid,'%s',whitespace);
                fseek(obj.fid,currPos,'bof');
                fprintf(obj.fid,'<BR>\n');
            end
        end
        function str = getcontents(obj)
            %temporarily opens the file for read
            %gets the contents, then closes it
            if ~exist(obj.file,'file'); str = ''; return; end
            fid_temp = fopen(obj.file,'r');
            str = fscanf(fid_temp,'%c');
            fclose(fid_temp);
        end
        %% READ AMD WRITE METADATA (PRIVATE)
        function writemeta(obj)
            %writes metadata like: <meta name="description" content="about stuff" />
            fields = obj.metafields;
            vals = obj.metavalues;
            for i=1:numel(fields);
                class = fields{i};
                values = vals{i};
                str = ['<meta name="' class '" content="'];
                if isempty(values); str = [str ',']; %#ok<AGROW>
                else
                    if iscell(values); for txt=values; str = [str num2str(txt{1}) ',']; end; end %#ok<AGROW>
                    if isnumeric(values); for val=values; str = [str num2str(val) ',']; end; end %#ok<AGROW>
                    if ischar(values); str = [str values ',']; end %#ok<AGROW>
                end
                str = [str(1:end-1) '" />'];
                obj.text(str,'nl');
            end
        end
        function readmeta(obj)
            %reads metadata from a file
            %reads contents of file
            %seeks meta keywords
            %parses these into strings
            %TODO parse as numbers too.
            str = obj.getcontents;
            [a,b] = regexp(str,'<meta.*?/>','start','end');
            for i=1:numel(a);
                s = str(a(i):b(i));
                [c,d] = regexp(s,'name=".*?"','start','end');
                name = s(c+6:d-1);
                [c,d] = regexp(s,'content=".*?"','start','end');
                content = s(c+9:d-1);
                [tf,loc] = ismember(name,obj.metafields);
                if tf; %this is a known class
                    try
                    switch obj.metaclass(loc);
                        case 's'; %do nothing
                        case 'c'; content = regexp(content,'[^,]+','match');
                        case 'n'; content = str2num(content); %#ok<ST2NM>
                        otherwise; error('unknown metaclass');
                    end
                    catch
                        keyboard
                    end
                else %unknown class, guess format
                %otherwise make a guess as to class of content
                %convert content to number if:
                %it consist entirely of [0-9|.|,|-|+]
                %it does not come out NaN
                s = regexp(content,'\s|\d|[e.,+-]');
                if isequal(s,1:numel(content))
                    num = str2num(content); %#ok<ST2NM>
                    if ~any(isnan(num)) && ~any(num<0)
                        content = num;
                    end
                end
                %determine if the result should be a cell array
                if ismember(',',content)
                    regexp(content,'[^,]+','match')
                    
                    
                end
                end
                
                %write to object meta values
                obj.setmeta(name,content)
            end
        end
        function clearmeta(obj)
            %set to detfault values
            obj.metafields = {'title','creator','date','figures','tables','headers'};
            obj.metavalues = {'','','',{},{},{}};
        end
        %% MISC FUNCTIONS (PRIVATE)
        function name = relative_path(obj,name)
            [fol_fig,base,ext] = fileparts(name);
            fol_htm = fileparts(obj.file);
            if strfind(fol_fig,fol_htm);
                fol_fig(1:numel(fol_htm)) = '';
            end
            if numel(fol_fig) && isequal(fol_fig(1),filesep)
                fol_fig(1) = '';
            end
            name = fullfile(fol_fig,[base ext]);
        end
        function name = full_path(obj,name)
            [fol,base,ext] = fileparts(name);
            if exist(fol,'dir');
                %make it a full path if it isn't already
                home = pwd;
                cd(fol);
                fol = pwd;
                cd(home);
            else
                %might be relative to html location
                fol = fullfile(fileparts(obj.file),fol);
                if ~exist(fol,'dir');
                    error(['folder does not exist: "' fol '"']);
                end
            end
            name = fullfile(fol,[base ext]);
        end
    end
    methods
        %% CREATE, START/STOP, SAVE (PUBLIC)
        function obj = htm(varargin)
            %constructor for htm class objects, returns a handle to the object
            %examples:
            %   h = htm;
            %   h = htm(foo);
            %if a filename is given, attempts to read metadata
            switch nargin;
                case 0; %do nothing
                case 1;  obj.file = varargin{1}; if exist(obj.file,'file'); obj.readmeta; end
                otherwise; error('can only accepts one input when creating object');
            end
        end
        function delete(obj)
            %destructor for htm class objects
            %if a file is open, will attempt to write the standard footer and metadata,
            %and close the file so no stray file handles exist.
            
            %close file down gracefully
            if ismember(obj.status,{'read','write'}); obj.stop; end
            %close file forcefully
            if obj.fid>0; fclose(obj.fid); end
        end
        function start(obj,filename)
            %starts or reopens a file
            %h.start()
            %h.start(foo)
            %closes the currently open file.
            %opens the new file, creating if neccesary
            
            %gracefully close currently open file
            if ismember(obj.status,{'read','write'}); obj.stop; end
            if nargin==2; obj.file=filename; end
            flag_existed = exist(obj.file,'file');
            %opens the file for writing (creates it as neccesary)
            obj.open_write;
            %if file did not exist, write a header
            if ~flag_existed; obj.writeheader; end
            %if file did exist, get rid of the previous footer and get ready to append
            if flag_existed; obj.readmeta; obj.removefooter; end
        end
        function stop(obj)
            %h.stop()
            %gracefully closes a file
            %writes metadata to the footer of the file
            
            %if the file is writeable, write the footer (with metadata)
            if isequal(obj.status,'write'); obj.writefooter; end
            %now close the file
            obj.close;
        end
        function clear(obj)
            %clears the current file
            %this deletes the html file and any figures in its metadata
            
            %closes and deletes the file if it exists
            if isequal(obj.status,'open'); obj.close; end
            %read the figures from the html file _before_ deleting it
            obj.readmeta(); figures = obj.getmeta('figures');
            %find all open handles to this same file, and close them
            fids = fopen('all');
            flag_closed = false;
            for i=1:numel(fids);
                if fids(i) ~=obj.fid && isequal(fopen(fids(i)),obj.file);
                    if obj.forceclose;
                        fclose(fids(i));
                        flag_closed = true;
                    else
                        warning('htm:FileProblem','another file handle to the same file exists, cannot delete'); 
                    end
                end
            end
            if flag_closed; warning('htm:FileProblem','had to close another file handle to the same file'); end
            if obj.fid>0; %close this file handle
                fclose(obj.fid); obj.fid = -1;
            end
            %delete the file
            if exist(obj.file,'file'); delete(obj.file);
            elseif obj.verb; disp('cannot delete file, it does not exist');
            end
            if exist(obj.file,'file');
                warning('could not delete file'); %#ok<WNTAG>
                obj.setstatus('closed');
                keyboard
            end
            obj.fid = -1;
            %delete the figures
            for figs=figures;
                fig = figs{1};
                fig = obj.full_path(fig);
                if exist(fig,'file');
                    if numel(fig)>4 && ismember(fig(end-3:end),{'.jpg',',bmp','.png','gif'});
                        if obj.verb; disp(['deleting "' fig '"']); end
                        delete(fig);
                    else
                        disp(['"' fig '" does not appear to be a figure , skipping'])
                    end
                else
                    keyboard
                end;
            end
            obj.clearmeta;
        end
        function tf = exist(obj)
            tf = ~isempty(obj.file) && exist(obj.file,'file');
        end
        function zip(obj,foo)
            foos = obj.getmeta('figures');
            %check if any of the figures are not in subfolders
            flag = false(size(foos));
            for i=1:numel(foos)
                flag(i) = isequal(foos{i},obj.full_path(foos{i}));
            end
            if any(flag)
                warning('htm:zipFigureLocation','Some figures are not in subfolders of the html file, these will be saved, but they have lost their folder information, and will be unzipped to the folder the html file is unzipped to');
                disp(char(foos(flag)))
            end
            foos{end+1} = obj.file;
            
            %root folder
            fol = fileparts(obj.file);
            if isempty(fol);
                fol = pwd;
            end
            if nargin<2;
                foo = regexprep(obj.file,'\.\w+$','');
                foo = [foo '.zip'];
            end
            if exist(foo,'file');
                delete(foo);
            end
            if exist(foo,'file');
                error(['could not delete "' foo '" nothing zipped']);
            end
            zip(foo,foos,fol)
        end
        %% METADATA (PUBLIC)
        function setmeta(obj,class,value)
            %sets the given meta field to the given value
            %meta values are written as part of the footer at the end of the file
            %example:
            %h.setmeta('figures',{'foo1.bmp','foo2.bmp'})
            %allows strings, cellstrings and number arrays up to 2-D
            %does not allow other cell arrays
            
            %check the new value is allowed dimensions
            checkdim(value);
            %if this is a pre-existing metafield, check type matches
            [tf,loc] = ismember(class,obj.metafields);
            if tf
                switch obj.metaclass(loc)
                    case 's'; if ~ischar(value); error('new value must be a string'); end
                    case 'c'; value = string2cell(value);
                        checkcellstring(value);
                    case 'n'; if ~isnumeric(value); error('new value must be numbers'); end
                    otherwise
                        error(['unknown metaclass "' obj.metaclass(loc) '"'])
                end
                %if a new field, check it is allowed values then add to
                %metafields
            else
                %determine class
                if isnumeric(value)
                    newclass = 'n';
                end
                if iscell(value)
                    checkcellstring(values);
                    newclass = 'c';
                end
                if ischar(value)
                    newclass = 's';
                end
                obj.metafields{end+1} = class;
                obj.metavalues{end+1} = value;
                obj.metaclass(end+1) = newclass;
            end
            
            
            [tf,loc] = ismember(class,obj.metafields);
            if tf;
                obj.metavalues{loc} = value;
            else
                error(['this is not a metafield "' class '"'])
            end
            
            %feedback
            if obj.debug; disp(['metafield ' class ' is now']); disp(obj.metavalues{loc}); dbstack; end
            %subroutines of setmeta
            function checkdim(val)
                if numel(size(val))>2; error('new value cannot have more than 2 dimensions'); end
                if size(val,1)>1; error('new value must be a 1xn vector'); end
            end
            function checkcellstring(val)
                if ~iscell(val) || ~all(cellfun(@ischar,val))
                    error('new value must be a cellstring array');
                end
            end
            function value = string2cell(value)
                if ~iscell(value) && ischar(value)
                    value = regexp(value,'[^,]+','match');
                end
            end
            
        end
        function metaval = getmeta(obj,class)
            %gets metafield values
            %empty or 'all' returns everything
            %examples:
            %h.getmeta('all')
            %h.getmeta('figures')
            if nargin<2 || isempty(class) || isequal(lower(class),'all');
                metaval.class = obj.metafields;
                metaval.value = obj.metavalues;
            else
                [tf,loc] = ismember(class,obj.metafields);
                if ~tf;
                    metaval.class = {};
                    metaval.value = [];
                    warning('htm:BadVal','that class is not part of the metadata');
                else
                    metaval.class = obj.metafields(loc);
                    metaval.value = obj.metavalues(loc);
                end
            end
            
            
            %if not requested as a variable, display to screen
            if ~nargout && obj.verb;
                %show the title
                [tf,loc] = ismember('title',metaval.class);
                if tf; val = metaval.value{loc};
                    disp(['TITLE: "' num2str(val) '"']);
                end
                %show the creator
                [tf,loc] = ismember('creator',metaval.class);
                if tf; val = metaval.value{loc};
                    disp(['LAST CLOSED BY: "' num2str(val) '"']);
                end
                %show the date
                [tf,loc] = ismember('date',metaval.class);
                if tf; val = metaval.value{loc};
                    disp(['LAST CLOSED AT: "' val '"']);
                end
                %show the headersr
                [tf,loc] = ismember('headers',metaval.class);
                if tf; val = metaval.value{loc};
                    disp('HEADERS IN FILE:');
                    try
                        val = regexprep(val,'^H1','H1 ');
                    catch
                        keyboard
                    end
                    val = regexprep(val,'^H2','H2   ');
                    val = regexprep(val,'^H3','H3     ');
                    val = regexprep(val,'^H4','H4       ');
                    for i=1:numel(val);
                        disp(val{i});
                    end
                end
                %show the tables
                [tf,loc] = ismember('tables',metaval.class);
                if tf; val = metaval.value(loc);
                    disp('TABLES IN FILE:')
                    if isempty(val); disp('none'); end
                    for i=1:numel(val)
                        disp(val{i})
                    end
                end
                %show the figures
                [tf,loc] = ismember('figures',metaval.class);
                if tf; val = metaval.value(loc);
                    disp('FIGURES:');
                    if isempty(val); disp('none'); end
                    for i=1:numel(val);
                        disp(val{i});
                    end
                end
                
            end
            if numel(metaval.class)==1; %only returned one class, probably just want the values
                metaval = metaval.value{1};
            end
        end
        function addmeta(obj,class,newval)
            %adds given values to the values of a given metafield
            %does NOT add new metafields
            %examples
            %h.addmeta('figures','foo1.bmp') adds 'foo1.bmp' to the list of figures
            if ~ismember(class,obj.metafields); warning('that is not a metafields, doing nothing'); return; end %#ok<WNTAG>
            val = obj.getmeta(class);
            if iscell(val);
                if numel(val) && iscell(val{1}); keyboard; end
                val = {val{:} , newval}; %#ok<CCAT>
            else            val = [val newval];
            end
            obj.setmeta(class,val);
        end
        function out = findmeta(obj)
            %if metadata is not in footer (e.g. file was not closed properly
            %attempts to create metadata from tags in file
            if obj.verb; disp('attempting to create metadata from file contents'); end
            if ~obj.exist; warning('htm:BadFile','file does not exist, cannot create metadata'); return; end
            if ~isequal('closed',obj.status); warning('htm:BadState','file is not closed, not reading metadata'); return; end
            
            str = obj.getcontents();
            if numel(regexp(str,'<meta')); warning('htm:BadFile','file has metadata, not refreshing'); return; end
            %now we have a closed file that exists, and doesnt have a
            %footer
            %find the data for this
            
            %find title from first H1 block
            a = regexp(str,'<H1.+?>','end','once');
            b = regexp(str,'</H1.+?>','once');
            if numel(a) && numel(b)
                out.title = str(a+1:b-1);
                disp('TITLE');
                disp(['"' out.title '"']);
            end
            %find who last closed it, and when
            a = regexp(str,'Created \d{8,8} by user .+?\n','match');
            if numel(a)
                a = a{end};
                disp('LAST CLOSEFILE');
                disp(a);
                out.date = datenum(regexp(a,'\d{8,8}','once','match'),'yyyymmdd');
                out.creator = regexp(a,'user \w+ at','once','match');
                out.creator = out.creator(6:end-3);
            end
            %find figures
            a = regexp(str,'img src ="\w+\.\w+','match');
            a = regexprep(a,'img src ="','');
            out.figures = a;
            %find tables
            a = regexp(str,'<TABLE.+?</TABLE>','match');
            for i=1:numel(a)
                s = a{i};
                if obj.allowtoggle
                    s = regexp(s,')">.+?</a></CAPTION>','match','once');
                    a{i} = s(4:end-14);
                else
                    s = regexp(s,'<CAPTION>.+?</CAPTION>','match','once');
                    a{i} = s(10:end-11);
                end
            end
            out.tables = a;
            %find headers
            
            [a,c] = regexp(str,'<H\d.+?>','start','end');
            b = regexp(str,'</H\d.+?>');
            if numel(a) && numel(b) && numel(a)==numel(b)
                for i=1:numel(a)
                    out.headers{i} = [str(a(i)+(1:2)) str((c(i)+1):b(i)-1)];
                end
            end
            
            %if successful, set metadata to the values found
            obj.setmeta('title',out.title);
            obj.setmeta('creator',out.creator);
            obj.setmeta('date',datestr(out.date,'yyyymmdd'));
            obj.setmeta('figures',out.figures);
            obj.setmeta('tables',out.tables);
            obj.setmeta('headers',out.headers);
            %then open file, write footer, and close again
            obj.start; obj.stop;
        end
        %% DISPLAY (PUBLIC)
        function show(obj,varargin)
            %h.show()
            %shows the html file in the matlab web browser
            for i=1:numel(varargin)
                if isequal(varargin{i},'new');
                    varargin{i} = '-new';
                end
            end
            if nargin
                web(obj.file,varargin{:});
            else
                web(obj.file);
            end
        end
        function str = read(obj)
            %h.read()
            %reads the contents of the html file to a string
            str = obj.getcontents;
        end
        function edit(obj)
            %opens the html file in the editor
            edit(obj.file)
        end
    end
    
    methods
        %% NEWLINE
        function newline(obj)
            obj.write('<BR>');
        end
        %% TEXT
        function text(obj,str,varargin)
            % h.text(string_or_cellofstrings,options)
            %writes the given text to the open file, with line breaks \n
            %options
            %<XX> will use XX as the class of each string. e.g.
            %h.text('sample','<H1>') will write '<H1>sample</H1>' to file
            %h.text('sample','nl'); adds <BR> and newline \n to the end
            %h.H1('sample'); writes using H1 format, I.e. <H1>sample</H1>
            %ditto for H1, H2, H3, H4, H5, comment, dev
            
            %parse options
            i = 0; id =''; format = '';
            prefix = ''; suffix = '';
            superprefix = ''; supersuffix='';
            wrap = []; style = ''; ref = '';
            while i<length(varargin)
                i = i+1;
                switch lower(varargin{i})
                    case ''; %ignore empty
                    case {'h1','h2','h3','h4','h5','comment','dev'}; format = varargin{i};
                    case {'body','font','text'}; format = 'FONT';
                    case {'nl','br','\n','<br>'}
                        suffix = [suffix '<BR>']; %#ok<AGROW>
                    case 'id';i=i+1; id = varargin{i};
                    case 'ref';i=i+1; ref = varargin{i};
                    case 'style';i=i+1; style = varargin{i};
                    case 'wrap';i=i+1; wrap = varargin{i};
                    otherwise
                        if regexp(varargin{i},'^<.+>$'); format = varargin{i}(2:end-1);
                        else warning('htm:BadArg',['unknown option ' num2str(varargin{i})]);
                        end
                end
            end
            %input parsing
            if ~ischar(id); error('id should be a string'); end
            if ~isempty(style); style = ['style="' style '"']; end
            if ~isempty(id); obj.text(['<A NAME="sec:' id '"></A>']); end
            if (~isempty(style) || ~isempty(id)) && isempty(format); format = 'FONT'; end
            if ~isempty(format);
                prefix = ['<'  format ' ' style '>'];
                suffix = ['</' format '>' suffix];
            end
            %split into "wrap" size chuncks if requested
            if ~isempty(wrap)
                if iscell(str); str = [str{:}]; end
                cl = cell;
                for i=1:wrap:numel(str);
                    a = (i-1)*wrap+1;
                    b = i*wrap;
                    cl{end+1} = str(a:b); %#ok<AGROW>
                end
                str = cl;
            end
            %reference wrapper
            if ~isempty(ref)
                superprefix = ['<A name="sec:' ref '">'];
                supersuffix = '</A>';
            end
            %write to file
            obj.write(str,suffix,prefix,supersuffix,superprefix)
        end
        %these are all special cases of "text" above
        function h1(obj,str,varargin)
            %writes a string in header-1 format
            obj.text(str,'<H1>',varargin{:});
            %sets this to the title, if no title exists yet
            if isempty(obj.getmeta('title')); obj.setmeta('title',str); end
            obj.addmeta('headers',['H1' str]);
        end
        function h2(obj,str,varargin)
            %writes a string in header-2 format
            obj.text(str,'<H2>',varargin{:});
            obj.addmeta('headers',['H2' str]);
        end;
        function h3(obj,str,varargin)
            %writes a string in header-3 format
            obj.text(str,'<H3>',varargin{:});
            obj.addmeta('headers',['H3' str]);
        end
        function h4(obj,str,varargin)
            %writes a string in header-4 format
            obj.text(str,'<H4>',varargin{:});
            obj.addmeta('headers',['H4' str]);
        end
        function comment(obj,str,varargin)
            %writes a string in "comment" format
            obj.text(str,'<comment>',varargin{:});
        end
        function dev(obj,str)
            %writes a string in "dev" format
            obj.text('<DEV>');
            obj.text(str);
            obj.text('</DEV>');
        end
        %% INCLUDE
        function include(obj,filename,newline)
            %includes the given file in the current file, line-by-line
            %include(filename,newline)
            if nargin<3; newline = ''; end
            fid = fopen(filename,'r'); %#ok<PROP>
            while true
                tline = fgetl(fid); %#ok<PROP>
                if ~ischar(tline); break; end
                obj.text(tline,newline);
            end
            fclose(fid); %#ok<PROP>
        end
        %% LIST
        function list(obj,listitems,varargin)
            %list(listitems_cell,options)
            %options 'id','style' both followed by string
            options = '';
            for i=1:2:numel(varargin)
                switch varargin{i}
                    case 'style'
                        options = [options ' ' varargin{i} '="' varargin{i+1} '"']; %#ok<AGROW>
                    case 'id';
                        obj.text(['<A NAME="lst:' varargin{i+1} '"></A>']);
                    otherwise
                        warning('htm:BadArg',['unknown option "' num2str(varargin{i}) '"']);
                end
            end
            if ~iscell(listitems)
                warning('htm:BadArg','list input is a single value');
                listitems = {listitems};
            end
            obj.write(['<UL ' options '>']);
            obj.text(listitems,'<li>')
            obj.write('</UL>');
        end
        %% LINK %
        function link(obj,str,lnk,str_end)
            %inserts a html hyperlink
            %link(string,link,endline)
            str = ['<A href="' lnk '">' str '</A>'];
            if nargin<4; str_end = ''; end
            obj.text(str,str_end);
            return
        end
        %% FIGURE
        function figure(obj,H,varargin)
            %inserts the current figure
            ext = '.png';
            resolution = '800x600';
            name = 'figure';
            id = '';
            caption = '';
            comment = '';
            tooltip = '';
            alttxt = '';
            i = 0;
            while i<length(varargin)
                i=i+1;
                switch varargin{i}
                    case 'custom'; resolution = get(H,'Position'); resolution = [num2str(resolution(3)) 'x' num2str(resolution(4))];
                    case {'name'}; i=i+1; name = varargin{i};
                    case {'id'};   i=i+1; id = varargin{i};
                    case 'caption';i=i+1; caption = varargin{i};
                    case 'comment';i=i+1; comment = varargin{i};
                    case 'tooltip';i=i+1; tooltip = varargin{i};
                    case 'alttxt';i=i+1; alttxt = varargin{i};
                    otherwise;
                        if regexp(varargin{i},'\d+x\d+'); %arbitrary resolution
                            resolution = varargin{i};
                        else
                            warning('htm:BadArg',['unknown option ' num2str(varargin{i})])
                        end
                end
            end
            if ~ischar(id); error('id should be a string'); end
            if ~isempty(id); obj.text(['<A NAME="fig:' id '"></A>']); end
            for i = 1:length(H);
                if iscell(H); figure(H{i});
                else          figure(H(i));
                end
                
                %set window and paper position appropriately
                %saveas does not save to specific sizes as standard, fudge
                %this through different paperpositions. does not give exact
                %figure sizes.
                px= 59.175; %conversion factor
                resolution = regexp(resolution,'\d+','match');
                resolution = str2num(char(resolution))'; %#ok<ST2NM>
                set(gcf,'Position',[50 50 resolution])
                set(gcf,'PaperPosition',[0.7 7 resolution/px]);
                
                %file name is assumed to be either relative to html file, or full path
                %make it full path if it isn't already, and check folder exists
                foo = obj.full_path(name);
                
                %check for an extension
                [fol,base,a] = fileparts(foo);
                if ~isempty(a) && ~isequal(a,ext);
                    warning('htm:BadArg',['changing extension to ' ext]);
                end
                if isempty(fol);
                    fol = fileparts(obj.file);
                end
                foo = fullfile(fol,[base ext]);
                count = 1;
                while exist(foo,'file');
                    count = count+1;
                    foo = fullfile(fol,[base num2str(count) ext]);
                end
                
                
                
                %print command plots other windows that are obscuring part
                %of the figure, use saveas instead
                %print(gcf,'-djpeg','-r600',['figure' num2str(count) '.' extension])
                %I = getframe(gcf); imwrite(I.cdata,name); %screen dump of the current file
                %set(gcf,'PaperOrientation','landscape','PaperPosition',[1 1 20 15]);
                saveas(gcf,foo);
                
                
                %modify the name to be relative to the htm file location
                name = obj.relative_path(foo);
                obj.addmeta('figures',name);
                
                %if figure is not in a subfolder, need a preamble on the url
                if isequal(name,foo)
                    pre = 'file://';
                else
                    pre = '';
                end
                
                %only add the relative path to metadata
                link = ['<img src ="' pre name '" '];
                if ~isempty(tooltip);
                    link = [link 'title="' tooltip '" ']; %#ok<AGROW>
                end
                if ~isempty(alttxt)
                    link = [link ' alt="' alttxt '" ']; %#ok<AGROW>
                end
                link = [link ' width="400">']; %#ok<AGROW>
                str = ['<a href="' pre name '">' link '</a>']; %the actual string that gets written
                if ~isempty(caption)
                    if ~isempty('comment')
                        obj.table({str},'caption',caption,'footer',comment)
                    else
                        obj.table({str},'caption',caption)
                    end
                else
                    obj.write(str)
                end
            end
            
        end
        %% TABLE
        function table(obj,A,varargin)
            %writes a matrix to a html table
            
            %% TABLE: RECURSIVE CALL FOR 3D TABLE
            if numel(size(A))>2;
                %if 'flagged' option is set, need to spit that into 2d subsets
                %can't use ismember here because some data is not strings
                flagged = [];
                for i=1:numel(varargin)
                    if isequal(varargin{i},'flagged');
                        flagged =varargin{i+1};
                        varargin{i+1} = flagged(:,:,1);
                        break
                    end
                end
                %the first part is using the original options
                obj.table(A(:,:,1),varargin{:});
                %this next part is a fudge. We keep the orignal options, but
                %we add another "caption" and "flagged" to the end. these will
                %overwrite the values in the original options
                for i=2:size(A,3)
                    capt = ['3D table part ' num2str(i)];
                    if isempty(flagged)
                        obj.table(A(:,:,i),varargin{:},'caption',capt);
                    else
                        obj.table(A(:,:,i),varargin{:},'caption',capt,'flagged',flagged(:,:,i))
                    end
                end
                return
            end
            %finished, remainder is how to add a 2D table
            
            %% TABLE: INPUT PARSING
            %default options
            mt_xgroup = true;
            mt_ygroup = true;
            mt_xheadr = true;
            mt_yheadr = true;
            xspan     = []; %size of the x group bins
            yspan     = []; %size of the y group bins
            mt_footer = true;
            footer    = [];
            footspan  = [];
            bodyalign = 'c'; %alignment of text in body
            headalign = 'c'; %alignment of text in x/y headers
            class     = [];  %css style class of this table
            id        = '';
            width     = [];
            flagged   = false(size(A));
            caption   = '';
            rnd     = [];
            i = 0;
            while i<length(varargin)
                i = i+1;
                switch(varargin{i})
                    case 'flagged';
                        i = i+1;
                        flagged = varargin{i};
                    case 'caption'
                        i = i+1;
                        caption = varargin{i};
                    case 'width'
                        i = i+1;
                        width  = num2str(varargin{i});
                    case {'xhdr','xhead'}
                        i=i+1; xheadr = varargin{i};
                        mt_xheadr = false;
                    case {'yhdr','yhead'}
                        i=i+1; yheadr = varargin{i};
                        mt_yheadr = false;
                    case 'xgroup';
                        i=i+1; xgroup = varargin{i};
                        i=i+1; xspan = varargin{i};
                        mt_xgroup = false;
                    case 'ygroup';
                        i=i+1; ygroup = varargin{i};
                        i=i+1; yspan = varargin{i};
                        mt_ygroup = false;
                    case 'class'
                        i = i+1;
                        class = varargin{i};
                    case 'footer'
                        i = i+1;
                        footer = varargin{i};
                        mt_footer = false;
                    case 'footspan'
                        i = i+1;
                        footspan = varargin{i};
                    case 'bodyalign'
                        i = i+1;
                        bodyalign = varargin{i};
                    case 'headalign'
                        i = i+1;
                        headalign = varargin{i};
                    case 'id'
                        i = i+1;
                        id = varargin{i};
                    case 'round';
                        i = i+1;
                        rnd = varargin{i};
                    otherwise
                        warning('cztools:BadArg',['unknown option "' num2str(varargin{i}) '"']);
                end
            end
            if ~ischar(id); error('id should be a string'); end
            if ~isempty(rnd) && ~isnumeric(rnd); error('round should be a number'); end
            if ~isequal(size(flagged),size(A)); error(['flagged is (' num2str(size(flagged)) '), data is (' num2str(size(A)) ')']); end
            
            %% TABLE: create name for this table
            %this is a name to use internally, either a sanitised version of the
            %caption, or generated
            if ~isempty('id');
                name = id;
            end
            if isempty(name) && exist('caption','var') && ~isempty(caption);
                name = caption;
            end
            if isempty(name)
                name = 'table';
            end
            %remove all unusual characters (including space)
            name = name(regexp(name,'\w|\d'));
            n = 1;
            name2 = name;
            while ismember(name2,obj.getmeta('tables'));
                n = n+1;
                name2 = [name num2str(n)];
            end
            obj.addmeta('tables',name2);
            %% TABLE: convert to cells
            if ~iscell(A); A = num2cell(A); end
            if ~mt_xheadr && ~iscell(xheadr); xheadr = num2cell(xheadr); end
            if ~mt_yheadr && ~iscell(yheadr); yheadr = num2cell(yheadr); end
            if ~mt_xgroup && ~iscell(xgroup); xgroup = num2cell(xgroup); end
            if ~mt_ygroup && ~iscell(ygroup); ygroup = num2cell(ygroup); end
            %autorotate to match headers
            if ~mt_xheadr && isequal(size(A,1),numel(xheadr)) && ~isequal(size(A,2),numel(xheadr)); A = A'; flagged = flagged'; end
            if ~mt_yheadr && isequal(size(A,2),numel(yheadr)) && ~isequal(size(A,1),numel(yheadr)); A = A'; flagged = flagged'; end
            
            %% TABLE: alignment of each column
            switch lower(bodyalign)
                case 'left';  bodyalign = 'l';
                case 'right'; bodyalign = 'r';
                case 'center';bodyalign = 'c';
            end
            if numel(bodyalign)==1; bodyalign = repmat(bodyalign,[1 size(A,2)]); end
            switch lower(headalign);
                case 'left';  headalign = 'l';
                case 'right'; headalign = 'r';
                case 'center';headalign = 'c';
            end
            %% TABLE: CHECK SIZES OF ELEMENTS
            nr = size(A,1); nc = size(A,2);
            %add span if not already
            if isempty(xspan); xspan = nc; end
            if isempty(yspan); yspan = nr; end
            
            %remove empty span elements
            if ~mt_xgroup; xgroup = xgroup(xspan~=0); end;
            if ~mt_ygroup; ygroup = ygroup(yspan~=0); end;
            xspan(xspan==0) = [];
            yspan(yspan==0) = [];
            
            if ~mt_xheadr && ~isequal(nc,numel(xheadr));
                warning('htm:BadArg','size of x header does not match size of table data')
                keyboard
                if nc>numel(xheadr); for i=(numel(xheadr)+1):nc; xheadr{i} = ''; end
                else xheadr = xheadr(1:nc);
                end
            end
            if ~mt_xgroup && ~isequal(nc,sum(xspan))
                warning('htm:BadArg','size of x groups does not match size of table data')
                if nc>sum(xspan); xspan(end) = xspan(end)+nc-sum(xspan);
                else
                    while sum(xspan)>nc;
                        xspan(end)=xspan(end)-1;
                        if xspan(end) == 0; xspan(end) = []; end;
                    end
                    xgroup = xgroup(1:numel(xspan));
                end
            end
            if ~mt_yheadr && ~isequal(nr,numel(yheadr));
                warning('htm:BadArg','size of y header does not match size of table data')
                if nr>numel(yheadr); for i=(numel(yheadr)+1):nr; yheadr{i} = ''; end
                else yheadr = yheadr(1:nr);
                end
            end
            if ~mt_ygroup && ~isequal(nr,sum(yspan))
                warning('htm:BadArg','size of y groups does not match size of table data')
                if nr>sum(yspan); yspan(end) = yspan(end)+nr-sum(yspan);
                else
                    while sum(yspan)>nr;
                        yspan(end)=yspan(end)-1;
                        if yspan(end) == 0; yspan(end) = []; end;
                    end
                    ygroup = ygroup(1:numel(yspan));
                end
            end
            
            if numel(bodyalign)~=nc;
                warning('htm:BadArg','number of bodyalign values does not match size of table data');
                if numel(bodyalign)>nc; bodyalign = bodyalign(1:nc);
                else bodyalign((end+1):nc) = 'c';
                end
            end
            
            align = bodyalign;
            
            %% TABLE: pixel width
            %if round option, round to the right number of decimals
            for i=1:nr
                for j=1:nc
                    if isnan(A{i,j}); A{i,j} = 'nan'; end
                    if isnumeric(A{i,j}) && ~isempty(rnd);
                        val = round(A{i,j}*10^rnd)/10^rnd;
                        val = num2str(val);
                        if ~numel(regexp(val,'\.')) && rnd>0; val = [val '.']; end %#ok<AGROW>
                        while numel(val)-regexp(val,'\.')<rnd; val = [val '0']; end %#ok<AGROW>
                        while numel(val)-regexp(val,'\.')>rnd; val = val(1:end-1); end
                        A{i,j} = val;
                    end
                end
            end
            %number of characters per cell
            lbody = 1; %length of the longest number
            for i=1:size(A,1)
                for j=1:size(A,2)
                    lbody = max(lbody,length(num2str(A{i,j})));
                end
            end
            if ~mt_xheadr
                for i=1:length(xheadr)
                    lbody = max(lbody,length(num2str(xheadr{i})));
                end
            end
            lenh = 1;
            if ~mt_yheadr
                for i=1:length(yheadr);
                    lenh = max(lenh,length(num2str(yheadr{i})));
                end
            end
            
            %convert to pixel widths
            yheadr_width = 10*lenh+10;
            if isempty(width);
                yheadr_width = [];
            else
                width = width+yheadr_width;
            end
            
            
            
            %% TABLE: PREAMBLE
            if ~isempty(id); obj.text(['<A NAME="tab:' id '"></A>']); end
            str = '<TABLE';
            if ~isempty(width); str = [str ' WIDTH="' width 'px"']; end
            if ~isempty(class); str = [str ' CLASS="' class '" ']; end
            str =[str ' RULES="GROUPS" FRAME="BOX" CELLSPACING="0" CELLPADDING="3" BORDER="1">'];
            obj.write(str);
            % COLUMN GROUPS (x span)
            %column groups for the yheadr and ygroup
            for i=1:sum([~mt_ygroup ~mt_yheadr]);
                obj.write('<COLGROUP>')
                switch headalign
                    case 'l';   str = '   <COL ALIGN="left"></COL>';
                    case 'r';   str = '   <COL ALIGN="right"></COL>';
                    case 'c';   str = '   <COL ALIGN="center"></COL>';
                    otherwise;  str = '   <COL></COL>';
                end
                obj.write(str);
                obj.write('</COLGROUP>')
            end
            
            %column groups for the main body
            c = 0;
            for i=1:numel(xspan)
                obj.write('<COLGROUP>')
                for j=1:xspan(i)
                    c = c+1;
                    switch align(c)
                        case 'l';   str = '   <COL ALIGN="left"></COL>';
                        case 'r';   str = '   <COL ALIGN="right"></COL>';
                        case 'c';   str = '   <COL ALIGN="center"></COL>';
                        otherwise;  str = '   <COL></COL>';
                    end
                    obj.write(str);
                end
                obj.write('</COLGROUP>')
            end
            %TABLE CAPTION
            if ~isempty('caption');
                if obj.allowtoggle;
                    obj.write(['<CAPTION><A HREF="#" class="toggle" onclick="toggleItem(''Tbody' name ''')">' caption '</a></CAPTION>']);
                else
                    obj.write(['<CAPTION>' caption '</CAPTION>']);
                end
            end
            obj.write('<THEAD>');
            %ROW OF X GROUP COLUMNS
            if ~mt_xgroup;
                str = '    <TR>';
                if exist('xalign','var'); str = ['    <TR ALIGN="' xalign '">']; end
                obj.write(str);
                
                %spare column in the x header for the y header
                str = '        ';
                if xor(~mt_ygroup,~mt_yheadr); str = [str '<TH></TH>']; end
                if and(~mt_ygroup,~mt_yheadr); str = [str '<TH COLSPAN="2"></TH>']; end
                obj.write(str);
                %x group elements
                for i=1:length(xgroup);
                    obj.write(['        <TH COLSPAN="' num2str(xspan(i)) '">' num2str(xgroup{i}) '</TH>']);
                end
                obj.write('    </TR>');
            end
            
            %ROW Of X HEADER COLUMNS
            if ~mt_xheadr;
                switch headalign
                    case 'l'; obj.write('    <TR ALIGN="left">');
                    case 'r'; obj.write('    <TR ALIGN="right">');
                    case 'c'; obj.write('    <TR ALIGN="center">');
                    otherwise;obj.write('    <TR ALIGN="center">');
                end
                str = '        ';
                %spare column in the x header for the y headr
                if xor(~mt_ygroup,~mt_yheadr); str = [str '<TH></TH>']; end
                if and(~mt_ygroup,~mt_yheadr); str = [str '<TH COLSPAN="2"></TH>']; end
                obj.write(str);
                %one per column
                for i=1:length(xheadr);
                    obj.write(['        <TH>' num2str(xheadr{i}) '</TH>']);
                end
                obj.write('    </TR>');
            end
            obj.write('</THEAD>');
            
            %% TABLE: CONTENTS
            obj.write(['<TBODY id="Tbody' name '">']);
            for i=1:size(A,1) %for every row
                obj.write('    <TR>');
                [tf,loc] = ismember(i,[1 1+cumsum(yspan(1:end-1))]);
                %single element at the start of the row if this is the first
                %row of a new group
                if ~mt_ygroup && tf;
                    if isempty(yheadr_width)
                        obj.write(['        <TH class = "yhdr" ROWSPAN="' num2str(yspan(loc)) '">' num2str(ygroup{loc}) '</TH>']);
                    else
                        obj.write(['        <TH class = "yhdr" ROWSPAN="' num2str(yspan(loc)) '" width="' num2str(yheadr_width) 'px">' num2str(ygroup{loc}) '</TH>']);
                    end
                end
                %single element at the start of the row if there is a y header
                if ~mt_yheadr;
                    if isempty(yheadr_width)
                        obj.write(['        <TH class = "yhdr">' num2str(yheadr{i}) '</TH>']);
                    else
                        obj.write(['        <TH class = "yhdr" width="' num2str(yheadr_width) 'px">' num2str(yheadr{i}) '</TH>']);
                    end
                end
                %single cell for every element in the body
                for j=1:size(A,2);
                    str = '        ';
                    %choose colour for this element
                    switch flagged(i,j);
                        case 0; str = [str '<TD>']; %#ok<AGROW>
                        case 1; str = [str '<TD bgcolor=#EEEE00>']; %#ok<AGROW> yellow
                        case 2; str = [str '<TD bgcolor=#88EEEE>']; %#ok<AGROW> blue
                        case 3; str = [str '<TD bgcolor=#EE8888>']; %#ok<AGROW> red
                        case 4; str = [str '<TD bgcolor=#AAEEAA>']; %#ok<AGROW> green
                        case 5; str = [str '<TD bgcolor=#EEAAEE>']; %#ok<AGROW> purple
                        otherwise; str = [str '<TD bgcolor=#CCCCCC>']; %#ok<AGROW>
                    end
                    str = [str num2str(A{i,j}) '</TD>']; %#ok<AGROW>
                    obj.write(str);
                end
                
                obj.write('    </TR>');
                if ismember(i,cumsum(yspan)) && i<size(A,1); obj.write('</TBODY>'); obj.write('<TBODY>'); end
            end
            obj.write('</TBODY>');
            
            %% TABLE: FOOTER
            if ~mt_footer
                obj.write('<TFOOT>');
                if ~isempty(footspan)
                    %do nothing
                else
                    footspan = size(A,2);
                    if ~mt_yheadr; footspan = footspan+1; end
                    if ~mt_ygroup; footspan = footspan+1; end
                end
                str = ['<TR><TD class="footer" colspan="' num2str(footspan) '" >' footer '</TD></TR>'];
                obj.write(str);
                obj.write('</TFOOT>');
            end
            %END TABLE
            obj.write('</TABLE>');
        end
        %% REF
        function ref(obj,type,tag,string,varargin)
            %creates an internal link similar to <a href="#tab:string">text</a>
            switch lower(type);
                case {'table','tab','tabl','tabel'}; type = 'tab:';
                case {'figure','figur','fig','figr'}; type = 'fig:';
                case {'section','header','text','sec','hdr','txt'}; type = 'sec:';
                case {'lst','list'}; type = 'lst:';
                otherwise; warning('CzTools:BadArg',['unknown type "' num2str(type) '"']);
            end
            tag = strrep(tag,'#','');
            str = ['#' type tag];
            obj.link(string,str,varargin{:})
        end
        %% TOGGLE
        function toggle(obj,text,id,varargin)
            %creates a toggleable section
            if ~obj.allowtoggle; warning('htm:badfile','cannot create toggle section, must set toggle on before file opened'); end
            if isequal(text,'end');
                obj.text('</div>');
            else
                if ~ischar(id); error('id should be a string'); end
                str1 = ['<A href="#" class="toggle" onclick="toggleItem(''div:' id ''')" id="tog:' id '">' text '</A>'];
                str2 = ['<div id="div:' id '">'];
                obj.text(str1,varargin{:});
                obj.text(str2);
            end
        end
    end
    
    %% DEMO
    methods (Static)
        function demo()
            % %================
            % %=== HTM DEMO ===
            % %================
            %
            % % create some values
            %val = round(100*rand(12,12));
            %plot(val);
            %
            % %======================
            % %=== simple example ===
            % %======================
            %
            %h = htm('test');                   %create the handle object
            %if h.exist; h.clear; end           %if the file exists, delete it
            %h.start;                           %start the file (open for writing, write html header
            %h.h1('This is a top level header');
            %h.text('This is some text.');
            %h.text('This is some more text with a line break after it','nl');
            %h.h2('This is a level 2 header');
            %h.figure(gcf,'caption','some random lines','name','randlines');
            %h.text('some text below the figure','nl');
            %h.table(val,'caption','the same data in a table','footer','these are all random numbers');
            %h.stop;                            %stops the file
            %
            %h.zip;                             %zips the file
            %h.show;                            %shows the file
            %h.edit                             %opens the file in the editor
            %
            % %=======================
            % %=== linking example ===
            % %=======================
            %
            %h = htm('test');
            %if h.exist; h.clear; end           %if the file exists, delete it
            %h.start;
            %h.h1('Example of linking within file');
            %h.text('This htm shows an example of links');
            % %external links are simple:
            %h.link('matlab website','http:\\www.mathworks.com','nl');
            % %internal links are called references
            % %they use html anchors
            % %can create the references before the thing they link to
            % %exists
            %h.ref('fig','afigure','ref to a figure'); h.newline
            %h.ref('tab','table1','and to a table'); h.newline
            %h.ref('sec','id1','and to section "jumphere"'); h.newline
            % %now create the things that were linked to above, using 'id'
            %for i=1:10; h.newline; end
            %val = rand(10);
            %h.figure(gcf,'caption','prettypic','id','afigure');
            %for i=1:10; h.newline; end
            %h.table(val,'caption','some values','id','table1');
            %for i=1:10; h.newline; end
            %h.h2('H2 class section jumphere','id','id1');
            %for i=1:30; h.newline; end
            %h.stop;
            % %finally, show the result in the browser
            %h.show
            %
            % %=======================
            % %=== figures example ===
            % %=======================
            %h = htm('test');
            %if h.exist; h.clear; end
            %h.start;
            %plot(peaks)
            %h.figure(gcf);
            % %the most basic figure insertion, creates the figure as a png file, and
            % %creates an img link to it
            %h.figure(gcf,'name','somelines')
            % %specifies the name of the file to save to (no extension)
            % %by default, htm saves figures to 'figure.png','figure2.png'
            % %the number in the filename is incremented until a 'free'
            % filename is found.
            %h.figure(gcf,'800x600')
            % %specifies the size of the figure created, 'custom' uses the
            % current figure size on screen.
            % htm uses saveas to save the figures, and fudges the
            % paperposition to give roughly the right image size. Exact
            % pixel accuracy of image size cannot be guaranteed
            % the alternative print command is available (but commented
            % out) in the code above, but this has a habit of printing
            % other windows that obscure the figure, black figures when the
            % screensaver is on, etc.
            %h.figure(gcf,'caption','somelines','comment','a figure comment',...
            %'name','figure','tooltip','atooltip','alttxt','somealttxt');
            %h.stop;
            %
            % =====================
            % === table example ===
            % =====================
            %
            %val = rand(12,10);
            %h = htm('test'); if h.exist; h.clear; end
            %h.start;
            %h.table(val,'round',1)
            % %the basic table, rounded to one decimal place
            %flag = zeros(size(val));
            %flag(val>0.2) = 1;
            %flag(val>0.5) = 2;
            %h.table(val,'flagged',flag,'caption','some numbers','footer','a comment')
            % %colours some cells, based on their value, and adds a header
            % %and footer
            %h.table(val,'xhead',1:12,'yhead',{'1','2','three','4','5','6','7','8','9','10'},...
            %'xgroup',{'Q1','Q2','Q3'},[4 3 5],'ygroup',{'Y1','Y2','Y3'},[5 3 2]);
            % %specifies the column headers, and divides the table into
            % %subtable. The second option for xgroup is the span of each
            % %group
            %h.table(rand(4,3,2))
            % %3-D tables are shown as a series of 2-D tables
            %h.stop
            %
            %
            % %========================
            % %=== metadata example ===
            % %========================
            %
            % %metadata is created as the file is started, and updated as
            % %new content is added. It is written to the footer when the
            % %file is stopped.
            % %
            % %metadata has the following fields by default:
            % %'title' - by default the first H1 text found
            % %'creator'- username of person who last used the file
            % %'date' - date file was last stopped
            % %'figures' - list of figures created by htm in this file
            % %'tables' - list of tables in the file
            % %'headers' - list of headers of class H1,H2,H3,H4
            % %
            % % this can be set and get using:
            %h.setmeta('title','A new title');
            %h.getmeta;
            %be wary of setting any metadata apart from title, as htm
            %uses these values internally. For example, the field
            %'figures' is a list of figures created by the file - these
            %will be deleted when you delete the file with h.clear.
            %
            % % recovering
            % % htm will try to stop a file gracefully by writing the
            % % metadata to the end of the file. This might not be possible,
            % % leaving a file with no metadata at the bottom. the function
            % %h.findmeta will try to scan the html for metadata and update
            % % h's metadata properties to match.
        end
    end
end %class