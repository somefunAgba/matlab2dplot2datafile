function output = matlab2dplot2datafile(filename, varnames, varargin)
% MATLAB2DPLOT2DATAFILE
% usage: MATLAB2DPLOT2DATAFILE('filename',{,...,},handle_1,...handle_n)
% usage: MATLAB2DPLOT2DATAFILE('filename',{,...,},plot variables)
% matlab2dplot2datafile('datafile.txt',...
%    {},...
%    x,y,':m');
%
% matlab2dplot2datafile('datafile.csv',...
%    {'x','y','z'},h1,h2);
%
% Copyright 2019, Somefun Oluwasegun A.
try
    strcmp(get(varargin{1},'type'),'line');
    err = 0;
catch
    err = 1;
end
disp(err)
if  ~err
    %% if reduce_plot handles are input
    
    nlines = length(varargin);
    % disp(nlines)
    
    l =[];
    for n = 1:nlines
        s = varargin{n};
        l = [l;s];
    end
    
    nlines = numel(l);
%   disp(nlines)
    h = [];
    for n = 1:nlines
        q = l(n);
        g = line(q.XData, q.YData, 'Color', q.Color,...
            'LineStyle', q.LineStyle, 'LineWidth',...
            q.LineWidth, 'MarkerSize',...
            q.MarkerSize, 'MarkerFaceColor', q.MarkerFaceColor);
        h = [h,g];
%         disp(n)
    end
    
    %     disp(err)
    
else
    %% if varaiables and properties are input
    
    h = reduce_plot(varargin{:});
    %     disp(err)
    
end

%% main action
% place plot data into a file

nlines = numel(h);
% disp(nlines)

x = h(1).XData;
set(gcf,'Units','pixels')
newlimits = get(gca, 'XLim');
newminidx = find(x >= floor(newlimits(1)), 1);
newmaxidx = find(x <= ceil(newlimits(2)), 1,'last');
figpos=get(gcf,'Position');

output = [];
for n = 1:nlines
    y = h(n).YData;
    [x_red, y_red]= reduce_to_width(x(:),y(:),figpos(3),[x(newminidx) x(newmaxidx)]);
    if n ==1
        output=[output, x_red]; %#ok<*AGROW>
        %         disp('x')
    end
    output=[output, y_red];
%         disp('output');
end

% save(filename,'output','-ascii');

% save from array to table to *.text/csv/dat file
if isempty(varnames)
    T = array2table(output);
else
    T = array2table(output,'VariableNames',varnames);
end
writetable(T,filename);

end
