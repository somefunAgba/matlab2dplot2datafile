%% Example program for 
% function: 'matlab2dplot2datafile' 
% aim: compress large plot datasets from matlab plots 
%      to a data file (txt/csv/dat) for  
%      Data Visualization using TikZ/pgfplots in LaTeX
%
% Author: Somefun, O. A.
% Date: 2019-02-19
% E-Mail: oluwasegun.somefun@yahoo.co.uk


%%
% Housekeeping
clc;clear variables; close all;

% Number of data points
N=100;

x=linspace(0,5,N);
y=sin(x);
z=cos(x);

%% ex1: 
% plot and save plot's data
% with header/variable/column name
figure(1)
out1 = matlab2dplot2datafile('datafile.txt',...
    {'x','y'},...
    x,y,'Color','m');
figure(2)
out2 = matlab2dplot2datafile('datafile2.csv',...
    {'x','y','z'},...
    x,y,'-.',x,z,':');
% no header/variable/column name
figure(3)
out3 = matlab2dplot2datafile('datafile3.dat',...
    {},...
    x,y,'-.',x,z,':');

%% ex3:
% using plot handles  
% save a single figure 2d plot to data file
figure(4)
h1 = reduce_plot(x,y);
hold on;
h2 = reduce_plot(x,z);
hold off;
figure(5)
out4 = matlab2dplot2datafile('datafile4.txt',...
    {'x','y','z'},h1,h2);





